package com.hwadee.backend.controller;

import com.hwadee.backend.DTO.ProductionMonitoringDTO;
import com.hwadee.backend.service.ProductionMonitoringService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/production-monitoring")
public class ProductionMonitoringController {

    @Autowired
    private ProductionMonitoringService service;

    // 列表接口
    @GetMapping("/list")
    public ResponseResult<List<ProductionMonitoringDTO>> list() {
        return ResponseResult.success(service.getBatchWithStandard());
    }

    // 质量标准详情接口
    @GetMapping("/quality-standard/by-product/{productCode}")
    public ResponseResult<ProductionMonitoringDTO> getStandard(@PathVariable String productCode) {
        return ResponseResult.success(service.getStandardByProductCode(productCode));
    }

    // 质检结果提交
    @PostMapping("/qc-result")
    public ResponseResult<Void> qcResult(@RequestBody QcResultRequest req) {
        service.updateBatchQcResult(req.getBatchCode(), req.getResult());
        return ResponseResult.success();
    }

    // 内部类用于接收前端POST参数
    public static class QcResultRequest {
        private String batchCode;
        private String result;
        public String getBatchCode() { return batchCode; }
        public void setBatchCode(String batchCode) { this.batchCode = batchCode; }
        public String getResult() { return result; }
        public void setResult(String result) { this.result = result; }
    }
}