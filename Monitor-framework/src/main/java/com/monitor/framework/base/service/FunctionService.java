package com.monitor.framework.base.service;

import java.util.List;
import java.util.Set;

import com.monitor.framework.base.entity.Function;
import com.monitor.framework.base.pojo.TreeNode;

public interface FunctionService extends BaseService {

    List<TreeNode> getTreeData();

    List<Function> getAll();

    Set<String> getFunctionCodeSet(Set<String> roleCodes);
}
