package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.News;
import com.hwadee.backend.mapper.NewsMapper;
import com.hwadee.backend.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {

    @Autowired
    private NewsMapper newsMapper;

    @Override
    public List<News> getLatestNews(Integer limit) {
        QueryWrapper<News> wrapper = new QueryWrapper<>();
        wrapper.eq("status", "published")
              .orderByDesc("publish_time")
              .last("LIMIT " + limit);
        return newsMapper.selectList(wrapper);
    }

    @Override
    public List<News> getNewsByCategory(String category) {
        QueryWrapper<News> wrapper = new QueryWrapper<>();
        wrapper.eq("category", category)
              .eq("status", "published")
              .orderByDesc("publish_time");
        return newsMapper.selectList(wrapper);
    }

    @Override
    public News getNewsById(Integer id) {
        return newsMapper.selectById(id);
    }

    @Override
    public List<News> getAllNews() {
        QueryWrapper<News> wrapper = new QueryWrapper<>();
        wrapper.eq("status", "published")
              .orderByDesc("publish_time");
        return newsMapper.selectList(wrapper);
    }
} 