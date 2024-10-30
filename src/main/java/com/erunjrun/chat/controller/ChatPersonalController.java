package com.erunjrun.chat.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.erunjrun.chat.service.ChatPersonalService;
import com.erunjrun.chat.service.SseService;



@Controller
public class ChatPersonalController {

	@Autowired ChatPersonalService chatPersonalService;
	@Autowired SseService sseService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	 @GetMapping("/chat/{id}/{unlikeId}")
	 @ResponseBody
     public Map<String, Object> getChat(@PathVariable String id, @PathVariable String unlikeId, HttpSession session, Model model){
		 Map<String, Object> data = new HashMap<String, Object>();

		 //check!! 임시세션 나중에 빼기
		session.setAttribute("loginId", "kimee01");
		logger.info("id: {}, unlikeId: {}",id,unlikeId);
		// 채팅방 넘버 체크
		String roomNum = chatPersonalService.getRoomNum(id,unlikeId);
		logger.info("roomNum"+roomNum);
		//model.addAttribute("roomNum", roomNum);
		// 없으면 생성
		if(roomNum == null) {
			roomNum = chatPersonalService.createRoom(id,unlikeId);
		}
		
		data.put("roomNum", roomNum);
        return data;
    }
	 
	 @GetMapping("chat/{roomNum}")
     public String openChat(@PathVariable String roomNum, Model model){
		 model.addAttribute("roomNum", roomNum);
        return "chat/personalChat";
    }

	 @GetMapping("/chat/data/{chatIdx}")
	 @ResponseBody
	 public Map<String, Object> getContent(@PathVariable String chatIdx, HttpSession session){
		
		 String baseUser = (String) session.getAttribute("loginId");
		 Map<String, Object> values = chatPersonalService.getContent(chatIdx, baseUser);
		 
		 return values;
	 }
	
	 @PostMapping("/chat/send")
	 @ResponseBody
	 public Map<String, Object> sendMessage(@RequestBody Map<String, Object> param){
		 Map<String, Object> data = new HashMap<String, Object>();
		 data.put("result", chatPersonalService.sendMessage(param));
		 return data;
	 }

	 @PostMapping("/chat/exit/{chatIdx}")
	 @ResponseBody
	 public Map<String, Object> exitRoom(@PathVariable String chatIdx, HttpSession session){
		 String user = (String) session.getAttribute("loginId");
		 Map<String, Object> result = new HashMap<String, Object>();
		 result.put("success", chatPersonalService.exitRoom(chatIdx, user));
		 return result;
	 }
	 
	 // 전송시 상대방 창 업데이트
//	 @PostMapping("/chat/update")
//	    public SseEmitter streamSse() {
//	        SseEmitter emitter = new SseEmitter();
//
//	        new Thread(() -> {
//	            try {
//	                // 5초마다 메시지 전송
//	                for (int i = 0; i < 10; i++) {
//	                    emitter.send("Message " + i);
//	                    Thread.sleep(5000);
//	                }
//	                emitter.complete();
//	            } catch (IOException | InterruptedException e) {
//	                emitter.completeWithError(e);
//	            }
//	        }).start();
//
//	        return emitter;
//	    }
	 
	 
	// 채팅 메시지 전송 - 특정 채팅방에 메시지 전송
	    @PostMapping("/chat/update/{roomId}")
	    @ResponseBody //check!!
	    public String postMessage(@PathVariable String roomId, @RequestParam String message, HttpSession session) {
	        // 1. 메시지 저장 로직 (데이터베이스에 roomId와 함께 저장)
	        // 예시: messageRepository.save(new Message(roomId, message));

	    	String userId = (String) session.getAttribute("loginId");
	    	
	        // 2. 해당 채팅방의 클라이언트에게만 메시지 전송
	        sseService.sendMessage(roomId, userId, message);

	        return "Message sent successfully!";
	    }

	    
	    /*
	    // 특정 채팅방에 대한 SSE 연결 설정
	    @GetMapping("/chat/{roomId}/sse")
	    public SseEmitter streamSse(@PathVariable String roomId, HttpSession session) {
	    	 SseEmitter emitter = sseService.addEmitter(roomId);
	    	 
	    	emitter.onError((e) -> {
	            System.out.println("SSE connection error: " + e.getMessage());
	            emitter.complete();  // 오류 발생 시 연결 종료
	        });
	    	
	    	return emitter;
	        
	    }

	    @ExceptionHandler(IOException.class)
	    public ResponseEntity<String> handleIOException(IOException e) {
	        // SSE에서 발생하는 IOException 처리
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body("SSE 연결 중 오류 발생: " + e.getMessage());
	    }
	 	*/
	    
	    
	    
	    /////////////////////크루장 채팅
	    
		 @GetMapping("/crewLdchat/{crewIdx}")
		 @ResponseBody
	     public Map<String, Object> getCrewLeaderChat(@PathVariable String crewIdx, HttpSession session){
			 Map<String, Object> data = new HashMap<String, Object>();
			 String baseUser = (String) session.getAttribute("loginId");
			 logger.info("crewIdx : {}, baseUser: {}",crewIdx,baseUser);
			 data.put("roomNum", chatPersonalService.getCrewLeaderChat(crewIdx,baseUser));
			
	        return data;
	    }
	    
	
		 @GetMapping("/crewLdchat/open/{roomNum}")
	     public String openCrewLeaderChat(@PathVariable String roomNum, Model model){
			 model.addAttribute("roomNum", roomNum);
	        return "chat/crewLeaderChat";
	    }
	
		 @GetMapping("/crewLdchat/data/{chatIdx}")
		 @ResponseBody
		 public Map<String, Object> getCrewLeaderContent(@PathVariable String chatIdx, HttpSession session){
			 String baseUser = (String) session.getAttribute("loginId");
			 Map<String, Object> values = chatPersonalService.getCrewLeaderContent(chatIdx, baseUser);
			 
			 return values;
		 }

	    
	 
}
