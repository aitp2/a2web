package com.monitor.framework.base.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.monitor.framework.base.dao.BaseDao;
import com.monitor.framework.base.entity.SystemFlow;
import com.monitor.framework.base.service.SystemFlowService;

@Service("systemFlowService")
public class SystemFlowServiceImpl extends BaseServiceImpl implements SystemFlowService{
	
	@Resource
    private BaseDao baseDao;

	@Override
	public List<SystemFlow> getSystemFlowsByTracktype(String tracknumtype) {
			return baseDao.findBySql("select * from tbl_system_flow where tracknumtype='"+tracknumtype+"' order by nodeno asc", SystemFlow.class);
	}
	
}
