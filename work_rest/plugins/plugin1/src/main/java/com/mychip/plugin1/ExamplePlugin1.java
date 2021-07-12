package com.mychip.plugin1;

import com.gitee.starblues.annotation.ConfigDefinition;
import com.gitee.starblues.realize.BasePlugin;
import org.pf4j.PluginWrapper;

/**
 * Description:插件测试
 * User:   zhouyu
 * Date:   2021/7/6 0006
 */

@ConfigDefinition(fileName = "plugin1.yml", devSuffix = "-dev", prodSuffix = "-prod")
public class ExamplePlugin1 extends BasePlugin {
    public ExamplePlugin1(PluginWrapper wrapper) {
        super(wrapper);
        System.out.println(wrapper);
    }
}
