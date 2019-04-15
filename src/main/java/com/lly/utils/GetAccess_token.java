package com.lly.utils;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

/**
 * ???token??
 */
public class GetAccess_token {


    public static String getAuth() {
        // ????????? API Key ???????????
        String clientId = "GpAjPgOATFGUf67pwFKRp0kY";
        // ????????? Secret Key ???????????
        String clientSecret = "qREZf8u0QAgaZGT9j2MlXAmCOsc396Q2";
        return getAuth(clientId, clientSecret);
    }


    public static String getAuth(String ak, String sk) {
        // ???token???
        String authHost = "https://aip.baidubce.com/oauth/2.0/token?";
        String getAccessTokenUrl = authHost
                // 1. grant_type????????
                + "grant_type=client_credentials"
                // 2. ????????? API Key
                + "&client_id=" + ak
                // 3. ????????? Secret Key
                + "&client_secret=" + sk;
        try {
            URL realUrl = new URL(getAccessTokenUrl);
            // ???URL????????
            HttpURLConnection connection = (HttpURLConnection) realUrl.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();
            // ??????????????
            Map<String, List<String>> map = connection.getHeaderFields();
            // ???????��????????
            for (String key : map.keySet()) {
                System.err.println(key + "--->" + map.get(key));
            }
            // ???? BufferedReader???????????URL?????
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String result = "";
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
            /**
             * ?????????
             */
            System.err.println("result:" + result);
            JSONObject jsonObject = new JSONObject(result);
            String access_token = jsonObject.getString("access_token");
            return access_token;
        } catch (Exception e) {
            System.err.printf("???token????");
            e.printStackTrace(System.err);
        }
        return null;
    }

}
