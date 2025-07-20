package com.hwadee.backend.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hwadee.backend.entity.Batch;
import com.hwadee.backend.entity.Compound;
import com.hwadee.backend.entity.Experiment;
import com.hwadee.backend.entity.Material;
import com.hwadee.backend.entity.Supplier;
import com.hwadee.backend.mapper.BatchMapper;
import com.hwadee.backend.mapper.CompoundMapper;
import com.hwadee.backend.mapper.ExperimentMapper;
import com.hwadee.backend.mapper.MaterialMapper;
import com.hwadee.backend.mapper.SupplierMapper;
import com.hwadee.backend.service.UserService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/stats")
@CrossOrigin(origins = "*")
public class StatsController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private CompoundMapper compoundMapper;
    
    @Autowired
    private ExperimentMapper experimentMapper;
    
    @Autowired
    private BatchMapper batchMapper;
    
    @Autowired
    private MaterialMapper materialMapper;
    
    @Autowired
    private SupplierMapper supplierMapper;

    @GetMapping("/dashboard")
    public ResponseResult<Map<String, Object>> getDashboardStats() {
        try {
            Map<String, Object> stats = new HashMap<>();
            
            // 获取用户统计
            int totalUsers = userService.getAllUsers().size();
            int adminUsers = userService.getUsersByRole("ADMIN").size();
            int researcherUsers = userService.getUsersByRole("RESEARCHER").size();
            int labTechnicianUsers = userService.getUsersByRole("LAB_TECHNICIAN").size();
            int approverUsers = userService.getUsersByRole("APPROVER").size();
            int supervisorUsers = userService.getUsersByRole("SUPERVISOR").size();
            
            // 研发模块统计（化合物、实验）
            Map<String, Object> rdStats = new HashMap<>();
            QueryWrapper<Compound> compoundWrapper = new QueryWrapper<>();
            compoundWrapper.eq("status", 1);
            int compoundCount = Math.toIntExact(compoundMapper.selectCount(compoundWrapper));
            rdStats.put("compounds", compoundCount);
            
            QueryWrapper<Experiment> experimentWrapper = new QueryWrapper<>();
            experimentWrapper.eq("status", 1);
            int experimentCount = Math.toIntExact(experimentMapper.selectCount(experimentWrapper));
            rdStats.put("experiments", experimentCount);
            
            // 生产模块统计（批次）
            Map<String, Object> prodStats = new HashMap<>();
            QueryWrapper<Batch> batchWrapper = new QueryWrapper<>();
            batchWrapper.eq("status", 1);
            int batchCount = Math.toIntExact(batchMapper.selectCount(batchWrapper));
            prodStats.put("batches", batchCount);
            prodStats.put("standards", 23); // 暂时使用模拟数据
            
            // 供应链模块统计（物料、供应商）
            Map<String, Object> scmStats = new HashMap<>();
            QueryWrapper<Material> materialWrapper = new QueryWrapper<>();
            materialWrapper.eq("status", 1);
            int materialCount = Math.toIntExact(materialMapper.selectCount(materialWrapper));
            scmStats.put("materials", materialCount);
            
            QueryWrapper<Supplier> supplierWrapper = new QueryWrapper<>();
            supplierWrapper.eq("status", 1);
            int supplierCount = Math.toIntExact(supplierMapper.selectCount(supplierWrapper));
            scmStats.put("suppliers", supplierCount);
            
            // 系统管理模块统计
            Map<String, Object> sysStats = new HashMap<>();
            sysStats.put("users", totalUsers);
            sysStats.put("roles", 5); // 固定角色数量
            
            // 总体统计
            stats.put("totalUsers", totalUsers);
            stats.put("totalCompounds", compoundCount);
            stats.put("totalBatches", batchCount);
            stats.put("totalSuppliers", supplierCount);
            
            // 模块统计
            stats.put("rd", rdStats);
            stats.put("prod", prodStats);
            stats.put("scm", scmStats);
            stats.put("sys", sysStats);
            
            // 角色分布
            Map<String, Object> roleDistribution = new HashMap<>();
            roleDistribution.put("admin", adminUsers);
            roleDistribution.put("researcher", researcherUsers);
            roleDistribution.put("labTechnician", labTechnicianUsers);
            roleDistribution.put("approver", approverUsers);
            roleDistribution.put("supervisor", supervisorUsers);
            stats.put("roleDistribution", roleDistribution);
            
            return ResponseResult.success(stats);
        } catch (Exception e) {
            return ResponseResult.error(500, "获取统计数据失败: " + e.getMessage());
        }
    }
} 