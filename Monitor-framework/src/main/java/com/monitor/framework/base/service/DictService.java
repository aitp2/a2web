package com.monitor.framework.base.service;

import java.util.List;

import com.monitor.framework.base.entity.Dict;
import com.monitor.framework.base.pojo.TreeNode;

public interface DictService extends BaseService {

    List<TreeNode> getTreeData();

    List<Dict> getDictsByCode(String code);
}
