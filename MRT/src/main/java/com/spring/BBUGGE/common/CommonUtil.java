package com.spring.BBUGGE.common;


import sun.net.www.protocol.http.HttpURLConnection;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.Logger;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommonUtil {
	private CommonVariable commonVariable;
	public boolean isNull(Object obj) {
		boolean rtnBool = false;
		
		if(obj == null) {
			rtnBool = true;
		}else {
			if(obj instanceof String) {
				if(obj.toString().equals("")) {
					rtnBool = true;
				}
			}
		}
		
		return rtnBool;
	}
    public void setCookie(HashMap<String,Object> paramMap, HttpServletResponse response){
        Cookie cookie = new Cookie(paramMap.get("id").toString(),"true");
        cookie.setMaxAge(60*60*24);     //기간 하루로 설정
        cookie.setPath("/");            //모든 페이지에서 쿠키 리스트 볼 수 있게 설정
        response.addCookie(cookie);
    }
    public void removeCookie(HashMap<String,Object> paramMap, HttpServletResponse response){
        Cookie cookie = new Cookie(paramMap.get("id").toString(),null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
    public boolean existCookie(HashMap<String,Object> paramMap, HttpServletRequest request){
        boolean rtnBool = false;
        Cookie[] cookie = request.getCookies();
        if(cookie != null) {
            for (Cookie c : cookie) {
                if(!c.getName().equals("JSESSIONID")) {
                    if (paramMap.get("id").toString().equals(c.getName()) && "true".equals(c.getValue())) {
                        rtnBool = true;
                    }
                }
            }
        }
        return rtnBool;
    }
    public String errorMsg(int errorNum){
        String msg = "";
        if(errorNum == 400){
            msg = "잘못된 요청입니다.";
        }else if(errorNum == 403){
            msg = "접근이 금지되었습니다.";
        }else if(errorNum == 404){
            msg = "요청하신 페이지는 존재하지 않습니다.";
        }else if(errorNum == 405){
            msg = "요청된 메소드가 허용되지 않습니다. 관리자에게 문의하세요.";
        }else if(errorNum == 500){
            msg = "서버에 오류가 발생하였습니다. 관리자에게 문의하세요.";
        }else if(errorNum == 503){
            msg = "서비스를 사용할 수 없습니다. 관리자에게 문의하세요.";
        }else{
            msg = "예외가 발생했습니다. 관리자에게 문의하세요.";
        }
        return msg;
    }
    
    // Map안의 공백문자 null 값으로 변경
    public Map<String,Object> mapTrim(Map<String,Object> paramMap){

        for(String key : paramMap.keySet()){
            String value = (String)paramMap.get(key);
            if(value == ""){
                paramMap.put(key,null);
            }
        }
        return paramMap;
    }

    public boolean isNullMap(Map<String,Object> paramMap,String key){
        boolean resBool = false;
        try {
            if (!paramMap.isEmpty()) {
                if (paramMap.get(key) != null) {
                    if (paramMap.get(key).toString().equals("")) {
                        resBool = true;
                    }
                } else if (paramMap.get(key) == null) {
                    resBool = true;
                }
            } else {
                resBool = true;
            }
        }catch (NullPointerException e){
            e.printStackTrace();
        }
        return resBool;
    }
    
    public String getLocalSource(HttpServletRequest request, HttpSession session, HashMap<String,Object> paramMap){
        String uri = request.getScheme() + "://" +   // "http" + "://
                request.getServerName() +       // "myhost"
                ":" + request.getServerPort(); // ":" + "8080"


        String paramUrl = uri+paramMap.get("url").toString();
        Document doc = null;
        Map<String,String> tempMap = new HashMap<String, String>();

        // 세션을 보내줄 파라미터 변수에 담기
        HashMap<String,Object> loginMap = (HashMap<String,Object>)session.getAttribute("loginMap");
        if(loginMap != null) {
            for (String key : loginMap.keySet()){
                tempMap.put("session-"+key,String.valueOf(loginMap.get(key)));
                /*if(loginMap.get(key) instanceof Integer){

                }else if(loginMap.get(key) instanceof String){
                    tempMap.put(key,)
                }*/
            }
        }

        // 받아온 파라미터를 보내줄 파라미터 변수에 담기
        if(paramMap != null){
            for (String key : paramMap.keySet()){
                tempMap.put(key,String.valueOf(paramMap.get(key)));
            }
        }

        try {
            /*if(!isNullMap(paramMap,"param")) {
                param = "?" + paramMap.get("param").toString();
            }*/
            Connection conn = Jsoup.connect(paramUrl).header("Content-Type", "application/text;charset=UTF-8").userAgent(commonVariable.USER_AGENT).data(tempMap).method(Connection.Method.GET).ignoreContentType(true);
            doc = conn.get();
//            logger.debug(doc.toString());

        }catch (Exception e){
            e.printStackTrace();
        }
        return  doc.toString();
    }
    public void setSessionFromParam(HashMap<String,Object> paramMap,HttpSession session){
        Map<String,Object> loginMap = new HashMap<String,Object>();
        List<String> removeList = new ArrayList<String>();
        int cnt = 0;
        if(paramMap.size() > 0) {
            for (String key : paramMap.keySet()){
                String [] keyArr = key.split("-");
                if(keyArr[0].equals("session")){
                    loginMap.put(keyArr[1],paramMap.get(key));
                    removeList.add(key);
                }
                cnt++;
            }
            // 세션에 set할 loginMap 생성 후 paramMap에서 remove
            for(String key : removeList){
                paramMap.remove(key);
            }

            session.setAttribute("loginMap",loginMap);
        }
    }
}
