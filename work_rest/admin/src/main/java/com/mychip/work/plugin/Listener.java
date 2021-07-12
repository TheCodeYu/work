package com.mychip.work.plugin;
import com.gitee.starblues.integration.listener.PluginListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * name: Listener
 * author: Administrator
 * data: 2021/7/12 0012
 * description: 插件启动、停止监听
 */


public class Listener implements  PluginListener {

    private final Logger logger = LoggerFactory.getLogger(Listener.class);
    /**
     * 注册插件
     * @param pluginId 插件id
     * @param isStartInitial 是否随着系统启动时而进行的插件注册
     */
    @Override
    public void registry(String pluginId,  boolean isStartInitial) {
        // 注册插件
        logger.info("registry:"+pluginId+":"+String.valueOf(isStartInitial));

    }

    @Override
    public void unRegistry(String pluginId) {
        // 卸载插件
        logger.info("unRegistry:"+pluginId);
    }

    @Override
    public void failure(String pluginId, Throwable throwable) {
        // 插件运行错误
        logger.info("failure:"+pluginId);
    }
}
