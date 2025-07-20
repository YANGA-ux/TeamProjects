package com.hwadee.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("scm_material")
public class Material {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String materialCode;
    private String materialName;
    private String materialType;
    private String category;
    private String specification;
    private String unit;
    private BigDecimal unitPrice;
    private String currency;
    private String storageConditions;
    private String shelfLife;
    private String manufacturer;
    private String supplierCode;
    private String qualityStandard;
    private String safetyData;
    private BigDecimal minStock;
    private BigDecimal maxStock;
    private BigDecimal currentStock;
    private String location;
    private String materialStatus;
    private String attachments;
    private String notes;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String createBy;
    private String updateBy;
} 