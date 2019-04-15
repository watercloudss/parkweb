package com.lly.dao;

import com.lly.po.Carspace;
import com.lly.po.Carstation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarspaceDao {
    public int insertCarspace(Carspace carspace);

    public Carspace selectCpAndCsById(@Param("id") int id);

    public Carspace selectByName(@Param("name") String name);

    public List<Carstation> carspaceList(@Param("id") int id, @Param("start") int start, @Param("rows") int rows);

    public List<Carstation> carspaceListInto(@Param("id") int id);

    public int updateCarspace(Carspace carspace);

    public int updateCarspacePriceAndTime(Carspace carspace);

    public int updateCarspaceState(Carspace carspace);

    public int deleteCarspace(@Param("id") int id);

    public int count(@Param("id") int id);

    public int countSpace();

    public int countPark(@Param("state") int state);
}
