package com.lly.po;

import java.util.List;

public class Carstation {
    private Integer c_id;
    private String c_code;
    private String c_name;
    private Integer c_total;
    private String c_location;
    private String c_description;
    private double c_price;
    private double c_pricetime;
    private List<Carspace> spaceList;

    public Integer getC_id() {
        return c_id;
    }

    public void setC_id(Integer c_id) {
        this.c_id = c_id;
    }

    public String getC_code() {
        return c_code;
    }

    public void setC_code(String c_code) {
        this.c_code = c_code;
    }

    public String getC_name() {
        return c_name;
    }

    public void setC_name(String c_name) {
        this.c_name = c_name;
    }

    public Integer getC_total() {
        return c_total;
    }

    public void setC_total(Integer c_total) {
        this.c_total = c_total;
    }

    public String getC_location() {
        return c_location;
    }

    public void setC_location(String c_location) {
        this.c_location = c_location;
    }

    public String getC_description() {
        return c_description;
    }

    public void setC_description(String c_description) {
        this.c_description = c_description;
    }

    public double getC_price() {
        return c_price;
    }

    public void setC_price(double c_price) {
        this.c_price = c_price;
    }

    public double getC_pricetime() {
        return c_pricetime;
    }

    public void setC_pricetime(double c_pricetime) {
        this.c_pricetime = c_pricetime;
    }

    public List<Carspace> getSpaceList() {
        return spaceList;
    }

    public void setSpaceList(List<Carspace> spaceList) {
        this.spaceList = spaceList;
    }

    @Override
    public String toString() {
        return "Carstation [c_id=" + c_id + ", c_code=" + c_code + ", c_name=" + c_name + ", c_total=" + c_total
                + ", c_location=" + c_location + ", c_description=" + c_description + ", c_price=" + c_price
                + ", c_pricetime=" + c_pricetime + ", spaceList=" + spaceList + "]";
    }

}
