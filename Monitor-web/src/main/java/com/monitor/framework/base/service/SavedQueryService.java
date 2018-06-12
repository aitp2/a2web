package com.monitor.framework.base.service;

import java.util.List;

import com.monitor.framework.base.entity.SavedQuery;
import com.monitor.framework.base.entity.SystemFlow;


public interface SavedQueryService extends BaseService{

	public List<SavedQuery> getSavedQueryByUsername(String username);
}
