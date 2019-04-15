package com.lly.service;

import com.lly.po.Carspace;
import com.lly.po.Carstation;
import com.lly.utils.Page;

public interface CarspaceService {
    public int addCarspace(Carspace carspace);

    public int updateCarspace(Carspace carspace);

    public int updateCarspacePriceAndTime(Carspace carspace);

    public int deleteCarspace(int sid, int cid, int ctotal);

    public Carspace selectById(int id);

    public Carspace selectByName(String name);

    public Carstation getCarstation(int id);

    public Page<Carstation> detailsPage(int id, int page, int rows);

}
