package com.mychip.work.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;

/**
 * name: MessageUtils
 * author: Administrator
 * data: 2021/7/11 0011
 * description: 获取i18n资源文件
 */
public class MessageUtils
{
    private static final Logger log = LoggerFactory.getLogger(MessageUtils.class);
    /**
     * 根据消息键和参数 获取消息 委托给spring messageSource
     *
     * @param code 消息键
     * @param args 参数
     * @return 获取国际化翻译值
     */
    public static String message(String code, Object... args)
    {
        MessageSource messageSource = SpringUtils.getBean(MessageSource.class);

        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }
}

