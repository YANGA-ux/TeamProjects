package com.hwadee.backend.controller;

import com.hwadee.backend.entity.ProdBatch;
import com.hwadee.backend.service.ProdBatchService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/prod/batch")
@CrossOrigin(origins = "*")
public class ProdBatchController {

    @Autowired
    private ProdBatchService prodBatchService;




    @GetMapping("/list")
    public ResponseResult<List<ProdBatch>> getBatchListWithDrugInfo() {
        List<ProdBatch> list = prodBatchService.list();
        for (ProdBatch batch : list) {
            System.out.println("批次详情: " + batch);
        }
        return ResponseResult.success(list);
    }
    @GetMapping("/stats")
    public ResponseResult<Map<String, Object>> getBatchStats() {
        return ResponseResult.success(prodBatchService.getBatchStats());
    }

    @PostMapping("/add")
    public ResponseResult<String> addBatch(@RequestBody ProdBatch batch) {
        boolean success = prodBatchService.save(batch);
        return success ? ResponseResult.success("添加成功") : ResponseResult.error(500, "添加失败");
    }

    @PutMapping("/update")
    public ResponseResult<String> updateBatch(@RequestBody ProdBatch batch) {
        boolean success = prodBatchService.updateById(batch);
        return success ? ResponseResult.success("更新成功") : ResponseResult.error(500, "更新失败");
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<String> deleteBatch(@PathVariable Long id) {
        boolean success = prodBatchService.removeById(id);
        return success ? ResponseResult.success("删除成功") : ResponseResult.error(500, "删除失败");
    }
}