package com.mychip.work.system.service.impl;

import com.mychip.work.core.domain.entity.SysRole;
import com.mychip.work.system.mapper.SysRoleMapper;
import com.mychip.work.system.service.ISysRoleService;
import com.mychip.work.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @name: ISysRoleServiceImpl
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 角色 业务层处理
 */
@Service
public class ISysRoleServiceImpl implements ISysRoleService {

    @Autowired
    private SysRoleMapper roleMapper;

    @Override
    public Set<String> selectRolePermissionByUserId(Long userId) {
        List<SysRole> perms = roleMapper.selectRolePermissionByUserId(userId);
        Set<String> permsSet = new HashSet<>();
        for (SysRole perm : perms)
        {
            if (StringUtils.isNotNull(perm))
            {
                permsSet.addAll(Arrays.asList(perm.getRoleKey().trim().split(",")));
            }
        }
        return permsSet;
    }
}
