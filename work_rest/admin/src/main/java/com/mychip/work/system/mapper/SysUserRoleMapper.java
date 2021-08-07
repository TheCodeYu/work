package com.mychip.work.system.mapper;

import com.mychip.work.system.domain.SysUserRole;

import java.util.List;

/**
 * @name: SysUserRoleMapper
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 用户与角色关联表 数据层
 */

public interface SysUserRoleMapper {
    /**
     * 批量新增用户角色信息
     *
     * @param userRoleList 用户角色列表
     * @return 结果
     */
    public int batchUserRole(List<SysUserRole> userRoleList);
}
