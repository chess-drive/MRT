package com.spring.BBUGGE.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.BBUGGE.common.CommonUtil;
import com.spring.BBUGGE.common.DateUtil;
import com.spring.BBUGGE.service.MonitorService;


/**
 * Handles requests for the application home page.
 */

@Controller
public class ModalController {
	@Autowired MonitorService monService;
	public CommonUtil commonUtil = new CommonUtil();
	public DateUtil dateUtil = new DateUtil();
	
	private static final Logger logger = LogManager.getLogger(ModalController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	// 상품 상세 모달
    @RequestMapping(value = "/modal/tbsUsgModal", method = RequestMethod.GET)
    public String productInfoModal(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        commonUtil.setSessionFromParam(paramMap,session);
        //HashMap<String, Object> loginMap = unLoginCheckAndGetLoginMapFromSession(request,response,session);
        
        List<HashMap<String,Object>> memTbsList = monService.selectMemoryTablespaceUsageList();
        List<HashMap<String,Object>> dskTbsList = monService.selectDiskTablespaceUsageList();



        request.setAttribute("memTbsList",memTbsList);
        request.setAttribute("dskTbsList",dskTbsList);
        request.setAttribute("paramMap",paramMap);
        
        return "/modal/tbsUsgModal";
    }
    @RequestMapping(value = "/modal/tbsUsgModalAjax", produces = "application/text; charset=utf8")
    public @ResponseBody String productInfoModalAjax(@RequestParam HashMap<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        String html = commonUtil.getLocalSource(request,session,paramMap);

        return html;
    }
	

}
