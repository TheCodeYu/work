package com.mychip.work.system.mapper;

import com.mychip.work.core.domain.entity.SysRole;

import java.util.List;

/**
 * @name: SysRoleMapper
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 角色表 数据层
 */

public interface SysRoleMapper {
    /**
     * 根据用户ID查询角色
     *
     * @param userId 用户ID
     * @return 角色列表
     */
    public List<SysRole> selectRolePermissionByUserId(Long userId);

}
