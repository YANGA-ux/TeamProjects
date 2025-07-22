package com.hwadee.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hwadee.backend.entity.Order;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper extends BaseMapper<Order> {
    List<Order> selectByUserId(Integer userId);
    List<Order> selectByStatus(String status);
} 