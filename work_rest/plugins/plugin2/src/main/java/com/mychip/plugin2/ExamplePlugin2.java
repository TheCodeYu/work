package com.mychip.plugin2;

import com.gitee.starblues.annotation.ConfigDefinition;
import com.gitee.starblues.realize.BasePlugin;
import org.pf4j.PluginWrapper;

/**
 * Description:
 * User:   zhouyu
 * Date:   2021/7/7 0007
 */
@ConfigDefinition(fileName = "plugin2.yml", devSuffix = "-dev", prodSuffix = "-prod")
public class ExamplePlugin2 extends BasePlugin {
    public ExamplePlugin2(PluginWrapper wrapper) {
        super(wrapper);
        System.out.println(wrapper);
    }
}
