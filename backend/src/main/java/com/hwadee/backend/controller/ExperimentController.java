package com.hwadee.backend.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Experiment;
import com.hwadee.backend.mapper.ExperimentMapper;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/experiment")
public class ExperimentController {
    @Autowired
    private ExperimentMapper experimentMapper;

    @GetMapping("/list")
    public ResponseResult<List<Experiment>> list() {
        List<Experiment> list = experimentMapper.selectList(null);
        return ResponseResult.success(list);
    }

    @GetMapping("/{id}")
    public ResponseResult<Experiment> getById(@PathVariable Long id) {
        Experiment experiment = experimentMapper.selectById(id);
        return experiment != null ? ResponseResult.success(experiment) : ResponseResult.error(500,"未找到实验");
    }

    @PostMapping("/add")
    public ResponseResult<?> add(@RequestBody Experiment experiment) {
        int result = experimentMapper.insert(experiment);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"添加失败");
    }

    @PostMapping("/update")
    public ResponseResult<?> update(@RequestBody Experiment experiment) {
        int result = experimentMapper.updateById(experiment);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<?> delete(@PathVariable Long id) {
        int result = experimentMapper.deleteById(id);
        return result > 0 ? ResponseResult.success() : ResponseResult.error(500,"删除失败");
    }
} 