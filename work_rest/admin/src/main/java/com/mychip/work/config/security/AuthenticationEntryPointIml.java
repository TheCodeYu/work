package com.mychip.work.config.security;

import com.alibaba.fastjson.JSON;

import com.mychip.work.core.domain.AjaxResult;
import com.mychip.work.utils.ServletUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;

import com.mychip.work.constant.HttpStatus;
import com.mychip.work.utils.StringUtils;
import org.springframework.stereotype.Component;
/**
 * name: AuthenticationEntryPointIml
 * author: Administrator
 * data: 2021/7/12 0012
 * description: 认证失败处理类 返回未授权
 */
@Component
public class AuthenticationEntryPointIml implements AuthenticationEntryPoint, Serializable {

    private static final long serialVersionUID = -8970718410437077606L;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
        int code = HttpStatus.UNAUTHORIZED;
        String msg = StringUtils.format("请求访问：{}，认证失败，无法访问系统资源", request.getRequestURI());
        ServletUtils.renderString(response, JSON.toJSONString(AjaxResult.error(code, msg)));
    }
}
