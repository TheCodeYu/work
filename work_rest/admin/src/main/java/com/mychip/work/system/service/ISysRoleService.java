package com.mychip.work.system.service;

import java.util.Set;

/**
 * @name: ISysRoleService
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 角色业务层
 */

public interface ISysRoleService {

    /**
     * 根据用户ID查询角色
     *
     * @param userId 用户ID
     * @return 权限列表
     */
    public Set<String> selectRolePermissionByUserId(Long userId);
}
