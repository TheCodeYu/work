package com.mychip.work.system.mapper;

import com.mychip.work.core.domain.entity.SysUser;

/**
 * name: UserMapper
 * author: Administrator
 * data: 2021/7/11 0011
 * description: 用户表 数据层
 */
public interface SysUserMapper {
    /**
     * 新增用户信息
     *
     * @param user 用户信息
     * @return 结果
     */
    public int insertUser(SysUser user);
    /**
     * 校验用户名称是否唯一
     *
     * @param userName 用户名称
     * @return 结果
     */
    public int checkUserNameUnique(String userName);

    /**
     * 校验手机号码是否唯一
     *
     * @param phonenumber 手机号码
     * @return 结果
     */
    public SysUser checkPhoneUnique(String phonenumber);
    /**
     * 通过手机号码查询用户
     *
     * @param phonenumber 手机号码
     * @return 用户对象信息
     */
    public SysUser selectUserByTelephone(String phonenumber);

    /**
     * 通过用户名查询用户
     *
     * @param userName 用户名
     * @return 用户对象信息
     */
    public SysUser selectUserByUserName(String userName);

}
