package com.hwadee.backend.service.impl;

import com.hwadee.backend.DTO.ProductionMonitoringDTO;
import com.hwadee.backend.mapper.ProductionMonitoringMapper;
import com.hwadee.backend.service.ProductionMonitoringService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductionMonitoringServiceImpl implements ProductionMonitoringService {
    @Autowired
    private ProductionMonitoringMapper mapper;

    @Override
    public List<ProductionMonitoringDTO> getBatchWithStandard() {
        return mapper.selectBatchWithStandard();
    }

    @Override
    public ProductionMonitoringDTO getStandardByProductCode(String productCode) {
        return mapper.selectStandardByProductCode(productCode);
    }

    @Override
    public void updateBatchQcResult(String batchCode, String result) {
        mapper.updateBatchQcResult(batchCode, result);
    }
}