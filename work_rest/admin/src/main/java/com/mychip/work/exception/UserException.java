package com.mychip.work.exception;

/**
 * @name: UserException
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 用户信息异常类
 */
public class UserException extends BaseException
{
    private static final long serialVersionUID = 1L;

    public UserException(String code, Object[] args)
    {
        super("user", code, args, null);
    }
}
