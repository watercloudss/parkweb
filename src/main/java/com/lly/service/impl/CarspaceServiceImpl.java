package com.lly.service.impl;

import com.lly.dao.CarspaceDao;
import com.lly.po.Carspace;
import com.lly.po.Carstation;
import com.lly.service.CarspaceService;
import com.lly.service.CarstationService;
import com.lly.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CarspaceServiceImpl implements CarspaceService {
    @Autowired
    private CarspaceDao carspaceDao;
    @Autowired
    private CarstationService carstationService;

    @Override
    public int addCarspace(Carspace carspace) {
        return carspaceDao.insertCarspace(carspace);
    }

    @Override
    public int updateCarspace(Carspace carspace) {
        return carspaceDao.updateCarspace(carspace);
    }

    @Override
    public int updateCarspacePriceAndTime(Carspace carspace) {
        return carspaceDao.updateCarspacePriceAndTime(carspace);
    }

    @Override
    public int deleteCarspace(int sid, int cid, int ctotal) {
        Carstation carstation = new Carstation();
        carstation.setC_id(cid);
        carstation.setC_total(ctotal - 1);
        carstationService.updateCarstationTotal(carstation);
        return carspaceDao.deleteCarspace(sid);
    }

    @Override
    public Carstation getCarstation(int id) {
        List<Carstation> l = carspaceDao.carspaceListInto(id);
        return l.get(0);
    }

    @Override
    public Carspace selectById(int id) {
        Carspace carspace = carspaceDao.selectCpAndCsById(id);
        if (carspace == null) {
            return null;
        }
        return carspaceDao.selectCpAndCsById(id);
    }

    @Override
    public Carspace selectByName(String name) {
        return carspaceDao.selectByName(name);
    }

    @Override
    public Page<Carstation> detailsPage(int id, int page, int rows) {
        int count = carspaceDao.count(id);
        int start = (page - 1) * rows;
        System.out.println(start + " ------- " + count);
        List<Carstation> detailes = carspaceDao.carspaceList(id, start, rows);
        Page<Carstation> detailsPage = new Page<>();
        detailsPage.setPage(page);
        detailsPage.setRows(detailes);
        detailsPage.setSize(rows);
        detailsPage.setTotal(count);
        return detailsPage;
    }

}
