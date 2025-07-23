package com.hwadee.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hwadee.backend.entity.Supplier;
import com.hwadee.backend.mapper.SupplierMapper;
import com.hwadee.backend.service.SupplierService;
import org.springframework.stereotype.Service;

@Service
public class SupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements SupplierService {
} 