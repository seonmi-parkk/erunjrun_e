package com.erunjrun.chat.controller;

import com.erunjrun.chat.dto.ChatCrewLeaderDTO;
import com.erunjrun.chat.service.ChatPersonalService;
import com.erunjrun.main.controller.AlarmController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class ChatPersonalController {

    private final ChatPersonalService chatPersonalService;
    private final AlarmController alarm_controller;

    public ChatPersonalController(ChatPersonalService chatPersonalService, AlarmController alarm_controller) {
        this.chatPersonalService = chatPersonalService;
        this.alarm_controller = alarm_controller;
    }

    Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping("/chat/{id}/{unlikeId}")
    @ResponseBody
    public Map<String, Object> getChat(@PathVariable String id, @PathVariable String unlikeId, HttpSession session, Model model) {
        Map<String, Object> data = new HashMap<String, Object>();

        // 채팅방 넘버 체크
        String roomNum = chatPersonalService.getRoomNum(id, unlikeId);
        // 없으면 생성
        if (roomNum == null) {
            roomNum = chatPersonalService.createRoom(id, unlikeId);
        }
        data.put("roomNum", roomNum);
        return data;
    }

    @GetMapping("chat/{roomNum}")
    public String openChat(@PathVariable String roomNum, Model model) {
        model.addAttribute("roomNum", roomNum);
        return "chat/personalChat";
    }

    @GetMapping("/chat/data/{chatIdx}")
    @ResponseBody
    public Map<String, Object> getContent(@PathVariable String chatIdx, HttpSession session) {
        String baseUser = (String) session.getAttribute("loginId");
        return chatPersonalService.getContent(chatIdx, baseUser);
    }

    @PostMapping("/chat/send")
    @ResponseBody
    public Map<String, Object> sendMessage(@RequestBody Map<String, Object> param) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("result", chatPersonalService.sendMessage(param));

        try {
            int idx = Integer.parseInt(param.get("chatIdx").toString());
            String id = (String) param.get("otherUser");
            String from_id = param.get("baseUser").toString();
            alarm_controller.personalChat(idx, id, from_id);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("chatIdx 또는 baseUser 값이 없습니다: " + e.getMessage());
        }
        return data;
    }

    @PostMapping("/chat/exit/{chatIdx}")
    @ResponseBody
    public Map<String, Object> exitRoom(@PathVariable String chatIdx, HttpSession session) {
        String user = (String) session.getAttribute("loginId");
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", chatPersonalService.exitRoom(chatIdx, user));
        return result;
    }

    //크루장 채팅
    @GetMapping("/crewMgchat/{crewIdx}/{userId}")
    @ResponseBody
    public Map<String, Object> getCrewLeaderChat(@PathVariable String crewIdx, @PathVariable String userId) {
        Map<String, Object> data = new HashMap<String, Object>();
        // 채팅방 번호 조회
        String roomNum = chatPersonalService.getCrewLeaderChat(crewIdx, userId);
        data.put("roomNum", roomNum);
        return data;
    }

    @GetMapping("/crewLdchat/{crewIdx}")
    @ResponseBody
    public Map<String, Object> getCrewLeaderChat(@PathVariable String crewIdx, HttpSession session) {
        Map<String, Object> data = new HashMap<String, Object>();
        String baseUser = (String) session.getAttribute("loginId");
        // 채팅방 번호 조회
        String roomNum = chatPersonalService.getCrewLeaderChat(crewIdx, baseUser);
        // 없으면 생성
        if (roomNum == null) {
            roomNum = chatPersonalService.createCrewLeaderRoom(crewIdx, baseUser);
        }
        data.put("roomNum", roomNum);
        return data;
    }


    @GetMapping("/crewLdchat/open/{roomNum}")
    public String openCrewLeaderChat(@PathVariable String roomNum, Model model) {
        model.addAttribute("roomNum", roomNum);
        return "chat/crewLeaderChat";
    }

    @GetMapping("/crewLdchat/data/{chatIdx}")
    @ResponseBody
    public Map<String, Object> getCrewLeaderContent(@PathVariable String chatIdx, HttpSession session) {
        String baseUser = (String) session.getAttribute("loginId");
        return chatPersonalService.getCrewLeaderContent(chatIdx, baseUser);
    }

    // 크루장 1:1 채팅 전송 (크루장, 일반 사용자 포함)
    @PostMapping("/crewLdchat/send")
    @ResponseBody
    public Map<String, Object> sendCrewLeaderMessage(@RequestBody Map<String, Object> param) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("result", chatPersonalService.sendCrewLeaderMessage(param));

        try {
            int idx = Integer.parseInt(param.get("chatIdx").toString());
            String from_id = param.get("baseUser").toString();
            String code = "P";
            alarm_controller.crewChat(idx, from_id, code);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("chatIdx 또는 baseUser 값이 없습니다: " + e.getMessage());
        }

        return data;
    }

    @PostMapping("/crewLdchat/exit/{chatIdx}")
    @ResponseBody
    public Map<String, Object> exitCrewLeaderRoom(@PathVariable String chatIdx, HttpSession session) {
        String user = (String) session.getAttribute("loginId");
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", chatPersonalService.exitCrewLeaderRoom(chatIdx, user));
        return result;
    }

    @GetMapping("/crewLdchatList/{crew_idx}")
    @ResponseBody
    public List<ChatCrewLeaderDTO> crewLeaderChatList(@PathVariable String crew_idx) {
        return chatPersonalService.crewLeaderChatList(crew_idx);
    }

    @GetMapping("/crewLdchatList/full")
    @ResponseBody
    public List<ChatCrewLeaderDTO> crewLeaderChatListFull(
        @RequestParam String crew_idx,
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "cnt", defaultValue = "15") int cnt,
        @RequestParam(defaultValue = "", value = "keyword") String keyword) {

        int crew_idxs = Integer.parseInt(crew_idx);
        return chatPersonalService.crewLeaderChatListFull(crew_idxs, page, cnt, keyword);
    }

}
