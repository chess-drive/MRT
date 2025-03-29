package com.spring.BBUGGE.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
public class HomeController {
	@Autowired MonitorService monService;
	public CommonUtil commonUtil = new CommonUtil();
	public DateUtil dateUtil = new DateUtil();
	
	private static final Logger logger = LogManager.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/", "/monitor"}, method = RequestMethod.GET)
	public String home(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String,Object> propMap = new HashMap<String,Object>();
		Map<String,Object> dbInfo = monService.selectDatabaseInfo();
		Map<String,Object> dbVer = monService.selectDatabaseVersion();
		Map<String,Object> replChkMap = monService.selectReplCheck();
		
		List<HashMap<String,Object>> sessStmtList = monService.selectSessionStatementList();
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		
		propMap.putAll(monService.selectPropertyMaxClient());
		propMap.putAll(monService.selectPropertyMaxStatementPerSession());
		
		request.setAttribute("paramMap", paramMap);
		request.setAttribute("now", now);
		request.setAttribute("dbInfo", dbInfo);
		request.setAttribute("dbVer", dbVer);
		request.setAttribute("propMap", propMap);
		request.setAttribute("sessStmtList", sessStmtList);
		request.setAttribute("replChkMap", replChkMap);
		
		return "monitor/monitor";
	}
	
	@RequestMapping(value = "/monitorAjax", method = RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> monitorAjax(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String,Object> rtnMap = new HashMap<String,Object>();
		boolean replBool = false;
		List<HashMap<String,Object>> replGapList = null;
		List<HashMap<String,Object>> replItemList = null;
		List<HashMap<String,Object>> replWholeStatusList = null;
		
		
		// memory 1
		List<HashMap<String,Object>> memList = monService.selectMemoryUsageWhenUseMemoryDBForMonitorAjaxList();
		
		// GC 2
		List<HashMap<String,Object>> gcGapList = monService.selectGCGapForMonitorAjaxList();

		// Active Session Count 3
		Map<String,Object> actSessMap = monService.selectActiveSessionCntForMonitorAjax();
		
		// Active Statement Count 4
		Map<String,Object> actStmtMap = monService.selectActiveStatementCntForMonitorAjax();
		
		// Lock 5
		Map<String,Object> lockMap = monService.selectLockCntForMonitorAjax();
		// Lock Detail

		// Replication 6
		Map<String,Object> replChkMap = monService.selectReplCheck();
		if(replChkMap.get("REPL_CHK") != null) {
			replBool = (String.valueOf(replChkMap.get("REPL_CHK")).equals("0"))?false:true;
		}
		
		if(replBool) {
			replGapList = monService.selectReplGapForMonitorAjaxList();
		}
		
		List<HashMap<String,Object>> sessStmtList = monService.selectSessionStatementList();
		

		
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("monitorAjax");
		
		rtnMap.put("now", now);
		rtnMap.put("memList", memList);
		rtnMap.put("gcGapList", gcGapList);
		rtnMap.put("actSessMap", actSessMap);
		rtnMap.put("actStmtMap", actStmtMap);
		rtnMap.put("lockMap", lockMap);
		rtnMap.put("replGapList", replGapList);
		rtnMap.put("sessStmtList", sessStmtList);
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/lockDetail", method = RequestMethod.GET)
	public String lockDetail(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {
		
		List<HashMap<String,Object>> lockDetailList = monService.selectLockDetailList();

		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("lockDetail");
		
		request.setAttribute("paramMap", paramMap);
		request.setAttribute("now", now);
		request.setAttribute("lockDetailList", lockDetailList);
		
		return "monitor/lockDetail";
	}
	
	@RequestMapping(value = "/lockDetailAjax", method = RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> lockDetailAjax(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String,Object> rtnMap = new HashMap<String,Object>();
		List<HashMap<String,Object>> lockDetailList = monService.selectLockDetailList();
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("lockDetailAjax");
		
		rtnMap.put("now", now);
		rtnMap.put("lockDetailList", lockDetailList);
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/gcDetail", method = RequestMethod.GET)
	public String gcDetail(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {
		
		List<HashMap<String,Object>> gcDetailList = monService.selectGCGapList();
		List<HashMap<String,Object>> gcQueryList = monService.selectQueryUsingGCByWaitingTransactionList();

		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("gcDetail");
		
		request.setAttribute("paramMap", paramMap);
		request.setAttribute("now", now);
		request.setAttribute("gcDetailList", gcDetailList);
		request.setAttribute("gcQueryList", gcQueryList);
		
		return "monitor/gcDetail";
	}
	
	@RequestMapping(value = "/gcDetailAjax", method = RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> gcDetailAjax(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String,Object> rtnMap = new HashMap<String,Object>();
		List<HashMap<String,Object>> gcDetailList = monService.selectGCGapList();
		List<HashMap<String,Object>> gcQueryList = monService.selectQueryUsingGCByWaitingTransactionList();
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("gcDetailAjax");
		
		rtnMap.put("now", now);
		rtnMap.put("gcDetailList", gcDetailList);
		rtnMap.put("gcQueryList", gcQueryList);
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/stmtDetail", method = RequestMethod.GET)
	public String stmtDetail(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {
		
		List<HashMap<String,Object>> slowQueryList = monService.selectSlowQueryList(paramMap);

		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("stmtDetail");
		
		request.setAttribute("paramMap", paramMap);
		request.setAttribute("now", now);
		request.setAttribute("slowQueryList", slowQueryList);
		
		return "monitor/stmtDetail";
	}
	
	@RequestMapping(value = "/stmtDetailAjax", method = RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> stmtDetailAjax(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String,Object> rtnMap = new HashMap<String,Object>();
		List<HashMap<String,Object>> slowQueryList = monService.selectSlowQueryList(paramMap);
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("stmtDetailAjax");
		
		rtnMap.put("now", now);
		rtnMap.put("slowQueryList", slowQueryList);
		
		return rtnMap;
	}

	@RequestMapping(value = "/replDetail", method = RequestMethod.GET)
	public String replDetail(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {
		
		List<HashMap<String,Object>> replDetailList = monService.selectReplWholeStatusList();

		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("replDetail");
		
		request.setAttribute("paramMap", paramMap);
		request.setAttribute("now", now);
		request.setAttribute("replDetailList", replDetailList);
		
		return "monitor/replDetail";
	}
	
	@RequestMapping(value = "/replDetailAjax", method = RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> replDetailAjax(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String,Object> rtnMap = new HashMap<String,Object>();
		List<HashMap<String,Object>> replDetailList = monService.selectReplWholeStatusList();
		
		String now = dateUtil.today("yyyy-MM-dd HH:mm:ss");
		logger.error("replDetailAjax");
		
		rtnMap.put("now", now);
		rtnMap.put("replDetailList", replDetailList);
		
		return rtnMap;
	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(@RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) {
		return "/test";
	}
	

}
