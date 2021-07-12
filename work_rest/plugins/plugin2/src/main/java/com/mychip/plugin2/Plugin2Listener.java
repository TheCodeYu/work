package com.mychip.plugin2;

import com.gitee.starblues.realize.BasePlugin;
import com.gitee.starblues.realize.OneselfListener;
import com.gitee.starblues.utils.OrderPriority;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Description:一个插件模块的监听器可定义多个。执行顺序由 OrderPriority 控制。
 * User:   zhouyu
 * Date:   2021/7/7 0007
 */

public class Plugin2Listener implements OneselfListener {

    private final Logger logger = LoggerFactory.getLogger(Plugin2Listener.class);


    @Override
    public OrderPriority order() {
        // 定义监听器执行顺序。用于多个监听器

        return OrderPriority.getMiddlePriority();
    }

    @Override
    public void startEvent(BasePlugin basePlugin) {
        // 启动事件
        logger.info("Plugin2Listener {} start Event", basePlugin.getWrapper().getPluginId());
    }

    @Override
    public void stopEvent(BasePlugin basePlugin) {
        // 停止事件
        logger.info("Plugin2Listener {} stop Event", basePlugin.getWrapper().getPluginId());
    }
}
