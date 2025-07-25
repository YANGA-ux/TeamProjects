/*
 Navicat Premium Dump SQL

 Source Server         : mysql_docker
 Source Server Type    : MySQL
 Source Server Version : 90300 (9.3.0)
 Source Host           : localhost:3307
 Source Schema         : bio

 Target Server Type    : MySQL
 Target Server Version : 90300 (9.3.0)
 File Encoding         : 65001

 Date: 25/07/2025 15:59:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for prod_batch
-- ----------------------------
DROP TABLE IF EXISTS `prod_batch`;
CREATE TABLE `prod_batch`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `batch_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '批次编号',
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编号',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `batch_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PLANNING' COMMENT '批次状态',
  `planned_quantity` decimal(15, 4) NULL DEFAULT NULL COMMENT '计划生产数量',
  `actual_quantity` decimal(15, 4) NULL DEFAULT NULL COMMENT '实际生产数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `planned_start_time` datetime NULL DEFAULT NULL COMMENT '计划开始时间',
  `planned_end_time` datetime NULL DEFAULT NULL COMMENT '计划结束时间',
  `actual_start_time` datetime NULL DEFAULT NULL COMMENT '实际开始时间',
  `actual_end_time` datetime NULL DEFAULT NULL COMMENT '实际结束时间',
  `production_line` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产线',
  `equipment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产设备',
  `process_parameters` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quality_parameters` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deviation_records` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `status` int NULL DEFAULT 1 COMMENT '数据状态：0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `batch_code`(`batch_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '批次表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prod_batch
-- ----------------------------
INSERT INTO `prod_batch` VALUES (7, 'B202401004', 'P004', '维生素C片', 'REJECTED', 20000.0000, 0.0000, '瓶', '2024-01-18 08:00:00', '2024-01-25 18:00:00', NULL, NULL, '1C', '设备D', NULL, NULL, NULL, NULL, '四批生产', 1, '2025-07-20 13:09:15', '2025-07-24 12:01:14', '赵六', NULL);
INSERT INTO `prod_batch` VALUES (8, '6', '6', '6', '', 6.0000, 6.0000, '6', NULL, NULL, NULL, NULL, '6', '6', '6', '6', '6', '6', '6', 1, '2025-07-22 12:59:48', '2025-07-22 12:59:48', '', '');
INSERT INTO `prod_batch` VALUES (9, '666666', '8888', '8888', '', 8888.0000, 8888.0000, '88888', NULL, NULL, NULL, NULL, '8888', '888', '88', '88', '8', '88', '', 1, '2025-07-22 13:01:58', '2025-07-22 13:01:58', '', '');
INSERT INTO `prod_batch` VALUES (13, '#123', '@131', '中药材', '1', 16.0000, 17.0000, '新疆科技学院', NULL, NULL, NULL, NULL, 'hwadee', '#66', '%3.2', '1.003', '1.002', '无', '无', 1, '2025-07-23 08:40:10', '2025-07-23 08:40:10', '', '');

-- ----------------------------
-- Table structure for qa_quality_standard
-- ----------------------------
DROP TABLE IF EXISTS `qa_quality_standard`;
CREATE TABLE `qa_quality_standard`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `standard_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标准编号',
  `standard_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标准名称',
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编号',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `standard_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标准类型',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版本号',
  `standard_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'DRAFT' COMMENT '标准状态',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '标准描述',
  `test_items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检验项目',
  `acceptance_criteria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '验收标准',
  `test_methods` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检验方法',
  `sampling_plan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '取样方案',
  `frequency` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检验频率',
  `effective_date` date NULL DEFAULT NULL COMMENT '生效日期',
  `expiry_date` date NULL DEFAULT NULL COMMENT '失效日期',
  `approval_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '批准人',
  `approval_date` datetime NULL DEFAULT NULL COMMENT '批准日期',
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '附件路径',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `standard_code`(`standard_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '质量标准表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qa_quality_standard
-- ----------------------------
INSERT INTO `qa_quality_standard` VALUES (4, 'QS004', '准质量标', 'P004', '维生素C片', '药品质量标准', '1.2', 'DRAFT', '维生素C片的质量标准', NULL, '的武器低洼瞧得起我', '带我去带我去带我去单位', NULL, '每批', '2024-01-01', '2026-12-31', '质量总监', '2024-01-04 10:00:00', NULL, NULL, 'draft', '2025-07-20 13:09:34', '2025-07-20 13:09:34', '质量部', NULL);
INSERT INTO `qa_quality_standard` VALUES (7, 'QS003', '感冒灵颗粒质量标准', 'P003', '感冒灵颗粒', '药品质量标准', '1.0', 'ACTIVE', '感冒灵颗粒的质量标准', NULL, NULL, NULL, NULL, '每批', '2024-01-01', '2026-12-31', '质量总监', '2024-01-03 10:00:00', NULL, NULL, '1', '2025-07-20 13:09:34', '2025-07-24 07:32:45', '质量部', NULL);
INSERT INTO `qa_quality_standard` VALUES (9, '12', '单位', '', '', '', '1.3', '', '单位', '', '单位', '单位', '', '', '2025-06-30', '2025-07-22', '', NULL, '', '', 'inactive', '2025-07-21 11:10:27', '2025-07-21 11:10:27', '', '');
INSERT INTO `qa_quality_standard` VALUES (10, '1', '1', '', '', '', '1', '', '1', '', '1', '1', '', '', '2025-07-06', '2025-07-29', '', NULL, '', '', 'draft', '2025-07-22 12:32:14', '2025-07-22 12:32:14', '', '');
INSERT INTO `qa_quality_standard` VALUES (11, '22', '2', '', '', '', '2', '', '22', '', '2', '22', '', '', '2025-07-13', '2025-07-28', '', NULL, '', '', 'active', '2025-07-22 12:32:54', '2025-07-22 12:32:54', '', '');

-- ----------------------------
-- Table structure for rd_compound
-- ----------------------------
DROP TABLE IF EXISTS `rd_compound`;
CREATE TABLE `rd_compound`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `compound_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '化合物编号',
  `compound_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '化合物名称',
  `chemical_formula` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '化学分子式',
  `molecular_structure` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '分子结构（SMILES格式）',
  `molecular_weight` decimal(10, 4) NULL DEFAULT NULL COMMENT '分子量',
  `cas_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'CAS号',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '化合物类别',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  `physical_properties` json NULL COMMENT '物理性质',
  `chemical_properties` json NULL COMMENT '化学性质',
  `toxicity` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '毒性信息',
  `storage_conditions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '储存条件',
  `safety_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '安全注意事项',
  `attachments` json NULL COMMENT '附件路径',
  `status` int NULL DEFAULT 1 COMMENT '数据状态：0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `compound_code`(`compound_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '化合物表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rd_compound
-- ----------------------------
INSERT INTO `rd_compound` VALUES (1, 'CMP001', '阿司匹林', 'C9H8O4', NULL, 180.1574, '50-78-2', '非甾体抗炎药', '经典的解热镇痛药物', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-07-20 06:28:07', '2025-07-22 12:15:26', 'admin', 'admin');
INSERT INTO `rd_compound` VALUES (2, 'CMP002', '布洛芬', 'C13H18O2', NULL, 206.2858, '15687-27-1', '解热镇痛药', '常用的消炎止痛药物', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-07-20 06:28:07', '2025-07-22 12:15:27', 'admin', 'admin');
INSERT INTO `rd_compound` VALUES (3, 'CMP003', '对乙酰氨基酚', 'C8H9NO2', NULL, 151.1626, '103-90-2', '解热镇痛药', '安全有效的退烧药物', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-07-20 06:28:07', '2025-07-22 12:15:27', 'admin', 'admin');
INSERT INTO `rd_compound` VALUES (4, '1', '1', '1', NULL, 1.0000, '1', '解热镇痛药', '1', NULL, NULL, NULL, NULL, NULL, NULL, 0, '2025-07-22 20:08:43', '2025-07-22 20:12:06', 'admin', 'admin');
INSERT INTO `rd_compound` VALUES (5, '666', '6666', '666', NULL, 6.0000, '333', '非甾体抗炎药', '333', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-07-22 20:43:30', '2025-07-22 20:43:30', 'admin', NULL);

-- ----------------------------
-- Table structure for rd_experiment
-- ----------------------------
DROP TABLE IF EXISTS `rd_experiment`;
CREATE TABLE `rd_experiment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `experiment_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实验编号',
  `experiment_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实验名称',
  `experiment_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '实验类型',
  `experiment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PLANNING' COMMENT '实验状态',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实验描述',
  `objective` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实验目标',
  `methodology` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实验方法',
  `planned_start_time` datetime NULL DEFAULT NULL COMMENT '计划开始时间',
  `planned_end_time` datetime NULL DEFAULT NULL COMMENT '计划结束时间',
  `actual_start_time` datetime NULL DEFAULT NULL COMMENT '实际开始时间',
  `actual_end_time` datetime NULL DEFAULT NULL COMMENT '实际结束时间',
  `project_id` bigint NULL DEFAULT NULL COMMENT '关联项目ID',
  `responsible_user_id` bigint NULL DEFAULT NULL COMMENT '负责人ID',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实验结果',
  `conclusion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '实验结论',
  `attachments` json NULL COMMENT '附件路径',
  `status` int NULL DEFAULT 1 COMMENT '数据状态：0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `experiment_code`(`experiment_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '实验表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rd_experiment
-- ----------------------------
INSERT INTO `rd_experiment` VALUES (3, 'EXP003', '对乙酰氨基酚纯度检测', '个吼吼吼吼吼吼', 'PLANNING', '对乙酰氨基酚的纯度分析', '检测对乙酰氨基酚的纯度', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-07-20 06:28:14', '2025-07-20 06:28:14', 'admin', NULL);
INSERT INTO `rd_experiment` VALUES (4, '123', '123', '213', '213', '123', '123', '123', '2025-07-14 16:00:00', '2025-07-22 16:00:00', '2025-07-22 16:00:00', '2025-07-24 16:00:00', 2, 1, '123', '123', '123', 1, '2025-07-13 16:00:00', '2025-07-23 16:00:00', '123', '123');
INSERT INTO `rd_experiment` VALUES (5, '1112', '333', '444', '44', '123', '123', '123', '2025-06-30 16:00:00', '2025-07-15 16:00:00', '2025-07-24 16:00:00', '2025-07-30 16:00:00', 1, 2, '123', '123', '123', 1, '2025-06-30 16:00:00', '2025-07-01 16:00:00', '12', '123');

-- ----------------------------
-- Table structure for rd_literature
-- ----------------------------
DROP TABLE IF EXISTS `rd_literature`;
CREATE TABLE `rd_literature`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `literature_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文献编号',
  `title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文献标题',
  `authors` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '作者',
  `journal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '期刊名称',
  `doi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'DOI号',
  `issn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ISSN号',
  `publish_date` date NULL DEFAULT NULL COMMENT '发布日期',
  `abstract_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '摘要',
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '关键词',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文献分类',
  `tags` json NULL COMMENT '标签',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件路径',
  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件类型',
  `file_size` bigint NULL DEFAULT NULL COMMENT '文件大小（字节）',
  `citation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '引用格式',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `read_count` int NULL DEFAULT 0 COMMENT '阅读次数',
  `download_count` int NULL DEFAULT 0 COMMENT '下载次数',
  `status` int NULL DEFAULT 1 COMMENT '数据状态：0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `literature_code`(`literature_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文献表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rd_literature
-- ----------------------------
INSERT INTO `rd_literature` VALUES (1, 'LIT001', '999', '作者1,作者2', '999', '10.1234/abcd.2025', '1234-5678', '2025-01-01', '这是第一条文献的摘要内容。', '关键词1,关键词2', '分类1', '[\"标签1\", \"标签2\"]', '/path/to/file1.pdf', 'PDF', 102400, '引用格式1', '备注1', 0, 0, 1, '2025-07-22 10:00:00', '2025-07-22 10:00:00', '创建人1', '更新人1');
INSERT INTO `rd_literature` VALUES (2, 'LIT002', '231', '作者3,作者4', '期刊名称2', '10.5678/efgh.2025', '9012-3456', '2025-02-01', '这是第二条文献的摘要内容。', '关键词3,关键词4', '分类2', '[\"标签3\", \"标签4\"]', '/path/to/file2.pdf', 'PDF', 204800, '引用格式2', '备注2', 0, 0, 1, '2025-07-22 11:00:00', '2025-07-22 11:00:00', '创建人2', '更新人2');
INSERT INTO `rd_literature` VALUES (3, '1', '1', '1', '1', '1', '1', '2025-07-12', '1', '1', '1', '1', '1', '1', 1, '1', '1', 1, 1, 1, '2025-07-22 11:56:14', '2025-07-22 11:56:14', NULL, NULL);

-- ----------------------------
-- Table structure for scm_material
-- ----------------------------
DROP TABLE IF EXISTS `scm_material`;
CREATE TABLE `scm_material`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `material_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物料编号',
  `material_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物料名称',
  `material_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料类型',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料分类',
  `specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规格',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `unit_price` decimal(15, 4) NULL DEFAULT NULL COMMENT '单价',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货币',
  `storage_conditions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '储存条件',
  `shelf_life` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '保质期',
  `manufacturer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `supplier_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商编号',
  `quality_standard` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '质量标准',
  `safety_data` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `min_stock` decimal(15, 4) NULL DEFAULT NULL COMMENT '最小库存',
  `max_stock` decimal(15, 4) NULL DEFAULT NULL COMMENT '最大库存',
  `current_stock` decimal(15, 4) NULL DEFAULT 0.0000 COMMENT '当前库存',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '库位',
  `material_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE' COMMENT '物料状态',
  `attachments` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据状态: 0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `material_code`(`material_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '物料表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scm_material
-- ----------------------------
INSERT INTO `scm_material` VALUES (1, 'MAT001', '阿司匹林原料', '原料药', 'API', '99.5%纯度', 'kg', 150.0000, 'CNY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100.0000, NULL, 'ACTIVE', NULL, NULL, '1', '2025-07-20 06:28:14', '2025-07-20 06:28:14', 'admin', NULL);
INSERT INTO `scm_material` VALUES (2, 'MAT002', '布洛芬原料', '原料药', 'API', '99.8%纯度', 'kg', 200.0000, 'CNY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 80.0000, NULL, 'ACTIVE', NULL, NULL, '1', '2025-07-20 06:28:14', '2025-07-20 06:28:14', 'admin', NULL);
INSERT INTO `scm_material` VALUES (6, '666', '666', '666', '666', '666', '666', 656.0000, '666', NULL, NULL, NULL, NULL, NULL, NULL, 66.0000, 66.0000, 666.0000, '6', 'ACTIVE', NULL, '666', '1', '2025-07-22 12:41:20', '2025-07-22 12:41:20', NULL, NULL);
INSERT INTO `scm_material` VALUES (7, '郝红梅', '郝红梅', '3wqq', '一级', '100', '100', 10.0000, 'yuan', NULL, NULL, NULL, NULL, NULL, NULL, 8.0000, 10.0000, 9.0000, '八', 'ACTIVE', NULL, '无', '1', '2025-07-24 12:43:03', '2025-07-24 12:43:03', NULL, NULL);

-- ----------------------------
-- Table structure for scm_supplier
-- ----------------------------
DROP TABLE IF EXISTS `scm_supplier`;
CREATE TABLE `scm_supplier`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商编号',
  `supplier_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商名称',
  `supplier_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商类型',
  `contact_person` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '地址',
  `business_license` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '营业执照号',
  `tax_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '税号',
  `qualification` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `supplier_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE' COMMENT '供应商状态',
  `risk_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '风险等级',
  `performance_rating` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '绩效评级',
  `qualification_expiry_date` date NULL DEFAULT NULL COMMENT '资质到期日期',
  `audit_history` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachments` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据状态: 0-删除 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `supplier_code`(`supplier_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供应商表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scm_supplier
-- ----------------------------
INSERT INTO `scm_supplier` VALUES (1, '1', '1', '1', '1', '1', '112@111.com', 'xxxxx', NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-07-22 12:22:19', '2025-07-24 07:32:24', NULL, NULL);
INSERT INTO `scm_supplier` VALUES (7, '6', '6', '6', '6', '6', '6', 'xxxxx', NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, '8', '1', '2025-07-22 12:37:12', '2025-07-24 07:32:15', NULL, NULL);

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `operation_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作类型',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模块名称',
  `function_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作描述',
  `user_id` bigint NULL DEFAULT NULL COMMENT '操作用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户名',
  `user_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户IP地址',
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '用户代理',
  `request_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求URL',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方法',
  `request_params` json NULL COMMENT '请求参数',
  `response_result` json NULL COMMENT '响应结果',
  `status` int NULL DEFAULT NULL COMMENT '操作状态：0-失败 1-成功',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '错误信息',
  `execution_time` bigint NULL DEFAULT NULL COMMENT '执行时间（毫秒）',
  `operation_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `target_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标表名',
  `target_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目标记录ID',
  `before_data` json NULL COMMENT '操作前数据',
  `after_data` json NULL COMMENT '操作后数据',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `permission_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限编码',
  `permission_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限类型：MENU-菜单 BUTTON-按钮 API-接口',
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资源路径或标识',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '权限描述',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父权限ID',
  `status` int NULL DEFAULT 1 COMMENT '状态：0-禁用 1-启用',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permission_code`(`permission_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '用户管理', 'USER_MANAGE', 'MENU', '/user', '用户管理菜单', NULL, 1, 1, '2025-07-19 02:15:34', '2025-07-19 02:15:34', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (2, '用户查看', 'USER_VIEW', 'BUTTON', 'user:view', '查看用户信息', 1, 1, 1, '2025-07-19 02:15:34', '2025-07-19 02:15:34', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (3, '用户创建', 'USER_CREATE', 'BUTTON', 'user:create', '创建用户', 1, 1, 2, '2025-07-19 02:15:34', '2025-07-19 02:15:34', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (4, '用户编辑', 'USER_EDIT', 'BUTTON', 'user:edit', '编辑用户信息', 1, 1, 3, '2025-07-19 02:15:34', '2025-07-19 02:15:34', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (5, '用户删除', 'USER_DELETE', 'BUTTON', 'user:delete', '删除用户', 1, 1, 4, '2025-07-19 02:15:34', '2025-07-19 02:15:34', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (6, '角色管理', 'ROLE_MANAGE', 'MENU', '/role', '角色管理菜单', NULL, 1, 2, '2025-07-19 02:17:32', '2025-07-19 02:17:32', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (7, '角色查看', 'ROLE_VIEW', 'BUTTON', 'role:view', '查看角色信息', 6, 1, 1, '2025-07-19 02:17:32', '2025-07-19 02:17:32', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (8, '角色创建', 'ROLE_CREATE', 'BUTTON', 'role:create', '创建角色', 6, 1, 2, '2025-07-19 02:17:32', '2025-07-19 02:17:32', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (9, '角色编辑', 'ROLE_EDIT', 'BUTTON', 'role:edit', '编辑角色信息', 6, 1, 3, '2025-07-19 02:17:32', '2025-07-19 02:17:32', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (10, '角色删除', 'ROLE_DELETE', 'BUTTON', 'role:delete', '删除角色', 6, 1, 4, '2025-07-19 02:17:32', '2025-07-19 02:17:32', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (16, '实验管理', 'EXPERIMENT_MANAGE', 'MENU', '/experiment', '实验管理菜单', NULL, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (17, '实验查看', 'EXPERIMENT_VIEW', 'BUTTON', 'experiment:view', '查看实验信息', 11, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (18, '实验创建', 'EXPERIMENT_CREATE', 'BUTTON', 'experiment:create', '创建实验', 11, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (19, '实验编辑', 'EXPERIMENT_EDIT', 'BUTTON', 'experiment:edit', '编辑实验信息', 11, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (20, '实验删除', 'EXPERIMENT_DELETE', 'BUTTON', 'experiment:delete', '删除实验', 11, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (21, '化合物管理', 'COMPOUND_MANAGE', 'MENU', '/compound', '化合物管理菜单', NULL, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (22, '化合物查看', 'COMPOUND_VIEW', 'BUTTON', 'compound:view', '查看化合物信息', 16, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (23, '化合物创建', 'COMPOUND_CREATE', 'BUTTON', 'compound:create', '创建化合物', 16, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (24, '化合物编辑', 'COMPOUND_EDIT', 'BUTTON', 'compound:edit', '编辑化合物信息', 16, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (25, '化合物删除', 'COMPOUND_DELETE', 'BUTTON', 'compound:delete', '删除化合物', 16, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (26, '文献管理', 'LITERATURE_MANAGE', 'MENU', '/literature', '文献管理菜单', NULL, 1, 5, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (27, '文献查看', 'LITERATURE_VIEW', 'BUTTON', 'literature:view', '查看文献信息', 21, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (28, '文献创建', 'LITERATURE_CREATE', 'BUTTON', 'literature:create', '创建文献', 21, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (29, '文献编辑', 'LITERATURE_EDIT', 'BUTTON', 'literature:edit', '编辑文献信息', 21, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (30, '文献删除', 'LITERATURE_DELETE', 'BUTTON', 'literature:delete', '删除文献', 21, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (31, '批次管理', 'BATCH_MANAGE', 'MENU', '/batch', '批次管理菜单', NULL, 1, 6, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (32, '批次查看', 'BATCH_VIEW', 'BUTTON', 'batch:view', '查看批次信息', 26, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (33, '批次创建', 'BATCH_CREATE', 'BUTTON', 'batch:create', '创建批次', 26, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (34, '批次编辑', 'BATCH_EDIT', 'BUTTON', 'batch:edit', '编辑批次信息', 26, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (35, '批次删除', 'BATCH_DELETE', 'BUTTON', 'batch:delete', '删除批次', 26, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (36, '质量标准管理', 'QUALITY_STANDARD_MANAGE', 'MENU', '/quality-standard', '质量标准管理菜单', NULL, 1, 7, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (37, '质量标准查看', 'QUALITY_STANDARD_VIEW', 'BUTTON', 'quality-standard:view', '查看质量标准信息', 31, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (38, '质量标准创建', 'QUALITY_STANDARD_CREATE', 'BUTTON', 'quality-standard:create', '创建质量标准', 31, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (39, '质量标准编辑', 'QUALITY_STANDARD_EDIT', 'BUTTON', 'quality-standard:edit', '编辑质量标准信息', 31, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (40, '质量标准删除', 'QUALITY_STANDARD_DELETE', 'BUTTON', 'quality-standard:delete', '删除质量标准', 31, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (41, '供应商管理', 'SUPPLIER_MANAGE', 'MENU', '/supplier', '供应商管理菜单', NULL, 1, 8, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (42, '供应商查看', 'SUPPLIER_VIEW', 'BUTTON', 'supplier:view', '查看供应商信息', 36, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (43, '供应商创建', 'SUPPLIER_CREATE', 'BUTTON', 'supplier:create', '创建供应商', 36, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (44, '供应商编辑', 'SUPPLIER_EDIT', 'BUTTON', 'supplier:edit', '编辑供应商信息', 36, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (45, '供应商删除', 'SUPPLIER_DELETE', 'BUTTON', 'supplier:delete', '删除供应商', 36, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (46, '物料管理', 'MATERIAL_MANAGE', 'MENU', '/material', '物料管理菜单', NULL, 1, 9, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (47, '物料查看', 'MATERIAL_VIEW', 'BUTTON', 'material:view', '查看物料信息', 41, 1, 1, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (48, '物料创建', 'MATERIAL_CREATE', 'BUTTON', 'material:create', '创建物料', 41, 1, 2, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (49, '物料编辑', 'MATERIAL_EDIT', 'BUTTON', 'material:edit', '编辑物料信息', 41, 1, 3, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);
INSERT INTO `sys_permission` VALUES (50, '物料删除', 'MATERIAL_DELETE', 'BUTTON', 'material:delete', '删除物料', 41, 1, 4, '2025-07-19 02:18:15', '2025-07-19 02:18:15', 'SYSTEM', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色编码',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '角色描述',
  `status` int NULL DEFAULT 1 COMMENT '状态：0-禁用 1-启用',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_code`(`role_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', 'ADMIN', '系统管理员，拥有所有权限', 1, 1, '2025-07-19 01:59:24', '2025-07-19 01:59:24', 'SYSTEM', NULL);
INSERT INTO `sys_role` VALUES (2, '研究员', 'RESEARCHER', '研究员，负责实验设计和数据分析', 1, 2, '2025-07-19 01:59:24', '2025-07-19 01:59:24', 'SYSTEM', NULL);
INSERT INTO `sys_role` VALUES (3, '实验员', 'LAB_TECHNICIAN', '实验员，负责实验操作和数据采集', 1, 3, '2025-07-19 01:59:24', '2025-07-19 01:59:24', 'SYSTEM', NULL);
INSERT INTO `sys_role` VALUES (4, '审批员', 'APPROVER', '审批员，负责流程审批', 1, 4, '2025-07-19 01:59:24', '2025-07-19 01:59:24', 'SYSTEM', NULL);
INSERT INTO `sys_role` VALUES (5, '监管人员', 'SUPERVISOR', '监管人员，负责质量监管', 1, 5, '2025-07-19 01:59:24', '2025-07-19 01:59:24', 'SYSTEM', NULL);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `permission_id` bigint NOT NULL COMMENT '权限ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_role_permission`(`role_id` ASC, `permission_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1, 1, 33, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (2, 1, 35, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (3, 1, 34, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (4, 1, 31, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (5, 1, 32, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (6, 1, 23, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (7, 1, 25, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (8, 1, 24, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (9, 1, 21, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (10, 1, 22, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (11, 1, 18, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (12, 1, 20, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (13, 1, 19, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (14, 1, 16, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (15, 1, 17, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (16, 1, 28, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (17, 1, 30, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (18, 1, 29, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (19, 1, 26, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (20, 1, 27, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (21, 1, 48, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (22, 1, 50, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (23, 1, 49, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (24, 1, 46, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (25, 1, 47, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (26, 1, 38, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (27, 1, 40, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (28, 1, 39, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (29, 1, 36, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (30, 1, 37, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (31, 1, 8, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (32, 1, 10, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (33, 1, 9, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (34, 1, 6, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (35, 1, 7, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (36, 1, 43, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (37, 1, 45, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (38, 1, 44, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (39, 1, 41, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (40, 1, 42, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (41, 1, 3, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (42, 1, 5, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (43, 1, 4, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (44, 1, 1, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (45, 1, 2, '2025-07-19 02:18:30', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (64, 2, 23, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (65, 2, 24, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (66, 2, 22, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (67, 2, 18, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (68, 2, 19, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (69, 2, 17, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (70, 2, 28, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (71, 2, 29, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (72, 2, 27, '2025-07-19 02:18:34', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (79, 3, 22, '2025-07-19 02:18:37', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (80, 3, 19, '2025-07-19 02:18:37', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (81, 3, 17, '2025-07-19 02:18:37', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (82, 3, 27, '2025-07-19 02:18:37', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (86, 4, 34, '2025-07-19 02:18:41', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (87, 4, 32, '2025-07-19 02:18:41', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (88, 4, 39, '2025-07-19 02:18:41', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (89, 4, 37, '2025-07-19 02:18:41', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (93, 5, 32, '2025-07-19 02:18:44', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (94, 5, 47, '2025-07-19 02:18:44', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (95, 5, 37, '2025-07-19 02:18:44', 'SYSTEM');
INSERT INTO `sys_role_permission` VALUES (96, 5, 42, '2025-07-19 02:18:44', 'SYSTEM');

-- ----------------------------
-- Table structure for sys_system_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_system_log`;
CREATE TABLE `sys_system_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `log_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志级别',
  `log_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志类型',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模块名称',
  `function_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能名称',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '日志消息',
  `stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '堆栈跟踪',
  `exception_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '异常类型',
  `exception_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '异常消息',
  `server_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务器IP',
  `server_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务器名称',
  `thread_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '线程名称',
  `execution_time` bigint NULL DEFAULT NULL COMMENT '执行时间（毫秒）',
  `memory_usage` json NULL COMMENT '内存使用情况',
  `cpu_usage` json NULL COMMENT 'CPU使用情况',
  `disk_usage` json NULL COMMENT '磁盘使用情况',
  `network_status` json NULL COMMENT '网络状态',
  `log_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日志时间',
  `context` json NULL COMMENT '上下文信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_system_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `real_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1213018115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '1', '李向东', 'ADMIN', 'ACTIVE', '2025-07-19 02:18:48', '2025-07-24 11:33:20');
INSERT INTO `sys_user` VALUES (760082434, 'LXD', '111', '123', 'user', 'RESEARCHER', '2025-07-19 03:07:41', '2025-07-24 11:22:32');
INSERT INTO `sys_user` VALUES (1213018114, 'yang', '123', '杨永海', 'user', '1', '2025-07-19 06:01:08', '2025-07-19 06:01:08');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_role`(`user_id` ASC, `role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2025-07-19 02:18:51', 'SYSTEM');

-- ----------------------------
-- Table structure for test_table
-- ----------------------------
DROP TABLE IF EXISTS `test_table`;
CREATE TABLE `test_table`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_table
-- ----------------------------
INSERT INTO `test_table` VALUES (1, 'test');

SET FOREIGN_KEY_CHECKS = 1;
