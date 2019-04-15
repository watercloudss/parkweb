package com.lly.controller;

import com.lly.po.Carspace;
import com.lly.po.Carstation;
import com.lly.service.CarspaceService;
import com.lly.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CarspaceController {
    @Autowired
    private CarspaceService carspaceService;

    @RequestMapping(value = "details.action", method = RequestMethod.GET)
    public String details(@RequestParam(defaultValue = "1") Integer page,
                          @RequestParam(defaultValue = "15") Integer rows, int id, Model model) {
        Page<Carstation> spage = carspaceService.detailsPage(id, page, rows);
        model.addAttribute("page", spage);
        model.addAttribute("sList", spage.getRows().get(0).getSpaceList());
        model.addAttribute("c", spage.getRows().get(0));
        return "csDetails";
    }

    @RequestMapping(value = "updateCarspace.action", method = RequestMethod.POST)
    @ResponseBody
    public String updateCarspace(int id, String name, String location, int type, double price, double time) {
        Carspace cp = new Carspace();
        cp.setS_id(id);
        cp.setS_location(location);
        cp.setS_name(name);
        cp.setS_price(price);
        cp.setS_pricetime(time);
        cp.setS_type(type);
        System.out.println(cp);
        int flag = carspaceService.updateCarspace(cp);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "deleteCarspace.action", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCarspace(int sid, int cid, int ctotal) {
        int flag = carspaceService.deleteCarspace(sid, cid, ctotal);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }

    @RequestMapping(value = "addCarspace.action", method = RequestMethod.POST)
    @ResponseBody
    public String addCarspace(int cid, String name, String location, int type, double price, double time) {
        Carspace cp = new Carspace();
        cp.setS_location(location);
        cp.setS_name(name);
        cp.setS_price(price);
        cp.setS_pricetime(time);
        cp.setS_type(type);
        cp.setC_id(cid);
        cp.setS_state(0);
        System.out.println(cp);
        int flag = carspaceService.addCarspace(cp);
        String msg = null;
        if (flag == 1) {
            msg = "OK";
            return msg;
        } else {
            return msg;
        }
    }
}
