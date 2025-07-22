package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Compound;
import com.hwadee.backend.mapper.CompoundMapper;
import com.hwadee.backend.service.CompoundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CompoundServiceImpl implements CompoundService {

    @Autowired
    private CompoundMapper compoundMapper;

    @Override
    public List<Compound> getAllCompounds() {
        QueryWrapper<Compound> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1).orderByDesc("create_time");
        return compoundMapper.selectList(wrapper);
    }

    @Override
    public Compound getCompoundById(Long id) {
        return compoundMapper.selectById(id);
    }

    @Override
    public Compound createCompound(Compound compound) {
        compound.setCreateTime(LocalDateTime.now());
        compound.setUpdateTime(LocalDateTime.now());
        compound.setStatus(1);
        compound.setCreateBy("admin"); // 暂时硬编码，后续可以从当前用户获取
        compoundMapper.insert(compound);
        return compound;
    }

    @Override
    public Compound updateCompound(Compound compound) {
        compound.setUpdateTime(LocalDateTime.now());
        compound.setUpdateBy("admin"); // 暂时硬编码，后续可以从当前用户获取
        compoundMapper.updateById(compound);
        return compound;
    }

    @Override
    public void deleteCompound(Long id) {
        // 软删除，设置状态为0
        Compound compound = new Compound();
        compound.setId(id);
        compound.setStatus(0);
        compound.setUpdateTime(LocalDateTime.now());
        compound.setUpdateBy("admin");
        compoundMapper.updateById(compound);
    }

    @Override
    public List<Compound> searchCompounds(String keyword) {
        QueryWrapper<Compound> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
              .and(w -> w.like("compound_name", keyword)
                        .or()
                        .like("compound_code", keyword)
                        .or()
                        .like("description", keyword))
              .orderByDesc("create_time");
        return compoundMapper.selectList(wrapper);
    }

    @Override
    public List<Compound> getCompoundsByCategory(String category) {
        QueryWrapper<Compound> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
              .eq("category", category)
              .orderByDesc("create_time");
        return compoundMapper.selectList(wrapper);
    }
} 