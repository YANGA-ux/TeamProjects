package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.User;
import com.hwadee.backend.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collections;

import static net.sf.jsqlparser.util.validation.metadata.NamedObject.user;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {


    @Autowired
    private UserMapper userMapper;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("loadUserByUsername 被调用，参数：" + username);


        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username); // 字段名根据你的表实际情况调整
        User user = userMapper.selectOne(wrapper);

        System.out.println("查到的用户：" + user);
        System.out.println("用户名：" + user.getUsername());
        System.out.println("密码：" + user.getPassword());
        System.out.println("角色：" + user.getRole());
        
        if (user == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        // 这里假设userRole字段是角色名
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority(user.getRole()))
        );
    }
}