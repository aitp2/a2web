package com.monitor.demos.service;

import com.monitor.framework.base.entity.User;
import com.monitor.framework.base.service.BaseService;

/**
 * Created by HANZO on 2016/6/17.
 */
public interface UserDemoService extends BaseService {

    User saveUser(User user);

}
