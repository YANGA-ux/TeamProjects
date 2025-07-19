package com.hwadee.backend.controller;

import com.hwadee.backend.entity.Drug;
import com.hwadee.backend.service.DrugService;
import com.hwadee.backend.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/drugs")
@CrossOrigin(origins = "*")
public class DrugController {

    @Autowired
    private DrugService drugService;

    @GetMapping
    public ResponseResult<List<Drug>> getAllDrugs() {
        List<Drug> drugs = drugService.getAllDrugs();
        return ResponseResult.success(drugs);
    }

    @GetMapping("/{id}")
    public ResponseResult<Drug> getDrugById(@PathVariable Integer id) {
        Drug drug = drugService.getDrugById(id);
        return ResponseResult.success(drug);
    }

    @GetMapping("/category/{category}")
    public ResponseResult<List<Drug>> getDrugsByCategory(@PathVariable String category) {
        List<Drug> drugs = drugService.getDrugsByCategory(category);
        return ResponseResult.success(drugs);
    }

    @GetMapping("/search")
    public ResponseResult<List<Drug>> searchDrugs(@RequestParam String keyword) {
        List<Drug> drugs = drugService.searchDrugs(keyword);
        return ResponseResult.success(drugs);
    }

    @GetMapping("/hot")
    public ResponseResult<List<Drug>> getHotDrugs() {
        List<Drug> drugs = drugService.getHotDrugs();
        return ResponseResult.success(drugs);
    }
} 