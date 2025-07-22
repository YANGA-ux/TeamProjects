package com.hwadee.backend.controller;

import com.hwadee.backend.entity.QaQualityStandard;
import com.hwadee.backend.service.QaQualityStandardService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/qa/standard")
@CrossOrigin(origins = "*")
public class QaQualityStandardController {

    @Autowired
    private QaQualityStandardService qaQualityStandardService;


    @GetMapping("/stats")
    public ResponseResult<Map<String, Object>> getStats() {
        Map<String, Object> stats = new HashMap<>();
        List<QaQualityStandard> list = qaQualityStandardService.list();
        stats.put("total", list.size());
        stats.put("active", list.stream().filter(q -> "active".equals(q.getStatus())).count());
        stats.put("inactive", list.stream().filter(q -> "inactive".equals(q.getStatus())).count());
        stats.put("draft", list.stream().filter(q -> "draft".equals(q.getStatus())).count());
        return ResponseResult.success(stats);
    }

    @GetMapping("/list")
    public ResponseResult<List<QaQualityStandard>> getStandardList() {
        return ResponseResult.success(qaQualityStandardService.list());
    }

    @PostMapping("/add")
    public ResponseResult<String> addStandard(@RequestBody QaQualityStandard standard) {
        boolean success = qaQualityStandardService.save(standard);
        return success ? ResponseResult.success("添加成功") : ResponseResult.error(500, "添加失败");
    }

    @PutMapping("/update")
    public ResponseResult<String> updateStandard(@RequestBody QaQualityStandard standard) {
        boolean success = qaQualityStandardService.updateById(standard);
        return success ? ResponseResult.success("更新成功") : ResponseResult.error(500, "更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<String> deleteStandard(@PathVariable Long id) {
        boolean success = qaQualityStandardService.removeById(id);
        return success ? ResponseResult.success("删除成功") : ResponseResult.error(500, "删除失败");
    }
} 