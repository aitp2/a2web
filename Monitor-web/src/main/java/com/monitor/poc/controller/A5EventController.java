package com.monitor.poc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
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

}
