package com.mychip.work.admin.anonymous.controller;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
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

    //验证码
    @GetMapping("/sendSMSCode/v1/{telephone}")
    public AjaxResult sendSMSCode(@PathVariable(value = "telephone") String telephone) {

        AjaxResult ajax = AjaxResult.success();
        SMSPayload payload = SMSPayload.newBuilder()
                .setMobileNumber("13800138000")
                .setTempId(1)
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
            ValidSMSResult res = smsClient.sendValidSMSCode(phone, code);
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

}
