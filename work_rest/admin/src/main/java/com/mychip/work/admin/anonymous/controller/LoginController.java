package com.mychip.work.admin.anonymous.controller;

import com.mychip.work.annotation.Log;
import com.mychip.work.constant.BusinessType;
import com.mychip.work.constant.Constant;
import com.mychip.work.constant.UserConstants;
import com.mychip.work.constant.UserStatus;
import com.mychip.work.core.SysLoginService;
import com.mychip.work.core.TokenService;
import com.mychip.work.core.domain.AjaxResult;
import com.mychip.work.core.domain.BaseController;
import com.mychip.work.core.domain.LoginBody;
import com.mychip.work.core.domain.LoginUser;
import com.mychip.work.core.domain.entity.SysUser;
import com.mychip.work.exception.BaseException;
import com.mychip.work.system.service.ISysUserService;
import com.mychip.work.utils.SecurityUtils;
import com.mychip.work.utils.ServletUtils;
import com.mychip.work.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Pattern;
import java.util.Set;

/**
 * @name: LoginController
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 登录注册控制器
 */
@RestController
@RequestMapping("/anonymous")
public class LoginController  extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(LoginController.class);


    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysUserService userService;

    /**
     * 登录方法
     *
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login/v1")
    public AjaxResult login(@RequestBody LoginBody loginBody)
    {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constant.TOKEN, token);
        return ajax;
    }



    @Log(title = "用户注册", businessType = BusinessType.INSERT)
    @PostMapping("/register/v1")
    public AjaxResult register(@Validated @RequestBody SysUser user){
        if (UserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(user.getUserName())))
        {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        }
        else if (StringUtils.isNotEmpty(user.getPhonenumber())
                && UserConstants.NOT_UNIQUE.equals(userService.checkPhoneUnique(user)))
        {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，手机号码已存在");
        }
//        else if (StringUtils.isNotEmpty(user.getEmail())
//                && UserConstants.NOT_UNIQUE.equals(userService.checkEmailUnique(user)))
//        {
//            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，邮箱账号已存在");
//        }

        user.setCreateBy(user.getUserName());//SecurityUtils.getUsername()
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));

        return toAjax(userService.insertUser(user));
    }

    //一键登录,验证电话存在就用验证码登录，否则就注册
    @GetMapping("/checkPhoneUnique/v1/{telephone}")
    public AjaxResult checkPhoneUnique(  @PathVariable(value = "telephone") String telephone){

        AjaxResult ajax = AjaxResult.success();
        SysUser user = userService.selectUserByTelephone(telephone);
        if (StringUtils.isNull(user))
        {
            log.info("登录用户：{} 不存在.", telephone);
            throw new BaseException("登录用户：" + telephone + " 不存在");
        }
        else if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
        {
            log.info("登录用户：{} 已被删除.", telephone);
            throw new BaseException("对不起，您的账号：" + telephone + " 已被删除");
        }
        else if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            log.info("登录用户：{} 已被停用.", telephone);
            throw new BaseException("对不起，您的账号：" + telephone + " 已停用");
        }
        ajax.put("user", user);
        return ajax;
    }


}
