package com.mychip.work.system.mapper;

import java.util.List;

/**
 * @name: SysMenuMapper
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 接口表 数据层
 */

public interface SysMenuMapper {

    /**
     * 根据用户ID查询权限
     *
     * @param userId 用户ID
     * @return 权限列表
     */
    public List<String> selectMenuPermsByUserId(Long userId);

}
