package com.lly.controller;

import com.lly.po.Message;
import com.lly.po.User;
import com.lly.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Controller
public class MessageController {
    @Autowired
    private MessageService messageService;

    @RequestMapping(value = "message.action", method = RequestMethod.GET)
    public String message(Model model) {
        List<Message> ml = messageService.messageList();
        model.addAttribute("ml", ml);
        return "message";
    }

    @RequestMapping(value = "addMessage.action", method = RequestMethod.POST)
    @ResponseBody
    public String addMessage(String title, String content, HttpSession session) {
        User user = (User) session.getAttribute("USER_LOGIN");
        Message m = new Message();
        m.setContent(content);
        m.setCreatTime(new Timestamp(new Date().getTime()));
        m.setTitle(title);
        m.setUid(user.getId());
        System.out.println(m);
        int flag = messageService.insertMessage(m);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "deleteMessage.action", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMessage(int id) {
        int flag = messageService.deleteMessage(id);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }
}
