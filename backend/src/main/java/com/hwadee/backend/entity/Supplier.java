package com.hwadee.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("scm_supplier")
public class Supplier {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String supplierCode;
    private String supplierName;
    private String supplierType;
    private String contactPerson;
    private String contactPhone;
    private String contactEmail;
    private String address;
    private String businessLicense;
    private String taxNumber;
    private String qualification;
    private String supplierStatus;
    private String riskLevel;
    private String performanceRating;
    private LocalDate qualificationExpiryDate;
    private String auditHistory;
    private String attachments;
    private String notes;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String createBy;
    private String updateBy;
} 