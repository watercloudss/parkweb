package com.lly.po;

public class Carspace {
    private int s_id;
    private String s_name;
    private String s_location;
    private int s_type;
    private int s_state;
    private double s_price;
    private double s_pricetime;
    private int c_id;
    private Carstation carstation;

    public int getS_id() {
        return s_id;
    }

    public void setS_id(int s_id) {
        this.s_id = s_id;
    }

    public String getS_name() {
        return s_name;
    }

    public void setS_name(String s_name) {
        this.s_name = s_name;
    }

    public String getS_location() {
        return s_location;
    }

    public void setS_location(String s_location) {
        this.s_location = s_location;
    }

    public int getS_type() {
        return s_type;
    }

    public void setS_type(int s_type) {
        this.s_type = s_type;
    }

    public int getS_state() {
        return s_state;
    }

    public void setS_state(int s_state) {
        this.s_state = s_state;
    }

    public double getS_price() {
        return s_price;
    }

    public void setS_price(double s_price) {
        this.s_price = s_price;
    }

    public double getS_pricetime() {
        return s_pricetime;
    }

    public void setS_pricetime(double s_pricetime) {
        this.s_pricetime = s_pricetime;
    }

    public int getC_id() {
        return c_id;
    }

    public void setC_id(int c_id) {
        this.c_id = c_id;
    }

    public Carstation getCarstation() {
        return carstation;
    }

    public void setCarstation(Carstation carstation) {
        this.carstation = carstation;
    }

    @Override
    public String toString() {
        return "Carspace [s_id=" + s_id + ", s_name=" + s_name + ", s_location=" + s_location + ", s_type=" + s_type
                + ", s_state=" + s_state + ", s_price=" + s_price + ", s_pricetime=" + s_pricetime + ", c_id=" + c_id
                + ", carstation=" + carstation + "]";
    }

}
