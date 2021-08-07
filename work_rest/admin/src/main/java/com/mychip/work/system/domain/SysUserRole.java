package com.mychip.work.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * @name: SysUserRole
 * @author: Administrator
 * @data: 2021/7/11 0011
 * @description: 用户和角色关联 sys_user_role
 */
public class SysUserRole {
    /** 用户ID */
    private Long userId;

    /** 角色ID */
    private Long roleId;

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getRoleId()
    {
        return roleId;
    }

    public void setRoleId(Long roleId)
    {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("userId", getUserId())
                .append("roleId", getRoleId())
                .toString();
    }
}
