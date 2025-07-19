package com.hwadee.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hwadee.backend.entity.News;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NewsMapper extends BaseMapper<News> {
    List<News> selectLatestNews(Integer limit);
    List<News> selectByCategory(String category);
} 