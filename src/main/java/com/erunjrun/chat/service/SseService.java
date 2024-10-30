package com.erunjrun.chat.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.erunjrun.chat.dao.ChatPersonalDAO;
import com.erunjrun.chat.dto.ChatPersonalDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class SseService {
	// ObjectMapper 초기화
	private final ObjectMapper objectMapper = new ObjectMapper();

	// 채팅방 별로 클라이언트를 관리하는 Map
    private final Map<String, List<SseEmitter>> roomEmitters = new HashMap<>();

    // 특정 채팅방에 새로운 SSE 연결 추가
    public SseEmitter addEmitter(String roomId) {
        SseEmitter emitter = new SseEmitter(0L); // 타임아웃 없는 SSE
        this.roomEmitters.computeIfAbsent(roomId, k -> new ArrayList<>()).add(emitter);

        emitter.onCompletion(() -> this.roomEmitters.get(roomId).remove(emitter));
        emitter.onTimeout(() -> this.roomEmitters.get(roomId).remove(emitter));
        emitter.onError((e) -> {
            roomEmitters.get(roomId).remove(emitter);
            // IOException 발생 시 처리: 로깅 또는 에러 처리 로직 추가
            System.out.println("SSE connection error: " + e.getMessage());
            emitter.completeWithError(e); 
        });
        
        return emitter;
    }

    // 특정 채팅방에 메시지 전송
    public void sendMessage(String roomId, String userId, String message) {
    	 // 현재 시간 가져오기
        LocalDateTime currentTime = LocalDateTime.now();

        // 전송할 데이터 (JSON 형태로 묶음)
        Map<String, String> data = new HashMap<>();
        data.put("userId", userId);            // 사용자 ID
        data.put("time", currentTime.toString()); // 현재 시간
        data.put("message", message);          // 메시지

        
    	
        List<SseEmitter> emitters = this.roomEmitters.get(roomId);
        if (emitters != null) {
            List<SseEmitter> deadEmitters = new ArrayList<>();

            for (Iterator<SseEmitter> iterator = emitters.iterator(); iterator.hasNext(); ) {
                SseEmitter emitter = iterator.next();
                try {
                	 String jsonData = objectMapper.writeValueAsString(data); // JSON 문자열로 변환
                     emitter.send(SseEmitter.event().name("message").data(jsonData));
                } catch (IOException e) {
                    deadEmitters.add(emitter);  // 전송 실패한 emitter는 제거
                    System.out.println("Failed to send SSE message: " + e.getMessage());
                    iterator.remove(); // 실패한 emitter를 즉시 리스트에서 제거
                }
            }
            
        }
    }
	
	
}

