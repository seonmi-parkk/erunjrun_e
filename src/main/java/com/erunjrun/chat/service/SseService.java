package com.erunjrun.chat.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.erunjrun.chat.dao.ChatPersonalDAO;
import com.erunjrun.chat.dto.ChatPersonalDTO;

@Service
public class SseService {

	// 채팅방 별로 클라이언트를 관리하는 Map
    private final Map<String, List<SseEmitter>> roomEmitters = new HashMap<>();

    // 특정 채팅방에 새로운 SSE 연결 추가
    public SseEmitter addEmitter(String roomId) {
        SseEmitter emitter = new SseEmitter(0L); // 타임아웃 없는 SSE
        this.roomEmitters.computeIfAbsent(roomId, k -> new ArrayList<>()).add(emitter);

     // 연결 종료 시 Emitter 삭제
        emitter.onCompletion(() -> this.roomEmitters.get(roomId).remove(emitter));
        emitter.onTimeout(() -> this.roomEmitters.get(roomId).remove(emitter));

        return emitter;
    }

    // 특정 채팅방에 메시지 전송
    public void sendMessage(String roomId, String userId, String message) {
    	
    	// 날짜 비교 (날짜 바뀔경우 체크)
		LocalDateTime currentTime = LocalDateTime.now();
		//DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		//currentTime.format(dateFormatter));    //2024-10-28 10:51:43
    	
		Map<String, String> data = new HashMap<String, String>();
		data.put("userId", userId);
		data.put("time", currentTime.toString());
		data.put("message", message);
    	
    	
    	
        List<SseEmitter> emitters = this.roomEmitters.get(roomId);
        if (emitters != null) {
            List<SseEmitter> deadEmitters = new ArrayList<>();

            emitters.forEach(emitter -> {
                try {
                	// 데이터를 JSON으로 변환하여 전송
                    emitter.send(SseEmitter.event().name("message").data(message));
                } catch (IOException e) {
                    deadEmitters.add(emitter);  // 전송 실패한 emitter는 제거
                }
            });

            emitters.removeAll(deadEmitters);
        }
    }
	
	
}

