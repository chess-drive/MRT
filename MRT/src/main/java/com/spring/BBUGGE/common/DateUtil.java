package com.spring.BBUGGE.common;


import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

//날짜 관련 함수
public class DateUtil {
    public String today(String outFormat){      //오늘 날짜
        Calendar cal = Calendar.getInstance();
        if(outFormat == null){
            outFormat = "yyyy-MM-dd";
        }
        SimpleDateFormat formatter = new SimpleDateFormat(outFormat);
        String str = formatter.format(cal.getTime());
        return str;
    }
    public String dateEx(String format, int year, int month, int day, int hour, int minute, int sec, String outFormat){     //날짜 계산
        Calendar cal = Calendar.getInstance();
        if(format != null){
            int yy = Integer.parseInt(format.substring(0,4));
            int MM = Integer.parseInt(format.substring(5,7))-1;
            int dd = Integer.parseInt(format.substring(8,10));
            if(format.length() == 10){
                cal.set(yy,MM,dd);
            }else if(format.length() == 19){
                int hh = Integer.parseInt(format.substring(11,13));
                int mm = Integer.parseInt(format.substring(14,16));
                int ss = Integer.parseInt(format.substring(17,19));
                cal.set(yy,MM,dd,hh,mm,ss);
            }
        }
        cal.add(cal.YEAR,year);
        cal.add(cal.MONTH,month);
        cal.add(cal.DAY_OF_MONTH,day);
        cal.add(cal.HOUR_OF_DAY,hour);
        cal.add(cal.MINUTE,minute);
        cal.add(cal.SECOND,sec);

        if(outFormat == null){
            outFormat = "yyyy-MM-dd";
        }
        SimpleDateFormat formatter = new SimpleDateFormat(outFormat);
        String str = formatter.format(cal.getTime());

        return str;
    }
    public long toNumber(String date){
        Date rtnDate = null;
        long rtnDateNumber = 0;
        if(date != null) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                rtnDate = formatter.parse(date);
                rtnDateNumber = rtnDate.getTime() / 1000;
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return rtnDateNumber;
    }
}
