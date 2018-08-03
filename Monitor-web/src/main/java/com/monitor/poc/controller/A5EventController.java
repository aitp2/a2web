package com.monitor.poc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.monitor.framework.base.pojo.PageInfo;
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
	private String list() {
		this.syncA5Log();
		return "base/a5Log/list";
	}
	
	/**
	 * dashboard
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "a5Overview", method = RequestMethod.GET)
	public String a5Overview(Model model,
			@RequestParam(value = "timerange", required = true) String timerange) {
		this.syncA5Log();
		//设置时间范围：当天 前两天 前三天 本周 本月
		String starttime  = "",endtime="";
		if(timerange == null || timerange.equals("") || timerange.equals("today")){
			
		}
		
		//查询活跃人次、活跃人数 打卡人数
		
		//按小时统计活跃人数与活跃人次曲线图
		
		//活跃人排行 top10 low10      
		return "poc/a5Overview";
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
			A5Log a5log_temp = new A5Log();
			StringBuilder strb = new StringBuilder();
	    	strb.append("select * from tbl_a5_log ");
	    	Object maxvalue = a5LogService.getMaxByExample(a5log_temp, "operatorTime", "", false);
	    	String starttime = "1997-01-01 00:00:00";
	    	if(maxvalue != null) {
	    		starttime = (String)maxvalue;
	    	}
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
	
	private Date getStartTime() {
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		return todayStart.getTime();
	}
 
	private Date getEndTime() {
		Calendar todayEnd = Calendar.getInstance();
		todayEnd.set(Calendar.HOUR, 23);
		todayEnd.set(Calendar.MINUTE, 59);
		todayEnd.set(Calendar.SECOND, 59);
		todayEnd.set(Calendar.MILLISECOND, 999);
		return todayEnd.getTime();
	}
	
}
