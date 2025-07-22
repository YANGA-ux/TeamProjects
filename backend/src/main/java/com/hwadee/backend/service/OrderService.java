package com.hwadee.backend.service;

import com.hwadee.backend.entity.Order;
import java.util.List;

public interface OrderService {
    List<Order> getOrdersByUserId(Integer userId);
    Order createOrder(Order order);
    Order updateOrderStatus(Integer orderId, String status);
    Order getOrderById(Integer orderId);
    List<Order> getAllOrders();
} 