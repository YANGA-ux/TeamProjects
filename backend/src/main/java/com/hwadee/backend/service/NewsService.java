package com.hwadee.backend.service;

import com.hwadee.backend.entity.News;
import java.util.List;

public interface NewsService {
    List<News> getLatestNews(Integer limit);
    List<News> getNewsByCategory(String category);
    News getNewsById(Integer id);
    List<News> getAllNews();
} 