package com.hwadee.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hwadee.backend.entity.ProdBatch;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProdBatchMapper extends BaseMapper<ProdBatch> {
    // 复杂查询可后续补充
}