-- 添加测试数据

-- 添加化合物测试数据
INSERT INTO rd_compound (compound_code, compound_name, chemical_formula, molecular_weight, cas_number, category, description, status, create_by) VALUES
('CMP001', '阿司匹林', 'C9H8O4', 180.1574, '50-78-2', '非甾体抗炎药', '经典的解热镇痛药物', 1, 'admin'),
('CMP002', '布洛芬', 'C13H18O2', 206.2858, '15687-27-1', '非甾体抗炎药', '常用的消炎止痛药物', 1, 'admin'),
('CMP003', '对乙酰氨基酚', 'C8H9NO2', 151.1626, '103-90-2', '解热镇痛药', '安全有效的退烧药物', 1, 'admin');

-- 添加实验测试数据
INSERT INTO rd_experiment (experiment_code, experiment_name, experiment_type, experiment_status, description, objective, status, create_by) VALUES
('EXP001', '阿司匹林合成实验', '合成实验', 'COMPLETED', '阿司匹林的实验室合成', '验证阿司匹林合成工艺', 1, 'admin'),
('EXP002', '布洛芬稳定性测试', '稳定性实验', 'IN_PROGRESS', '布洛芬在不同条件下的稳定性', '评估布洛芬的储存稳定性', 1, 'admin'),
('EXP003', '对乙酰氨基酚纯度检测', '分析实验', 'PLANNING', '对乙酰氨基酚的纯度分析', '检测对乙酰氨基酚的纯度', 1, 'admin');

-- 添加批次测试数据
INSERT INTO prod_batch (batch_code, product_code, product_name, batch_status, planned_quantity, unit, status, create_by) VALUES
('BAT001', 'PROD001', '阿司匹林片剂', 'IN_PROGRESS', 1000.0000, '片', 1, 'admin'),
('BAT002', 'PROD002', '布洛芬胶囊', 'COMPLETED', 500.0000, '粒', 1, 'admin'),
('BAT003', 'PROD003', '对乙酰氨基酚片', 'PLANNING', 2000.0000, '片', 1, 'admin');

-- 添加物料测试数据
INSERT INTO scm_material (material_code, material_name, material_type, category, specification, unit, unit_price, currency, current_stock, material_status, status, create_by) VALUES
('MAT001', '阿司匹林原料', '原料药', 'API', '99.5%纯度', 'kg', 150.0000, 'CNY', 100.0000, 'ACTIVE', 1, 'admin'),
('MAT002', '布洛芬原料', '原料药', 'API', '99.8%纯度', 'kg', 200.0000, 'CNY', 80.0000, 'ACTIVE', 1, 'admin'),
('MAT003', '对乙酰氨基酚原料', '原料药', 'API', '99.9%纯度', 'kg', 120.0000, 'CNY', 150.0000, 'ACTIVE', 1, 'admin');

-- 添加供应商测试数据
INSERT INTO scm_supplier (supplier_code, supplier_name, supplier_type, contact_person, contact_phone, contact_email, address, supplier_status, status, create_by) VALUES
('SUP001', '华药集团', '原料供应商', '张三', '13800138001', 'zhangsan@huayao.com', '河北省石家庄市', 'ACTIVE', 1, 'admin'),
('SUP002', '恒瑞医药', '原料供应商', '李四', '13800138002', 'lisi@henrui.com', '江苏省连云港市', 'ACTIVE', 1, 'admin'),
('SUP003', '齐鲁制药', '原料供应商', '王五', '13800138003', 'wangwu@qilu.com', '山东省济南市', 'ACTIVE', 1, 'admin'); 