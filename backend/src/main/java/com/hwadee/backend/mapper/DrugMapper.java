package com.hwadee.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hwadee.backend.entity.Drug;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DrugMapper extends BaseMapper<Drug> {
    List<Drug> selectByCategory(String category);
    List<Drug> searchDrugs(String keyword);
} 