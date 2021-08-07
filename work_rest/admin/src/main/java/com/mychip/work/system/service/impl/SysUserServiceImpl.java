package com.mychip.work.system.service.impl;

import com.mychip.work.constant.UserConstants;
import com.mychip.work.core.domain.entity.SysUser;
import com.mychip.work.system.domain.SysUserRole;
import com.mychip.work.system.mapper.SysUserMapper;
import com.mychip.work.system.service.ISysUserService;
import com.mychip.work.system.mapper.SysUserRoleMapper;
import com.mychip.work.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @name: SysUserServiceImpl
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description:
 */
@Service
public class SysUserServiceImpl implements ISysUserService {
    private static final Logger log = LoggerFactory.getLogger(SysUserServiceImpl.class);
    @Autowired
    private SysUserMapper userMapper;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    /**
     * 校验用户名称是否唯一
     *
     * @param userName 用户名称
     * @return 结果
     */
    @Override
    public String checkUserNameUnique(String userName) {
        int count = userMapper.checkUserNameUnique(userName);
        if (count > 0)
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验用户手机是否唯一
     *
     * @param user 用户信息
     * @return 结果
     */
    @Override
    public String checkPhoneUnique(SysUser user) {
        Long userId = StringUtils.isNull(user.getUserId()) ? -1L : user.getUserId();
        SysUser info = userMapper.checkPhoneUnique(user.getPhonenumber());
        if (StringUtils.isNotNull(info) && info.getUserId().longValue() != userId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 通过用户名查询用户
     *
     * @param userName 用户名
     * @return 用户对象信息
     */
    @Override
    public SysUser selectUserByUserName(String userName)
    {
        return userMapper.selectUserByUserName(userName);
    }

    /**
     * 校验用户手机是否唯一
     *
     * @param telephone 用户信息
     * @return 结果
     */
    @Override
    public SysUser selectUserByTelephone(String telephone) {
        return userMapper.selectUserByTelephone(telephone);


    }

    @Override
    public int insertUser(SysUser user) {
        // 新增用户信息
        int rows = userMapper.insertUser(user);
        // 新增用户与角色管理

        if (rows>0){
            ///默认都是common
            Long[] roles ={2L};
            user.setRoleIds(roles);
            insertUserRole(user);

        }

        return rows;
    }

    /**
     * 新增用户角色信息
     *
     * @param user 用户对象
     */
    private void insertUserRole(SysUser user)
    {
        Long[] roles = user.getRoleIds();
        if (StringUtils.isNotNull(roles))
        {
            // 新增用户与角色管理
            List<SysUserRole> list = new ArrayList<SysUserRole>();
            for (Long roleId : roles)
            {
                SysUserRole ur = new SysUserRole();
                ur.setUserId(user.getUserId());
                ur.setRoleId(roleId);
                list.add(ur);
            }
            if (list.size() > 0)
            {
                userRoleMapper.batchUserRole(list);
            }
        }
    }
}
