package com.monitor.poc.controller;

import java.sql.Timestamp;
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
			@RequestParam(value = "apprange", required = false) String apprange) {
		this.syncA5Log();
		//设置时间范围：当天 前两天 前三天 本周 本月
		String starttime  = "",endtime="";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
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
		
		//查询活跃人次、活跃人数  新加入人数
		model.addAttribute("visitCount", a5LogService.getVisitCountByTimerange(starttime, endtime,apprange)); 
		model.addAttribute("usersCount", a5LogService.getUsersCountByTimerange(starttime, endtime,apprange)); 
		model.addAttribute("newUsersCount", a5LogService.getNewUsersCountByTimerange(starttime, endtime,apprange)); 
		
		//按小时统计活跃人数与活跃人次曲线图
		Map<Integer,Integer> list_visitCount = a5LogService.getVisitCountByTimerangePerHour( starttime,  endtime,apprange);
		Map<Integer,Integer> list_userCount = a5LogService.getUsersCountByTimerangePerHour( starttime,  endtime,apprange);
		String visitArray = "";
		for(int i=0;i<24;i++) {
				if(i==23) {
					if(list_visitCount.get(i) != null) {
						visitArray = visitArray +","+ list_visitCount.get(i);
					}else {
						visitArray = "0";
					}
				}else if(i== 0){
					if(list_visitCount.get(i) != null) {
						visitArray = list_visitCount.get(i).toString();
					}else {
						visitArray = "0" +",";
					}
				}else {
					if(list_visitCount.get(i) != null) {
						visitArray = visitArray +","+ list_visitCount.get(i);
					}else {
						visitArray = visitArray+","+"0" ;
					}
				}
		}
		String userArray = "";
		for(int i=0;i<24;i++) {
			if(i==23) {
				if(list_userCount.get(i) != null) {
					userArray = userArray +","+ list_userCount.get(i);
				}else {
					userArray = "0";
				}
			}else if(i== 0) {
				if(list_userCount.get(i) != null) {
					userArray = list_userCount.get(i).toString();
				}else {
					userArray = "0" +",";
				}
			}
			else {
				if(list_userCount.get(i) != null) {
					userArray = userArray +","+ list_userCount.get(i);
				}else {
					userArray = userArray  +","+ "0";
				}
			}
			
		}
		model.addAttribute("visitArray", visitArray); 
		model.addAttribute("userArray", userArray); 
		
		//活跃人排行 top10 low10    
		
		model.addAttribute("visitCountUserTop10List", a5LogService.getVisitCountUserTop10(starttime, endtime,apprange)); 
		model.addAttribute("visitCountModuleEntryTop10List", a5LogService.getVisitCountModuleEntryTop10(starttime, endtime,apprange)); 
		model.addAttribute("commentUserTop10List", a5LogService.getCommentUserTop10(starttime, endtime,apprange)); 
		model.addAttribute("commentModuleEntryTop10List", a5LogService.getCommentModuleEntryTop10(starttime, endtime,apprange)); 
		model.addAttribute("clockModuleEntryTop10List", a5LogService.getClockModuleEntryTop10(starttime, endtime,apprange)); 
		
		model.addAttribute("timerange",timerange);
		model.addAttribute("starttime",starttime);
		model.addAttribute("endtime",endtime);
		model.addAttribute("apprange", apprange);
		model.addAttribute("appnameList", a5LogService.getAppNames());
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
    public Date getBeginDayOfWeek() {
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
        cal.add(Calendar.DATE, 2 - dayofweek);
        return getDayStartTime(cal.getTime());
    }
    
    //获取本周的结束时间
    public Date getEndDayOfWeek(){
        Calendar cal = Calendar.getInstance();
        cal.setTime(getBeginDayOfWeek());  
        cal.add(Calendar.DAY_OF_WEEK, 6); 
        Date weekEndSta = cal.getTime();
        return getDayEndTime(weekEndSta);
    }
    
    //获取本月的开始时间
     public Date getBeginDayOfMonth() {
            Calendar calendar = Calendar.getInstance();
            calendar.set(getNowYear(), getNowMonth() - 1, 1);
            return getDayStartTime(calendar.getTime());
        }
    //获取本月的结束时间
     public Date getEndDayOfMonth() {
            Calendar calendar = Calendar.getInstance();
            calendar.set(getNowYear(), getNowMonth() - 1, 1);
            int day = calendar.getActualMaximum(5);
            calendar.set(getNowYear(), getNowMonth() - 1, day);
            return getDayEndTime(calendar.getTime());
        }
     
   //获取某个日期的开始时间
     public Timestamp getDayStartTime(Date d) {
         Calendar calendar = Calendar.getInstance();
         if(null != d) calendar.setTime(d);
         calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),    calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
         calendar.set(Calendar.MILLISECOND, 0);
         return new Timestamp(calendar.getTimeInMillis());
     }
     //获取某个日期的结束时间
     public Timestamp getDayEndTime(Date d) {
         Calendar calendar = Calendar.getInstance();
         if(null != d) calendar.setTime(d);
         calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),    calendar.get(Calendar.DAY_OF_MONTH), 23, 59, 59);
         calendar.set(Calendar.MILLISECOND, 999);
         return new Timestamp(calendar.getTimeInMillis());
     }
     
     //获取今年是哪一年
     public Integer getNowYear() {
             Date date = new Date();
            GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
            gc.setTime(date);
            return Integer.valueOf(gc.get(1));
        }
     
     //获取本月是哪一月
     public int getNowMonth() {
             Date date = new Date();
            GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
            gc.setTime(date);
            return gc.get(2) + 1;
        }
	
}
