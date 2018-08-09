package com.monitor.demos.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.monitor.demos.service.A5LogService;
import com.monitor.framework.base.entity.A5Log;
import com.monitor.framework.base.service.impl.BaseServiceImpl;
import com.monitor.framework.dto.A5TopDTO;
import com.monitor.framework.util.HttpUtil;

@Service("a5LogService")
public class A5LogServiceImpl extends BaseServiceImpl implements A5LogService {
	
	/**
	 * 获取日志表最新时间
	 */
	public String getMaxTimeOfA5Log() {
		A5Log a5log_temp = new A5Log();
		StringBuilder strb = new StringBuilder();
    	strb.append("SELECT * FROM TBL_A5_LOG ");
    	Object maxvalue = this.getMaxByExample(a5log_temp, "operatorTime", "", false);
    	String starttime = "1997-01-01 00:00:00";
    	if(maxvalue != null) {
    		starttime = (String)maxvalue;
    	}
    	return starttime;
	}
	
	/**
	 * 获取app列表
	 */
	public List<String> getAppNames(){
		StringBuilder strb = new StringBuilder();
    	strb.append("SELECT module,count(module) FROM tbl_a5_log  GROUP BY  module ");
    	List<Object[]> result = this.querySql(strb.toString());
    	List<String> list =  new ArrayList<String>();
    	for (Object[] objects : result) {
    		if(objects[0] != null) {
    			String appname = objects[0].toString();
    			list.add(appname);
    		}
		}
    	return list;
	}
	
	/**
	 * 获取访问人次
	 */
	public Long getVisitCountByTimerange(String starttime, String endtime,String apprange) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT COUNT(NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
    	
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 获取访问人数
	 */
	public Long getUsersCountByTimerange(String starttime, String endtime,String apprange) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" );
		}else {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
    	
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 获取新加入人员
	 */
	public Long getNewUsersCountByTimerange(String starttime, String endtime,String apprange) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATOR='newJoin' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATOR='newJoin' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
    	
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 计算每小时访问人次
	 */
	public Map<Integer,Integer> getVisitCountByTimerangePerHour(String starttime, String endtime,String apprange){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT DATE_FORMAT( operatorTime, \"%H\" ) AS hours,COUNT(nickname) countVisit FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY hours ORDER BY hours ");
		}else {
			strb.append("SELECT DATE_FORMAT( operatorTime, \"%H\" ) AS hours,COUNT(nickname) countVisit FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY hours ORDER BY hours ");
		}
    	
    	List<Object[]> result = this.querySql(strb.toString());
    	Map<Integer,Integer> map = new HashMap<Integer,Integer>();
    	for (Object[] objects : result) {
			String hours = objects[0].toString();
			String countVisit = objects[1].toString();
			map.put(new Integer(hours), new Integer(countVisit));
		}
    	return map;
	}
	
	/**
	 * 计算每小时访问人数
	 */
	public Map<Integer,Integer> getUsersCountByTimerangePerHour(String starttime, String endtime,String apprange){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT DATE_FORMAT( operatorTime, \"%H\" ) AS hours,COUNT(DISTINCT nickname) countUser FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY hours ORDER BY hours ");
		}else {
			strb.append("SELECT DATE_FORMAT( operatorTime, \"%H\" ) AS hours,COUNT(DISTINCT nickname) countUser FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY hours ORDER BY hours ");
		}
    	
    	List<Object[]> result = this.querySql(strb.toString());
    	Map<Integer,Integer> map = new HashMap<Integer,Integer>();
    	for (Object[] objects : result) {
			String hours = objects[0].toString();
			String countUser = objects[1].toString();
			map.put(new Integer(hours), new Integer(countUser));
		}
    	return map;
	}
	
	/**
	 * 获取访问量top10 user
	 */
	public List<A5TopDTO> getVisitCountUserTop10(String starttime, String endtime,String apprange,String top){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
		}else {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
		}
    	
		return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}

	/**
	 * 获取访问量 top10活动
	 */
	public List<A5TopDTO> getVisitCountModuleEntryTop10(String starttime, String endtime,String apprange,String top){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE        OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE        OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}
    	
		return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取评论量  top10 user
	 */
	public List<A5TopDTO> getCommentUserTop10(String starttime, String endtime,String apprange,String top){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE OPERATOR='comment' AND  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
		}else {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE OPERATOR='comment' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
		}
    	
    	return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取评论量 top10 活动
	 */
	public List<A5TopDTO> getCommentModuleEntryTop10(String starttime, String endtime,String apprange,String top){
		
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE   OPERATOR='comment' AND     OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE    OPERATOR='comment' AND    OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}   	
    	return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取打卡 top10 活动
	 */
	public List<A5TopDTO> getClockModuleEntryTop10(String starttime, String endtime,String apprange,String top){
		
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE   OPERATOR='clock' AND     OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE    OPERATOR='clock' AND    OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')"
	    			+" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		}   	
    	return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	private List<A5TopDTO> getTop10SearchWithBasedecode(String sql,String top){
		List<Object[]> result = this.querySql(sql);
    	List<A5TopDTO> list =  new ArrayList<A5TopDTO>();
    	int i = 1;
    	for (Object[] objects : result) {
    		if(objects[0] != null) {
    			String name = HttpUtil.baseDecoder(objects[0].toString());
    			String countVisit = objects[1].toString();
    			A5TopDTO a5TopDTO = new A5TopDTO();
    			a5TopDTO.setNo(i);
    			a5TopDTO.setName(name);
    			a5TopDTO.setCount(new Integer(countVisit));
    			list.add(a5TopDTO);
    			i = i +1;
    		}
			
		}
    	Integer num = new Integer(top);
    	if(i <= num) {
    		for(;i<(num+1);i++) {
    			A5TopDTO a5TopDTO = new A5TopDTO();
    			a5TopDTO.setNo(i);
    			a5TopDTO.setName("");
    			a5TopDTO.setCount(new Integer("0"));
    			list.add(a5TopDTO);
    		}
    	}
    	return list;
	}
	

}
