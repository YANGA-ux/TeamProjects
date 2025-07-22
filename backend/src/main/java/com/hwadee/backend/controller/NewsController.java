package com.hwadee.backend.controller;

import com.hwadee.backend.entity.News;
import com.hwadee.backend.service.NewsService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/news")
@CrossOrigin(origins = "*")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @GetMapping
    public ResponseResult<List<News>> getAllNews() {
        List<News> news = newsService.getAllNews();
        return ResponseResult.success(news);
    }

    @GetMapping("/latest")
    public ResponseResult<List<News>> getLatestNews(@RequestParam(defaultValue = "5") Integer limit) {
        List<News> news = newsService.getLatestNews(limit);
        return ResponseResult.success(news);
    }

    @GetMapping("/category/{category}")
    public ResponseResult<List<News>> getNewsByCategory(@PathVariable String category) {
        List<News> news = newsService.getNewsByCategory(category);
        return ResponseResult.success(news);
    }

    @GetMapping("/{id}")
    public ResponseResult<News> getNewsById(@PathVariable Integer id) {
        News news = newsService.getNewsById(id);
        return ResponseResult.success(news);
    }
} 