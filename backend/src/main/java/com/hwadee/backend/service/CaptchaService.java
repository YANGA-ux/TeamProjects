package com.hwadee.backend.service;

public interface CaptchaService {
    String generateCaptcha(String key);
    boolean validateCaptcha(String key, String code);
    void removeCaptcha(String key);
}
