package com.hwadee.backend.controller;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.Random;

public class CaptchaUtil {
    private static final int WIDTH = 100;
    private static final int HEIGHT = 40;
    private static final int CODE_LENGTH = 4;
    private static final Random random = new Random();

    // 生成随机验证码文本
    public static String generateRandomText() {
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < CODE_LENGTH; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    // 生成验证码图片
    public static void generateCaptchaImage(String text, OutputStream outputStream) {
        try {
            BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();

            // 设置背景色
            g.setColor(Color.WHITE);
            g.fillRect(0, 0, WIDTH, HEIGHT);

            // 绘制干扰线
            for (int i = 0; i < 5; i++) {
                g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
                g.drawLine(random.nextInt(WIDTH), random.nextInt(HEIGHT),
                        random.nextInt(WIDTH), random.nextInt(HEIGHT));
            }

            // 绘制验证码
            g.setFont(new Font("Arial", Font.BOLD, 30));
            for (int i = 0; i < text.length(); i++) {
                g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
                g.drawString(String.valueOf(text.charAt(i)), 20 * i + 10, 30);
            }

            // 释放资源
            g.dispose();
            ImageIO.write(image, "png", outputStream);
        } catch (Exception e) {
            throw new RuntimeException("生成验证码失败", e);
        }
    }
}