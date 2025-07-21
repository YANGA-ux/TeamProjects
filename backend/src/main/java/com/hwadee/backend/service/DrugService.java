package com.hwadee.backend.service;

import com.hwadee.backend.entity.Drug;
import java.util.List;

public interface DrugService {
    List<Drug> getAllDrugs();
    Drug getDrugById(Integer id);
    List<Drug> getDrugsByCategory(String category);
    List<Drug> searchDrugs(String keyword);
    List<Drug> getHotDrugs();

    List<Drug> list();
}