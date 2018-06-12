package com.monitor.framework.base.service;

import java.util.List;

import com.monitor.framework.base.entity.SystemFlow;


public interface SystemFlowService extends BaseService{

	public List<SystemFlow> getSystemFlowsByTracktype(String tracknumtype);
}
