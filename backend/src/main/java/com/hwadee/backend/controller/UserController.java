package com.hwadee.backend.controller;

import com.hwadee.backend.entity.User;
import com.hwadee.backend.service.UserService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user")
@CrossOrigin(origins = "*")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 根据用户名获取用户信息
    @GetMapping("/info")
    public ResponseResult<User> getUserInfo(@RequestParam String username) {
        try {
            User user = userService.getUserByUsername(username);
            if (user != null) {
                // 不返回密码信息
                user.setPassword(null);
                return ResponseResult.success(user);
            } else {
                return ResponseResult.error(404, "用户不存在");
            }
        } catch (Exception e) {
            return ResponseResult.error(500, "获取用户信息失败: " + e.getMessage());
        }
    }

    // 查询所有用户
    @GetMapping("/list")
    public ResponseResult<List<User>> getAllUsers() {
        try {
            List<User> users = userService.getAllUsers();
            // 不返回密码信息
            users.forEach(user -> user.setPassword(null));
            return ResponseResult.success(users);
        } catch (Exception e) {
            return ResponseResult.error(500, "获取用户列表失败: " + e.getMessage());
        }
    }

    // 根据ID查询用户
    @GetMapping("/{id}")
    public ResponseResult<User> getUserById(@PathVariable Long id) {
        try {
            User user = userService.getUserById(id);
            if (user != null) {
                user.setPassword(null);
                return ResponseResult.success(user);
            } else {
                return ResponseResult.error(404, "用户不存在");
            }
        } catch (Exception e) {
            return ResponseResult.error(500, "获取用户信息失败: " + e.getMessage());
        }
    }

    // 创建用户
    @PostMapping
    public ResponseResult<User> createUser(@RequestBody User user) {
        try {
            User createdUser = userService.createUser(user);
            createdUser.setPassword(null);
            return ResponseResult.success(createdUser);
        } catch (Exception e) {
            return ResponseResult.error(500, "创建用户失败: " + e.getMessage());
        }
    }

    // 更新用户
    @PutMapping("/{id}")
    public ResponseResult<User> updateUser(@PathVariable Long id, @RequestBody User user) {
        try {
            User updatedUser = userService.updateUser(id, user);
            updatedUser.setPassword(null);
            return ResponseResult.success(updatedUser);
        } catch (Exception e) {
            return ResponseResult.error(500, "更新用户失败: " + e.getMessage());
        }
    }

    // 删除用户
    @DeleteMapping("/{id}")
    public ResponseResult<String> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteUser(id);
            return ResponseResult.success("用户删除成功");
        } catch (Exception e) {
            return ResponseResult.error(500, "删除用户失败: " + e.getMessage());
        }
    }

    // 修改密码
    @PostMapping("/change-password")
    public ResponseResult<String> changePassword(@RequestParam String username,
                               @RequestParam String oldPassword,
                               @RequestParam String newPassword) {
        try {
            boolean success = userService.changePassword(username, oldPassword, newPassword);
            if (success) {
                return ResponseResult.success("密码修改成功");
            } else {
                return ResponseResult.error(400, "原密码错误或用户不存在");
            }
        } catch (Exception e) {
            return ResponseResult.error(500, "修改密码失败: " + e.getMessage());
        }
    }

    // 根据角色查询用户
    @GetMapping("/role/{role}")
    public ResponseResult<List<User>> getUsersByRole(@PathVariable String role) {
        try {
            List<User> users = userService.getUsersByRole(role);
            users.forEach(user -> user.setPassword(null));
            return ResponseResult.success(users);
        } catch (Exception e) {
            return ResponseResult.error(500, "获取用户列表失败: " + e.getMessage());
        }
    }
}
