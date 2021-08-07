package com.mychip.work.annotation;

import com.mychip.work.constant.BusinessType;

import java.lang.annotation.*;

/**
 * @name: Log
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description:
 */

@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log
{
    /**
     * 模块
     */
    public String title() default "";

    /**
     * 功能
     */
    public BusinessType businessType() default BusinessType.OTHER;

    /**
     * 操作人类别
     */
    public OperatorType operatorType() default OperatorType.MANAGE;

    /**
     * 是否保存请求的参数
     */
    public boolean isSaveRequestData() default true;
}
