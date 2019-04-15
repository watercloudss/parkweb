package com.lly.dao;

import com.lly.po.Carorder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarorderDao {
    public int insertCarorder(Carorder carorder);

    public int updateCarorderEnd(Carorder carorder);

    public List<Carorder> carorderListBytime(@Param("amTime") String amTime, @Param("clickTime") String clickTime,
                                             @Param("uid") int uid);

    public Carorder selectBySid(@Param("sid") int sid);

    public Carorder selectCarorder(@Param("province") String province, @Param("carNumber") String carNumber);
}
