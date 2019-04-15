package com.lly.utils;

import java.util.Calendar;

public class Time {
    public static String getAmTimeByCalendar() {

        Calendar cal = Calendar.getInstance();

        int year = cal.get(Calendar.YEAR);// 获取年份

        int month = cal.get(Calendar.MONTH) + 1;// 获取月份

        int day = cal.get(Calendar.DAY_OF_MONTH);// 获取日

        System.out.println("现在的时间是：公元" + year + "年" + month + "月" + day + "日      ");
        String now = year + "-" + month + "-" + day + " " + "00:00:00";
        return now;
    }

    public static String getClickTimeByCalendar() {

        Calendar cal = Calendar.getInstance();

        int year = cal.get(Calendar.YEAR);// 获取年份

        int month = cal.get(Calendar.MONTH) + 1;// 获取月份

        int day = cal.get(Calendar.DAY_OF_MONTH);// 获取日

        int hour = cal.get(Calendar.HOUR_OF_DAY);// 小时

        int minute = cal.get(Calendar.MINUTE);// 分

        int second = cal.get(Calendar.SECOND);// 秒

        System.out
                .println("现在的时间是：公元" + year + "年" + month + "月" + day + "日      " + hour + "时" + minute + "分" + second);
        String now = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
        return now;
    }

}
