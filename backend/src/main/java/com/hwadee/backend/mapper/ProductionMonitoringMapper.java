package com.hwadee.backend.mapper;

import com.hwadee.backend.DTO.ProductionMonitoringDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductionMonitoringMapper {
    List<ProductionMonitoringDTO> selectBatchWithStandard();

    // 可选：根据产品编号查质量标准
    ProductionMonitoringDTO selectStandardByProductCode(@Param("productCode") String productCode);

    // 质检结果更新
    int updateBatchQcResult(@Param("batchCode") String batchCode, @Param("result") String result);
}