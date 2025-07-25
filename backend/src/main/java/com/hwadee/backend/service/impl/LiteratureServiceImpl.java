package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hwadee.backend.entity.Literature;
import com.hwadee.backend.mapper.LiteratureMapper;
import com.hwadee.backend.service.LiteratureService;
import org.springframework.stereotype.Service;

@Service
public class LiteratureServiceImpl extends ServiceImpl<LiteratureMapper, Literature> implements LiteratureService {
} 