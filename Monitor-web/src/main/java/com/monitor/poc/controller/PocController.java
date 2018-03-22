package com.monitor.poc.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.monitor.framework.base.pojo.ResultCode;
import com.monitor.framework.dto.OrderStatusEntity;
import com.monitor.framework.dto.OrderStatusMonitorDTO;
import com.monitor.framework.dto.ResultData;
import com.monitor.framework.dto.TracknumEntity;
import com.monitor.framework.util.HttpClientUtil;
import com.monitor.framework.utils.PropertiesUtil;

@Controller
@RequestMapping("poc")
public class PocController {
	
	 private static final String BUSINESSOVERVIEW = "poc/businessoverview";
	 private static final String STATUSOVERVIEW = "poc/statusoverview";
	 private static final String SYSTEMOVERVIEW = "poc/systemoverview";
	 private static final String CARTSTATUS = "poc/cartStatus";
	 private static final String ORDERSTATUS = "poc/orderStatus";
	 private static final String PRODUCTSTATUS = "poc/productStatus";
	 private static final String ORDERSTATUS_DATA = "poc/orderStatus_data";
	 
	 private static final String queryByTracknum = "queryByTracknum";
	 private static final String queryJinggaoData = "queryJinggaoData";
	 private static final String queryOrderStatusData = "queryOrderStatusData";
	 private static final String queryJinggaoDataByProvince = "queryJinggaoDataByProvince";
	 
	 @RequestMapping(value = "businessoverview", method = RequestMethod.GET)
	 public String businessoverview() {

		 return BUSINESSOVERVIEW;
	 }
	 
	 @RequestMapping(value = "statusoverview", method = RequestMethod.GET)
	 public String statusoverview(Model model,@RequestParam(value = "province", required = false) String province) {
		 try {
			 if(province != null){
				 province = java.net.URLDecoder.decode(province,"UTF-8");
				 model.addAttribute("province", province);
			 }
			 //queryOrderStatusData
			 String result_OrderStatusData = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryOrderStatusData, null);
			 ResultData<List<OrderStatusEntity>> parseObject_OrderStatusData = JSON.parseObject(result_OrderStatusData, 
						new TypeReference<ResultData<List<OrderStatusEntity>>>(){});
			 if(parseObject_OrderStatusData.getCode()>0){
				 for(OrderStatusEntity OrderStatusEntity:parseObject_OrderStatusData.getSerializableData()){
					 model.addAttribute(OrderStatusEntity.getStatus(), OrderStatusEntity.getNum());
				 }
					model.addAttribute("orderStatusDataList", parseObject_OrderStatusData.getSerializableData());
				}else{
					model.addAttribute("orderStatusDataList", null);
				}
			 
			 //queryJinggaoData
			 String result_queryJinggaoData = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryJinggaoData, null);
			 model.addAttribute("jinggaoData", result_queryJinggaoData);
			 
			 //queryJinggaoDataByProvince
			 String result_queryJinggaoDataByProvince = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryJinggaoDataByProvince+"?province="+(province==null?"":province), null);
			 ResultData<List<OrderStatusMonitorDTO>> parseObject_queryJinggaoDataByProvince = JSON.parseObject(result_queryJinggaoDataByProvince, 
						new TypeReference<ResultData<List<OrderStatusMonitorDTO>>>(){});
			 if(parseObject_queryJinggaoDataByProvince.getCode()>0){
					model.addAttribute("orderStatusList", parseObject_queryJinggaoDataByProvince.getSerializableData());
				}else{
					model.addAttribute("orderStatusList", null);
				}
		 } catch (Exception e) {
			e.printStackTrace();
		 }
		 return STATUSOVERVIEW;
	 }
	 
	 @RequestMapping(value = "systemoverview", method = RequestMethod.GET)
	 public String systemoverview(Model model,@RequestParam(value = "province", required = false) String province) {
		 try {
			 if(province != null){
				 province = java.net.URLDecoder.decode(province,"UTF-8");
				 model.addAttribute("province", province);
			 }
			 //queryOrderStatusData
			 String result_OrderStatusData = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryOrderStatusData, null);
			 ResultData<List<OrderStatusEntity>> parseObject_OrderStatusData = JSON.parseObject(result_OrderStatusData, 
						new TypeReference<ResultData<List<OrderStatusEntity>>>(){});
			 if(parseObject_OrderStatusData.getCode()>0){
				 for(OrderStatusEntity OrderStatusEntity:parseObject_OrderStatusData.getSerializableData()){
					 model.addAttribute(OrderStatusEntity.getStatus(), OrderStatusEntity.getNum());
				 }
					model.addAttribute("orderStatusDataList", parseObject_OrderStatusData.getSerializableData());
				}else{
					model.addAttribute("orderStatusDataList", null);
				}
			 
			 //queryJinggaoData
			 String result_queryJinggaoData = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryJinggaoData, null);
			 model.addAttribute("jinggaoData", result_queryJinggaoData);
			 
			 //queryJinggaoDataByProvince
			 String result_queryJinggaoDataByProvince = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryJinggaoDataByProvince+"?province="+(province==null?"":province), null);
			 ResultData<List<OrderStatusMonitorDTO>> parseObject_queryJinggaoDataByProvince = JSON.parseObject(result_queryJinggaoDataByProvince, 
						new TypeReference<ResultData<List<OrderStatusMonitorDTO>>>(){});
			 if(parseObject_queryJinggaoDataByProvince.getCode()>0){
					model.addAttribute("orderStatusList", parseObject_queryJinggaoDataByProvince.getSerializableData());
				}else{
					model.addAttribute("orderStatusList", null);
				}
		 } catch (Exception e) {
			e.printStackTrace();
		 }
		 return SYSTEMOVERVIEW;
	 }
	 
	 @RequestMapping(value = "cartStatus", method = RequestMethod.GET)
	 public String cartStatus() {

		 return CARTSTATUS;
	 }
	 
	 @RequestMapping(value = "orderStatus", method = RequestMethod.GET)
	 public String orderStatus() {

		 return ORDERSTATUS;
	 }
	 
	 @RequestMapping(value = "orderStatus/{tracknum}", method = RequestMethod.GET)
	 public String orderStatusByTracknum(Model model,@PathVariable("tracknum") String tracknum) {
		 if(tracknum != null && !tracknum.equals("")){
			 Map<String,String> para  = new HashMap<String,String>();
		    	para.put("tracknum", tracknum);
			 try {
				String result = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")+queryByTracknum, para);
				ResultData<List<TracknumEntity>> parseObject = JSON.parseObject(result, 
						new TypeReference<ResultData<List<TracknumEntity>>>(){});
				if(parseObject.getCode()>0){
					model.addAttribute("loglist", parseObject.getSerializableData());
				}else{
					model.addAttribute("loglist", null);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
		 model.addAttribute("tracknum", tracknum);
		 return ORDERSTATUS_DATA;
	 }
	 
	 @RequestMapping(value = "productStatus", method = RequestMethod.GET)
	 public String productStatus() {

		 return PRODUCTSTATUS;
	 }

}
