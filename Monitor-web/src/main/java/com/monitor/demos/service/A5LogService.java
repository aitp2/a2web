package com.monitor.demos.service;

import java.util.List;
import java.util.Map;

import com.monitor.framework.base.service.BaseService;
import com.monitor.framework.dto.A5TopDTO;

public interface A5LogService extends BaseService {
	
	public String getMaxTimeOfA5Log();
	
	public List<String> getAppNames();
	
	public Long getVisitCountByTimerange(String starttime, String endtime,String apprange);
	
	public Long getUsersCountByTimerange(String starttime, String endtime,String apprange);
	
	public Long getNewUsersCountByTimerange(String starttime, String endtime,String apprange);
	
	public Map<Integer,Integer> getVisitCountByTimerangePerHour(String starttime, String endtime,String apprange);
	
	public Map<Integer,Integer> getUsersCountByTimerangePerHour(String starttime, String endtime,String apprange);
	
	public List<A5TopDTO> getVisitCountUserTop10(String starttime, String endtime,String apprange);
	
	public List<A5TopDTO> getVisitCountModuleEntryTop10(String starttime, String endtime,String apprange);
	
	public List<A5TopDTO> getCommentUserTop10(String starttime, String endtime,String apprange);
	
	public List<A5TopDTO> getCommentModuleEntryTop10(String starttime, String endtime,String apprange);
	
	public List<A5TopDTO> getClockModuleEntryTop10(String starttime, String endtime,String apprange);
}
