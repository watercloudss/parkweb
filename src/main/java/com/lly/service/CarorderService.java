package com.lly.service;

import com.lly.po.Carorder;

import java.util.List;
import java.util.Map;

public interface CarorderService {
    public int insertCarorder(Carorder carorder);

    public int updateCarorderEnd(Carorder carorder);

    public Carorder selectByCarNumber(String province, String carNumber);

    public Map<String, Object> systemState();

    public List<Carorder> selectByTime(int uid);

    public Carorder selectBySid(int sid);

    public Map<String, Object> selectCarorderCost(String province, String carNumber);
}
