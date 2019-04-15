package com.lly.utils;

import com.alibaba.fastjson.JSONObject;

public class FastJson {
    public static String getJsonString(String str) {
        JSONObject jsonObject = JSONObject.parseObject(str);
        String r = jsonObject.getString("words_result");
        JSONObject jsonObject1 = JSONObject.parseObject(r);
        return jsonObject1.getString("number");
    }
}
