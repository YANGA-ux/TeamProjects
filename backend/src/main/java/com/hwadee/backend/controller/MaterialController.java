package com.hwadee.backend.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Material;
import com.hwadee.backend.mapper.MaterialMapper;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/material")
public class MaterialController {
    @Autowired
    private MaterialMapper materialMapper;

    @GetMapping("/list")
    public ResponseResult<List<Material>> list() {
        List<Material> list = materialMapper.selectList(null);
        return ResponseResult.success(list);
    }

    @GetMapping("/{id}")
    public ResponseResult<Material> getById(@PathVariable Long id) {
        Material material = materialMapper.selectById(id);
        return material != null ? ResponseResult.success(material) : ResponseResult.error(500,"未找到物料");
    }

    @PostMapping("/add")
    public ResponseResult<?> add(@RequestBody Material material) {
        int result = materialMapper.insert(material);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"添加失败");
    }

    @PostMapping("/update")
    public ResponseResult<?> update(@RequestBody Material material) {
        int result = materialMapper.updateById(material);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<?> delete(@PathVariable Long id) {
        int result = materialMapper.deleteById(id);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"删除失败");
    }
}
