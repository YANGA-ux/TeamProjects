package com.hwadee.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("prod_batch")
public class Batch {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String batchCode;
    private String productCode;
    private String productName;
    private String batchStatus;
    private BigDecimal plannedQuantity;
    private BigDecimal actualQuantity;
    private String unit;
    private LocalDateTime plannedStartTime;
    private LocalDateTime plannedEndTime;
    private LocalDateTime actualStartTime;
    private LocalDateTime actualEndTime;
    private String productionLine;
    private String equipment;
    private String processParameters;
    private String qualityParameters;
    private String deviationRecords;
    private String attachments;
    private String notes;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String createBy;
    private String updateBy;
} 