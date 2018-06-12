package com.monitor.poc.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.monitor.framework.base.pojo.PageInfo;
import com.monitor.framework.base.pojo.ResultCode;
import com.monitor.framework.dto.DFSOrderDTO;
import com.monitor.framework.dto.ExceptionAggs;
import com.monitor.framework.dto.ExceptionEntity;
import com.monitor.framework.dto.LibyOrderDTO;
import com.monitor.framework.dto.OrderStatusEntity;
import com.monitor.framework.dto.OrderStatusMonitorDTO;
import com.monitor.framework.dto.PageableEntity;
import com.monitor.framework.dto.ProductOrder;
import com.monitor.framework.dto.ProductTotal;
import com.monitor.framework.dto.ProvinceOrder;
import com.monitor.framework.dto.ResultData;
import com.monitor.framework.dto.TracknumEntity;
import com.monitor.framework.util.HttpClientUtil;
import com.monitor.framework.utils.PropertiesUtil;

import freemarker.template.utility.StringUtil;

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
	private static final String EXCEPTIONSTATUS = "poc/exceptionStatus";
	
	private static final String DFSSYSTEMOVERVIEW = "poc/dfsSystemOverview";
	private static final String LIBYSYSTEMOVERVIEW = "poc/libySystemOverview";
	private static final String MESSAGESEARCH = "poc/messageSearch";
	private static final String CUSTOMSYSTEMFLOW = "poc/customSystemFlow";

	private static final String queryByTracknumAndTime = "queryByTracknumAndTime";
	private static final String queryJinggaoData = "queryJinggaoData";
	private static final String queryOrderStatusData = "queryOrderStatusData";
	private static final String queryJinggaoDataByProvince = "queryJinggaoDataByProvince";
	private static final String queryAllOrder = "queryAllOrder";
	private static final String queryAllProduct = "queryAllProduct";
	private static final String queryJinggaoShuliang ="queryJinggaoShuliang";
	private static final String queryExceptionByAggs ="queryExceptionByAggs";
	private static final String queryException ="queryException";
	private static final String queryDFSOperatorByTime ="queryDFSOperatorByTime";
	private static final String queryAllMessage = "queryAllMessage";
	
	private static final int PAGESIZE = 10;

	@RequestMapping(value = "businessoverview", method = RequestMethod.GET)
	public String businessoverview(Model model) {
		try {
			String result_queryAllData = HttpClientUtil
					.httpGet(PropertiesUtil.getValue("microservice.url")
							+ queryAllOrder, null);
			ResultData<List<OrderStatusMonitorDTO>> parseObject_queryAllData = JSON
					.parseObject(
							result_queryAllData,
							new TypeReference<ResultData<List<OrderStatusMonitorDTO>>>() {
							});
			// 总金额
			BigDecimal totalprice = new BigDecimal("0");
			// 客单价
			BigDecimal kedanjia = new BigDecimal("0");
			// 订单数量
			BigDecimal ordernum = new BigDecimal("0");
			// 按省区设置值
			List<ProvinceOrder> list_province_order = new ArrayList<ProvinceOrder>();
			// 按商品设置值
			List<ProductOrder> list_product_order = new ArrayList<ProductOrder>();
			if (parseObject_queryAllData.getCode() > 0) {
				for (OrderStatusMonitorDTO orderStatusMonitorDTO : parseObject_queryAllData
						.getSerializableData()) {
					if(orderStatusMonitorDTO.getTotalPrice() != null && !orderStatusMonitorDTO.getTotalPrice().equals("")){
						totalprice = totalprice.add(new BigDecimal(
								orderStatusMonitorDTO.getTotalPrice()));
						ordernum = ordernum.add(new BigDecimal("1"));
						boolean containfalg = false;
						for (ProvinceOrder tt : list_province_order) {
							if (tt.getName().equals(
									orderStatusMonitorDTO.getProvince())) {
								tt.setTotalprice(tt.getTotalprice().add(
										new BigDecimal(orderStatusMonitorDTO
												.getTotalPrice())));
								containfalg = true;
							}
						}
						if (containfalg == false) {
							ProvinceOrder po = new ProvinceOrder();
							po.setName(orderStatusMonitorDTO.getProvince());
							po.setTotalprice(new BigDecimal(orderStatusMonitorDTO
									.getTotalPrice()));
							list_province_order.add(po);
						}
					}
					
				}
			}
			Collections.sort(list_province_order);
			int i = 1;
			for (ProvinceOrder pp : list_province_order) {
				pp.setPercentage(pp.getTotalprice()
						.divide(totalprice, 2, BigDecimal.ROUND_DOWN)
						.multiply(new BigDecimal("100")).toString());
				model.addAttribute("orovinceOrder" + i, pp);
				i = i + 1;
			}
			kedanjia = totalprice.divide(ordernum, 2, BigDecimal.ROUND_DOWN);
			model.addAttribute("totalprice", totalprice);
			model.addAttribute("ordernum", ordernum);
			model.addAttribute("kedanjia", kedanjia);

			// 商品销量排序
			String result_queryAllProduct = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryAllProduct, null);
			ResultData<List<ProductTotal>> parseObject_queryAllProduct = JSON
					.parseObject(
							result_queryAllProduct,
							new TypeReference<ResultData<List<ProductTotal>>>() {
							});
			if (parseObject_queryAllProduct.getCode() > 0) {
				for (ProductTotal productTotal : parseObject_queryAllProduct
						.getSerializableData()) {
					boolean containfalg = false;
					for (ProductOrder tt : list_product_order) {
						if (tt.getName().equals(productTotal.getProduct())) {
							tt.setTotalprice(tt.getTotalprice()
									.add(new BigDecimal(productTotal
											.getTotalPrice())));
							containfalg = true;
						}
					}
					if (containfalg == false) {
						ProductOrder po = new ProductOrder();
						po.setName(productTotal.getProduct());
						po.setTotalprice(new BigDecimal(productTotal
								.getTotalPrice()));
						list_product_order.add(po);
					}
				}
				Collections.sort(list_product_order);
				int j = 1;
				for (ProductOrder pp : list_product_order) {
					pp.setPercentage(pp.getTotalprice()
							.divide(totalprice, 2, BigDecimal.ROUND_DOWN)
							.multiply(new BigDecimal("100")).toString());
					model.addAttribute("productOrder" + j, pp);
					j = j + 1;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return BUSINESSOVERVIEW;
	}

	@RequestMapping(value = "statusoverview", method = RequestMethod.GET)
	public String statusoverview(Model model,
			@RequestParam(value = "province", required = false) String province) {
		try {
			if (province != null) {
				province = java.net.URLDecoder.decode(province, "UTF-8");
				model.addAttribute("province", province);
			}
			// queryOrderStatusData
			String result_OrderStatusData = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryOrderStatusData, null);
			ResultData<List<OrderStatusEntity>> parseObject_OrderStatusData = JSON
					.parseObject(
							result_OrderStatusData,
							new TypeReference<ResultData<List<OrderStatusEntity>>>() {
							});
			if (parseObject_OrderStatusData.getCode() > 0) {
				for (OrderStatusEntity OrderStatusEntity : parseObject_OrderStatusData
						.getSerializableData()) {
					model.addAttribute(OrderStatusEntity.getStatus(),
							OrderStatusEntity.getNum());
				}
				model.addAttribute("orderStatusDataList",
						parseObject_OrderStatusData.getSerializableData());
			} else {
				model.addAttribute("orderStatusDataList", null);
			}

			// queryJinggaoData
			String result_queryJinggaoData = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryJinggaoData, null);
			model.addAttribute("jinggaoData", result_queryJinggaoData);
			
			// queryJinggaoShuliang
			String result_queryJinggaoShuliang = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryJinggaoShuliang, null);
			model.addAttribute("jinggaoShuliang", result_queryJinggaoShuliang);

			// queryJinggaoDataByProvince
			String result_queryJinggaoDataByProvince = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryJinggaoDataByProvince + "?province="
							+ (province == null ? "" : province), null);
			ResultData<List<OrderStatusMonitorDTO>> parseObject_queryJinggaoDataByProvince = JSON
					.parseObject(
							result_queryJinggaoDataByProvince,
							new TypeReference<ResultData<List<OrderStatusMonitorDTO>>>() {
							});
			if (parseObject_queryJinggaoDataByProvince.getCode() > 0) {
				model.addAttribute("orderStatusList",
						parseObject_queryJinggaoDataByProvince
								.getSerializableData());
			} else {
				model.addAttribute("orderStatusList", null);
			}

			String result_queryAllData = HttpClientUtil
					.httpGet(PropertiesUtil.getValue("microservice.url")
							+ queryAllOrder, null);
			ResultData<List<OrderStatusMonitorDTO>> parseObject_queryAllData = JSON
					.parseObject(
							result_queryAllData,
							new TypeReference<ResultData<List<OrderStatusMonitorDTO>>>() {
							});
			if (parseObject_queryAllData.getCode() > 0) {
				// 总金额
				BigDecimal totalprice = new BigDecimal("0");
				BigDecimal kedanjia = new BigDecimal("0");
				BigDecimal ordernum = new BigDecimal("0");
				for (OrderStatusMonitorDTO orderStatusMonitorDTO : parseObject_queryAllData
						.getSerializableData()) {
					if(orderStatusMonitorDTO.getTotalPrice() != null && !orderStatusMonitorDTO.getTotalPrice().equals("")){
						totalprice = totalprice.add(new BigDecimal(
								orderStatusMonitorDTO.getTotalPrice()));
						ordernum = ordernum.add(new BigDecimal("1"));
					}
				}
				kedanjia = totalprice
						.divide(ordernum, 2, BigDecimal.ROUND_DOWN);
				// 总数量

				// 客单价
				model.addAttribute("totalprice", totalprice);
				model.addAttribute("ordernum", ordernum);
				model.addAttribute("kedanjia", kedanjia);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return STATUSOVERVIEW;
	}

	@RequestMapping(value = "systemoverview", method = RequestMethod.GET)
	public String systemoverview(Model model,
			@RequestParam(value = "province", required = false) String province,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime) {
		try {
			if (province != null) {
				province = java.net.URLDecoder.decode(province, "UTF-8");
				model.addAttribute("province", province);
			}
						
			//异常排行
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			starttime = starttime.replace("T", " ");
			endtime = endtime.replace("T", " ");
			Map<String, String> para = new HashMap<String, String>();
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			String result_queryExceptionAggs = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryExceptionByAggs, para);
			ResultData<List<ExceptionAggs>> parseObject_queryExceptionAggs = JSON
					.parseObject(
							result_queryExceptionAggs,
							new TypeReference<ResultData<List<ExceptionAggs>>>() {
							});
			model.addAttribute("exceptionAggs", parseObject_queryExceptionAggs
					.getSerializableData());
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
	public String orderStatusByTracknum(Model model,
			@PathVariable("tracknum") String tracknum,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime) {
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		if(starttime == null || starttime.equals("")){
			starttime = "1997-01-01 00:00:00";
		}
		if(endtime == null || endtime.equals("")){
			endtime = "2997-01-01 00:00:00";
		}
		starttime = starttime.replace("T", " ");
		endtime = endtime.replace("T", " ");
		if (tracknum != null && !tracknum.equals("")) {
			Map<String, String> para = new HashMap<String, String>();
			para.put("tracknum", tracknum);
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			try {
				String result = HttpClientUtil.httpGet(
						PropertiesUtil.getValue("microservice.url")
								+ queryByTracknumAndTime, para);
				ResultData<List<TracknumEntity>> parseObject = JSON
						.parseObject(
								result,
								new TypeReference<ResultData<List<TracknumEntity>>>() {
								});
				if (parseObject.getCode() > 0) {
					for(TracknumEntity te:parseObject.getSerializableData()){
						if(te.getMessage().contains("error")||te.getMessage().contains("Error")
								||te.getMessage().contains("Exception")||te.getMessage().contains("exception")){
							te.setError("true");
						}else{
							te.setError("false");
						}
					}
					model.addAttribute("loglist",
							parseObject.getSerializableData());
				} else {
					model.addAttribute("loglist", null);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("tracknum", tracknum);
		return ORDERSTATUS_DATA;
	}
	
	@RequestMapping(value = "exceptionStatus", method = RequestMethod.GET)
	public String exceptionStatus(Model model,
			@RequestParam(value = "exception", required = false) String exception,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime) {
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		if(starttime == null || starttime.equals("")){
			starttime = "1997-01-01 00:00:00";
		}
		if(endtime == null || endtime.equals("")){
			endtime = "2997-01-01 00:00:00";
		}
		starttime = starttime.replace("T", " ");
		endtime = endtime.replace("T", " ");
		if (exception != null && !exception.equals("")) {
			Map<String, String> para = new HashMap<String, String>();
			para.put("exception", exception);
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			try {
				String result = HttpClientUtil.httpGet(
						PropertiesUtil.getValue("microservice.url")
								+ queryException, para);
				ResultData<List<ExceptionEntity>> parseObject = JSON
						.parseObject(
								result,
								new TypeReference<ResultData<List<ExceptionEntity>>>() {
								});
				if (parseObject.getCode() > 0) {
					model.addAttribute("loglist",
							parseObject.getSerializableData());
				} else {
					model.addAttribute("loglist", null);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("exception", exception);
		return EXCEPTIONSTATUS;
	}
	
	@RequestMapping(value = "messageSearch", method = RequestMethod.GET)
	public String messageSearch(Model model,
			@RequestParam(value = "message", required = false) String message,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "server", required = false) String server) {
		if(message != null || starttime != null){
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			starttime = starttime.replace("T", " ");
			endtime = endtime.replace("T", " ");
			
				Map<String, String> para = new HashMap<String, String>();
				if(server == null || server.equals("")){
					para.put("message", message==null?"":"*"+message+"*");
				}else{
					String msg = "*"+message+"*" + " AND logsource:("+StringUtil.replace(server, ",", " OR ")+")";
					para.put("message", msg);
				}
				para.put("starttime", starttime);
				para.put("endtime", endtime);
				try {
					String result = HttpClientUtil.httpGet(
							PropertiesUtil.getValue("microservice.url")
									+ queryAllMessage, para);
					ResultData<List<TracknumEntity>> parseObject = JSON
							.parseObject(
									result,
									new TypeReference<ResultData<List<TracknumEntity>>>() {
									});
					if (parseObject.getCode() > 0) {
						//处理相同时间
						
						
						Map<String,List<TracknumEntity>> map = new TreeMap<String,List<TracknumEntity>>(new  
							     Comparator<String>() {  
							     public int compare(String obj1, String obj2) {  
							    	 SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
							    	 
							     try {
									return sdf.parse(obj1).compareTo(sdf.parse(obj2));
								} catch (ParseException e) {
									e.printStackTrace();
									return 0;
								}  
							     }  
							     }); 
						for(TracknumEntity msg:parseObject.getSerializableData()){
							if(map.get(msg.getLogtime())==null){
								List<TracknumEntity> list_te = new ArrayList<TracknumEntity>();
								list_te.add(msg);
								map.put(msg.getLogtime(), list_te);
							}else{
								map.get(msg.getLogtime()).add(msg);
							}
						}
						List<TracknumEntity> list_bytime = new ArrayList<TracknumEntity>();
						for(String time:map.keySet()){
							TracknumEntity newtt = new TracknumEntity();
							newtt.setLogtime(time.substring(0, time.indexOf(".")));
							newtt.setLogsource(map.get(time).get(0).getLogsource());
							for(TracknumEntity aa:map.get(time)){
								if(newtt.getMessage()==null){
									newtt.setMessage(aa.getMessage()+"\n");
								}else{
									newtt.setMessage(newtt.getMessage()+aa.getMessage()+"\n");
								}
							}
							
							newtt.setListTracknumEntity(map.get(time));
							list_bytime.add(newtt);
						}
						
						model.addAttribute("loglist",
								list_bytime);
					} else {
						model.addAttribute("loglist", null);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			
			model.addAttribute("message", message);
			model.addAttribute("orignalserver", server);
			if(server != null && !server.equals("")){
				server = "[\""+StringUtil.replace(server, ",", "\",\"")+"\"]";
			}else{
				server = "";
			}
			model.addAttribute("server", server);
		}else{
			model.addAttribute("init", "true");
		}
		
		return MESSAGESEARCH;
	}

	@RequestMapping(value = "productStatus", method = RequestMethod.GET)
	public String productStatus() {

		return PRODUCTSTATUS;
	}
	
	/**
	 * DFS systemoverview
	 * @return
	 */
	@RequestMapping(value = "dfsSystemOverview", method = RequestMethod.GET)
	public String dfsSystemOverview(Model model,
			@RequestParam(value = "productCode", required = false) String productCode,
			@RequestParam(value = "orderCode", required = false) String orderCode,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "productExceptionPagenum", required = false) String productExceptionPagenum,
			@RequestParam(value = "pendingtype", required = false) String pendingtype) {

		try {
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			if(orderCode == null){
				orderCode = "";
			}
			starttime = starttime.replace("T", " ");
			endtime = endtime.replace("T", " ");
			
			Map<String, String> para = new HashMap<String, String>();
			para.put("orderCode", orderCode);
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			
			String result_queryDFSOrder = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryDFSOperatorByTime, para);
			ResultData<List<DFSOrderDTO>> parseObject_queryDFSOrderDTO = JSON
					.parseObject(
							result_queryDFSOrder,
							new TypeReference<ResultData<List<DFSOrderDTO>>>() {
							});
			
			if (parseObject_queryDFSOrderDTO.getCode() > 0) {
				model.addAttribute("dfsOrderlist",
						parseObject_queryDFSOrderDTO.getSerializableData());
			} else {
				model.addAttribute("dfsOrderlist", null);
			}
			model.addAttribute("orderCode", orderCode);
			
			//异常排行
			
			String result_queryExceptionAggs = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryExceptionByAggs, para);
			ResultData<List<ExceptionAggs>> parseObject_queryExceptionAggs = JSON
					.parseObject(
							result_queryExceptionAggs,
							new TypeReference<ResultData<List<ExceptionAggs>>>() {
							});
			model.addAttribute("exceptionAggs", parseObject_queryExceptionAggs
					.getSerializableData());
			
			//产品异常
			PageInfo pageInfo = new PageInfo(PAGESIZE);
			if(productExceptionPagenum == null){
				productExceptionPagenum = "1";
			}
			pageInfo.setPageNum(new Integer(productExceptionPagenum));
			Map<String, String> para_product = new HashMap<String, String>();
			para_product.put("productCode", productCode);
			para_product.put("starttime", starttime);
			para_product.put("endtime", endtime);
			para_product.put("from", new Integer(pageInfo.getNumfrom()-1).toString());
			para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
			if(pendingtype == null || pendingtype.equals("0")){
				para_product.put("pendingtypeCondition", "(message:\\\"com.dfs.jms.exception.DFSProductFeedPendingException\\\" OR message:\\\"Not pending\\\")");
			}else if(pendingtype.equals("1")){
				para_product.put("pendingtypeCondition", "(message:\\\"com.dfs.jms.exception.DFSProductFeedPendingException\\\" )");
			}else if(pendingtype.equals("2")){
				para_product.put("pendingtypeCondition", "(message:\\\"Not pending\\\")");
			}
			para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
			
			//para_product.put("pageInfo",pageInfo);
			String result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "queryDFSProductByTime", para_product);
			ResultData<PageableEntity> parseObject = JSON
					.parseObject(
							result,
							new TypeReference<ResultData<PageableEntity>>() {
							});
			if (parseObject.getCode() > 0) {
				for(TracknumEntity TracknumEntity_product:parseObject.getSerializableData().getList()){
					if(TracknumEntity_product.getMessage().contains("Not pending Exception")){
						TracknumEntity_product.setOrderCode("Not pendding Exception");
					}else{
						TracknumEntity_product.setOrderCode("pendding exception");
					}
					TracknumEntity_product.setError(TracknumEntity_product.getMessage().substring(TracknumEntity_product.getMessage().indexOf("Exception:"), TracknumEntity_product.getMessage().length()));
				}
				
				pageInfo.setCount(new Long(parseObject.getSerializableData().getTotal()).intValue());
				model.addAttribute("productExceptonList",
						parseObject.getSerializableData().getList());
				model.addAttribute("pageInfo", pageInfo);
			} else {
				model.addAttribute("productExceptonList", null);
			}
			model.addAttribute("productCode", productCode);
			model.addAttribute("pendingtype", pendingtype==null?"0":pendingtype);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return DFSSYSTEMOVERVIEW;
	}
	
	
	/**
	 * DFS dfsProductException
	 * @return
	 */
	@RequestMapping(value = "dfsProductException", method = RequestMethod.GET)
	public String dfsProductException(Model model,
			@RequestParam(value = "productCode", required = false) String productCode,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "pagenum", required = false) String pagenum,
			@RequestParam(value = "pendingtype", required = false) String pendingtype) {

		try {
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			starttime = starttime.replace("T", " ");
			endtime = endtime.replace("T", " ");
			
			Map<String, String> para = new HashMap<String, String>();
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			
			
			//产品异常
			PageInfo pageInfo = new PageInfo(PAGESIZE);
			if(pagenum == null){
				pagenum = "1";
			}
			pageInfo.setPageNum(new Integer(pagenum));
			Map<String, String> para_product = new HashMap<String, String>();
			para_product.put("productCode", productCode);
			para_product.put("starttime", starttime);
			para_product.put("endtime", endtime);
			para_product.put("from", new Integer(pageInfo.getNumfrom()-1).toString());
			para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
			if(pendingtype == null || pendingtype.equals("0")){
				para_product.put("pendingtypeCondition", "(message:\\\"com.dfs.jms.exception.DFSProductFeedPendingException\\\" OR message:\\\"Not pending\\\")");
			}else if(pendingtype.equals("1")){
				para_product.put("pendingtypeCondition", "(message:\\\"com.dfs.jms.exception.DFSProductFeedPendingException\\\" )");
			}else if(pendingtype.equals("2")){
				para_product.put("pendingtypeCondition", "(message:\\\"Not pending\\\")");
			}
			para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
			
			//para_product.put("pageInfo",pageInfo);
			String result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "queryDFSProductByTime", para_product);
			ResultData<PageableEntity> parseObject = JSON
					.parseObject(
							result,
							new TypeReference<ResultData<PageableEntity>>() {
							});
			if (parseObject.getCode() > 0) {
				for(TracknumEntity TracknumEntity_product:parseObject.getSerializableData().getList()){
					if(TracknumEntity_product.getMessage().contains("Not pending Exception")){
						TracknumEntity_product.setOrderCode("Not pendding Exception");
					}else{
						TracknumEntity_product.setOrderCode("pendding exception");
					}
					TracknumEntity_product.setError(TracknumEntity_product.getMessage().substring(TracknumEntity_product.getMessage().indexOf("Exception:"), TracknumEntity_product.getMessage().length()));
				}
				
				pageInfo.setCount(new Long(parseObject.getSerializableData().getTotal()).intValue());
				model.addAttribute("productExceptonList",
						parseObject.getSerializableData().getList());
				model.addAttribute("pageInfo", pageInfo);
			} else {
				model.addAttribute("productExceptonList", null);
			}
			model.addAttribute("productCode", productCode);
			model.addAttribute("pendingtype", pendingtype==null?"0":pendingtype);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "poc/dfsProductException";
	}
	
	/**
	 * Liby systemoverview
	 * @return
	 */
	@RequestMapping(value = "libySystemOverview", method = RequestMethod.GET)
	public String libySystemOverview(Model model,
			@RequestParam(value = "orderCode", required = false) String orderCode,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime) {

		try {
			model.addAttribute("starttime", starttime);
			model.addAttribute("endtime", endtime);
			if(starttime == null || starttime.equals("")){
				starttime = "1997-01-01 00:00:00";
			}
			if(endtime == null || endtime.equals("")){
				endtime = "2997-01-01 00:00:00";
			}
			if(orderCode == null){
				orderCode = "";
			}
			starttime = starttime.replace("T", " ");
			endtime = endtime.replace("T", " ");
			Map<String, String> para = new HashMap<String, String>();
			para.put("orderCode", orderCode);
			para.put("starttime", starttime);
			para.put("endtime", endtime);
			
			String result_querylibyOrder = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "queryLibyOperatorByTime", para);
			ResultData<List<LibyOrderDTO>> parseObject_querylibyOrderDTO = JSON
					.parseObject(
							result_querylibyOrder,
							new TypeReference<ResultData<List<LibyOrderDTO>>>() {
							});
			
			if (parseObject_querylibyOrderDTO.getCode() > 0) {
				List<LibyOrderDTO> list = new ArrayList<LibyOrderDTO>();
				for(LibyOrderDTO libyOrDTO:parseObject_querylibyOrderDTO.getSerializableData()){
					for(Object a:libyOrDTO.getList_splittime()){
						libyOrDTO.setSplittime((libyOrDTO.getSplittime()==null?"":libyOrDTO.getSplittime()) +"  " +(String)a);
					}
					for(Object b:libyOrDTO.getList_sendsaptime()){
						libyOrDTO.setSendsaptime((libyOrDTO.getSendsaptime()==null?"":libyOrDTO.getSendsaptime()) +"  " + (String)b);
					}
					for(Object c:libyOrDTO.getList_sapreturntime()){
						libyOrDTO.setSapreturntime((libyOrDTO.getSapreturntime()==null?"":libyOrDTO.getSapreturntime()) + "  " +(String)c);
					}
					for(Object d:libyOrDTO.getList_dealtime()){
						libyOrDTO.setDealtime((libyOrDTO.getDealtime()==null?"":libyOrDTO.getDealtime()) + "  " +(String)d);
					}
					list.add(libyOrDTO);
				}
				
				model.addAttribute("libyOrderlist",list);
			} else {
				model.addAttribute("libyOrderlist", null);
			}
			model.addAttribute("orderCode", orderCode);
			
			//异常排行
			
			String result_queryExceptionAggs = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ queryExceptionByAggs, para);
			ResultData<List<ExceptionAggs>> parseObject_queryExceptionAggs = JSON
					.parseObject(
							result_queryExceptionAggs,
							new TypeReference<ResultData<List<ExceptionAggs>>>() {
							});
			model.addAttribute("exceptionAggs", parseObject_queryExceptionAggs
					.getSerializableData());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return LIBYSYSTEMOVERVIEW;
	}
	
	
	/**
	 * customSystemFlow
	 * @return
	 */
	@RequestMapping(value = "customSystemFlow", method = RequestMethod.GET)
	public String customSystemFlow(Model model,
			@RequestParam(value = "tracknumtype", required = false) String tracknumtype,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "pagenum", required = false) String pagenum,
			@RequestParam(value = "tracknum", required = false) String tracknum) {
		
		model.addAttribute("starttime", starttime);
		model.addAttribute("endtime", endtime);
		if(starttime == null || starttime.equals("")){
			starttime = "1997-01-01 00:00:00";
		}
		if(endtime == null || endtime.equals("")){
			endtime = "2997-01-01 00:00:00";
		}
		starttime = starttime.replace("T", " ");
		endtime = endtime.replace("T", " ");
		
		PageInfo pageInfo = new PageInfo(PAGESIZE);
		if(pagenum == null){
			pagenum = "1";
		}
		pageInfo.setPageNum(new Integer(pagenum));
		Map<String, String> para_product = new HashMap<String, String>();
		para_product.put("tracknumtype", tracknumtype);
		para_product.put("starttime", starttime);
		para_product.put("endtime", endtime);
		para_product.put("from", new Integer(pageInfo.getNumfrom()-1).toString());
		para_product.put("size", new Integer(pageInfo.getPageSize()).toString());
		para_product.put("tracknum", tracknum);
		
		String result;
		try {
			result = HttpClientUtil.httpGet(
					PropertiesUtil.getValue("microservice.url")
							+ "querySystemFlowByTracknum", para_product);
		
		ResultData<PageableEntity> parseObject = JSON
				.parseObject(
						result,
						new TypeReference<ResultData<PageableEntity>>() {
						});
		pageInfo.setCount(new Long(parseObject.getSerializableData().getTotal()).intValue());
		model.addAttribute("SystemFlowTracknumList",
				parseObject.getSerializableData().getList_systemFlowTracknum());
		model.addAttribute("pageInfo", pageInfo);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return CUSTOMSYSTEMFLOW;
		
	}

}
