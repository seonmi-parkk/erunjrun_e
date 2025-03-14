package com.erunjrun.chat.controller;

import com.erunjrun.chat.service.ChatGroupService;
import com.erunjrun.main.controller.AlarmController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@Controller
public class ChatGroupController {

    private final ChatGroupService chatGroupService;
    private final AlarmController alarm_controller;

    public ChatGroupController(ChatGroupService chatGroupService, AlarmController alarm_controller) {
        this.chatGroupService = chatGroupService;
        this.alarm_controller = alarm_controller;
    }

    Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping("/crewChat/{crewIdx}")
    @ResponseBody
    public Map<String, Object> getCrewChat(@PathVariable String crewIdx) {
        Map<String, Object> data = new HashMap<String, Object>();

        // 채팅방 번호 조회
        String roomNum = chatGroupService.getCrewChat(crewIdx);
        data.put("roomNum", roomNum);
        return data;
    }

    @GetMapping("/crewChat/open/{crew_idx}/{roomNum}")
    public String openCrewChat(@PathVariable String roomNum, @PathVariable String crew_idx, Model model) {
        model.addAttribute("roomNum", roomNum);
        model.addAttribute("crewIdx", crew_idx);
        return "chat/crewChat";
    }

    @GetMapping("/crewChat/data/{crewIdx}/{chatIdx}")
    @ResponseBody
    public Map<String, Object> getCrewContent(@PathVariable String crewIdx, @PathVariable String chatIdx, HttpSession session) {
        return chatGroupService.getCrewContent(crewIdx, chatIdx);
    }

    @PostMapping("/crewChat/send")
    @ResponseBody
    public Map<String, Object> sendCrewMessage(@RequestBody Map<String, Object> param) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("result", chatGroupService.sendCrewMessage(param));

        try {
            int idx = Integer.parseInt(param.get("chatIdx").toString());
            String from_id = param.get("baseUser").toString();
            String code = "C";
            alarm_controller.crewChat(idx, from_id, code);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("chatIdx 또는 baseUser 값이 없습니다: " + e.getMessage());
        }
        return data;
    }


}
