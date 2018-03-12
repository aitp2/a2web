package com.monitor.framework.oauth.service.impl;

import com.monitor.framework.base.service.impl.BaseServiceImpl;
import com.monitor.framework.oauth.entity.OAuthUser;
import com.monitor.framework.oauth.service.OAuthUserService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by billJiang on 2017/1/15.
 * e-mail:jrn1012@petrochina.com.cn qq:475572229
 */
@Service("oAuthUserService")
public class OAuthUserServiceImpl extends BaseServiceImpl implements OAuthUserService {
    @Override
    public OAuthUser findByOAuthTypeAndOAuthId(String authType, String oAuthId) {
        String hql="from OAuthUser where oAuthType=:authType and oAuthId=:oAuthId";
        Map<String,Object> params= new HashMap<>();
        params.put("authType",authType);
        params.put("oAuthId",oAuthId);
        return this.get(hql,params);
    }
}
