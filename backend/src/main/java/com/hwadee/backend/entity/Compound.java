package com.hwadee.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("rd_compound")
public class Compound {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String compoundCode;
    private String compoundName;
    private String chemicalFormula;
    private String molecularStructure;
    private BigDecimal molecularWeight;
    private String casNumber;
    private String category;
    private String description;
    private String physicalProperties;
    private String chemicalProperties;
    private String toxicity;
    private String storageConditions;
    private String safetyNotes;
    private String attachments;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String createBy;
    private String updateBy;
} 