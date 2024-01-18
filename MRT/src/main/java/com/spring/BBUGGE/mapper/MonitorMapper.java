package com.spring.BBUGGE.mapper;

import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface MonitorMapper {
    public HashMap<String,Object> selectNum();
    // Database Info
    public HashMap<String,Object> selectDatabaseInfo();
    public HashMap<String,Object> selectDatabaseVersion();
    // Replication
    public HashMap<String,Object> selectReplCheck();
    public List<HashMap<String,Object>> selectReplGapList();
    public List<HashMap<String,Object>> selectReplGapForMonitorAjaxList();
    public List<HashMap<String,Object>> selectReplItemList();
    public List<HashMap<String,Object>> selectLogfileForReplList();
    public List<HashMap<String,Object>> selectReplWholeStatusList();
    // Memory
    public HashMap<String,Object> selectMemoryUsageWhenUseMemoryDB();
    // Tablespace Usage
    public List<HashMap<String,Object>> selectMemoryTablespaceUsageList();
    public List<HashMap<String,Object>> selectDiskTablespaceUsageList();
    // GC
    public List<HashMap<String,Object>> selectGCGapList();
    public List<HashMap<String,Object>> selectGCGapForMonitorAjaxList();
    public List<HashMap<String,Object>> selectQueryUsingGCByWaitingTransactionList();
    // Lock
    public HashMap<String,Object> selectLockCntForMonitorAjax();
    public List<HashMap<String,Object>> selectLockDetailList();
    // Session
    public HashMap<String,Object> selectActiveSessionCntForMonitorAjax();
    public HashMap<String,Object> selectPropertyMaxClient();
    // Statement
    public HashMap<String,Object> selectActiveStatementCntForMonitorAjax();
    public HashMap<String,Object> selectPropertyMaxStatementPerSession();
 // Slow Query
    public List<HashMap<String,Object>> selectSlowQueryList(HashMap<String,Object> paramMap);
    public List<HashMap<String,Object>> selectSessionStatementList();
    
}
