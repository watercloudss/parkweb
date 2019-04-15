package com.lly.service.impl;

import com.lly.dao.CarstationDao;
import com.lly.po.Carspace;
import com.lly.po.Carstation;
import com.lly.service.CarspaceService;
import com.lly.service.CarstationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class CarstationServiceImpl implements CarstationService {
    @Autowired
    private CarstationDao carstationDao;
    @Autowired
    private CarspaceService carspaceService;

    @Override
    public int addCarstation(Carstation carstation) {
        carstation.setC_code(UUID.randomUUID().toString().substring(0, 5));
        int flag = carstationDao.insertCarstation(carstation);
        String c_code = carstation.getC_code();
        System.out.println(c_code);
        int c_id = carstationDao.selectByCode(c_code);
        for (int i = 1; i <= carstation.getC_total(); i++) {
            Carspace csp = new Carspace();
            csp.setS_name(carstation.getC_name() + "--" + i);
            csp.setS_state(0);
            csp.setS_type(1);
            csp.setS_price(carstation.getC_price());
            csp.setS_pricetime(carstation.getC_pricetime());
            csp.setC_id(c_id);
            carspaceService.addCarspace(csp);
        }
        return flag;
    }

    @Override
    public int updateCarstationTotal(Carstation carstation) {
        return carstationDao.updateCarstationTotal(carstation);
    }

    @Override
    public int deleteCarstation(int id) {
        return carstationDao.deleteCarstation(id);
    }

    @Override
    public int updateCarstation(Carstation carstation) {
        int flag = carstationDao.updateCarstation(carstation);
        Carspace csp = new Carspace();
        csp.setS_price(carstation.getC_price());
        csp.setS_pricetime(carstation.getC_pricetime());
        csp.setC_id(carstation.getC_id());
        carspaceService.updateCarspacePriceAndTime(csp);
        return flag;
    }

    @Override
    public List<Carstation> cList() {
        return carstationDao.cList();
    }

}
