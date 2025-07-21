package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Drug;
import com.hwadee.backend.mapper.DrugMapper;
import com.hwadee.backend.service.DrugService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DrugServiceImpl implements DrugService {

    @Autowired
    private DrugMapper drugMapper;

    @Override
    public List<Drug> getAllDrugs() {
        QueryWrapper<Drug> wrapper = new QueryWrapper<>();
        wrapper.eq("status", "active");
        return drugMapper.selectList(wrapper);
    }

    @Override
    public Drug getDrugById(Integer id) {
        return drugMapper.selectById(id);
    }

    @Override
    public List<Drug> getDrugsByCategory(String category) {
        QueryWrapper<Drug> wrapper = new QueryWrapper<>();
        wrapper.eq("category", category).eq("status", "active");
        return drugMapper.selectList(wrapper);
    }

    @Override
    public List<Drug> searchDrugs(String keyword) {
        QueryWrapper<Drug> wrapper = new QueryWrapper<>();
        wrapper.like("name", keyword)
              .or()
              .like("generic_name", keyword)
              .or()
              .like("description", keyword)
              .eq("status", "active");
        return drugMapper.selectList(wrapper);
    }

    @Override
    public List<Drug> getHotDrugs() {
        // 获取热门药品（这里简单返回前10个）
        QueryWrapper<Drug> wrapper = new QueryWrapper<>();
        wrapper.eq("status", "active").last("LIMIT 10");
        return drugMapper.selectList(wrapper);
    }

    @Override
    public List<Drug> list() {
        return null;
    }


} 