package com.lly.controller;

import com.lly.po.Carstation;
import com.lly.service.CarstationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CarstationController {
    @Autowired
    private CarstationService carstationService;

    @RequestMapping(value = "/carstationList.action")
    public String carport(Model model) {
        List<Carstation> cList = carstationService.cList();
        for (Carstation c : cList) {
            System.out.println(c);
        }
        model.addAttribute("cList", cList);
        return "carstationList";
    }

    @RequestMapping(value = "/addCarStation.action", method = RequestMethod.POST)
    @ResponseBody
    public String addCarStation(String name, String location, String description, String total, Double price, Double time) {
        Carstation cs = new Carstation();
        cs.setC_name(name);
        cs.setC_location(location);
        cs.setC_description(description);
        cs.setC_total(Integer.parseInt(total));
        cs.setC_price(price);
        cs.setC_pricetime(time);
        System.out.println(cs);
        int flag = carstationService.addCarstation(cs);
        System.out.println(price + "   " + time);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "updateCarstation.action", method = RequestMethod.POST)
    @ResponseBody
    public String updateCarstation(int id, String name, String location, String description, String total, Double price, Double time) {
        Carstation cs = new Carstation();
        cs.setC_id(id);
        cs.setC_name(name);
        cs.setC_location(location);
        cs.setC_description(description);
        cs.setC_price(price);
        cs.setC_pricetime(time);
        System.out.println(cs);
        int flag = carstationService.updateCarstation(cs);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "deleteCarStation.action", method = RequestMethod.POST)
    @ResponseBody
    public String deleteUser(int id) {
        int flag = carstationService.deleteCarstation(id);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

}
