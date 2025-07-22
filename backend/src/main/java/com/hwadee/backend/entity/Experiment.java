package com.hwadee.backend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("rd_experiment")
public class Experiment {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String experimentCode;
    private String experimentName;
    private String experimentType;
    private String experimentStatus;
    private String description;
    private String objective;
    private String methodology;
    private LocalDateTime plannedStartTime;
    private LocalDateTime plannedEndTime;
    private LocalDateTime actualStartTime;
    private LocalDateTime actualEndTime;
    private Long projectId;
    private Long responsibleUserId;
    private String result;
    private String conclusion;
    private String attachments;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String createBy;
    private String updateBy;
} 