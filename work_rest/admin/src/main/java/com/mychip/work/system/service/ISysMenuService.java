package com.mychip.work.system.service;

import java.util.Set;

/**
 * @name: ISysMenuService
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 接口 业务层
 */

public interface ISysMenuService {

    /**
     * 根据用户ID查询权限
     *
     * @param userId 用户ID
     * @return 权限列表
     */
    public Set<String> selectMenuPermsByUserId(Long userId);

}
