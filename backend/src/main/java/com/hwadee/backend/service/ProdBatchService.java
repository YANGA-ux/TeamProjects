package com.hwadee.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hwadee.backend.entity.ProdBatch;

import java.util.List;
import java.util.Map;

public interface ProdBatchService extends IService<ProdBatch> {
    
    List<ProdBatch> getBatchListWithDrugInfo();
    
    Map<String, Object> getBatchStats();
    
    boolean updateBatchStatus(Integer id, String status);
    
    boolean updateQualityScore(Integer id, Double qualityScore);
} 