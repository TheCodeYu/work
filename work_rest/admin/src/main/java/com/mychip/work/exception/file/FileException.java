package com.mychip.work.exception.file;

import com.mychip.work.exception.BaseException;

/**
 * 文件信息异常类
 *
 * @author zhouyu
 */
public class FileException extends BaseException
{
    private static final long serialVersionUID = 1L;

    public FileException(String code, Object[] args)
    {
        super("file", code, args, null);
    }

}
