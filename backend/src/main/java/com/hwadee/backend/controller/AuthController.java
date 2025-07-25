package com.hwadee.backend.controller;
import com.hwadee.backend.entity.User;
import com.hwadee.backend.service.CaptchaService;
import com.hwadee.backend.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.GrantedAuthority;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserService userService;
    @Autowired
    private CaptchaService captchaService; // 注入验证码服务

    // 获取验证码接口
    @GetMapping("/captcha")
    public ResponseEntity<byte[]> getCaptcha() {
        // ...生成验证码图片...
        try {
            String captchaKey = UUID.randomUUID().toString();
            String captchaText = captchaService.generateCaptcha(captchaKey); // 生成并存储验证码

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            CaptchaUtil.generateCaptchaImage(captchaText, outputStream);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.set("Captcha-Key", captchaKey);
            headers.setAccessControlExposeHeaders(List.of("Captcha-Key")); // 关键配置

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(outputStream.toByteArray());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest loginRequest,
                                                     @RequestHeader(value = "Captcha-Key", required = false) String headerKey) {
        // 优先使用请求体中的key，如果没有则使用header中的key
        String captchaKey = loginRequest.getCaptchaKey() != null ?
                loginRequest.getCaptchaKey() : headerKey;

        if (captchaKey == null || captchaKey.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Map.of("code", 400, "message", "验证码key不能为空"));
        }

        if (!captchaService.validateCaptcha(captchaKey, loginRequest.getCaptcha())) {
            return ResponseEntity.badRequest()
                    .body(Map.of("code", 400, "message", "验证码错误或已过期"));
        }
        // 2. 原有认证逻辑
        UsernamePasswordAuthenticationToken token =
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword());

        try {
            Authentication authentication = authenticationManager.authenticate(token);
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            Map<String, Object> response = new HashMap<>();
            response.put("code", 200);
            response.put("message", "登录成功");
            response.put("username", loginRequest.getUsername());

            String role = userDetails.getAuthorities().stream()
                    .findFirst()
                    .map(GrantedAuthority::getAuthority)
                    .orElse("DEFAULT_ROLE");

            response.put("role", role);

            return ResponseEntity.ok(response);
        } catch (AuthenticationException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                    Map.of("code", 401, "message", "用户名或密码错误")
            );
        }
    }
//    @PostMapping("/login")
//    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest loginRequest) {
//        UsernamePasswordAuthenticationToken token =
//                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword());
//
//        try {
//            Authentication authentication = authenticationManager.authenticate(token);
//
//            // 获取用户详细信息（包含角色）
//            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
//
//            // 构造响应数据
//            Map<String, Object> response = new HashMap<>();
//            response.put("code", 200);
//            response.put("message", "登录成功");
//            response.put("username", loginRequest.getUsername());
//
//            // 获取用户角色（Spring Security默认会将权限放在GrantedAuthority中）
//            String role = userDetails.getAuthorities().stream()
//                    .findFirst()
//                    .map(GrantedAuthority::getAuthority)
//                    .orElse("DEFAULT_ROLE");
//
//            response.put("role", role);
//
//            return ResponseEntity.ok(response);
//        } catch (AuthenticationException e) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
//                    Map.of("code", 401, "message", "用户名或密码错误")
//            );
//        }
//    }
    // 修改密码接口
    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody ChangePasswordRequest req) {
        boolean success = userService.changePassword(req.getUsername(), req.getOldPassword(), req.getNewPassword());
        if (success) {
            return ResponseEntity.ok("修改成功");
        } else {
            return ResponseEntity.status(400).body("原密码错误或用户不存在");
        }
    }
//    注册
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest req) {
        boolean success = userService.register(req.getUsername(), req.getPassword(), req.getRealName());
        if (success) {
            return ResponseEntity.ok("注册成功");
        } else {
            return ResponseEntity.status(400).body("用户名已存在");
        }
    }
    public static class LoginRequest {
        private String username;
        private String password;
        private String captcha;      // 用户输入的验证码

        public String getCaptcha() {
            return captcha;
        }

        public void setCaptcha(String captcha) {
            this.captcha = captcha;
        }

        public String getCaptchaKey() {
            return captchaKey;
        }

        public void setCaptchaKey(String captchaKey) {
            this.captchaKey = captchaKey;
        }

        private String captchaKey;   // 验证码唯一标识
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    // 修改密码请求体
    public static class ChangePasswordRequest {
        private String username;
        private String oldPassword;
        private String newPassword;

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }

        public String getOldPassword() { return oldPassword; }
        public void setOldPassword(String oldPassword) { this.oldPassword = oldPassword; }

        public String getNewPassword() { return newPassword; }
        public void setNewPassword(String newPassword) { this.newPassword = newPassword; }
    }
//    注册请求
    public static class RegisterRequest {
        private String username;
        private String password;
        private String realName;

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public String getRealName() { return realName; }
        public void setRealName(String realName) { this.realName = realName; }
    }
    //验证码登录
    
    
}