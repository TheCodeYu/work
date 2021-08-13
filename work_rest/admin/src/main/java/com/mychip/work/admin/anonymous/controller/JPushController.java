package com.mychip.work.admin.anonymous.controller;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.PushPayload;
import cn.jsms.api.SendSMSResult;
import cn.jsms.api.ValidSMSResult;
import cn.jsms.api.common.SMSClient;
import cn.jsms.api.common.model.SMSPayload;
import com.mychip.work.core.domain.AjaxResult;
import com.mychip.work.core.domain.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import static cn.jpush.api.push.model.notification.PlatformNotification.ALERT;

/**
 * @name: JPushController
 * @author: Administrator
 * @data: 2021/8/7 0007
 * @description: 极光控制器
 */
@RestController
@RequestMapping("/anonymous")
public class JPushController extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(JPushController.class);

    @Autowired
    private SMSClient smsClient;

    @Autowired
    private JPushClient jPushClient;
    //验证码
    @GetMapping("/sendSMSCode/v1/{telephone}")
    public AjaxResult sendSMSCode(@PathVariable(value = "telephone") String telephone) {

        AjaxResult ajax = AjaxResult.success();
        SMSPayload payload = SMSPayload.newBuilder()
                .setMobileNumber(telephone)
                .setTempId(1)
                .setSignId(19883)
                .build();
        try {
            SendSMSResult res = smsClient.sendSMSCode(payload);
            System.out.println(res.toString());
            log.info(res.toString());
            ajax.put("msg_id", res);
        } catch (APIConnectionException e) {
            log.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            log.error("Error response from JPush server. Should review and fix it. ", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Message: " + e.getMessage());
        }
        return ajax;
    }

    @GetMapping("/sendValidSMSCode/v1")
    public AjaxResult sendValidSMSCode(String phone,String code) {
        AjaxResult ajax = AjaxResult.success();
        try {
            ValidSMSResult res = smsClient.sendValidSMSCode("343211245856768", "685759");
            System.out.println(res.toString());
            log.info(res.toString());
        } catch (APIConnectionException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            log.error("Connection error. Should retry later. ", e);
        } catch (APIRequestException e) {
            e.printStackTrace();
            if (e.getErrorCode() == 50010) {
                // do something
            }
            System.out.println(e.getStatus() + " errorCode: " + e.getErrorCode() + " " + e.getErrorMessage());
            log.error("Error response from JPush server. Should review and fix it. ", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Message: " + e.getMessage());
        }
        return ajax;
    }

    @GetMapping("/pushAll/v1")
    public AjaxResult pushAll(){
        AjaxResult ajax = AjaxResult.success();
        PushPayload payload = PushPayload.alertAll(ALERT);

        try {
            PushResult result = jPushClient.sendPush(payload);
            log.info("Got result - " + result);

        } catch (APIConnectionException e) {
            // Connection error, should retry later
            log.error("Connection error, should retry later", e);

        } catch (APIRequestException e) {
            // Should review the error, and fix the request
            log.error("Should review the error, and fix the request", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Code: " + e.getErrorCode());
            log.info("Error Message: " + e.getErrorMessage());
        }
        return ajax;
    }
}
