package com.monitor.demos.service;

import java.util.List;
import java.util.Map;

import com.monitor.framework.base.service.BaseService;
import com.monitor.framework.dto.A5TopDTO;

public interface A5LogService extends BaseService {
	
	public String getMaxTimeOfA5Log();
	
	public List<String> getAppNames();
	
	public Long getVisitCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle);
	
	public Long getUsersCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle);
	
	public Long getNewUsersCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle);
	
	public Long getNewActivityCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle);
	
	public Map<Integer,Integer> getVisitCountByTimerangeAndCounttype(String starttime, String endtime,String apprange,String counttype,String distinctUser,String nickname,String entrytitle);
	
	public List<A5TopDTO> getVisitCountUserTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle);
	
	public List<A5TopDTO> getVisitCountModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle);
	
	public List<A5TopDTO> getCommentUserTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle);
	
	public List<A5TopDTO> getCommentModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle);
	
	public List<A5TopDTO> getClockModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle);
	
	public Map<String,Integer> getAppHot(String starttime, String endtime,String apprange,String nickname,String entrytitle);
}
