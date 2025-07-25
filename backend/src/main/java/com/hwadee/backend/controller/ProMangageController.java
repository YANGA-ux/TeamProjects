package com.hwadee.backend.controller;


import com.hwadee.backend.DTO.ProMangageDTO;
import com.hwadee.backend.service.ProMangageService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/pro-mangage")
public class ProMangageController {

    @Autowired
    private ProMangageService service;

//    获取列表
    @GetMapping("/list")
    public ResponseResult<List<ProMangageDTO>> list(){
        return ResponseResult.success(service.getMaterialWithSupplier());
    }



}
