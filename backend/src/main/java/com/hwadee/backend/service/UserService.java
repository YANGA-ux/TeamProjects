package com.hwadee.backend.service;

import com.hwadee.backend.entity.User;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {

    List<User> getAllUsers();

    User getUserById(Long id);

    User getUserByUsername(String username);

    User createUser(User user);

    User updateUser(Long id, User user);

    void deleteUser(Long id);

    boolean changePassword(String username, String oldPassword, String newPassword);//修改密码service
    boolean register(String username, String password, String realName);//注册service

    List<User> getUsersByRole(String role);

}
