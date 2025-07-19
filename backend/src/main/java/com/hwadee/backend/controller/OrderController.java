package com.hwadee.backend.controller;

import com.hwadee.backend.entity.Order;
import com.hwadee.backend.service.OrderService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
@CrossOrigin(origins = "*")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/user/{userId}")
    public ResponseResult<List<Order>> getOrdersByUserId(@PathVariable Integer userId) {
        List<Order> orders = orderService.getOrdersByUserId(userId);
        return ResponseResult.success(orders);
    }

    @PostMapping
    public ResponseResult<Order> createOrder(@RequestBody Order order) {
        Order createdOrder = orderService.createOrder(order);
        return ResponseResult.success(createdOrder);
    }

    @PutMapping("/{orderId}/status")
    public ResponseResult<Order> updateOrderStatus(
            @PathVariable Integer orderId,
            @RequestParam String status) {
        Order updatedOrder = orderService.updateOrderStatus(orderId, status);
        return ResponseResult.success(updatedOrder);
    }

    @GetMapping("/{orderId}")
    public ResponseResult<Order> getOrderById(@PathVariable Integer orderId) {
        Order order = orderService.getOrderById(orderId);
        return ResponseResult.success(order);
    }

    @GetMapping
    public ResponseResult<List<Order>> getAllOrders() {
        List<Order> orders = orderService.getAllOrders();
        return ResponseResult.success(orders);
    }
} 