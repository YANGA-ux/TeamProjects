package com.hwadee.backend.service.impl;

import com.hwadee.backend.service.CaptchaService;
import com.hwadee.backend.util.CaptchaUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class CaptchaServiceImpl implements CaptchaService {

    private static final Logger logger = LoggerFactory.getLogger(CaptchaServiceImpl.class);
    private final Map<String, String> captchaCache = new ConcurrentHashMap<>();

    @Override
    public String generateCaptcha(String key) {
        if (key == null || key.isEmpty()) {
            throw new IllegalArgumentException("验证码key不能为空");
        }

        String captcha = CaptchaUtil.generateRandomText();
        captchaCache.put(key, captcha);
        logger.info("生成验证码: key={}, code={}", key, captcha);
        return captcha;
    }

    @Override
    public boolean validateCaptcha(String key, String code) {
        // 双重检查key和code
        if (key == null || key.isEmpty()) {
            logger.warn("验证码key为空");
            return false;
        }

        if (code == null || code.isEmpty()) {
            logger.warn("验证码内容为空");
            return false;
        }

        String storedCode = captchaCache.get(key);
        if (storedCode == null) {
            logger.warn("验证码不存在或已过期: key={}", key);
            return false;
        }

        boolean valid = storedCode.equalsIgnoreCase(code);
        if (valid) {
            captchaCache.remove(key);
            logger.info("验证码验证成功: key={}", key);
        } else {
            logger.warn("验证码不匹配: key={}, 输入={}, 存储={}", key, code, storedCode);
        }
        return valid;
    }

    @Override
    public void removeCaptcha(String key) {
        if (key != null) {
            captchaCache.remove(key);
            logger.info("移除验证码: key={}", key);
        }
    }
}