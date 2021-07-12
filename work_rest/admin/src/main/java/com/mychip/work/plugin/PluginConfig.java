package com.mychip.work.plugin;

import com.gitee.starblues.extension.log.SpringBootLogExtension;
import com.gitee.starblues.extension.mybatis.SpringBootMybatisExtension;
import com.gitee.starblues.integration.AutoIntegrationConfiguration;
import com.gitee.starblues.integration.application.AutoPluginApplication;
import com.gitee.starblues.integration.application.PluginApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
/**
 * name: PluginConfig
 * author: Administrator
 * data: 2021/7/12 0012
 * description: 插件配置文件
 */
@Configuration
@Import(AutoIntegrationConfiguration.class)
public class PluginConfig {

    /**
     * 定义插件应用。使用可以注入它操作插件。
     * @return PluginApplication
     */
    @Bean
    public PluginApplication pluginApplication(){
        // 实例化自动初始化插件的PluginApplication
        PluginApplication pluginApplication = new AutoPluginApplication();
        // 新增mybatis-plus扩展
        pluginApplication
                .addExtension(new SpringBootMybatisExtension(SpringBootMybatisExtension.Type.MYBATIS))
                .addExtension(new SpringBootLogExtension(SpringBootLogExtension.Type.LOGBACK));
        // .addExtension(new StaticResourceExtension(StaticResourceExtension.Include.THYMELEAF));

        return pluginApplication;
    }

    @Bean
    public PluginApplication pluginApplication(PluginListener pluginListener){
        AutoPluginApplication autoPluginApplication = new AutoPluginApplication();
        autoPluginApplication.setPluginInitializerListener(pluginListener);
        autoPluginApplication.addListener(Listener.class);
        // 新增mybatis-plus扩展
        autoPluginApplication
                .addExtension(new SpringBootMybatisExtension(SpringBootMybatisExtension.Type.MYBATIS))
                .addExtension(new SpringBootLogExtension(SpringBootLogExtension.Type.LOGBACK));
        // .addExtension(new StaticResourceExtension(StaticResourceExtension.Include.THYMELEAF));
        return autoPluginApplication;
    }
}

