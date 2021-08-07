package com.mychip.work.admin.authenticated;

import com.mychip.work.core.SysPermissionService;
import com.mychip.work.core.TokenService;
import com.mychip.work.core.domain.AjaxResult;
import com.mychip.work.core.domain.BaseController;
import com.mychip.work.core.domain.LoginUser;
import com.mychip.work.core.domain.entity.SysUser;
import com.mychip.work.system.service.ISysMenuService;
import com.mychip.work.utils.ServletUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;

/**
 * @name: UserInfoController
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description:
 */
@RestController
@RequestMapping("/authenticated")
public class UserInfoController extends BaseController {

    @Autowired
    private TokenService tokenService;
    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;
    /**
     * 获取用户信息
     * 后端校验权限，不用传递到前端
     * @return 用户信息
     */
    ///@PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/getInfo/v1")
    public AjaxResult getInfo()
    {
        LoginUser loginUser = tokenService.getLoginUser(ServletUtils.getRequest());
        SysUser user = loginUser.getUser();
        // 角色集合
        //Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        //Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);

//        ajax.put("roles", roles);
//        ajax.put("permissions", permissions);
        return ajax;
    }
}
