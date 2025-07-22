package com.hwadee.backend.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Literature;
import com.hwadee.backend.mapper.LiteratureMapper;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/literature")
public class LiteratureController {
    @Autowired
    private LiteratureMapper literatureMapper;

    @GetMapping("/list")
    public ResponseResult<List<Literature>> list() {
        List<Literature> list = literatureMapper.selectList(null);
        return ResponseResult.success(list);
    }

    @GetMapping("/{id}")
    public ResponseResult<Literature> getById(@PathVariable Long id) {
        Literature literature = literatureMapper.selectById(id);
        return literature != null ? ResponseResult.success(literature) : ResponseResult.error(500,"未找到文献");
    }

    @PostMapping("/add")
    public ResponseResult<?> add(@RequestBody Literature literature) {
        int result = literatureMapper.insert(literature);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"添加失败");
    }

    @PostMapping("/update")
    public ResponseResult<?> update(@RequestBody Literature literature) {
        int result = literatureMapper.updateById(literature);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<?> delete(@PathVariable Long id) {
        int result = literatureMapper.deleteById(id);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"删除失败");
    }
} 