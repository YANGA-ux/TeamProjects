package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hwadee.backend.entity.Experiment;
import com.hwadee.backend.mapper.ExperimentMapper;
import com.hwadee.backend.service.ExperimentService;
import org.springframework.stereotype.Service;

@Service
public class ExperimentServiceImpl extends ServiceImpl<ExperimentMapper, Experiment> implements ExperimentService {
} 