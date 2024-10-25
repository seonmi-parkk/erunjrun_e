package com.erunjrun.mypage.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.erunjrun.member.dto.MemberDTO;
import com.erunjrun.member.dto.ProfileDTO;
import com.erunjrun.mypage.service.MypageService;

@Controller
public class MypageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MypageService mypageService;
	
	@GetMapping(value = "/profileDetail")
	public String profileDetail(Model model, HttpSession session) {
		
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.profileViewImage(id);
			model.addAttribute("member", member);
			model.addAttribute("profile", profile);

		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 이동
		}
		return "mypage/profile";
	}

	@GetMapping(value = "/profileUpdateView")
	public String profileUpdateView(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.profileViewImage(id);
			logger.info("Profile image for user {}: {}", id, profile.getImage());
			model.addAttribute("member", member);
			model.addAttribute("profile", profile);
			logger.info("profile image?" + profile.getImage());
			return "mypage/profileUpdate"; // 수정 페이지로 이동
		} else {
			return "main"; // 로그인 페이지로 리다이렉트
		}
	}

	@PostMapping(value = "/profileUpdate")
	public String profileUpdate(Model model, @RequestParam Map<String, String> params,
			@RequestParam("imageFile") MultipartFile imageFile, HttpSession session) {
		String id = (String) session.getAttribute("loginId");

		if (id != null) {
			params.put("id", id); // 세션에서 가져온 ID를 params에 추가

			// 이미지 파일 처리
			if (!imageFile.isEmpty()) {
				String originalFileName = imageFile.getOriginalFilename();
				String newFileName = UUID.randomUUID().toString() + "_" + originalFileName; // 새로운 파일 이름 생성

				// 파일 저장 경로
				String uploadDir = "C:/upload/"; // 실제 경로로 변경해야 함
				Path path = Paths.get(uploadDir + newFileName);

				try {
					Files.write(path, imageFile.getBytes()); // 파일 저장
					params.put("image", newFileName); // params에 이미지 파일 이름 추가
				} catch (IOException e) {
					e.printStackTrace();
					model.addAttribute("msg", "파일 저장 중 오류가 발생했습니다.");
					return "member/profileUpdate"; // 에러 페이지로 리다이렉트
				}
			}

			logger.info("params : {}", params);
			mypageService.profileUpdate(params); // 업데이트 호출

			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.profileViewImage(id);
			model.addAttribute("profile", profile);
			model.addAttribute("member", member);
			return "mypage/profile"; // 프로필 페이지로 리다이렉트
		} else {
			// 세션에 ID가 없으면 로그인 페이지로 리다이렉트
			return "main";
		}
	}

	@GetMapping(value = "/deleteView")
	public String deleteView() {
		return "mypage/delete";
	}

	@PostMapping("/memberDelete") // 실제로 delete하는 것이 아니니, 혼동 방지를 위해 post로 작성했습니다!
	public String memberDelete(@RequestParam String id, @RequestParam String email, @RequestParam String pw, HttpSession session, Model model) {
		
		String sessionId = (String) session.getAttribute("loginId");	
		if (sessionId.equals(id)) {
			// ID가 세션에 있는지 확인
			MemberDTO member = mypageService.findSessionId(id);
			if (member.getEmail().equals(email) && member.getPw().equals(pw)) {
				// 이메일과 비밀번호가 일치하는 경우
				mypageService.setUseY(id); // 탈퇴 상태로 변경
				session.invalidate(); // 세션 무효화
				model.addAttribute("msg", "탈퇴가 완료되었습니다. 지금까지 이용해주셔서 감사합니다.");
				return "main"; // 로그인 페이지로 리다이렉트
			} else {
				model.addAttribute("msg", "입력한 정보가 올바르지 않습니다.");
			}
		} else {
			model.addAttribute("msg", "로그인후 탈퇴할 수 있습니다.");
		}
		return "main"; // 탈퇴 페이지로 다시 리다이렉트
	}

	@GetMapping(value = "/firstExerciseProfile")
	public String firstExerciseProfile(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId"); // 세션에서 로그인 ID 가져오기

		if (id != null) {
			model.addAttribute("loginId", id); // 모델에 로그인 ID 추가 (필요시)
			String profileImage = (String) session.getAttribute("profileImage"); // 세션에서 프로필 이미지 가져오기
	        model.addAttribute("profileImage", profileImage);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다."); // 로그인 필요 메시지
			return "redirect:/login"; // 로그인 페이지로 리다이렉트
		}

		return "mypage/firstExerciseProfile"; // 프로필 페이지로 이동
	}
}
