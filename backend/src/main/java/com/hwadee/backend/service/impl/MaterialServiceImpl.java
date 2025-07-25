package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hwadee.backend.entity.Material;
import com.hwadee.backend.mapper.MaterialMapper;
import com.hwadee.backend.service.MaterialService;
import org.springframework.stereotype.Service;

@Service
public class MaterialServiceImpl extends ServiceImpl<MaterialMapper, Material> implements MaterialService {
} 