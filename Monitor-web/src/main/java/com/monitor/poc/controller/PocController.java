package com.monitor.poc.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
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
import com.monitor.framework.dto.ProductOrder;
import com.monitor.framework.dto.ProductTotal;
import com.monitor.framework.dto.ProvinceOrder;
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
	private static final String queryAllOrder = "queryAllOrder";
	private static final String queryAllProduct = "queryAllProduct";
	private static final String queryJinggaoShuliang ="queryJinggaoShuliang";
	

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
					totalprice = totalprice.add(new BigDecimal(
							orderStatusMonitorDTO.getTotalPrice()));
					ordernum = ordernum.add(new BigDecimal("1"));
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
			@PathVariable("tracknum") String tracknum) {
		if (tracknum != null && !tracknum.equals("")) {
			Map<String, String> para = new HashMap<String, String>();
			para.put("tracknum", tracknum);
			try {
				String result = HttpClientUtil.httpGet(
						PropertiesUtil.getValue("microservice.url")
								+ queryByTracknum, para);
				ResultData<List<TracknumEntity>> parseObject = JSON
						.parseObject(
								result,
								new TypeReference<ResultData<List<TracknumEntity>>>() {
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
		model.addAttribute("tracknum", tracknum);
		return ORDERSTATUS_DATA;
	}

	@RequestMapping(value = "productStatus", method = RequestMethod.GET)
	public String productStatus() {

		return PRODUCTSTATUS;
	}

}
