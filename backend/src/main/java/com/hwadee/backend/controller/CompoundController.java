package com.hwadee.backend.controller;

import com.hwadee.backend.entity.Compound;
import com.hwadee.backend.service.CompoundService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/compounds")
@CrossOrigin(origins = "*")
public class CompoundController {

    @Autowired
    private CompoundService compoundService;

    @GetMapping
    public ResponseResult<List<Compound>> getAllCompounds() {
        try {
            List<Compound> compounds = compoundService.getAllCompounds();
            return ResponseResult.success(compounds);
        } catch (Exception e) {
            return ResponseResult.error(500, "获取化合物列表失败: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseResult<Compound> getCompoundById(@PathVariable Long id) {
        try {
            Compound compound = compoundService.getCompoundById(id);
            if (compound != null) {
                return ResponseResult.success(compound);
            } else {
                return ResponseResult.error(404, "化合物不存在");
            }
        } catch (Exception e) {
            return ResponseResult.error(500, "获取化合物信息失败: " + e.getMessage());
        }
    }

    @PostMapping
    public ResponseResult<Compound> createCompound(@RequestBody Compound compound) {
        try {
            Compound createdCompound = compoundService.createCompound(compound);
            return ResponseResult.success(createdCompound);
        } catch (Exception e) {
            return ResponseResult.error(500, "创建化合物失败: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseResult<Compound> updateCompound(@PathVariable Long id, @RequestBody Compound compound) {
        try {
            compound.setId(id);
            Compound updatedCompound = compoundService.updateCompound(compound);
            return ResponseResult.success(updatedCompound);
        } catch (Exception e) {
            return ResponseResult.error(500, "更新化合物失败: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseResult<String> deleteCompound(@PathVariable Long id) {
        try {
            compoundService.deleteCompound(id);
            return ResponseResult.success("化合物删除成功");
        } catch (Exception e) {
            return ResponseResult.error(500, "删除化合物失败: " + e.getMessage());
        }
    }

    @GetMapping("/search")
    public ResponseResult<List<Compound>> searchCompounds(@RequestParam String keyword) {
        try {
            List<Compound> compounds = compoundService.searchCompounds(keyword);
            return ResponseResult.success(compounds);
        } catch (Exception e) {
            return ResponseResult.error(500, "搜索化合物失败: " + e.getMessage());
        }
    }

    @GetMapping("/category/{category}")
    public ResponseResult<List<Compound>> getCompoundsByCategory(@PathVariable String category) {
        try {
            List<Compound> compounds = compoundService.getCompoundsByCategory(category);
            return ResponseResult.success(compounds);
        } catch (Exception e) {
            return ResponseResult.error(500, "获取化合物列表失败: " + e.getMessage());
        }
    }
} 