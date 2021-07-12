package com.mychip.plugin1;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 * User:   zhouyu
 * Date:   2021/7/6 0006
 */
@RestController
public class Test {
    @GetMapping("/plugin111")
    public String show(){
        return "index";
    }
}
