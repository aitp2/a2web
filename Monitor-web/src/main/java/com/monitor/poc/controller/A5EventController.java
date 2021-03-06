package com.monitor.poc.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.monitor.demos.service.A5LogService;
import com.monitor.framework.base.entity.A5Log;
import com.monitor.framework.base.entity.Function;
import com.monitor.framework.base.pojo.PageInfo;
import com.monitor.framework.dto.A5TopDTO;
import com.monitor.framework.dto.A5EventEntity;
import com.monitor.framework.dto.PageableEntity;
import com.monitor.framework.dto.ResultData;
import com.monitor.framework.dto.TracknumEntity;
import com.monitor.framework.util.HttpClientUtil;
import com.monitor.framework.util.HttpUtil;
import com.monitor.framework.utils.PropertiesUtil;

@Controller
@RequestMapping("a5")
public class A5EventController {
	
	@Resource
	private A5LogService a5LogService;
	
	/**
	 * 列表
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/list")
	private String list(Model model,
			@RequestParam(value = "module", required = false) String module,
			@RequestParam(value = "moduleEntryId", required = false) String moduleEntryId,
			@RequestParam(value = "moduleEntryTitle", required = false) String moduleEntryTitle,
			@RequestParam(value = "operator", required = false) String operator,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "nickname", required = false) String nickname,
			@RequestParam(value = "sex", required = false) String sex) {
		this.syncA5Log();
		if(module != null && module.equals("all")) {
			model.addAttribute("module", "");
		}else {
			model.addAttribute("module", module);
		}
		
		model.addAttribute("moduleEntryId", moduleEntryId);
		model.addAttribute("moduleEntryTitle", moduleEntryTitle);
		model.addAttribute("operator", operator);
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		model.addAttribute("nickname", nickname);
		model.addAttribute("sex", sex);
		return "base/a5Log/list";
	}
	
	/**
	 * dashboard
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "overview", method = RequestMethod.GET)
	public String overview(Model model,
			@RequestParam(value = "timerange", required = false) String timerange,
			@RequestParam(value = "apprange", required = false) String apprange,
			@RequestParam(value = "toprange", required = false) String toprange,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "counttype", required = false) String counttype,
			@RequestParam(value = "nickname", required = false) String nickname,
			@RequestParam(value = "entrytitle", required = false) String entrytitle) {
		this.syncA5Log();
		if(nickname != null && !nickname.equals("")) {
			nickname = nickname.replace("%20", " ");
			nickname = nickname.replace("%23", "#");
		}
		if(entrytitle != null && !entrytitle.equals("")) {
			entrytitle = entrytitle.replace("%20", " ");
			entrytitle = entrytitle.replace("%23", "#");
		}
		//设置时间范围：当天 前两天 前三天 本周 本月
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		if(starttime != null && !starttime.equals("")) {
			starttime = starttime.replace("T", " ");
		}
		if(endtime != null && !endtime.equals("")) {
			endtime = endtime.replace("T", " ");
		}
		if(timerange == null || timerange.equals("") || timerange.equals("today")){
			starttime = df.format(this.getTodayStartTime());
			endtime = df.format(this.getTodayEndTime());
		}else if(timerange.equals("todayAndBeforeOneDay")) {
			starttime = df.format(this.getTodayBeforeOneDayStartTime());
			endtime = df.format(this.getTodayEndTime());
		}else if(timerange.equals("todayAndBeforeTwoDay")) {
			starttime = df.format(this.getTodayBeforeTwoeDayStartTime());
			endtime = df.format(this.getTodayEndTime());
		}else if(timerange.equals("thisWeek")) {
			starttime = df.format(this.getBeginDayOfWeek());
			endtime = df.format(this.getEndDayOfWeek());
		}else if(timerange.equals("thisMonth")) {
			starttime = df.format(this.getBeginDayOfMonth());
			endtime = df.format(this.getEndDayOfMonth());
		}
		
		if(apprange == null || apprange.equals("") || apprange.equals("all")) {
			apprange = "all";
		}
		
		if(toprange == null || toprange.equals("")) {
			toprange = "10";
		}
		
		//查询活跃人次、活跃人数  新加入人数
		model.addAttribute("visitCount", a5LogService.getVisitCountByTimerange(starttime, endtime,apprange,nickname,entrytitle)); 
		model.addAttribute("usersCount", a5LogService.getUsersCountByTimerange(starttime, endtime,apprange,nickname,entrytitle)); 
		model.addAttribute("newUsersCount", a5LogService.getNewUsersCountByTimerange(starttime, endtime,apprange,nickname,entrytitle)); 
		model.addAttribute("newActivityCount", a5LogService.getNewActivityCountByTimerange(starttime, endtime,apprange,nickname,entrytitle)); 
		
		String message = "Internal Server Error";
		Map<String, String> para = new HashMap<String, String>();
		para.put("message", message==null?"":""+message.replace(" ", "%20")+"");
		para.put("starttime", starttime);
		para.put("endtime", endtime);
		para.put("size", "0");
		String result = "0";
		try {
			result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "queryAllMessage", para);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ResultData<List<TracknumEntity>> parseObject = JSON
				.parseObject(
						result,
						new TypeReference<ResultData<List<TracknumEntity>>>() {
						});
		if (parseObject.getCode() > 0) {
			model.addAttribute("errorNum", parseObject.getCode().toString()); 
		}else {
			model.addAttribute("errorNum", "0");
		}
		
		//按小时统计活跃人数与活跃人次曲线图
		Map<Integer,Integer> list_visitCount = a5LogService.getVisitCountByTimerangeAndCounttype( starttime,  endtime,apprange,counttype,"",nickname,entrytitle);
		Map<Integer,Integer> list_userCount = a5LogService.getVisitCountByTimerangeAndCounttype( starttime,  endtime,apprange,counttype,"DISTINCT",nickname,entrytitle);
		String visitArray = "",userArray = "";
		if(counttype == null ||counttype.equals("") || counttype.equals("hour")) {
			visitArray = this.countVisthandle(list_visitCount, 23,0);
			userArray = this.countVisthandle(list_userCount, 23,0);
			model.addAttribute("horizontalArray", "'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12','13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'");
		}else if(counttype.equals("weekday")) {
			visitArray = this.countVisthandle(list_visitCount, 6,0);
			userArray = this.countVisthandle(list_userCount, 6,0);
			model.addAttribute("horizontalArray", "'周日', '周一', '周二', '周三', '周四', '周五', '周六'");
		}else if(counttype.equals("day")) {
			List<String> array_day = this.getDayFromStartAndEndTime(starttime, endtime);
			visitArray = this.countVisthandleDay(list_visitCount, array_day);
			userArray = this.countVisthandleDay(list_userCount, array_day);
			model.addAttribute("horizontalArray",this.getHorizontalArrayDay(array_day));
		}else if(counttype.equals("month")) {
			visitArray = this.countVisthandle(list_visitCount, 12,1);
			userArray = this.countVisthandle(list_userCount, 12,1);
			model.addAttribute("horizontalArray", "'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'");
		}
		model.addAttribute("visitArray", visitArray); 
		model.addAttribute("userArray", userArray); 
		
		//活跃人排行 top10 low10    
		
		model.addAttribute("visitCountUserTop10List", a5LogService.getVisitCountUserTop10(starttime, endtime,apprange,toprange,nickname,entrytitle)); 
		model.addAttribute("visitCountModuleEntryTop10List", a5LogService.getVisitCountModuleEntryTop10(starttime, endtime,apprange,toprange,nickname,entrytitle)); 
		model.addAttribute("commentUserTop10List", a5LogService.getCommentUserTop10(starttime, endtime,apprange,toprange,nickname,entrytitle)); 
		model.addAttribute("commentModuleEntryTop10List", a5LogService.getCommentModuleEntryTop10(starttime, endtime,apprange,toprange,nickname,entrytitle)); 
		model.addAttribute("clockModuleEntryTop10List", a5LogService.getClockModuleEntryTop10(starttime, endtime,apprange,toprange,nickname,entrytitle)); 
		
		model.addAttribute("timerange",timerange);
		model.addAttribute("starttime",starttime);
		model.addAttribute("endtime",endtime);
		model.addAttribute("apprange", apprange);
		model.addAttribute("toprange", toprange);
		model.addAttribute("counttype", counttype==null?"hour":counttype);
		List<String> appnameList =  a5LogService.getAppNames();
		model.addAttribute("appnameList", appnameList);
		model.addAttribute("nickname", nickname);
		model.addAttribute("entrytitle",entrytitle);
		model.addAttribute("appHotLegend",this.getAppHotLegend(appnameList));
		model.addAttribute("appHotData",this.getAppHotdata(a5LogService.getAppHot(starttime, endtime, apprange, nickname, entrytitle)));
		return "base/a5Log/overview";
	}
	
	/**
	 * 直接es查询a5 log 
	 * @param model
	 * @param module
	 * @param moduleEntryId
	 * @param moduleEntryTitle
	 * @param operator
	 * @param starttime
	 * @param endtime
	 * @param nickname
	 * @param sex
	 * @param pagesize
	 * @param pagenum
	 * @return
	 */
	@RequestMapping(value = "a5Event", method = RequestMethod.GET)
	public String a5Event(Model model,
			@RequestParam(value = "module", required = false) String module,
			@RequestParam(value = "moduleEntryId", required = false) String moduleEntryId,
			@RequestParam(value = "moduleEntryTitle", required = false) String moduleEntryTitle,
			@RequestParam(value = "operator", required = false) String operator,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "nickname", required = false) String nickname,
			@RequestParam(value = "sex", required = false) String sex,
			@RequestParam(value = "pagesize", required = false) String pagesize,
			@RequestParam(value = "pagenum", required = false) String pagenum) {

		try {
			if(starttime != null) {
				starttime = starttime.replace("T", " ");
			}
			if(endtime != null) {
				endtime = endtime.replace("T", " ");
			}
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			String query = "";
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			boolean andflag = false;
			if(module != null && !module.equals("")) {
				query = andflag?" AND ":""+"module:"+module;
				andflag = true;
			}
			if(moduleEntryId != null && !moduleEntryId.equals("")) {
				query = andflag?" AND ":""+"moduleEntryId:"+moduleEntryId;
				andflag = true;
			}
			if(moduleEntryTitle != null && !moduleEntryTitle.equals("")) {
				query = andflag?" AND ":""+"moduleEntryTitle:"+ (moduleEntryTitle);
				andflag = true;
				
			}
			if(operator != null && !operator.equals("")) {
				query = andflag?" AND ":""+"operator:"+operator;
				andflag = true;
			}
			if(nickname != null && !nickname.equals("")) {
				query = andflag?" AND ":""+"nickname:"+(nickname);
				andflag = true;
			}
			if(sex != null && !sex.equals("")) {
				query = andflag?" AND ":""+"sex:"+sex;
				andflag = true;
			}
			
			//产品异常
			PageInfo pageInfo = new PageInfo();
			pageInfo.setPageSize(new Integer((pagesize==null||pagesize.equals(""))?"10":pagesize));
			pageInfo.setPageNum(new Integer((pagenum==null||pagenum.equals(""))?"1":pagenum));
			Map<String, String> para_product = new HashMap<String, String>();
			para_product.put("query", query);
			para_product.put("starttime", starttime);
			para_product.put("endtime", endtime);
			para_product.put("from", new Integer(pageInfo.getNumfrom()-1).toString());
			para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
			
			String result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "querya5event", para_product);
			ResultData<PageableEntity> parseObject = JSON
					.parseObject(
							result,
							new TypeReference<ResultData<PageableEntity>>() {
							});
			if (parseObject.getCode() > 0) {
				for(A5EventEntity a5EventEntity:parseObject.getSerializableData().getList_a5EventEntity()){
					if(a5EventEntity.getModuleEntryTitle() != null && !a5EventEntity.getModuleEntryTitle().equals("")) {
						a5EventEntity.setModuleEntryTitle(HttpUtil.baseDecoder(a5EventEntity.getModuleEntryTitle()));
					}
					a5EventEntity.setNickname(HttpUtil.baseDecoder(a5EventEntity.getNickname()));
				}
				pageInfo.setCount(new Long(parseObject.getSerializableData().getTotal()).intValue());
				model.addAttribute("eventList",
						parseObject.getSerializableData().getList_a5EventEntity());
				model.addAttribute("pageInfo", pageInfo);
			} else {
				model.addAttribute("eventList", null);
			}
			model.addAttribute("module", module);
			model.addAttribute("moduleEntryId", moduleEntryId);
			model.addAttribute("moduleEntryTitle", HttpUtil.baseDecoder(moduleEntryTitle) );
			model.addAttribute("operator", operator);
			model.addAttribute("nickname", HttpUtil.baseDecoder(nickname));
			model.addAttribute("sex", sex);
			model.addAttribute("pagesize", pagesize);
			model.addAttribute("pagenum", pagenum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "poc/a5Event";
	}
	
	private void syncA5Log() {
		try {
	    	String starttime = a5LogService.getMaxTimeOfA5Log();
	    	
	    	Date day=new Date();    
	    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	    	Map<String, String> para_product = new HashMap<String, String>();
			para_product.put("query", "");
			para_product.put("starttime", starttime);
			para_product.put("endtime", df.format(day));
			para_product.put("from", "0");
			para_product.put("size", "10000");
			
			String result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "querya5event", para_product);
			ResultData<PageableEntity> parseObject = JSON
					.parseObject(
							result,
							new TypeReference<ResultData<PageableEntity>>() {
							});
			
			List<A5Log> list_a5log = new ArrayList<A5Log> ();
			for(A5EventEntity a5EventEntity:parseObject.getSerializableData().getList_a5EventEntity()) {
				list_a5log.add(new A5Log(a5EventEntity));
			}
			a5LogService.batchSave(list_a5log);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//当天开始时间
	private Date getTodayStartTime() {
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR_OF_DAY, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		return todayStart.getTime();
	}
	
	//前一天开始时间
	private Date getTodayBeforeOneDayStartTime() {
			Calendar todayStart = Calendar.getInstance();
			todayStart.set(Calendar.DAY_OF_MONTH, todayStart.get(Calendar.DAY_OF_MONTH) -1);
			todayStart.set(Calendar.HOUR_OF_DAY, 0);
			todayStart.set(Calendar.MINUTE, 0);
			todayStart.set(Calendar.SECOND, 0);
			todayStart.set(Calendar.MILLISECOND, 0);
			return todayStart.getTime();
		}
		
	//当两天开始时间
	private Date getTodayBeforeTwoeDayStartTime() {
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.DAY_OF_MONTH, todayStart.get(Calendar.DAY_OF_MONTH) -2);
		todayStart.set(Calendar.HOUR_OF_DAY, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		return todayStart.getTime();
	}
 
	//当天结束时间
	private Date getTodayEndTime() {
		Calendar todayEnd = Calendar.getInstance();
		todayEnd.set(Calendar.HOUR_OF_DAY, 23);
		todayEnd.set(Calendar.MINUTE, 59);
		todayEnd.set(Calendar.SECOND, 59);
		todayEnd.set(Calendar.MILLISECOND, 999);
		return todayEnd.getTime();
	}
	
    //获取本周的开始时间
	private Date getBeginDayOfWeek() {
        Date date = new Date();
        if (date == null) {
            return null;
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int dayofweek = cal.get(Calendar.DAY_OF_WEEK);
        if (dayofweek == 1) {
            dayofweek += 7;
        }
        cal.add(Calendar.DATE, 1 - dayofweek);
        return getDayStartTime(cal.getTime());
    }
    
    //获取本周的结束时间
	private Date getEndDayOfWeek(){
        Calendar cal = Calendar.getInstance();
        cal.setTime(getBeginDayOfWeek());  
        cal.add(Calendar.DAY_OF_WEEK, 6); 
        Date weekEndSta = cal.getTime();
        return getDayEndTime(weekEndSta);
    }
    
    //获取本月的开始时间
	private Date getBeginDayOfMonth() {
            Calendar calendar = Calendar.getInstance();
            calendar.set(getNowYear(), getNowMonth() - 1, 1);
            return getDayStartTime(calendar.getTime());
        }
    //获取本月的结束时间
	private Date getEndDayOfMonth() {
            Calendar calendar = Calendar.getInstance();
            calendar.set(getNowYear(), getNowMonth() - 1, 1);
            int day = calendar.getActualMaximum(5);
            calendar.set(getNowYear(), getNowMonth() - 1, day);
            return getDayEndTime(calendar.getTime());
        }
     
   //获取某个日期的开始时间
	private Timestamp getDayStartTime(Date d) {
         Calendar calendar = Calendar.getInstance();
         if(null != d) calendar.setTime(d);
         calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),    calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
         calendar.set(Calendar.MILLISECOND, 0);
         return new Timestamp(calendar.getTimeInMillis());
     }
     //获取某个日期的结束时间
	private Timestamp getDayEndTime(Date d) {
         Calendar calendar = Calendar.getInstance();
         if(null != d) calendar.setTime(d);
         calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),    calendar.get(Calendar.DAY_OF_MONTH), 23, 59, 59);
         calendar.set(Calendar.MILLISECOND, 999);
         return new Timestamp(calendar.getTimeInMillis());
     }
     
     //获取今年是哪一年
	private Integer getNowYear() {
             Date date = new Date();
            GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
            gc.setTime(date);
            return Integer.valueOf(gc.get(1));
        }
     
     //获取本月是哪一月
	private int getNowMonth() {
             Date date = new Date();
            GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
            gc.setTime(date);
            return gc.get(2) + 1;
   }
	
	//处理统计数据
	private String countVisthandle(Map<Integer,Integer> list,int horizontalNum,int start) {
		String visitArray = "";
		for(int i=start;i<=horizontalNum;i++) {
				if(i== start){
					if(list.get(i) != null) {
						visitArray = list.get(i).toString();
					}else {
						visitArray = "0";
					}
				}else {
					if(list.get(i) != null) {
						visitArray = visitArray +","+ list.get(i);
					}else {
						visitArray = visitArray+","+"0" ;
					}
				}
		}
		return visitArray;
	}
	
	private List<String> getDayFromStartAndEndTime(String starttime,String endtime){
		List<String> list = new ArrayList<String>();
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
			cal.setTime(df.parse(starttime));
			while(1==1) {
				list.add(df.format(cal.getTime()));
				if(df.format(cal.getTime()).equals(endtime.substring(0, 10))) {
					break;
				}else {
					cal.set(Calendar.DAY_OF_MONTH,cal.get(Calendar.DAY_OF_MONTH)+1);
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		List<String> list_return = new ArrayList<String>();
		for(String s:list) {
			String s_r = s.replace("-", "");
			list_return.add(s_r);
		}
		return list_return;
	}
	
	private String countVisthandleDay(Map<Integer,Integer> list,List<String> datelist) {
		String visitArray = "";
		for(int i=0;i<datelist.size();i++) {
				if(i== 0){
					if(list.get(new Integer(datelist.get(i))) != null) {
						visitArray = list.get(new Integer(datelist.get(i))).toString();
					}else {
						visitArray = "0" +",";
					}
				}else {
					if(list.get(new Integer(datelist.get(i))) != null) {
						visitArray = visitArray +","+ list.get(new Integer(datelist.get(i)));
					}else {
						visitArray = visitArray+","+"0" ;
					}
				}
		}
		return visitArray;
	}
	
	private String getHorizontalArrayDay(List<String> datelist) {
		String array = "";
		for(int i=0;i<datelist.size();i++) {
			if(i == 0) {
				array = "'"+datelist.get(i)+"'";
			}else{
				array = array+ ","+"'"+datelist.get(i)+"'";
			}
		}
		return array;
	}
	
	private String getAppHotLegend(List<String> appnames) {
		int i = 0;
		String legend=  "";
		for(String app:appnames) {
			if(app.equals("fit")) {
				app = "小目标";
			}
			if(app.equals("pinfan")) {
				app = "小邀约";
			}
			if(i==0) {
				legend = "'"+app+"'";
			}else {
				legend = legend +","+"'"+app+"'";
			}
			i = i+1;
		}
		return legend;
	}
	
	private String getAppHotdata(Map<String,Integer> appHotdata) {
		int i = 0;
		String legend=  "";
		for(String app:appHotdata.keySet()) {
			String appName = "";
			if(app.equals("fit")) {
				appName = "小目标";
			}
			if(app.equals("pinfan")) {
				appName = "小邀约";
			}
			if(i==0) {
				legend = "{value:"+appHotdata.get(app)+", name:'"+appName+"'}";
			}else {
				legend = legend +","+"{value:"+appHotdata.get(app)+", name:'"+appName+"'}";
			}
			i = i+1;
		}
		return legend;
	}
}
