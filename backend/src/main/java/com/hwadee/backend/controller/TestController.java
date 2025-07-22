package com.hwadee.backend.controller;

import com.hwadee.backend.service.DrugService;
import com.hwadee.backend.service.NewsService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
@CrossOrigin(origins = "*")
public class TestController {

    @Autowired
    private DrugService drugService;

    @Autowired
    private NewsService newsService;

    @GetMapping("/health")
    public ResponseResult<Map<String, Object>> healthCheck() {
        Map<String, Object> health = new HashMap<>();
        health.put("status", "UP");
        health.put("timestamp", System.currentTimeMillis());
        health.put("service", "Bio-Pharma System");
        health.put("version", "1.0.0");
        
        return ResponseResult.success(health);
    }

    @GetMapping("/simple")
    public Map<String, Object> simpleTest() {
        Map<String, Object> result = new HashMap<>();
        result.put("message", "后端服务正常");
        result.put("timestamp", System.currentTimeMillis());
        return result;
    }

    @GetMapping("/database")
    public ResponseResult<Map<String, Object>> databaseTest() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 测试药品服务
            int drugCount = drugService.getAllDrugs().size();
            result.put("drugCount", drugCount);
            
            // 测试新闻服务
            int newsCount = newsService.getAllNews().size();
            result.put("newsCount", newsCount);
            
            result.put("databaseStatus", "CONNECTED");
            result.put("message", "数据库连接正常");
            result.put("drugs", drugService.getAllDrugs());
            result.put("news", newsService.getAllNews());
            
        } catch (Exception e) {
            result.put("databaseStatus", "ERROR");
            result.put("message", "数据库连接失败: " + e.getMessage());
            result.put("error", e.toString());
            e.printStackTrace();
        }
        
        return ResponseResult.success(result);
    }
} 