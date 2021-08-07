package com.mychip.work.system.service;

import com.mychip.work.core.domain.entity.SysUser;

/**
 * @name: ISysUserService
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 用户 业务层
 */

public interface ISysUserService {

    /**
     * 校验用户名称是否唯一
     *
     * @param userName 用户名称
     * @return 结果
     */
    public String checkUserNameUnique(String userName);

    /**
     * 校验手机号码是否唯一
     *
     * @param user 用户信息
     * @return 结果
     */
    public String checkPhoneUnique(SysUser user);

    /**
     * 通过用户名查询用户
     *
     * @param userName 用户名
     * @return 用户对象信息
     */
    public SysUser selectUserByUserName(String userName);

    /**
     * 通过用户名查询用户
     *
     * @param telephone 用户名
     * @return 用户对象信息
     */
    public SysUser selectUserByTelephone(String telephone);

    /**
     * 新增用户信息
     *
     * @param user 用户信息
     * @return 结果
     */
    public int insertUser(SysUser user);
}
