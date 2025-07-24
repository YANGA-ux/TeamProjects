package com.hwadee.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hwadee.backend.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    List<User> selectByRole(String role);

}
    