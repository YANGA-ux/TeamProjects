package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Order;
import com.hwadee.backend.mapper.OrderMapper;
import com.hwadee.backend.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<Order> getOrdersByUserId(Integer userId) {
        QueryWrapper<Order> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId).orderByDesc("order_time");
        return orderMapper.selectList(wrapper);
    }

    @Override
    public Order createOrder(Order order) {
        order.setOrderTime(LocalDateTime.now());
        order.setStatus("pending");
        orderMapper.insert(order);
        return order;
    }

    @Override
    public Order updateOrderStatus(Integer orderId, String status) {
        Order order = orderMapper.selectById(orderId);
        if (order != null) {
            order.setStatus(status);
            if ("completed".equals(status)) {
                order.setDeliveryTime(LocalDateTime.now());
            }
            orderMapper.updateById(order);
        }
        return order;
    }

    @Override
    public Order getOrderById(Integer orderId) {
        return orderMapper.selectById(orderId);
    }

    @Override
    public List<Order> getAllOrders() {
        QueryWrapper<Order> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("order_time");
        return orderMapper.selectList(wrapper);
    }
} 