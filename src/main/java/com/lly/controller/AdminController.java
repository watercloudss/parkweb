package com.lly.controller;

import com.lly.po.Message;
import com.lly.po.User;
import com.lly.service.CarorderService;
import com.lly.service.MessageService;
import com.lly.service.UserService;
import com.lly.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private CarorderService carorderService;
    @Autowired
    private MessageService messageService;

    @RequestMapping(value = "/admin.action")
    public String admin(Model model) {
        Map<String, Object> s = carorderService.systemState();
        List<Message> ml = messageService.messageList();
        model.addAttribute("s", s);
        model.addAttribute("ml", ml);
        return "admin";
    }

    @RequestMapping(value = "/employee.action")
    public String employee(@RequestParam(defaultValue = "1") Integer page,
                           @RequestParam(defaultValue = "10") Integer rows, String code, String username, String name, Model model) {
        System.out.println(code + "  " + username + "  " + name);
        Page<User> userPage = userService.userPage(page, rows, code, username, name);
        model.addAttribute("page", userPage);
        return "employee";
    }

    @RequestMapping(value = "systemState.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> systemState() {
        Map<String, Object> s = carorderService.systemState();
        return s;
    }

}
