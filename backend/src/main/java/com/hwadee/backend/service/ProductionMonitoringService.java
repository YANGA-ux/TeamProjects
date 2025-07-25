package com.hwadee.backend.service;

import com.hwadee.backend.DTO.ProductionMonitoringDTO;

import java.util.List;

public interface ProductionMonitoringService {
    List<ProductionMonitoringDTO> getBatchWithStandard();
    ProductionMonitoringDTO getStandardByProductCode(String productCode);
    void updateBatchQcResult(String batchCode, String result);
}