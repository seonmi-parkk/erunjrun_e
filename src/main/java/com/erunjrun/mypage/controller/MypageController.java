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
import com.erunjrun.mypage.dto.MypageDTO;
import com.erunjrun.mypage.service.MypageService;

@Controller
public class MypageController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MypageService mypageService;

	@GetMapping(value = "/profileDetail")
	public String profileDetail(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.ProfileImage(id);
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
			ProfileDTO profile = mypageService.ProfileImage(id);
			model.addAttribute("member", member);
			model.addAttribute("profile", profile);
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
				String uploadDir = "C:/upload/"; // 실제 경로
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
			mypageService.profileUpdate(params); // 업데이트 호출
			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.ProfileImage(id);
			model.addAttribute("profile", profile);
			model.addAttribute("member", member);
			return "mypage/profile"; // 프로필 페이지로
		} else {
			// 세션에 ID가 없으면 로그인 페이지로
			return "member/login";
		}
	}

	@GetMapping(value = "/deleteView")
	public String deleteView() {
		return "mypage/delete";
	}

	@PostMapping("/memberDelete") // 실제로 delete하는 것이 아니니, 혼동 방지를 위해 @post로 작성했습니다!
	public String memberDelete(@RequestParam String id, @RequestParam String email, @RequestParam String pw,
			HttpSession session, Model model) {

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

	@GetMapping(value = "/createExerciseProfile")
	public String createExerciseProfile(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");

		if (id != null) {
			// 회원 정보 조회
			MemberDTO member = mypageService.findSessionId(id);
			if ("Y".equals(member.getProfile_use())) {
				MypageDTO mypage = mypageService.mypageDetail(id);
				model.addAttribute("mypage", mypage); // 모델에 MypageDTO 추가
				// 운동 프로필이 이미 작성된 경우
				return "mypage/ExerciseProfile"; // 운동 프로필 페이지로 리다이렉트
			}
			model.addAttribute("loginId", id);

			String profileImage = (String) session.getAttribute("profileImage");
			model.addAttribute("profileImage", profileImage);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}

		return "mypage/createExerciseProfile"; // 최초 프로필 작성 안내 페이지로 이동
	}

	@GetMapping(value = "/firstExerciseProfileView")
	public String firstExerciseProfileView(HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");

		if (id != null) {
			// 회원 정보 조회
			MemberDTO member = mypageService.profileDetail(id); // 여기서 회원 정보를 가져옴
			if ("Y".equals(member.getProfile_use())) {
				// 운동 프로필이 이미 작성된 경우
				return "mypage/ExerciseProfile"; // 운동 프로필 페이지로 리다이렉트
			}
			model.addAttribute("loginId", id);
			model.addAttribute("member", member); // member를 모델에 추가
			String profileImage = (String) session.getAttribute("profileImage");
			model.addAttribute("profileImage", profileImage);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}

		return "mypage/firstExerciseProfile"; // 최초 프로필 작성 안내 페이지로 이동
	}

	@PostMapping(value = "/firstExerciseProfile")
	public String firstExerciseProfile(@RequestParam Map<String, String> params, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			// 운동 프로필 생성
			mypageService.firstExerciseProfile(params);

			// 프로필 작성 상태 업데이트
			mypageService.updateProfile_use(id, "Y");

			// 프로필 공개 여부 및 운동 메이트 찾기 여부 업데이트
			String profileVisibility = params.get("profileVisibility");
			String mateSearch = params.get("mateSearch");

			// 프로필 공개 여부 업데이트
			mypageService.updateProfileVisibility(id, "Y".equals(profileVisibility) ? "Y" : "N");

			// 운동 메이트 찾기 여부 업데이트
			mypageService.updateMateSearch(id, "Y".equals(mateSearch) ? "Y" : "N");

			// 업데이트된 회원 정보 가져오기
			MemberDTO member = mypageService.profileDetail(id);
			String birthString = member.getFormattedBirth();
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가
			model.addAttribute("member", member);
		}
		return "mypage/ExerciseProfile"; // 운동 프로필 페이지로 리다이렉트
	}

	@GetMapping(value = "/ExerciseProfile")
	public String ExerciseProfile(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = mypageService.profileDetail(id);
			ProfileDTO profile = mypageService.ProfileImage(id);
			MypageDTO mypage = mypageService.mypageDetail(id);

			// 생년월일을 가져와 로그에 출력
			logger.info("Member Birth: {}", member.getBirth());

			// 포맷된 생년월일 추가
			String birthString = member.getFormattedBirth();
			model.addAttribute("member", member);
			model.addAttribute("profile", profile);
			model.addAttribute("mypage", mypage); // 모델에 MypageDTO 추가
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가

		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 이동
		}
		return "mypage/ExerciseProfile";
	}

	@GetMapping(value = "/ExerciseProfileUpdateView")
	public String ExerciseProfileUpdateView(Model model, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			MemberDTO member = mypageService.profileDetail(id);
			MypageDTO mypage = mypageService.mypageDetail(id);
			String birthString = member.getFormattedBirth();
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가
			model.addAttribute("member", member);
			model.addAttribute("mypage", mypage); // 모델에 MypageDTO 추가
			model.addAttribute("profileVisibility", mypage.getProfile_use());
			model.addAttribute("mateSearch", mypage.getExercise_use());
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login";
		}
		return "mypage/ExerciseProfileUpdate";
	}

	@PostMapping(value = "/ExerciseProfileUpdate")
	public String ExerciseProfileUpdate(Model model, HttpSession session, @RequestParam Map<String, String> params) {
	    logger.info("Received params: {}", params);
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			mypageService.ExerciseProfileUpdate(params);
			String profileVisibility = params.get("profileVisibility");
			String mateSearch = params.get("mateSearch");
			mypageService.updateProfileVisibility(id, "Y".equals(profileVisibility) ? "Y" : "N");
			mypageService.updateMateSearch(id, "Y".equals(mateSearch) ? "Y" : "N");
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}
		return "mypage/ExerciseProfile";
	}
}
