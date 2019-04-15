package com.lly.service.impl;

import com.lly.dao.CarorderDao;
import com.lly.dao.CarspaceDao;
import com.lly.dao.CarstationDao;
import com.lly.dao.UserDao;
import com.lly.po.Carorder;
import com.lly.po.Carspace;
import com.lly.po.User;
import com.lly.service.CarorderService;
import com.lly.utils.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CarorderServiceImpl implements CarorderService {
    @Autowired
    private CarorderDao carorderDao;
    @Autowired
    private CarspaceDao carspaceDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private CarstationDao carstationDao;

    @Override
    public int insertCarorder(Carorder carorder) {
        Carspace cs = new Carspace();
        cs.setS_id(carorder.getSid());
        cs.setS_state(1);
        carspaceDao.updateCarspaceState(cs);
        return carorderDao.insertCarorder(carorder);
    }

    @Override
    public Map<String, Object> systemState() {
        int pn = carspaceDao.countPark(1);
        int np = carspaceDao.countPark(0);
        int all = carspaceDao.countSpace();
        int k = carstationDao.count();
        Map<String, Object> s = new HashMap<String, Object>();
        s.put("pn", pn);
        s.put("np", np);
        s.put("all", all);
        s.put("k", k);
        return s;
    }

    @Override
    public Carorder selectByCarNumber(String province, String carNumber) {
        return carorderDao.selectCarorder(province, carNumber);
    }

    @Override
    public Carorder selectBySid(int sid) {
        return carorderDao.selectBySid(sid);
    }

    @Override
    public List<Carorder> selectByTime(int uid) {
        String amTime = Time.getAmTimeByCalendar();
        String clickTiem = Time.getClickTimeByCalendar();
        return carorderDao.carorderListBytime(amTime, clickTiem, uid);
    }

    @Override
    public int updateCarorderEnd(Carorder carorder) {
        Carspace ca = new Carspace();
        ca.setS_id(carorder.getSid());
        ca.setS_state(0);
        carspaceDao.updateCarspaceState(ca);
        return carorderDao.updateCarorderEnd(carorder);
    }

    @Override
    public Map<String, Object> selectCarorderCost(String province, String carNumber) {
        Carorder co = carorderDao.selectCarorder(province, carNumber);
        Map<String, Object> carCost = new HashMap<String, Object>();
        if (co != null) {
            Carspace carspace = carspaceDao.selectCpAndCsById(co.getSid());
            User user = userDao.selectUserById(co.getUid());
            Timestamp oneEndTime = new Timestamp(new Date().getTime());
            SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
            long endTime = oneEndTime.getTime();
            long startTime = co.getStartTime().getTime();
            double minute = (double) ((endTime - startTime) / (1000 * 60));
            double hour = minute / 60;
            double price = carspace.getS_price();
            double pricetime = carspace.getS_pricetime();
            double time = hour / pricetime;
            double cost = time * price;
            System.out.println(endTime + " " + startTime + "  " + minute + "  " + hour + "  " + time + "  " + cost);
            System.out.println(user);
            System.out.println(carspace);
            carCost.put("co", co);
            carCost.put("user", user);
            carCost.put("carspace", carspace);
            carCost.put("cost", String.format("%.2f", cost));
            carCost.put("startTime", s.format(startTime));
            carCost.put("endTime", s.format(oneEndTime));
            carCost.put("oneEndTime", oneEndTime);
            carCost.put("time", String.format("%.2f", time));
            return carCost;
        } else {
            carCost.put("co", co);
            return carCost;
        }

    }
}
