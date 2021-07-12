package com.mychip.work.plugin;
import com.gitee.starblues.integration.listener.PluginInitializerListener;
import org.springframework.stereotype.Component;
/**
 * name: PluginListener
 * author: Administrator
 * data: 2021/7/12 0012
 * description:  初始化监听器
 */
@Component
public class PluginListener implements PluginInitializerListener {
    @Override
    public void before() {
        System.out.println("初始化之前");
    }

    @Override
    public void complete() {
        System.out.println("初始化完成");
    }

    @Override
    public void failure(Throwable throwable) {
        System.out.println("初始化失败:"+throwable.getMessage());
    }
}

