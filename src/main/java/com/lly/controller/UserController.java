package com.lly.controller;

import com.lly.po.User;
import com.lly.service.UserService;
import com.lly.utils.FileDelete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.UUID;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "login.action", method = RequestMethod.GET)
    public String login(HttpServletRequest request, Model model) {
        String msg = request.getParameter("msg");
        if (msg != null) {
            model.addAttribute("msg", msg);
        }
        return "login";
    }

    @RequestMapping(value = "deleteUser.action", method = RequestMethod.POST)
    @ResponseBody
    public String deleteUser(int id) {
        int flag = userService.deleteUser(id);
        System.out.println(flag);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "updateUserState.action", method = RequestMethod.POST)
    @ResponseBody
    public String updateUserState(int id, int state) {
        int flag = userService.updateUserState(state, id);
        System.out.println(flag);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "updateUserType.action", method = RequestMethod.POST)
    @ResponseBody
    public String updateUserType(int id, int type) {
        int flag = userService.updateUserType(type, id);
        System.out.println(flag);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "login.action", method = RequestMethod.POST)
    public String login(String username, String password, Model model, HttpSession session) {
        System.out.println("热部署成功了");
        System.out.println("卧槽");
        User user = userService.findUser(username, password);
        if (user != null) {
            session.setAttribute("USER_LOGIN", user);
            return "redirect:admin.action";
        }
        model.addAttribute("msg", "账号或密码错误，请重新输入！");
        return "redirect:login.action";
    }

    @RequestMapping(value = "/logout.action")
    public String logout(HttpSession session) {
        System.out.println("退出！");
        session.invalidate();
        return "redirect:login.action";
    }

    @RequestMapping(value = "/checkPassword.action", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkPassword(String password, HttpSession session) {
        User user = (User) session.getAttribute("USER_LOGIN");
        User u = userService.findUser(user.getUsername(), password);
        if (u != null) {
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/checkUsername.action", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkUsername(String username) {
        User u = userService.findByUsername(username);
        if (u != null) {
            return false;
        }
        return true;
    }

    @RequestMapping(value = "/checkCode.action", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkCode(String code) {
        User u = userService.findByCode(code);
        if (u != null) {
            return false;
        }
        return true;
    }

    @RequestMapping(value = "/updatePassword.action", method = RequestMethod.POST)
    public String updatePassword(String newPassword, HttpSession session, Model model) {
        User user = (User) session.getAttribute("USER_LOGIN");
        userService.updatePassword(user.getId(), newPassword);
        session.invalidate();
        model.addAttribute("msg", "密码修改成功，请重新登录！");
        return "redirect:login.action";
    }

    @RequestMapping(value = "/updateUserInfo.action", method = RequestMethod.POST)
    @ResponseBody
    public String updateUserInfo(String name, String email, String phone, String say, HttpSession session) {
        User user = (User) session.getAttribute("USER_LOGIN");
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setSay(say);
        int flag = userService.updateUserInfo(user);
        session.setAttribute("USER_LOGIN", user);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "/addUser.action", method = RequestMethod.POST)
    @ResponseBody
    public String addUser(String username, String code, String name, String sex, String email, String phone) {
        User user = new User();
        user.setCode(code);
        user.setUsername(username);
        user.setPassword(username);
        user.setName(name);
        user.setSex(Integer.parseInt(sex));
        user.setEmail(email);
        user.setPhone(phone);
        user.setHeadImg("headImgs/1.png");
        user.setSay("道路千万条，安全第一条；行车不规范，亲人两行泪！");
        user.setState(1);
        user.setType(0);
        int flag = userService.insertUser(user);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "/userSetting.action")
    public String userSetting() {
        return "userSetting";
    }

    @RequestMapping(value = "/fileUpload.action", method = RequestMethod.POST)
    public String handleFormUpload(@RequestParam("uploadfile") MultipartFile uploadfile, HttpServletRequest request,
                                   HttpSession session) {
        // 判断所上传文件是否存在
        if (!uploadfile.isEmpty()) {
            // 获取上传文件的原始名称
            String originalFilename = uploadfile.getOriginalFilename();
            // 设置上传文件的保存地址目录
            String dirPath = "/usr/local/imgs/";
            // 使用UUID重新命名上传的文件名称(上传人_uuid_原始文件名称)
            String newFilename = UUID.randomUUID().toString().substring(0, 11) + "_" + originalFilename;
            String filePath = "imgs/" + newFilename;
            User user = (User) session.getAttribute("USER_LOGIN");
            String oldImg = user.getHeadImg().replace("imgs/", "");
            userService.updateUserImg(filePath, user.getId());
            user.setHeadImg(filePath);
            session.setAttribute("USER_LOGIN", user);
            try {
                // 使用MultipartFile接口的方法完成文件上传到指定位置
                uploadfile.transferTo(new File(dirPath + newFilename));
            } catch (Exception e) {
                e.printStackTrace();
                return "error";
            }
            FileDelete.deleteFile(dirPath + oldImg);
            // 跳转到成功页面
            return "redirect:userSetting.action";
        } else {
            return "error";
        }
    }
}
