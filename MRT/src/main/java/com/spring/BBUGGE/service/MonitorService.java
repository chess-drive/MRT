package com.spring.BBUGGE.service;

import com.spring.BBUGGE.controller.HomeController;
import com.spring.BBUGGE.mapper.MonitorMapper;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
public class MonitorService {
    @Resource private MonitorMapper monMapper;
    private static final Logger logger = LogManager.getLogger(MonitorService.class);
    
    public HashMap<String,Object> selectNum() {
    	return monMapper.selectNum();
    }
    
    // Database Info
    public HashMap<String,Object> selectDatabaseInfo(){
    	return monMapper.selectDatabaseInfo();
    }
    public HashMap<String,Object> selectDatabaseVersion(){
    	return monMapper.selectDatabaseVersion();
    }
    
    // Replication
    public HashMap<String,Object> selectReplCheck(){
    	return monMapper.selectReplCheck();
    }
    public List<HashMap<String,Object>> selectReplGapList(){
    	return monMapper.selectReplGapList();
    }
    public List<HashMap<String,Object>> selectReplGapForMonitorAjaxList(){
    	return monMapper.selectReplGapForMonitorAjaxList();
    }
    public List<HashMap<String,Object>> selectReplItemList(){
    	return monMapper.selectReplItemList();
    }
    public List<HashMap<String,Object>> selectLogfileForReplList(){
    	return monMapper.selectLogfileForReplList();
    }
    public List<HashMap<String,Object>> selectReplWholeStatusList(){
    	return monMapper.selectReplWholeStatusList();
    }
    
    // Memory
    public List<HashMap<String,Object>> selectMemoryUsageWhenUseMemoryDBForMonitorAjaxList(){
    	List<HashMap<String,Object>> memList = new ArrayList<HashMap<String,Object>>();
    	HashMap<String,Object> memMap = monMapper.selectMemoryUsageWhenUseMemoryDB();
    	int cnt = 0;
    	
    	
    	memList.add(new HashMap<String,Object>(){
    		{
    			put("KEY","MAX("+memMap.get("UNIT").toString()+")");
    			put("VALUE",memMap.get("MAX"));
    			}
    		});
    	memList.add(new HashMap<String,Object>(){
    		{
    			put("KEY","TOTAL("+memMap.get("UNIT").toString()+")");
    			put("VALUE",memMap.get("TOTAL"));
    			}
    		});
    	memList.add(new HashMap<String,Object>(){
    		{
    			put("KEY","ALLOC("+memMap.get("UNIT").toString()+")");
    			put("VALUE",memMap.get("ALLOC"));
    			}
    		});
    	memList.add(new HashMap<String,Object>(){
    		{
    			put("KEY","USED("+memMap.get("UNIT").toString()+")");
    			put("VALUE",memMap.get("USED"));
    			}
    		});
    	return memList;
    }
    // Tablespace Usage
    public List<HashMap<String,Object>> selectMemoryTablespaceUsageList(){
    	return monMapper.selectMemoryTablespaceUsageList();
    }
    public List<HashMap<String,Object>> selectDiskTablespaceUsageList(){
    	return monMapper.selectDiskTablespaceUsageList();
    }
    
    // GC
    public List<HashMap<String,Object>> selectGCGapList(){
    	return monMapper.selectGCGapList();
    }
    public List<HashMap<String,Object>> selectGCGapForMonitorAjaxList(){
    	return monMapper.selectGCGapForMonitorAjaxList();
    }
    public List<HashMap<String,Object>> selectQueryUsingGCByWaitingTransactionList(){
    	return monMapper.selectQueryUsingGCByWaitingTransactionList();
    }
    
    // Lock
    public HashMap<String,Object> selectLockCntForMonitorAjax(){
    	return monMapper.selectLockCntForMonitorAjax();
    }
    public List<HashMap<String,Object>> selectLockDetailList(){
    	return monMapper.selectLockDetailList();
    }
    
    // Session
    public HashMap<String,Object> selectActiveSessionCntForMonitorAjax(){
    	return monMapper.selectActiveSessionCntForMonitorAjax();
    }
    public HashMap<String,Object> selectPropertyMaxClient(){
    	return monMapper.selectPropertyMaxClient();
    }
    
    // Statement
    public HashMap<String,Object> selectActiveStatementCntForMonitorAjax(){
    	return monMapper.selectActiveStatementCntForMonitorAjax();
    }
    public HashMap<String,Object> selectPropertyMaxStatementPerSession(){
    	return monMapper.selectPropertyMaxStatementPerSession();
    }
    
    // Slow Query
    public List<HashMap<String,Object>> selectSlowQueryList(HashMap<String,Object> paramMap){
    	return monMapper.selectSlowQueryList(paramMap);
    }
    
    public List<HashMap<String,Object>> selectSessionStatementList(){
    	return monMapper.selectSessionStatementList();
    }
}
