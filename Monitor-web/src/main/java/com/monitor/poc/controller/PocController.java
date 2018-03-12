package com.monitor.poc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("poc")
public class PocController {
	
	 private static final String BUSINESSOVERVIEW = "poc/businessoverview";
	 private static final String STATUSOVERVIEW = "poc/statusoverview";
	 private static final String SYSTEMOVERVIEW = "poc/systemoverview";
	 private static final String CARTSTATUS = "poc/cartStatus";
	 private static final String ORDERSTATUS = "poc/orderStatus";
	 private static final String PRODUCTSTATUS = "poc/productStatus";

	 @RequestMapping(value = "businessoverview", method = RequestMethod.GET)
	 public String businessoverview() {

		 return BUSINESSOVERVIEW;
	 }
	 
	 @RequestMapping(value = "statusoverview", method = RequestMethod.GET)
	 public String statusoverview() {

		 return STATUSOVERVIEW;
	 }
	 
	 @RequestMapping(value = "systemoverview", method = RequestMethod.GET)
	 public String systemoverview() {

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
	 
	 @RequestMapping(value = "productStatus", method = RequestMethod.GET)
	 public String productStatus() {

		 return PRODUCTSTATUS;
	 }
}
