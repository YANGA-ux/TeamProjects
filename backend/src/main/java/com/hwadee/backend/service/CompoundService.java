package com.hwadee.backend.service;

import com.hwadee.backend.entity.Compound;
import java.util.List;

public interface CompoundService {
    List<Compound> getAllCompounds();
    Compound getCompoundById(Long id);
    Compound createCompound(Compound compound);
    Compound updateCompound(Compound compound);
    void deleteCompound(Long id);
    List<Compound> searchCompounds(String keyword);
    List<Compound> getCompoundsByCategory(String category);
} 