package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.InetAddress;
import java.net.UnknownHostException;


@Controller
public class HealthCheckController {

    private static final String SUCCESS = "success";

    @GetMapping({"/"})
    public @ResponseBody String checkPreload() {
        return SUCCESS;
    }

    @GetMapping("/system")
    public @ResponseBody String getSysInfo() {
        try {
            // 获取本地主机对象
            InetAddress localHost = InetAddress.getLocalHost();

            // 获取主机名
            String hostName = localHost.getHostName();

            // 获取IP地址
            String hostAddress = localHost.getHostAddress();

            return String.format("response form %s at %s for version 0.0.1", hostName, hostAddress);
        } catch (UnknownHostException e) {
            System.err.println("无法获取本机IP地址及主机名: " + e.getMessage());
            return "UNKNOWN";
        }
    }
}
