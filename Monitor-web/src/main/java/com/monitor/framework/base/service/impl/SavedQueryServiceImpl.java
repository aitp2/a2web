package com.monitor.framework.base.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.monitor.framework.base.dao.BaseDao;
import com.monitor.framework.base.entity.SavedQuery;
import com.monitor.framework.base.service.SavedQueryService;

@Service("savedQueryService")
public class SavedQueryServiceImpl extends BaseServiceImpl implements
		SavedQueryService {

	@Resource
    private BaseDao baseDao;
	
	@Override
	public List<SavedQuery> getSavedQueryByUsername(String username) {
		return baseDao.findBySql("select * from tbl_saved_query where username='"+username+"' order by update_date_time desc", SavedQuery.class);
	}

}
