package com.erunjrun.mypage.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String profileUpdate(Model model, @RequestParam Map<String, String> params, HttpSession session) {

		String id = (String) session.getAttribute("loginId");
		if (id != null) {
			params.put("id", id); // 세션에서 가져온 ID를 params에 추가

			// 업데이트 호출
			mypageService.profileUpdate(params);

			// 사용자 정보 및 프로필 이미지 가져오기
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
				return "redirect:/ExerciseProfile"; // 운동 프로필 페이지로 리다이렉트
			}
			model.addAttribute("loginId", id);
			model.addAttribute("member", member); // 모델에 MypageDTO 추가
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
			logger.info("Member Birth: {}", member.getBirth());
			String birthString = member.getFormattedBirth();
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가

			String profileImage = (String) session.getAttribute("profileImage");
			model.addAttribute("profileImage", profileImage);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}

		return "mypage/firstExerciseProfile"; // 최초 프로필 작성 안내 페이지로 이동
	}

	@PostMapping(value = "/firstExerciseProfile")
	public String firstExerciseProfile(@RequestParam Map<String, String> params,
			@RequestParam("imageFile") MultipartFile imageFile, HttpSession session, Model model) {
		String id = (String) session.getAttribute("loginId");
		if (id != null) {
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
					return "mypage/createExerciseProfile"; // 에러 페이지로 리다이렉트
				}
			}

			// 운동 프로필 생성
			mypageService.profileUpdate(params); // 업데이트 호출
			ProfileDTO profile = mypageService.ProfileImage(id);
			model.addAttribute("profile", profile);
			mypageService.firstExerciseProfile(params);
			logger.info("Params: {}", params);

			// 프로필 작성 상태 업데이트
			mypageService.updateProfile_use(id, "Y");

			// 프로필 공개 여부 및 운동 메이트 찾기 여부 업데이트
			String profileVisibility = params.get("profileVisibility");
			String mateSearch = params.get("mateSearch");

			// 프로필 공개 여부 업데이트
			mypageService.updateProfileVisibility(id, "Y".equals(profileVisibility) ? "Y" : "N");

			// 운동 메이트 찾기 여부 업데이트
			mypageService.updateMateSearch(id, "Y".equals(mateSearch) ? "Y" : "N");

			// 포인트 추가
			mypageService.addPoint(id, 10);

			// 업데이트된 회원 정보 가져오기
			MemberDTO member = mypageService.profileDetail(id);
			String birthString = member.getFormattedBirth();
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가
			model.addAttribute("member", member);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}
		return "redirect:/ExerciseProfile";
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
			ProfileDTO profile = mypageService.ProfileImage(id);

			String birthString = member.getFormattedBirth();
			model.addAttribute("birthString", birthString); // 포맷된 생년월일 추가
			model.addAttribute("member", member);
			model.addAttribute("profile", profile);
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
	public String ExerciseProfileUpdate(Model model, HttpSession session, @RequestParam Map<String, String> params,
			@RequestParam(value = "fileInput", required = false) MultipartFile imageFile) {
		logger.info("Received params: {}", params);
		logger.info("Image parameter added to params: {}", params.get("image"));
		String id = (String) session.getAttribute("loginId");

		if (id != null) {
			// 이미지 파일 처리
			if (imageFile != null && !imageFile.isEmpty()) {
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
					return "mypage/createExerciseProfile"; // 에러 페이지로 리다이렉트
				}
			}

			// 프로필 정보 업데이트
			mypageService.profileUpdate(params); // 업데이트 호출
			mypageService.ExerciseProfileUpdate(params);
			String profileVisibility = params.get("profileVisibility");
			String mateSearch = params.get("mateSearch");
			mypageService.updateProfileVisibility(id, "Y".equals(profileVisibility) ? "Y" : "N");
			mypageService.updateMateSearch(id, "Y".equals(mateSearch) ? "Y" : "N");

			model.addAttribute("msg", "프로필이 성공적으로 업데이트되었습니다.");
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "member/login"; // 로그인 페이지로 리다이렉트
		}

		return "redirect:/ExerciseProfile"; // 업데이트 후 프로필 페이지로 리다이렉트
	}

	@GetMapping(value = "/pointHistoryListView")
	public String pointHistoryListView(HttpSession session, Model model) {
		logger.info("pointHistoryListView called");

		// 세션에서 사용자 ID를 가져오기
		String id = (String) session.getAttribute("loginId");
		if (id == null) {
			logger.warn("User not logged in. Redirecting to login page.");
			model.addAttribute("msg", "로그인이 필요합니다."); // 모델에 메시지 추가
			return "member/login"; // 로그인 페이지로 리다이렉트
		}

		return "mypage/pointHistoryList"; // 로그인된 경우 리스트 페이지로 이동
	}

	@GetMapping(value = "/pointHistoryList.ajax")
	@ResponseBody
	public Map<String, Object> list(String page, String cnt, HttpSession session, Model model) {
		logger.info("list called with page: {}, cnt: {}", page, cnt);

		// 세션에서 사용자 ID를 가져오기
		String id = (String) session.getAttribute("loginId");
		if (id == null) {
			logger.warn("User not logged in. Redirecting to login page.");
			model.addAttribute("msg", "로그인이 필요합니다."); // 모델에 메시지 추가
			return null; // AJAX 요청에 대한 적절한 응답을 반환
		}

		// 페이지와 항목 수 변환
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);

		// 서비스 호출 시 ID 전달
		Map<String, Object> result = mypageService.list(page_, cnt_, id);
		logger.info("Result from service: {}", result);

		return result;
	}

	// 친구 요청 페이지로 이동
	@GetMapping(value = "/requestedMateListView")
	public String requestedMateList() {
		return "mypage/requestedMateList"; // JSP 페이지 이름
	}

	@GetMapping("/friendRequests.ajax")
	@ResponseBody // JSON 형식으로 응답
	public Map<String, Object> getFriendRequests(String page, String cnt, HttpSession session, Model model) {

		// 세션에서 사용자 ID를 가져오기
		String id = (String) session.getAttribute("loginId");
		if (id == null) {
			model.addAttribute("msg", "로그인이 필요합니다."); // 모델에 메시지 추가
			return null; // 에러 응답 반환
		}

		// 친구 요청 가져오기 (ID를 매개변수로 전달)
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);

		// 서비스 호출 시 ID 전달
		Map<String, Object> result = mypageService.getFriendRequests(page_, cnt_, id);
		logger.info("Result from service: {}", result);

		return result;
	}
	
	@GetMapping("/mypage/{userId}")
	public String getProfile(@PathVariable String userId, HttpSession session, Model model) {
	    String id = (String) session.getAttribute("loginId");
	    if (id == null) {
	        model.addAttribute("error", "로그인이 필요합니다."); // 모델에 에러 메시지 추가
	        return "errorPage"; // 에러 페이지로 리다이렉트
	    }

	    Map<String, Object> profileData = mypageService.getProfileData(userId);
	    model.addAttribute("profileDTO", profileData); // 프로필 데이터를 모델에 추가

	    return "mypage/ProfileDetail"; // JSP 페이지 이름 반환
	}

	@PostMapping(value = "/handleFriendRequest.ajax")
	@ResponseBody
	public Map<String, Object> handleFriendRequest(String unlikeId, String action, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		// 세션에서 사용자 ID를 가져오기
		String id = (String) session.getAttribute("loginId");
		if (id == null) {
			response.put("success", false);
			response.put("message", "로그인이 필요합니다.");
			return response;
		}

		try {
			if ("accept".equals(action)) {
				// 수락 처리 로직
				mypageService.acceptFriendRequest(id, unlikeId);
			} else if ("reject".equals(action)) {
				// 거절 처리 로직
				mypageService.rejectFriendRequest(id, unlikeId);
			}
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "처리 중 오류가 발생했습니다.");
			logger.error("Error handling friend request: {}", e.getMessage());
		}

		return response;
	}
	
	@GetMapping(value = "/requestingMateListView")
	public String requestingMateListView() {
		return "mypage/requestingMateList";
	}
	
	@GetMapping(value = "/appliedMates.ajax")
	@ResponseBody
	public Map<String, Object> getAppliedMates(String page, String cnt, HttpSession session, Model model) {
	    String id = (String) session.getAttribute("loginId");
	    if (id == null) {
	    	model.addAttribute("msg", "로그인이 필요합니다.");
	        return null;
	    }

	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);
	    
	    Map<String, Object> result = mypageService.getAppliedMates(page_, cnt_, id);
		logger.info("Result from service: {}", result);
	    
	    return result;
	}

	@PostMapping(value = "/cancelMateApplication.ajax")
	@ResponseBody
	public Map<String, Object> cancelMateApplication(String unlikeId, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    String id = (String) session.getAttribute("loginId");

	    // ID가 null인 경우 처리
	    if (id == null) {
	        response.put("success", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }

	    mypageService.cancelMateApplication(id, unlikeId);
	    response.put("success", true);

	    return response;
	}
	
	@GetMapping(value = "/myIconListView")
	public String myIconListView() {
		return "mypage/myIconList";
	}
	
	@GetMapping(value = "/myIconList.ajax")
	@ResponseBody // JSON 형식으로 응답
	public Map<String, Object> myIconList(String page, String cnt, HttpSession session, Model model) {

		// 세션에서 사용자 ID를 가져오기
		String id = (String) session.getAttribute("loginId");
		if (id == null) {
			model.addAttribute("msg", "로그인이 필요합니다."); // 모델에 메시지 추가
			return null; // 에러 응답 반환
		}

		// 친구 요청 가져오기 (ID를 매개변수로 전달)
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);

		// 서비스 호출 시 ID 전달
		Map<String, Object> result = mypageService.myIconList(page_, cnt_, id);
		logger.info("Result from service: {}", result);

		return result;
	}
	
}
