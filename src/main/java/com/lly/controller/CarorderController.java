package com.lly.controller;

import com.lly.po.Carorder;
import com.lly.po.Carspace;
import com.lly.po.Carstation;
import com.lly.po.User;
import com.lly.service.CarorderService;
import com.lly.service.CarspaceService;
import com.lly.service.CarstationService;
import com.lly.utils.FastJson;
import com.lly.utils.HttpURLconn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CarorderController {
    @Autowired
    private CarstationService carstationService;
    @Autowired
    private CarspaceService carspaceService;
    @Autowired
    private CarorderService carorderService;

    @RequestMapping(value = "carInto.action", method = RequestMethod.GET)
    public String carInto(Model model) {
        List<Carstation> cs = carstationService.cList();
        Carstation c = carspaceService.getCarstation(cs.get(0).getC_id());
        model.addAttribute("cs", cs);
        model.addAttribute("c", c);
        return "carInto";
    }

    @RequestMapping(value = "today.action", method = RequestMethod.GET)
    public String today(Model model, HttpSession session) {
        User user = (User) session.getAttribute("USER_LOGIN");
        List<Carorder> coList = carorderService.selectByTime(user.getId());
        double cost = 0.0;
        for (Carorder c : coList) {
            cost += c.getCost();
        }
        model.addAttribute("coList", coList);
        model.addAttribute("cost", cost);
        model.addAttribute("count", coList.size());
        return "today";
    }

    @RequestMapping(value = "carInto.action", method = RequestMethod.POST)
    public String carInto(int cid, Model model) {
        List<Carstation> cs = carstationService.cList();
        Carstation c = carspaceService.getCarstation(cid);
        model.addAttribute("cs", cs);
        model.addAttribute("c", c);
        return "carInto";
    }

    @RequestMapping(value = "getOrderInfo.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getOrderInfo(int sid) {
        Carorder co = carorderService.selectBySid(sid);
        SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("co", co);
        map.put("startTime", s.format(co.getStartTime()));
        return map;
    }

    @RequestMapping(value = "endCarorder.action", method = RequestMethod.POST)
    @ResponseBody
    public String endCarorder(int oid, int sid, double time, double cost, Long endTime) {
        System.out.println(endTime);
        Carorder co = new Carorder();
        co.setId(oid);
        co.setSid(sid);
        co.setCost(cost);
        co.setTime(time);
        co.setEndTime(new Timestamp(endTime));
        co.setState(1);
        String msg = null;
        int flag = carorderService.updateCarorderEnd(co);
        if (flag != 0) {
            msg = "OK";
            return msg;
        } else {
            return "";
        }
    }

    @RequestMapping(value = "searchcarnumber.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> searchcarnumber(String selectId, String carNumber) {
        Carorder co = carorderService.selectByCarNumber(selectId, carNumber);
        Carspace cs = null;
        Map<String, Object> carInfo = new HashMap<String, Object>();
        if (co == null) {
            carInfo.put("co", co);
            carInfo.put("cs", cs);
            return carInfo;
        }
        cs = carspaceService.selectById(co.getSid());
        carInfo.put("co", co);
        carInfo.put("cs", cs);
        return carInfo;
    }

    @RequestMapping(value = "searchcaspace.action", method = RequestMethod.POST)
    @ResponseBody
    public Carspace searchcaspace(String carspacename) {
        Carspace carspace = carspaceService.selectByName(carspacename);
        return carspace;
    }

    @RequestMapping(value = "addCarorder.action", method = RequestMethod.POST)
    @ResponseBody
    public String addCarorder(int sid, int cid, int uid, String selectId, String car_number, String car_name,
                              String car_phone) {
        Carorder co = new Carorder();
        co.setProvince(selectId);
        co.setCarNumber(car_number);
        co.setCustomerName(car_name);
        co.setCustomerPhone(car_phone);
        co.setCost(0.0);
        co.setTime(0.0);
        co.setCid(cid);
        co.setSid(sid);
        co.setUid(uid);
        co.setStartTime(new Timestamp(new Date().getTime()));
        co.setState(0);
        int flag = carorderService.insertCarorder(co);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "selectCarorder.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectCarorder(String selectId, String car_num) {
        System.out.println(selectId + "  " + car_num);
        Map<String, Object> carCost = carorderService.selectCarorderCost(selectId, car_num);
        return carCost;
    }

    @RequestMapping(value = "OCRNumberPark.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> OCRNumberPark(String Base64Image) {
        String bImg = Base64Image.substring(23);
        String msg = null;
        try {
            msg = HttpURLconn.getCarCarNumber(bImg);
            String carnumber = FastJson.getJsonString(msg);
            String province = carnumber.substring(0, 1);
            String number = carnumber.substring(1);
            Map<String, Object> carNumber = new HashMap<String, Object>();
            carNumber.put("province", province);
            carNumber.put("number", number);
            return carNumber;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "OCRNumber.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> OCNumber(String Base64Image) {
        String bImg = Base64Image.substring(23);
        String msg = null;
        try {
            msg = HttpURLconn.getCarCarNumber(bImg);
            String carnumber = FastJson.getJsonString(msg);
            String province = carnumber.substring(0, 1);
            String carNumber = carnumber.substring(1);
            Map<String, Object> carCost = carorderService.selectCarorderCost(province, carNumber);
            return carCost;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
