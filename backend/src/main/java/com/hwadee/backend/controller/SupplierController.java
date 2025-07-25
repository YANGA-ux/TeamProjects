package com.hwadee.backend.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Supplier;
import com.hwadee.backend.mapper.SupplierMapper;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/supplier")
public class SupplierController {
    @Autowired
    private SupplierMapper supplierMapper;

    @GetMapping("/list")
    public ResponseResult<List<Supplier>> list() {
        List<Supplier> list = supplierMapper.selectList(null);
        return ResponseResult.success(list);
    }

    @GetMapping("/{id}")
    public ResponseResult<Supplier> getById(@PathVariable Long id) {
        Supplier supplier = supplierMapper.selectById(id);
        return supplier != null ? ResponseResult.success(supplier) : ResponseResult.error(500,"未找到供应商");
    }

    @PostMapping("/add")
    public ResponseResult<?> add(@RequestBody Supplier supplier) {
        int result = supplierMapper.insert(supplier);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"添加失败");
    }

    @PostMapping("/update")
    public ResponseResult<?> update(@RequestBody Supplier supplier) {
        int result = supplierMapper.updateById(supplier);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<?> delete(@PathVariable Long id) {
        int result = supplierMapper.deleteById(id);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"删除失败");
    }
}
