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
	 * app热度
	 */
	public Map<String,Integer> getAppHot(String starttime, String endtime,String apprange,String nickname,String entrytitle){
		StringBuilder strb = new StringBuilder();
		strb.append("SELECT MODULE AS module,COUNT(  nickname) countVisit FROM tbl_a5_log WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		if(!apprange.equals("all")) {
			strb.append(" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
		strb.append(" GROUP BY module ORDER BY module ");
		
    	List<Object[]> result = this.querySql(strb.toString());
    	Map<String,Integer> map = new HashMap<String,Integer>();
    	for (Object[] objects : result) {
			String app = objects[0].toString();
			String countVisit = objects[1].toString();
			map.put(app, new Integer(countVisit));
		}
    	return map;
	}
	
	/**
	 * 获取访问人次
	 */
	public Long getVisitCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT COUNT(NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
    	if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 获取访问人数
	 */
	public Long getUsersCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" );
		}else {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 获取新加入人员
	 */
	public Long getNewUsersCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATOR='newJoin' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT COUNT(DISTINCT NICKNAME) FROM TBL_A5_LOG WHERE OPERATOR='newJoin' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 获取新活动数
	 * @param starttime
	 * @param endtime
	 * @param apprange
	 * @return
	 */
	public Long getNewActivityCountByTimerange(String starttime, String endtime,String apprange,String nickname,String entrytitle) {
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT COUNT(DISTINCT MODULEENTRYTITLE) FROM TBL_A5_LOG WHERE OPERATOR='createActivity' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT COUNT(DISTINCT MODULEENTRYTITLE) FROM TBL_A5_LOG WHERE OPERATOR='createActivity' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'" +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	return this.countBySql(strb.toString());
	}
	
	/**
	 * 计算时、周天、天、月访问人次
	 */
	public Map<Integer,Integer> getVisitCountByTimerangeAndCounttype(String starttime, String endtime,String apprange,String counttype,String distinctUser,String nickname,String entrytitle){
		String counttypecondition = "";
		if(counttype == null ||counttype.equals("") || counttype.equals("hour")) {
			counttypecondition = "DATE_FORMAT( operatorTime, \"%H\" )";
		}else if(counttype.equals("weekday")) {
			counttypecondition = "DATE_FORMAT( operatorTime, \"%w\" )";
		}else if(counttype.equals("day")) {
			counttypecondition = "DATE_FORMAT(operatorTime,\"%Y%m%d\")";
		}else if(counttype.equals("month")) {
			counttypecondition = "DATE_FORMAT(operatorTime,\"%c\")";
		}
		StringBuilder strb = new StringBuilder();
		strb.append("SELECT "+counttypecondition+" AS counttype,COUNT( "+distinctUser+" nickname) countVisit FROM TBL_A5_LOG WHERE OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		if(!apprange.equals("all")) {
			strb.append(" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
		strb.append(" GROUP BY counttype ORDER BY counttype ");
		
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
	 * 获取访问量top10 user
	 */
	public List<A5TopDTO> getVisitCountUserTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	strb.append(" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
		return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}

	/**
	 * 获取访问量 top10活动
	 */
	public List<A5TopDTO> getVisitCountModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE        OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE        OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	strb.append(" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
		return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取评论量  top10 user
	 */
	public List<A5TopDTO> getCommentUserTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle){
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE OPERATOR='comment' AND  OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT nickname AS nickname, COUNT(nickname) AS visitCount FROM tbl_a5_log    WHERE OPERATOR='comment' AND OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')");
		}
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	strb.append(" GROUP BY nickname ORDER BY visitCount DESC LIMIT "+top);
    	return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取评论量 top10 活动
	 */
	public List<A5TopDTO> getCommentModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle){
		
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE   OPERATOR='comment' AND     OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE    OPERATOR='comment' AND    OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')");
		}   	
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	strb.append(" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
    	return this.getTop10SearchWithBasedecode(strb.toString(),top);
	}
	
	/**
	 * 获取打卡 top10 活动
	 */
	public List<A5TopDTO> getClockModuleEntryTop10(String starttime, String endtime,String apprange,String top,String nickname,String entrytitle){
		
		StringBuilder strb = new StringBuilder();
		if(apprange.equals("all")) {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE   OPERATOR='clock' AND     OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'");
		}else {
			strb.append("SELECT moduleEntryTitle AS moduleEntryTitle, COUNT(moduleEntryTitle) AS visitCount FROM tbl_a5_log    WHERE    OPERATOR='clock' AND    OPERATORTIME BETWEEN '"+starttime+"' AND '"+ endtime+"'"  +" AND MODULE IN ('"+apprange+"')");
		}   	
		if(nickname != null && !nickname.equals("")) {
    		strb.append(" AND NICKNAME = '"+HttpUtil.baseEncoder(nickname)+"'");
    	}
    	if(entrytitle != null && !entrytitle.equals("")) {
    		strb.append(" AND MODULEENTRYTITLE = '"+HttpUtil.baseEncoder(entrytitle)+"'");
    	}
    	strb.append(" GROUP BY    moduleEntryTitle ORDER BY visitCount desc LIMIT "+top);
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
