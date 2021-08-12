///极光相关的API

package com.mychip.work.config;

import cn.jsms.api.common.SMSClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class JPushConfig {

    protected static final Logger LOG = LoggerFactory.getLogger(JPushConfig.class);

    private static final String appkey = "986a9991774fb03b60d4b7aa";
    private static final String masterSecret = "69d79d5bcf4a196558cfe479";

    @Bean
    public SMSClient get(){
        return new SMSClient(masterSecret, appkey);
    }
}
