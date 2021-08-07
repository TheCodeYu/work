package com.mychip.work.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * @name: SysRoleMenu
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 角色和菜单关联 sys_role_menu
 */
public class SysRoleMenu {
    /** 角色ID */
    private Long roleId;

    /** 菜单ID */
    private Long menuId;

    public Long getRoleId()
    {
        return roleId;
    }

    public void setRoleId(Long roleId)
    {
        this.roleId = roleId;
    }

    public Long getMenuId()
    {
        return menuId;
    }

    public void setMenuId(Long menuId)
    {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("roleId", getRoleId())
                .append("menuId", getMenuId())
                .toString();
    }
}
