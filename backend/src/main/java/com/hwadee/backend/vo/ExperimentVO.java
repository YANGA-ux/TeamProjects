package com.hwadee.backend.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ExperimentVO {
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
    private String responsibleUserName; // 负责人姓名
} 