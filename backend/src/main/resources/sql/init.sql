-- 生物医药系统数据库初始化脚本

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS bio DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE bio;

-- 用户表（已存在，这里只是参考）
-- CREATE TABLE sys_user (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     username VARCHAR(50) UNIQUE NOT NULL,
--     password VARCHAR(100) NOT NULL,
--     real_name VARCHAR(50),
--     role VARCHAR(20) DEFAULT 'user',
--     status VARCHAR(10) DEFAULT '1'
-- );

-- 药品表
CREATE TABLE IF NOT EXISTS drug (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '药品名称',
    generic_name VARCHAR(100) COMMENT '通用名',
    manufacturer VARCHAR(100) COMMENT '生产厂家',
    dosage_form VARCHAR(50) COMMENT '剂型',
    strength VARCHAR(50) COMMENT '规格',
    price DECIMAL(10,2) NOT NULL COMMENT '价格',
    stock INT DEFAULT 0 COMMENT '库存',
    description TEXT COMMENT '描述',
    category VARCHAR(50) COMMENT '分类',
    status VARCHAR(20) DEFAULT 'active' COMMENT '状态',
    image_url VARCHAR(255) COMMENT '图片URL',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 新闻资讯表
CREATE TABLE IF NOT EXISTS news (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '标题',
    content TEXT COMMENT '内容',
    author VARCHAR(50) COMMENT '作者',
    category VARCHAR(50) COMMENT '分类',
    image_url VARCHAR(255) COMMENT '图片URL',
    view_count INT DEFAULT 0 COMMENT '浏览次数',
    status VARCHAR(20) DEFAULT 'published' COMMENT '状态',
    publish_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 订单表
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL COMMENT '用户ID',
    drug_id INT NOT NULL COMMENT '药品ID',
    quantity INT NOT NULL COMMENT '数量',
    total_price DECIMAL(10,2) NOT NULL COMMENT '总价',
    status VARCHAR(20) DEFAULT 'pending' COMMENT '订单状态',
    shipping_address TEXT COMMENT '收货地址',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    delivery_time TIMESTAMP NULL COMMENT '配送时间',
    FOREIGN KEY (user_id) REFERENCES sys_user(id),
    FOREIGN KEY (drug_id) REFERENCES drug(id)
);

-- 插入示例药品数据
INSERT INTO drug (name, generic_name, manufacturer, dosage_form, strength, price, stock, description, category, image_url) VALUES
('阿莫西林胶囊', '阿莫西林', '华北制药股份有限公司', '胶囊', '0.25g*24粒', 15.80, 100, '用于敏感菌所致的呼吸道感染、泌尿生殖道感染等', '抗生素', '/drug1.jpg'),
('布洛芬片', '布洛芬', '中美史克制药有限公司', '片剂', '0.1g*20片', 12.50, 150, '用于缓解轻至中度疼痛，如头痛、关节痛、偏头痛等', '解热镇痛', '/drug2.jpg'),
('感冒灵颗粒', '复方感冒灵', '华润三九医药股份有限公司', '颗粒', '10g*10袋', 18.90, 80, '用于感冒引起的头痛发热、鼻塞流涕等症状', '感冒用药', '/drug3.jpg'),
('维生素C片', '维生素C', '汤臣倍健股份有限公司', '片剂', '0.1g*100片', 25.00, 200, '补充维生素C，增强免疫力', '维生素', '/drug4.jpg'),
('板蓝根颗粒', '板蓝根', '白云山制药股份有限公司', '颗粒', '10g*20袋', 16.80, 120, '清热解毒，凉血利咽，用于咽喉肿痛', '清热解毒', '/drug5.jpg'),
('藿香正气水', '藿香正气', '太极集团有限公司', '口服液', '10ml*10支', 22.50, 90, '解表化湿，理气和中，用于外感风寒、内伤湿滞', '祛暑药', '/drug6.jpg'),
('创可贴', '苯扎氯铵贴', '云南白药集团股份有限公司', '贴剂', '1.2cm*2.5cm*10片', 8.90, 300, '用于小创伤、擦伤等患处', '外用药品', '/drug7.jpg'),
('红霉素软膏', '红霉素', '哈药集团制药总厂', '软膏', '10g', 6.50, 180, '用于脓疱疮等化脓性皮肤病', '外用药品', '/drug8.jpg');

-- 插入示例新闻数据
INSERT INTO news (title, content, author, category, image_url, view_count) VALUES
('新型疫苗研发取得重大突破', '科研团队在新型疫苗研发方面取得重大突破，为疫情防控提供新的解决方案。该疫苗采用最新的mRNA技术，具有更高的安全性和有效性。', '医药科技', '疫苗研发', '/news1.jpg', 1250),
('国家药监局发布新政策', '国家药监局发布关于药品质量管理的新的政策规定，进一步保障药品安全。新政策将加强对药品生产、流通、使用全过程的监管。', '药监总局', '政策法规', '/news2.jpg', 980),
('中医药现代化发展报告', '最新发布的中医药现代化发展报告显示，中医药在疾病治疗方面发挥重要作用。报告指出，中医药现代化是未来发展的必然趋势。', '中医药协会', '中医药', '/news3.jpg', 756),
('罕见病药物研发进展', '多家制药公司宣布在罕见病药物研发方面取得重要进展，为罕见病患者带来新的治疗希望。这些药物将显著改善患者的生活质量。', '医药研发', '药物研发', '/news4.jpg', 634),
('医疗器械创新技术展示', '2024年医疗器械创新技术展示会在北京举行，展示了最新的医疗器械技术和产品，推动医疗器械行业的发展。', '医疗器械协会', '医疗器械', '/news5.jpg', 445);

-- 插入示例订单数据（需要先有用户数据）
-- INSERT INTO orders (user_id, drug_id, quantity, total_price, status, shipping_address, contact_phone) VALUES
-- (1, 1, 2, 31.60, 'completed', '北京市朝阳区xxx街道xxx号', '13800138000'),
-- (1, 3, 1, 18.90, 'pending', '北京市朝阳区xxx街道xxx号', '13800138000'); 