package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hwadee.backend.entity.ProdBatch;
import com.hwadee.backend.mapper.ProdBatchMapper;
import com.hwadee.backend.service.ProdBatchService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProdBatchServiceImpl extends ServiceImpl<ProdBatchMapper, ProdBatch> implements ProdBatchService {
    @Override
    public List<ProdBatch> getBatchListWithDrugInfo() {
        return this.list();
    }

    @Override
    public Map<String, Object> getBatchStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", this.count()); // 总批次数
        stats.put("inProgress", this.count(new QueryWrapper<ProdBatch>().eq("batch_status", "IN_PROGRESS")));
        stats.put("completed", this.count(new QueryWrapper<ProdBatch>().eq("batch_status", "COMPLETED")));
        return stats;
    }

    @Override
    public boolean updateBatchStatus(Integer id, String status) {
        return false;
    }

    @Override
    public boolean updateQualityScore(Integer id, Double qualityScore) {
        return false;
    }
}