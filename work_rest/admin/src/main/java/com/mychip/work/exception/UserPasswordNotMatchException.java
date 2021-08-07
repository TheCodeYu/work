package com.mychip.work.exception;


/**
 * @name: UserPasswordNotMatchException
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 用户密码不正确或不符合规范异常类
 */
public class UserPasswordNotMatchException extends UserException
{
    private static final long serialVersionUID = 1L;

    public UserPasswordNotMatchException()
    {
        super("user.password.not.match", null);
    }
}
