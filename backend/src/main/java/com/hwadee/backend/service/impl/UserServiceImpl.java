package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.User;
import com.hwadee.backend.mapper.UserMapper;
import com.hwadee.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    @Autowired // 推荐构造方法注入
    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public List<User> getAllUsers() {
        return userMapper.selectList(null);
    }
    // ... existing code ...
    @Override
    public User getUserById(Long id) {
        // 通过ID查询用户
        return userMapper.selectById(id);
    }

    @Override
    public User getUserByUsername(String username) {
        // 通过用户名查询用户
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username);
        return userMapper.selectOne(wrapper);
    }

    @Override
    public User createUser(User user) {
        // 创建用户
        userMapper.insert(user);
        return user;
    }

    @Override
    public User updateUser(Long id, User user) {
        // 更新用户
        user.setId(id.intValue()); // 注意：User实体是int类型uerId
        userMapper.updateById(user);
        return user;
    }

    @Override
    public void deleteUser(Long id) {
        // 删除用户
        userMapper.deleteById(id);
    }
//修改密码
    @Override
    public boolean changePassword(String username, String oldPassword, String newPassword) {
    // 用 username 查询用户并校验原密码
    User user = userMapper.selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<User>().eq("username", username));
    if (user != null && user.getPassword().equals(oldPassword)) {
        user.setPassword(newPassword);
        userMapper.updateById(user);
        return true;
    }
    return false;
}
//注册
    @Override
    public boolean register(String username, String password, String realName) {
        // 检查用户名是否已存在
        User exist = userMapper.selectOne(new QueryWrapper<User>().eq("username", username));
        if (exist != null) {
            return false;
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setReal_name(realName);
        user.setRole("user"); // 默认普通用户
        user.setStatus("1");  // 默认启用
        userMapper.insert(user);
        return true;
    }

    @Override
    public List<User> getUsersByRole(String role) {
        // 这里建议在UserMapper中自定义selectByRole方法
        return userMapper.selectByRole(role);
    }


}

