/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50141
Source Host           : localhost:3306
Source Database       : adminlte

Target Server Type    : MYSQL
Target Server Version : 50141
File Encoding         : 65001

Date: 2017-03-17 16:00:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactoryBean', 'billJiang1489379109578', '1489571613398', '20000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for query_config
-- ----------------------------
DROP TABLE IF EXISTS `query_config`;
CREATE TABLE `query_config` (
  `id` varchar(36) NOT NULL,
  `columnsName` longtext,
  `pageName` longtext,
  `queryId` varchar(255) DEFAULT NULL,
  `userid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of query_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_demo_generator
-- ----------------------------
DROP TABLE IF EXISTS `tbl_demo_generator`;
CREATE TABLE `tbl_demo_generator` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `isEnable` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dict_nation` tinyblob,
  `remark` longtext,
  `salary` double DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `enable` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_demo_generator
-- ----------------------------
INSERT INTO `tbl_demo_generator` VALUES ('402880ee5a3d1df3015a3d39608b0001', '2017-02-14 23:24:14', '0', '2017-02-25 10:43:09', '4', '2017-02-07 00:00:00', 'test', 'test', '402881f053cd72330153cd820b960004', '1', '\0', 'test', 0x3430323838316630353365353565373130313533653537313665373930303033, 'test', '2.3', '123@12.com', '');

-- ----------------------------
-- Table structure for tbl_dict
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dict`;
CREATE TABLE `tbl_dict` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `code` varchar(200) DEFAULT NULL,
  `levelCode` varchar(36) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `parent_id` varchar(200) DEFAULT NULL,
  `remark` longtext,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dict
-- ----------------------------
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b7113e8f0008', null, '0', '2016-06-23 10:53:13', '1', 'INTENTION', '000029000002', 'æ„�å�‘', '402881ec54b7493f0154b7545e8f0008', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b7115e8f0008', null, '0', '2016-06-23 10:57:06', '1', 'FORMAL', '000029000003', 'æ­£å¼�', '402881ec54b7493f0154b7545e8f0008', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b7135e8f0008', null, '0', '2016-06-23 10:56:34', '1', 'CONSULTING', '000029000001', 'å’¨è¯¢', '402881ec54b7493f0154b7545e8f0008', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b75082770007', null, '0', null, '0', 'PPSITION', '000028', 'è�ŒåŠ¡', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b7514e8f0008', null, '0', null, '2', 'SELL', '000028000001', 'é”€å”®', '402881ec54b7493f0154b75082770007', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ec54b7493f0154b7545e8f0008', null, '0', '2016-06-23 12:19:26', '4', 'STATES', '000029', 'é˜¶æ®µ', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701557b2f29cf0000', '2016-06-23 10:55:36', '0', '2016-06-23 10:55:36', '0', 'CLIENTLEVEL', '000080', 'å®¢æˆ·çº§åˆ«', null, null, null);
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701557b3111bc0001', '2016-06-23 10:57:41', '0', '2016-06-23 10:57:41', '0', 'CLIENTLEVEL_1', '000080000001', 'æˆ˜ç•¥å®¢æˆ·', '402881ef557b216701557b2f29cf0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701557b31931a0002', '2016-06-23 10:58:14', '0', '2016-06-23 10:58:14', '0', 'CLIENTLEVEL_3', '000080000002', 'ä¸€èˆ¬å®¢æˆ·', '402881ef557b216701557b2f29cf0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701557b31fca00003', '2016-06-23 10:58:41', '0', '2016-06-23 10:58:41', '0', 'CLIENTLEVEL_3', '000080000003', 'é‡�ç‚¹å®¢æˆ·', '402881ef557b216701557b2f29cf0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701557b45fca00003', null, '0', null, '0', 'POSITIONS', '000033', 'è�Œä½�', null, null, null);
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701565b45fca00003', null, '0', null, '0', 'MANAGER', '000033000001', 'ç»�ç�†', '402881ef557b216701557b45fca00003', null, null);
INSERT INTO `tbl_dict` VALUES ('402881ef557b216701675b45fca00003', null, '0', null, '0', 'CUSTOMER', '000033000002', 'å®¢æœ�', '402881ef557b216701557b45fca00003', null, null);
INSERT INTO `tbl_dict` VALUES ('402881f053b726080153b72893a60000', null, '0', '2016-08-24 20:54:20', '5', 'ACCOUNTCHECKTYPE', '000011', 'å¯¹è´¦ç±»åž‹', '', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053b726080153b7294a1d0001', null, '0', '2016-06-23 10:42:59', '4', 'MONTH_CHECK', '000011000001', 'æœˆç»“', '402881f053b726080153b72893a60000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053b726080153b72986f80002', null, '0', '2016-06-23 10:31:30', '3', 'HQ_CHECK', '000011000002', 'ç¥¨åˆ°', '402881f053b726080153b72893a60000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053b726080153b74586f80002', null, '0', '2016-06-23 10:42:48', '4', 'PRE_CHECK', '000011000003', 'é¢„ä»˜', '402881f053b726080153b72893a60000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd670d0153cd6d6be40000', null, '0', null, '2', 'EDUCATION', '000017', 'å­¦åŽ†', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd78bacf0000', null, '0', null, '0', 'EDUCATIONCOLLEGE', '000017000001', 'æœ¬ç§‘', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd796ac90001', null, '0', null, '0', 'EDUCATIONHIGHSCHOOL', '000017000002', 'é«˜ä¸­', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd80b46c0002', null, '0', null, '0', 'EDUCATIONPRIMARY', '000017000003', 'å°�å­¦', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd8153450003', null, '0', null, '0', 'EDUCATIONJUNIOR', '000017000004', 'åˆ�ä¸­', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd820b960004', null, '0', null, '0', 'EDUCATIONDOCTOR', '000017000005', 'å�šå£«', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd82a79d0005', null, '0', null, '0', 'EDUCATIONMASTER', '000017000006', 'ç¡•å£«', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053cd72330153cd8384590006', null, '0', null, '0', 'EDUCATIONJUNIORCOLLEGE', '000017000007', 'å¤§ä¸“', '402881f053cd670d0153cd6d6be40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4a845920001', null, '0', null, '0', 'TAXPAYERTYPE', '000019', 'çº³ç¨Žäºº', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4a9d0f00002', null, '0', null, '0', 'GENERALTAXPAYER', '000019000001', 'ä¸€èˆ¬çº³ç¨Žäºº', '402881f053d4a5260153d4a845920001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4ab6b110003', null, '0', null, '0', 'SMALLSCALETAXPAYER', '000019000002', 'å°�è§„æ¨¡çº³ç¨Žäºº', '402881f053d4a5260153d4a845920001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4ab6b130003', null, '0', '2016-06-23 10:24:40', '1', 'GTAXPAYER', '000019000003', 'ä¸ªä½“å·¥å•†æˆ·', '402881f053d4a5260153d4a845920001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4aceaf20004', null, '0', null, '0', 'CAPITALTYPE', '000020', 'ä¼�ä¸šæ€§è´¨', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4ae22ee0005', null, '1', null, '1', 'OVERSEASFUNDED', '000020000001', 'å¤–èµ„ä¼�ä¸š', '402881f053d4a5260153d4aceaf20004', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4aeadd20006', null, '0', null, '0', 'STATEOWNED', '000020000002', 'å›½è�¥ä¼�ä¸š', '402881f053d4a5260153d4aceaf20004', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4af6f1a0007', null, '0', null, '0', 'JOINTVENTURE', '000020000003', 'å�ˆèµ„ä¼�ä¸š', '402881f053d4a5260153d4aceaf20004', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4a5260153d4b0a80c0008', null, '0', null, '1', 'PRIVATE', '000020000004', 'æ°‘è�¥ä¼�ä¸š', '402881f053d4a5260153d4aceaf20004', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4eccd0153d5117aac0001', null, '0', '2016-06-21 10:33:20', '2', 'SETTLEMENTTYPE', '000021', 'ç»“ç®—æ–¹å¼�', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4eccd0153d512a8580002', null, '0', null, '1', 'HQ_SETTLE', '000021000001', 'ç»Ÿä¸€ç»“ç®—', '402881f053d4eccd0153d5117aac0001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053d4eccd0153d513a0260003', null, '0', null, '1', 'INDIVIDUAL_SETTLE', '000021000002', 'ç‹¬ç«‹ç»“ç®—', '402881f053d4eccd0153d5117aac0001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e570c0890001', null, '0', null, '0', 'NATION', '000023', 'æ°‘æ—�', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57116300002', null, '0', null, '0', 'NATION01', '000023000001', 'æ±‰æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5716e790003', null, '0', null, '0', 'NATION02', '000023000002', 'è’™å�¤æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e571c0f60004', null, '0', null, '0', 'NATION03', '000023000003', 'å›žæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5723ada0005', null, '0', null, '0', 'NATION04', '000023000004', 'è—�æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57269ca0006', null, '0', null, '0', 'NATION05', '000023000005', 'ç»´å�¾å°”æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57293c20007', null, '0', null, '0', 'NATION06', '000023000006', 'è‹—æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e572e34c0008', null, '0', null, '0', 'NATION07', '000023000007', 'å½�æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5732caf0009', null, '0', null, '0', 'NATION08', '000023000008', 'å£®æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57366fb000a', null, '0', null, '0', 'NATION09', '000023000009', 'å¸ƒä¾�æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5739474000b', null, '0', null, '0', 'NATION10', '000023000010', 'æœ�é²œæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e573cc35000c', null, '0', null, '0', 'NATION11', '000023000011', 'æ»¡æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5743c21000d', null, '0', null, '0', 'NATION12', '000023000012', 'ä¾—æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5747f53000e', null, '0', null, '0', 'NATION13', '000023000013', 'ç‘¶æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e574b560000f', null, '0', null, '0', 'NATION14', '000023000014', 'ç™½æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57575d20010', null, '0', null, '0', 'NATION15', '000023000015', 'åœŸå®¶æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5759d8f0011', null, '0', null, '0', 'NATION16', '000023000016', 'å“ˆå°¼æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e575d9640012', null, '0', null, '0', 'NATION17', '000023000017', 'å“ˆè�¨å…‹æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5761ee30013', null, '0', null, '0', 'NATION18', '000023000018', 'å‚£æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5764cfb0014', null, '0', null, '0', 'NATION18', '000023000019', 'é»Žæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5768eff0015', null, '0', null, '0', 'NATION20', '000023000020', 'å‚ˆåƒ³æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e576c05a0016', null, '0', null, '0', 'NATION21', '000023000021', 'ä½¤æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5771fb10017', null, '0', null, '0', 'NATION22', '000023000022', 'ç•²æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e577754f0018', null, '0', null, '0', 'NATION23', '000023000023', 'é«˜å±±æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e577d8220019', null, '0', null, '0', 'NATION24', '000023000024', 'æ‹‰ç¥œæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57840d4001a', null, '0', null, '0', 'NATION25', '000023000025', 'æ°´æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e578beac001b', null, '0', null, '0', 'NATION26', '000023000026', 'ä¸œä¹¡æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e579cc50001c', null, '0', null, '0', 'NATION27', '000023000027', 'çº³è¥¿æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57a4b49001d', null, '0', null, '0', 'NATION28', '000023000028', 'æ™¯é¢‡æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57ab2ed001e', null, '0', null, '0', 'NATION29', '000023000029', 'æŸ¯å°”å…‹å­œæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57aeb4a001f', null, '0', null, '0', 'NATION30', '000023000030', 'åœŸæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57bb0c20020', null, '0', null, '0', 'NATION31', '000023000031', 'è¾¾æ–¡å°”æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57c1cb50021', null, '0', null, '0', 'NATION32', '000023000032', 'ä»«ä½¬æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57c71630022', null, '0', null, '0', 'NATION33', '000023000033', 'ç¾Œæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57cb5aa0023', null, '0', null, '0', 'NATION34', '000023000034', 'å¸ƒæœ—æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57d27c90024', null, '0', null, '0', '35', '000023000035', 'æ’’æ‹‰æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57df9a10025', null, '0', null, '0', 'NATION36', '000023000036', 'æ¯›éš¾æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57e48b80026', null, '0', null, '0', 'NATION37', '000023000037', 'ä»¡ä½¬æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57e8b080027', null, '0', null, '0', 'NATION38', '000023000038', 'é”¡ä¼¯æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57ebe990028', null, '0', null, '0', 'NATION', '000023000039', 'é˜¿æ˜Œæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57ef9f50029', null, '0', null, '0', 'NATION40', '000023000040', 'æ™®ç±³æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57f6094002a', null, '0', null, '0', 'NATION41', '000023000041', 'å¡”å�‰å…‹æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57fbe0b002b', null, '0', null, '0', 'NATION42', '000023000042', 'æ€’æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e57ffd10002c', null, '0', null, '0', 'NATION43', '000023000043', 'ä¹Œå…¹åˆ«å…‹', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5802506002d', null, '0', null, '0', 'NATION44', '000023000044', 'ä¿„ç½—æ–¯æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e58066c6002e', null, '0', null, '0', 'NATION45', '000023000045', 'é„‚æ¸©å…‹æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e580a981002f', null, '0', null, '0', 'NATION46', '000023000046', 'å´©é¾™æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e580e3540030', null, '0', null, '0', 'NATION47', '000023000047', 'ä¿�å®‰æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5813d0a0031', null, '0', null, '0', 'NATION48', '000023000048', 'è£•å›ºæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e581adce0032', null, '0', null, '0', 'NATION49', '000023000049', 'äº¬æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e581eb050033', null, '0', null, '0', 'NATION50', '000023000050', 'å¡”å¡”å°”æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e582223b0034', null, '0', null, '0', 'NATION51', '000023000051', 'ç‹¬é¾™æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e58269950035', null, '0', null, '0', 'NATION52', '000023000052', 'é„‚ä¼¦æ˜¥æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e582c7b80036', null, '0', null, '0', 'NATION53', '000023000053', 'èµ«å“²æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e58307aa0037', null, '0', null, '0', 'NATION54', '000023000054', 'é—¨å·´æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e583596a0038', null, '0', null, '0', 'NATION55', '000023000055', 'ç�žå·´æ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053e55e710153e5838d9c0039', null, '0', null, '0', 'NATION56', '000023000056', 'åŸºè¯ºæ—�', '402881f053e55e710153e570c0890001', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053f983b00153f98597fd0000', null, '0', null, '0', 'MESSAGETYPE', '000024', 'ç«™å†…ä¿¡ç±»åž‹', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053f983b00153f986e77c0001', null, '0', '2016-07-31 08:40:32', '2', 'MESSAGEPRODUCT', '000024000001', 'ç”Ÿäº§', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053f983b00153f98822340002', null, '0', null, '0', 'MESSAGEMARKET', '000024000002', 'é”€å”®', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053f983b00153f988e3190003', null, '0', null, '0', 'MESSAGEDELIVERY', '000024000003', 'é€�è´§', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f053f983b00153f989be130004', null, '0', null, '0', 'MESSAGEPURCHASE', '000024000004', 'é‡‡è´­', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402881f0540024cd0154003bae140006', null, '0', null, '0', 'INFORM', '000024000005', 'é€šçŸ¥', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453c561fa0153c5647ce00003', null, '0', null, '0', 'CHANNELTYPE', '000013', 'æ�¥æº�', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453c561fa0153c56598ee0004', null, '0', '2016-08-27 23:55:23', '1', 'CHANNELTYPEACTIVITY', '000013000001', 'æŽ¨å¹¿æ´»åŠ¨', '402882f453c561fa0153c5647ce00003', '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453c561fa0153c565dd6b0005', null, '0', null, '1', 'CHANNELTYPETEL', '000013000002', 'ç”µè¯�å’¨è¯¢', '402882f453c561fa0153c5647ce00003', '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453cf94730153cf96f8e40000', null, '0', null, '0', 'SUPPLIERLEVEL', '000018', 'ä¾›åº”å•†çº§åˆ«', null, '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453cf94730153cf97dbc30001', null, '0', '2016-06-23 10:18:12', '2', 'SUPPLIERLEVELSILVER', '000018000001', 'ä¸€èˆ¬ä¾›åº”å•†', '402882f453cf94730153cf96f8e40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453cf94730153cf9834bd0002', null, '0', '2016-06-23 10:18:00', '2', 'SUPPLIERLEVELGOLD', '000018000002', 'é‡�ç‚¹ä¾›åº”å•†', '402882f453cf94730153cf96f8e40000', '', '');
INSERT INTO `tbl_dict` VALUES ('402882f453cf94730153cf98f3fa0003', null, '0', '2016-06-23 10:17:32', '2', 'SUPPLIERLEVELDIAMOND', '000018000003', 'æˆ˜ç•¥ä¾›åº”å•†', '402882f453cf94730153cf96f8e40000', '', '');
INSERT INTO `tbl_dict` VALUES ('8a2c43d853f918e30153f92417ab0004', null, '0', null, '0', 'CHANNELTYPEMEDIA', '000013000003', 'åª’ä½“å¹¿å‘Š', '402882f453c561fa0153c5647ce00003', '', '');
INSERT INTO `tbl_dict` VALUES ('8a2c43d853f918e30153f92589ad0005', null, '0', null, '0', 'CHANNELTYPEPEINTRO', '000013000004', 'ç†ŸäººæŽ¨è��', '402882f453c561fa0153c5647ce00003', '', '');
INSERT INTO `tbl_dict` VALUES ('8a2c43d853f918e30153f928e92e0006', null, '0', null, '0', 'CHANNELTYPEOTHERS', '000013000005', 'å…¶ä»–', '402882f453c561fa0153c5647ce00003', '', '');
INSERT INTO `tbl_dict` VALUES ('bc4d163c5880ab4901588b5582360001', '2016-11-22 17:19:46', '0', '2016-11-22 17:19:46', '0', 'TEXT', '000024000006', 'çŸ­ä¿¡', '402881f053f983b00153f98597fd0000', '', '');
INSERT INTO `tbl_dict` VALUES ('bc4d163c5880ab4901588b5b49080002', '2016-11-22 17:26:05', '0', '2016-11-22 17:26:05', '0', 'HANZU', '000023000057', 'æ±‰æ—�', '402881f053e55e710153e570c0890001', '', '');

-- ----------------------------
-- Table structure for tbl_file
-- ----------------------------
DROP TABLE IF EXISTS `tbl_file`;
CREATE TABLE `tbl_file` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `create_user_id` varchar(255) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `filePath` varchar(255) DEFAULT NULL,
  `fileSize` bigint(20) DEFAULT NULL,
  `form_ID` varchar(255) DEFAULT NULL,
  `savedName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_file
-- ----------------------------
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab1a4a4ff0013', '2017-03-09 13:57:21', '0', '2017-03-09 13:57:21', '0', '402880e456223e8f015625231d8e0003', 'ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '\\uploadPath\\file\\20170309135721782_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '69120', null, '20170309135721782_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab1a582830014', '2017-03-09 13:58:18', '0', '2017-03-09 13:58:18', '0', '402880e456223e8f015625231d8e0003', '010202æ–°å¢žå·¥åŽ‚.png', '\\uploadPath\\file\\20170309135818497_010202æ–°å¢žå·¥åŽ‚.png', '63321', null, '20170309135818497_010202æ–°å¢žå·¥åŽ‚.png');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab1a6cdc80016', '2017-03-09 13:59:43', '0', '2017-03-09 13:59:43', '0', '402880e456223e8f015625231d8e0003', 'dist.rar', '\\uploadPath\\file\\20170309135943302_dist.rar', '494885', null, '20170309135943302_dist.rar');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab2527de10019', '2017-03-09 17:07:15', '0', '2017-03-09 17:07:15', '0', '402880e456223e8f015625231d8e0003', 'Penguins.jpg', '\\uploadPath\\file\\2017030917071536_Penguins.jpg', '777835', null, '2017030917071536_Penguins.jpg');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab2527de9001a', '2017-03-09 17:07:15', '0', '2017-03-09 17:07:15', '0', '402880e456223e8f015625231d8e0003', 'Desert.jpg', '\\uploadPath\\file\\2017030917071545_Desert.jpg', '845941', null, '2017030917071545_Desert.jpg');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab35f47fe001b', '2017-03-09 22:00:50', '0', '2017-03-09 22:00:50', '0', '402880e456223e8f015625231d8e0003', 'Koala.jpg', '\\uploadPath\\file\\20170309220050423_Koala.jpg', '780831', null, '20170309220050423_Koala.jpg');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab35f4806001c', '2017-03-09 22:00:50', '0', '2017-03-09 22:00:50', '0', '402880e456223e8f015625231d8e0003', 'Penguins.jpg', '\\uploadPath\\file\\20170309220050433_Penguins.jpg', '777835', null, '20170309220050433_Penguins.jpg');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab388c523001d', '2017-03-09 22:46:09', '0', '2017-03-09 22:46:09', '0', '402880e456223e8f015625231d8e0003', 'çŸ³æ²¹å¤§é™¢ç¤¾åŒºappæ±‡æŠ¥.pptx', '\\uploadPath\\file\\20170309224609437_çŸ³æ²¹å¤§é™¢ç¤¾åŒºappæ±‡æŠ¥.pptx', '2956689', null, '20170309224609437_çŸ³æ²¹å¤§é™¢ç¤¾åŒºappæ±‡æŠ¥.pptx');
INSERT INTO `tbl_file` VALUES ('402880ea5aae3edf015ab388c52a001e', '2017-03-09 22:46:09', '0', '2017-03-09 22:46:09', '0', '402880e456223e8f015625231d8e0003', 'é€�æ ·å�•_åœ°å¤§æ­¦æ±‰_Tmax_å¡«.xls', '\\uploadPath\\file\\20170309224609446_é€�æ ·å�•_åœ°å¤§æ­¦æ±‰_Tmax_å¡«.xls', '17408', null, '20170309224609446_é€�æ ·å�•_åœ°å¤§æ­¦æ±‰_Tmax_å¡«.xls');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abc895fcc0003', '2017-03-11 16:43:23', '0', '2017-03-11 16:43:23', '0', '402880e456223e8f015625231d8e0003', 'è½¯ä»¶å·¥ç¨‹_é’±ä¹�ç§‹_.rar', '\\uploadPath\\file\\20170311164323978_è½¯ä»¶å·¥ç¨‹_é’±ä¹�ç§‹_.rar', '3926542', null, '20170311164323978_è½¯ä»¶å·¥ç¨‹_é’±ä¹�ç§‹_.rar');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abc9ff9500004', '2017-03-11 17:08:05', '0', '2017-03-11 17:08:05', '0', '402880e456223e8f015625231d8e0003', 'AdminEAP_framework_1.0_SNAPSHOT.jar', '\\uploadPath\\file\\2017031117080570_AdminEAP_framework_1.0_SNAPSHOT.jar', '180562', null, '2017031117080570_AdminEAP_framework_1.0_SNAPSHOT.jar');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abca8159d0005', '2017-03-11 17:16:56', '0', '2017-03-11 17:16:56', '0', '402880e456223e8f015625231d8e0003', 'ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '\\uploadPath\\file\\20170311171656603_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '69120', null, '20170311171656603_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcb7f70f0006', '2017-03-11 17:34:17', '0', '2017-03-11 17:34:17', '0', '402880e456223e8f015625231d8e0003', 'ç« çœŸå¿ 2.docx', '\\uploadPath\\file\\20170311173417357_ç« çœŸå¿ 2.docx', '64781', null, '20170311173417357_ç« çœŸå¿ 2.docx');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcb9228a0007', '2017-03-11 17:35:34', '0', '2017-03-11 17:35:34', '0', '402880e456223e8f015625231d8e0003', 'ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '\\uploadPath\\file\\2017031117353423_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc', '69120', null, '2017031117353423_ä¸­å›½çŸ³æ²¹å‹˜æŽ¢å¼€å�‘ç ”ç©¶é™¢ç®€åŽ†ï¼ˆæ±Ÿæ—¥å¿µï¼‰.doc');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcbb8e24000e', '2017-03-11 17:38:12', '0', '2017-03-11 17:38:12', '0', '402880e456223e8f015625231d8e0003', '234928_150R215404322.jpg', '\\uploadPath\\file\\20170311173812641_234928_150R215404322.jpg', '91256', null, '20170311173812641_234928_150R215404322.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcbfc66f000f', '2017-03-11 17:42:49', '0', '2017-03-11 17:42:49', '0', '402880e456223e8f015625231d8e0003', '234928_150R215404322.jpg', '\\uploadPath\\file\\20170311174249197_234928_150R215404322.jpg', '91256', null, '20170311174249197_234928_150R215404322.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcc037440012', '2017-03-11 17:43:18', '0', '2017-03-11 17:43:18', '0', '402880e456223e8f015625231d8e0003', '104039672.png', '\\uploadPath\\file\\2017031117431882_104039672.png', '138668', null, '2017031117431882_104039672.png');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abcc0430d0013', '2017-03-11 17:43:21', '0', '2017-03-11 17:43:21', '0', '402880e456223e8f015625231d8e0003', '104039672_å‰¯æœ¬.png', '\\uploadPath\\file\\2017031117432199_104039672_å‰¯æœ¬.png', '138668', null, '2017031117432199_104039672_å‰¯æœ¬.png');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abdcfc6b70014', '2017-03-11 22:39:55', '0', '2017-03-11 22:39:55', '0', '402880e456223e8f015625231d8e0003', '234928_150R215404322.jpg', '\\uploadPath\\file\\2017031122395561_234928_150R215404322.jpg', '91256', null, '2017031122395561_234928_150R215404322.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abdd3df0f0015', '2017-03-11 22:44:23', '0', '2017-03-11 22:44:23', '0', '402880e456223e8f015625231d8e0003', '1_146_.jpg', '\\uploadPath\\file\\20170311224423438_1_146_.jpg', '38230', null, '20170311224423438_1_146_.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abdd3e73c0016', '2017-03-11 22:44:25', '0', '2017-03-11 22:44:25', '0', '402880e456223e8f015625231d8e0003', '1.jpg', '\\uploadPath\\file\\20170311224425530_1.jpg', '23341', null, '20170311224425530_1.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abdd694eb0017', '2017-03-11 22:47:21', '0', '2017-03-11 22:47:21', '0', '402880e456223e8f015625231d8e0003', '5936056_135709981147_2.jpg', '\\uploadPath\\file\\2017031122472166_5936056_135709981147_2.jpg', '196305', null, '2017031122472166_5936056_135709981147_2.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abbe288015abdd6b22e0018', '2017-03-11 22:47:28', '0', '2017-03-11 22:47:28', '0', '402880e456223e8f015625231d8e0003', '234928_150R215404322.jpg', '\\uploadPath\\file\\20170311224728557_234928_150R215404322.jpg', '91256', null, '20170311224728557_234928_150R215404322.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abdfec1015ac02c71f10001', '2017-03-12 09:40:22', '0', '2017-03-12 09:40:22', '0', '402880e456223e8f015625231d8e0003', '234928_150R215404322.jpg', '\\uploadPath\\file\\20170312094022638_234928_150R215404322.jpg', '91256', null, '20170312094022638_234928_150R215404322.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abdfec1015ac02c71f50002', '2017-03-12 09:40:22', '0', '2017-03-12 09:40:22', '0', '402880e456223e8f015625231d8e0003', '5936056_135709981147_2.jpg', '\\uploadPath\\file\\20170312094022644_5936056_135709981147_2.jpg', '196305', null, '20170312094022644_5936056_135709981147_2.jpg');
INSERT INTO `tbl_file` VALUES ('402880ed5abdfec1015ac02c71f80003', '2017-03-12 09:40:22', '0', '2017-03-12 09:40:22', '0', '402880e456223e8f015625231d8e0003', '5936056_154500108516_2.jpg', '\\uploadPath\\file\\20170312094022647_5936056_154500108516_2.jpg', '273616', null, '20170312094022647_5936056_154500108516_2.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab60555015ab6098adf0000', '2017-03-10 10:26:03', '0', '2017-03-10 10:26:03', '0', '402880e456223e8f015625231d8e0003', 'ç« çœŸå¿ 2.docx', '\\uploadPath\\file\\2017031010260396_ç« çœŸå¿ 2.docx', '64781', null, '2017031010260396_ç« çœŸå¿ 2.docx');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab64a5c015ab64d26c90001', '2017-03-10 11:39:53', '0', '2017-03-10 11:39:53', '0', '402880e456223e8f015625231d8e0003', 'mm_facetoface_collect_qrcode_1487932173612.png', '\\uploadPath\\file\\20170310113953926_mm_facetoface_collect_qrcode_1487932173612.png', '85360', null, '20170310113953926_mm_facetoface_collect_qrcode_1487932173612.png');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab64a5c015ab64d26ce0002', '2017-03-10 11:39:53', '0', '2017-03-10 11:39:53', '0', '402880e456223e8f015625231d8e0003', 'quoteServiceImpl.txt', '\\uploadPath\\file\\20170310113953932_quoteServiceImpl.txt', '17439', null, '20170310113953932_quoteServiceImpl.txt');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab6571bfa0000', '2017-03-10 11:50:46', '0', '2017-03-10 11:50:46', '0', '402880e456223e8f015625231d8e0003', 'Hydrangeas.jpg', '\\uploadPath\\file\\20170310115046517_Hydrangeas.jpg', '595284', null, '20170310115046517_Hydrangeas.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab6571c1b0001', '2017-03-10 11:50:46', '0', '2017-03-10 11:50:46', '0', '402880e456223e8f015625231d8e0003', 'Jellyfish.jpg', '\\uploadPath\\file\\20170310115046553_Jellyfish.jpg', '775702', null, '20170310115046553_Jellyfish.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab659bb8e0002', '2017-03-10 11:53:38', '0', '2017-03-10 11:53:38', '0', '402880e456223e8f015625231d8e0003', 'Jellyfish.jpg', '\\uploadPath\\file\\20170310115338442_Jellyfish.jpg', '775702', null, '20170310115338442_Jellyfish.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab659bb940003', '2017-03-10 11:53:38', '0', '2017-03-10 11:53:38', '0', '402880e456223e8f015625231d8e0003', 'Koala.jpg', '\\uploadPath\\file\\20170310115338450_Koala.jpg', '780831', null, '20170310115338450_Koala.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab659bb990004', '2017-03-10 11:53:38', '0', '2017-03-10 11:53:38', '0', '402880e456223e8f015625231d8e0003', 'Lighthouse.jpg', '\\uploadPath\\file\\20170310115338455_Lighthouse.jpg', '561276', null, '20170310115338455_Lighthouse.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab6749dfa0005', '2017-03-10 12:23:00', '0', '2017-03-10 12:23:00', '0', '402880e456223e8f015625231d8e0003', 'Koala.jpg', '\\uploadPath\\file\\20170310122300343_Koala.jpg', '780831', null, '20170310122300343_Koala.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab6749e010006', '2017-03-10 12:23:00', '0', '2017-03-10 12:23:00', '0', '402880e456223e8f015625231d8e0003', 'Lighthouse.jpg', '\\uploadPath\\file\\20170310122300351_Lighthouse.jpg', '561276', null, '20170310122300351_Lighthouse.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab6759e9e0008', '2017-03-10 12:24:06', '0', '2017-03-10 12:24:06', '0', '402880e456223e8f015625231d8e0003', 'Koala.jpg', '\\uploadPath\\file\\2017031012240643_Koala.jpg', '780831', null, '2017031012240643_Koala.jpg');
INSERT INTO `tbl_file` VALUES ('8a8a84995ab654d1015ab69a75c0000a', '2017-03-10 13:04:20', '0', '2017-03-10 13:04:20', '0', '402880e456223e8f015625231d8e0003', 'Desert.jpg', '\\uploadPath\\file\\20170310130420413_Desert.jpg', '845941', null, '20170310130420413_Desert.jpg');

-- ----------------------------
-- Table structure for tbl_function
-- ----------------------------
DROP TABLE IF EXISTS `tbl_function`;
CREATE TABLE `tbl_function` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `functype` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `levelCode` varchar(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_function
-- ----------------------------
INSERT INTO `tbl_function` VALUES ('402880e958eb83230158eb85a30f0000', '2016-12-11 09:35:53', '0', '2016-12-11 09:35:53', '0', 'ARTICLE', '1', 'fa fa-edit', '000028000001', 'æˆ‘çš„æ–‡ç« ', '402880eb58d9a6d40158d9a7b21f0000', '', '/markdown/list');
INSERT INTO `tbl_function` VALUES ('402880e95a72d8a4015a738980e30000', '2017-02-25 12:31:15', '0', '2017-02-25 12:31:15', '0', 'FORM', '1', 'fa fa-edit', '000004000002', 'è¡¨å�•-form', 'ff80808159ea142c0159ea670fae0000', 'è¡¨å�•ç»„ä»¶base-form', '/markdown/preview/form');
INSERT INTO `tbl_function` VALUES ('402880e95a72d8a4015a738bb1990001', '2017-02-25 12:33:39', '0', '2017-02-25 12:33:57', '1', 'JOB', '1', 'fa fa-calendar-check-o', '000028000005', 'ä»»åŠ¡ç®¡ç�†å™¨', '402880eb58d9a6d40158d9a7b21f0000', 'åŸºäºŽQuartzçš„å®šæ—¶ä»»åŠ¡ç®¡ç�†å™¨', '/job/list');
INSERT INTO `tbl_function` VALUES ('402880ea5aae3edf015ab1b0ec9d0017', '2017-03-09 14:10:46', '0', '2017-03-09 14:10:46', '0', 'FILEINPUT', '1', 'fa fa-file-o', '000004000003', 'é™„ä»¶ä¸Šä¼ -file', 'ff80808159ea142c0159ea670fae0000', '', '/markdown/preview/file');
INSERT INTO `tbl_function` VALUES ('402880eb56875b7f0156876338100000', '2016-08-14 12:50:41', '0', '2016-12-05 15:12:59', '3', 'DEMO', '0', 'fa fa-table', '000002', 'CURD DEMO', '', '', '');
INSERT INTO `tbl_function` VALUES ('402880eb56875b7f01568763ac630001', '2016-08-14 12:51:11', '0', '2016-12-05 16:22:21', '5', 'USER-DIALOG', '1', 'fa fa-user', '000002000001', 'ç”¨æˆ·åˆ—è¡¨-Dailog', '402880eb56875b7f0156876338100000', '', '/user/list');
INSERT INTO `tbl_function` VALUES ('402880eb58d9a6d40158d9a7b21f0000', '2016-12-07 22:19:55', '0', '2016-12-07 22:19:55', '0', 'TOOL', '0', 'fa fa-wrench', '000028', 'ç³»ç»Ÿå·¥å…·', '', '', '');
INSERT INTO `tbl_function` VALUES ('402880eb58d9a6d40158d9a995130001', '2016-12-07 22:21:59', '0', '2016-12-12 09:59:46', '3', 'MARKDOWN', '1', 'fa fa-pencil', '000028000002', 'Markdownç¼–è¾‘å™¨', '402880eb58d9a6d40158d9a7b21f0000', '', '/markdown/edit');
INSERT INTO `tbl_function` VALUES ('40288182579e398f0157a25ca29a0002', '2016-10-08 11:36:02', '0', '2016-10-08 11:36:02', '0', 'USER-DEMO-TAB', '1', 'fa fa-male', '000002000002', 'ç”¨æˆ·åˆ—è¡¨-Tab', '402880eb56875b7f0156876338100000', 'CURD-DEMO tabæ–¹å¼�', '/user/tab/list');
INSERT INTO `tbl_function` VALUES ('4028818a567745ec0156786cd39e000b', '2016-08-11 15:06:53', '0', '2016-08-30 14:06:15', '5', 'TODO', '0', 'fa fa-calendar-check-o', '000001', 'æˆ‘çš„å¾…åŠž', '', '', '');
INSERT INTO `tbl_function` VALUES ('4028818a56d407950156d41352630000', '2016-08-29 10:14:11', '0', '2016-08-29 10:14:11', '0', 'SYSTEM', '0', 'fa fa-tv', '000030', 'ç³»ç»Ÿç®¡ç�†', '', '', '');
INSERT INTO `tbl_function` VALUES ('4028818a56d407950156d41435830001', '2016-08-29 10:15:09', '0', '2016-08-29 10:15:09', '0', 'USER', '1', 'fa fa-user', '000030000001', 'ç”¨æˆ·ç®¡ç�†', '4028818a56d407950156d41352630000', '', '/user/list');
INSERT INTO `tbl_function` VALUES ('4028818a56d407950156d4160e390002', '2016-08-29 10:17:10', '0', '2016-08-29 10:17:10', '0', 'DICTIONARY', '1', 'fa fa-book', '000030000002', 'å­—å…¸ç®¡ç�†', '4028818a56d407950156d41352630000', '', '/dict/tree');
INSERT INTO `tbl_function` VALUES ('4028818a56d407950156d41d32ab0003', '2016-08-29 10:24:58', '0', '2017-01-03 16:51:49', '2', 'FUNCTION', '1', 'fa fa-cog', '000030000003', 'åŠŸèƒ½ç®¡ç�†', '4028818a56d407950156d41352630000', '', '/function/tree');
INSERT INTO `tbl_function` VALUES ('4028818a56d407950156d4ecfafa0004', '2016-08-29 14:11:55', '0', '2016-08-30 13:44:07', '1', 'Role', '1', 'fa fa-street-view', '000030000004', 'è§’è‰²ç®¡ç�†', '4028818a56d407950156d41352630000', '', '/role/list');
INSERT INTO `tbl_function` VALUES ('402881f25681c52a015681d472ba0000', '2016-08-13 10:56:39', '0', '2016-12-05 09:58:40', '2', 'TEST', '1', 'fa fa-bicycle', '000001000001', 'TEST', '4028818a567745ec0156786cd39e000b', '', 'TEST');
INSERT INTO `tbl_function` VALUES ('8a8a801b58ce0f500158ce14d2c20000', '2016-12-05 16:23:40', '0', '2016-12-05 16:23:40', '0', 'USER-PAGE', '1', 'fa fa-user', '000002000003', 'ç”¨æˆ·åˆ—è¡¨-Page', '402880eb56875b7f0156876338100000', '', '/user/page/list');
INSERT INTO `tbl_function` VALUES ('8a8a807a59634b2801596364e33d0001', '2017-01-03 16:14:33', '0', '2017-01-03 16:14:33', '0', 'ROLEFUNC', '1', 'fa fa-key', '000030000005', 'è§’è‰²æŽˆæ�ƒ', '4028818a56d407950156d41352630000', '', '/rolefunc/list');
INSERT INTO `tbl_function` VALUES ('8a8a81425a1b36e9015a1b42074b0000', '2017-02-08 09:06:36', '0', '2017-02-13 13:40:04', '1', 'CODEGENERATOR', '1', 'fa fa-list', '000028000003', 'ä»£ç �ç”Ÿæˆ�å™¨', '402880eb58d9a6d40158d9a7b21f0000', '', '/generator/setting');
INSERT INTO `tbl_function` VALUES ('8a8a81d65a3598d9015a360092e60000', '2017-02-13 13:44:51', '1', '2017-03-01 11:01:46', '2', 'GENERATOR', '1', 'fa fa-edit', '000028000004', 'ä»£ç �ç”Ÿæˆ�å™¨æµ‹è¯•', '402880eb58d9a6d40158d9a7b21f0000', 'æœ¬åŠŸèƒ½è�œå�•ä¸ºä»£ç �ç”Ÿæˆ�å™¨ç”Ÿæˆ�ï¼Œæ—¶é—´ï¼š2017-02-13 13:44:51', '/generator/list');
INSERT INTO `tbl_function` VALUES ('8a8a83295a83a81a015a843e397b0000', '2017-02-28 18:22:34', '0', '2017-02-28 18:22:34', '0', 'MESSAGE', '1', 'fa fa-list', '000028000006', 'æ¶ˆæ�¯ç®¡ç�†å™¨', '402880eb58d9a6d40158d9a7b21f0000', '', '/message/list');
INSERT INTO `tbl_function` VALUES ('ff80808159ea142c0159ea670fae0000', '2017-01-29 21:25:39', '0', '2017-02-06 14:34:24', '2', 'Component', '0', 'fa fa-server', '000004', 'ç»„ä»¶ä½¿ç”¨è¯´æ˜Ž', '', '', '');
INSERT INTO `tbl_function` VALUES ('ff80808159ea142c0159ea68d1e30001', '2017-01-29 21:27:35', '0', '2017-02-25 12:31:32', '3', 'MODALS', '1', 'fa fa-windows', '000004000001', 'çª—ä½“-modals', 'ff80808159ea142c0159ea670fae0000', '', '/markdown/preview/modal');

-- ----------------------------
-- Table structure for tbl_function_filter
-- ----------------------------
DROP TABLE IF EXISTS `tbl_function_filter`;
CREATE TABLE `tbl_function_filter` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `class_type` varchar(255) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `functionId` varchar(255) DEFAULT NULL,
  `roleId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_function_filter
-- ----------------------------
INSERT INTO `tbl_function_filter` VALUES ('40288193596da8a301596dd926ed0001', '2017-01-05 16:57:44', '0', '2017-01-05 16:57:44', '0', 'java.lang.Double', 'test', 'not_null', '1', 'test', '402880eb58d9a6d40158d9a995130001', 'bc4d163c5880ab4901588b6681e50003');

-- ----------------------------
-- Table structure for tbl_markdown
-- ----------------------------
DROP TABLE IF EXISTS `tbl_markdown`;
CREATE TABLE `tbl_markdown` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `content` longtext,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_markdown
-- ----------------------------
INSERT INTO `tbl_markdown` VALUES ('402880e958ecdff60158ed0c62ba0001', '2016-12-11 16:42:41', '0', '2017-02-06 11:18:28', '2', 'Markdown,å…³é”®å­—', 'æ¬¢è¿Žä½¿ç”¨Markdownç¼–è¾‘å™¨å†™æ–‡ç« ', null, '# æ¬¢è¿Žä½¿ç”¨Markdownç¼–è¾‘å™¨å†™æ–‡ç« \n\næœ¬Markdownç¼–è¾‘å™¨ä½¿ç”¨**Editor.md**ä¿®æ”¹è€Œæ�¥ï¼Œç”¨å®ƒå†™æŠ€æœ¯æ–‡ç« ï¼Œå°†ä¼šå¸¦æ�¥å…¨æ–°çš„ä½“éªŒå“¦ï¼š\n\n- **Markdownå’Œæ‰©å±•Markdownç®€æ´�çš„è¯­æ³•**\n- **ä»£ç �å�—é«˜äº®**\n- **å›¾ç‰‡é“¾æŽ¥å’Œå›¾ç‰‡ä¸Šä¼ **\n- ***LaTex*æ•°å­¦å…¬å¼�**\n- **UMLåº�åˆ—å›¾å’Œæµ�ç¨‹å›¾**\n- **ç¦»çº¿å†™æ–‡ç« **\n- **å¯¼å…¥å¯¼å‡ºMarkdownæ–‡ä»¶**\n- **ä¸°å¯Œçš„å¿«æ�·é”®**\n-------------------\n\n## å¿«æ�·é”®\n\n - åŠ ç²—     `Ctrl + B`\n - æ–œä½“     `Ctrl + I`\n - å¼•ç”¨     `Ctrl + Q`\n - æ�’å…¥é“¾æŽ¥    `Ctrl + L`\n - æ�’å…¥ä»£ç �    `Ctrl + K`\n - æ�’å…¥å›¾ç‰‡    `Ctrl + G`\n - æ��å�‡æ ‡é¢˜    `Ctrl + H`\n - æœ‰åº�åˆ—è¡¨    `Ctrl + O`\n - æ— åº�åˆ—è¡¨    `Ctrl + U`\n - æ¨ªçº¿    `Ctrl + R`\n - æ’¤é”€    `Ctrl + Z`\n - é‡�å�š    `Ctrl + Y`\n\n## Markdownå�Šæ‰©å±•\n\n> Markdown æ˜¯ä¸€ç§�è½»é‡�çº§æ ‡è®°è¯­è¨€ï¼Œå®ƒå…�è®¸äººä»¬ä½¿ç”¨æ˜“è¯»æ˜“å†™çš„çº¯æ–‡æœ¬æ ¼å¼�ç¼–å†™æ–‡æ¡£ï¼Œç„¶å�Žè½¬æ�¢æˆ�æ ¼å¼�ä¸°å¯Œçš„HTMLé¡µé�¢ã€‚    â€”â€” <a href=\"https://zh.wikipedia.org/wiki/Markdown\" target=\"_blank\"> [ ç»´åŸºç™¾ç§‘ ]\n\nä½¿ç”¨ç®€å�•çš„ç¬¦å�·æ ‡è¯†ä¸�å�Œçš„æ ‡é¢˜ï¼Œå°†æŸ�äº›æ–‡å­—æ ‡è®°ä¸º**ç²—ä½“**æˆ–è€…*æ–œä½“*ï¼Œåˆ›å»ºä¸€ä¸ª[é“¾æŽ¥](http://www.csdn.net)ç­‰ï¼Œè¯¦ç»†è¯­æ³•å�‚è€ƒå¸®åŠ©ï¼Ÿã€‚\n\næœ¬ç¼–è¾‘å™¨æ”¯æŒ� **Markdown Extra** , ã€€æ‰©å±•äº†å¾ˆå¤šå¥½ç”¨çš„åŠŸèƒ½ã€‚å…·ä½“è¯·å�‚è€ƒ[Github][2].\n\n### è¡¨æ ¼\n\n**Markdownã€€Extra**ã€€è¡¨æ ¼è¯­æ³•ï¼š\n\né¡¹ç›®     | ä»·æ ¼\n-------- | ---\nComputer | $1600\nPhone    | $12\nPipe     | $1\n\nå�¯ä»¥ä½¿ç”¨å†’å�·æ�¥å®šä¹‰å¯¹é½�æ–¹å¼�ï¼š\n\n| é¡¹ç›®      |    ä»·æ ¼ | æ•°é‡�  |\n| :-------- | --------:| :--: |\n| Computer  | 1600 å…ƒ |  5   |\n| Phone     |   12 å…ƒ |  12  |\n| Pipe      |    1 å…ƒ | 234  |\n\n\n### ä»£ç �å�—\nä»£ç �å�—è¯­æ³•é�µå¾ªæ ‡å‡†markdownä»£ç �ï¼Œä¾‹å¦‚ï¼š\n``` python\n@requires_authorization\ndef somefunc(param1=\'\', param2=0):\n    \'\'\'A docstring\'\'\'\n    if param1 > param2: # interesting\n        print \'Greater\'\n    return (param2 - param1 + 1) or None\nclass SomeClass:\n    pass\n>>> message = \'\'\'interpreter\n... prompt\'\'\'\n```\n\n\n### ç›®å½•\nç”¨ `[TOC]`æ�¥ç”Ÿæˆ�ç›®å½•ï¼š\n\n[TOC]\n\n### æ•°å­¦å…¬å¼�\nä½¿ç”¨MathJaxæ¸²æŸ“*LaTex* æ•°å­¦å…¬å¼�ï¼Œè¯¦è§�[math.stackexchange.com][1].\n\n - è¡Œå†…å…¬å¼�ï¼Œæ•°å­¦å…¬å¼�ä¸ºï¼š$\\Gamma(n) = (n-1)!\\quad\\forall n\\in\\mathbb N$ã€‚\n - å�—çº§å…¬å¼�ï¼š\n\n$$	x = \\dfrac{-b \\pm \\sqrt{b^2 - 4ac}}{2a} $$\n\næ›´å¤šLaTexè¯­æ³•è¯·å�‚è€ƒ [è¿™å„¿][3].\n\n### UML å›¾:\n\nå�¯ä»¥æ¸²æŸ“åº�åˆ—å›¾ï¼š\n\n```sequence\nå¼ ä¸‰->æ�Žå››: å˜¿ï¼Œå°�å››å„¿, å†™å�šå®¢äº†æ²¡?\nNote right of æ�Žå››: æ�Žå››æ„£äº†ä¸€ä¸‹ï¼Œè¯´ï¼š\næ�Žå››-->å¼ ä¸‰: å¿™å¾—å��è¡€ï¼Œå“ªæœ‰æ—¶é—´å†™ã€‚\n```\n\næˆ–è€…æµ�ç¨‹å›¾ï¼š\n\n```flow\nst=>start: å¼€å§‹\ne=>end: ç»“æ�Ÿ\nop=>operation: æˆ‘çš„æ“�ä½œ\ncond=>condition: ç¡®è®¤ï¼Ÿ\n\nst->op->cond\ncond(yes)->e\ncond(no)->op\n```\n\n- å…³äºŽ **åº�åˆ—å›¾** è¯­æ³•ï¼Œå�‚è€ƒ [è¿™å„¿][4],\n- å…³äºŽ **æµ�ç¨‹å›¾** è¯­æ³•ï¼Œå�‚è€ƒ [è¿™å„¿][5].\n\n## ç¦»çº¿å†™å�šå®¢\n\nå�³ä½¿ç”¨æˆ·åœ¨æ²¡æœ‰ç½‘ç»œçš„æƒ…å†µä¸‹ï¼Œä¹Ÿå�¯ä»¥é€šè¿‡æœ¬ç¼–è¾‘å™¨ç¦»çº¿å†™æ–‡ç« ï¼ˆç›´æŽ¥åœ¨æ›¾ç»�ä½¿ç”¨è¿‡çš„æµ�è§ˆå™¨ä¸­è¾“å…¥[write.blog.csdn.net/mdeditor](http://write.blog.csdn.net/mdeditor)å�³å�¯ã€‚**Markdownç¼–è¾‘å™¨**ä½¿ç”¨æµ�è§ˆå™¨ç¦»çº¿å­˜å‚¨å°†å†…å®¹ä¿�å­˜åœ¨æœ¬åœ°ã€‚\n\nç”¨æˆ·å†™æ–‡ç« çš„è¿‡ç¨‹ä¸­ï¼Œå†…å®¹å®žæ—¶ä¿�å­˜åœ¨æµ�è§ˆå™¨ç¼“å­˜ä¸­ï¼Œåœ¨ç”¨æˆ·å…³é—­æµ�è§ˆå™¨æˆ–è€…å…¶å®ƒå¼‚å¸¸æƒ…å†µä¸‹ï¼Œå†…å®¹ä¸�ä¼šä¸¢å¤±ã€‚ç”¨æˆ·å†�æ¬¡æ‰“å¼€æµ�è§ˆå™¨æ—¶ï¼Œä¼šæ˜¾ç¤ºä¸Šæ¬¡ç”¨æˆ·æ­£åœ¨ç¼–è¾‘çš„æ²¡æœ‰å�‘è¡¨çš„å†…å®¹ã€‚\n\næ–‡ç« å�‘è¡¨å�Žï¼Œæœ¬åœ°ç¼“å­˜å°†è¢«åˆ é™¤ã€‚\n\nç”¨æˆ·å�¯ä»¥é€‰æ‹© <i class=\"icon-disk\"></i> æŠŠæ­£åœ¨å†™çš„æ–‡ç« ä¿�å­˜åˆ°æœ�åŠ¡å™¨è�‰ç¨¿ç®±ï¼Œå�³ä½¿æ�¢æµ�è§ˆå™¨æˆ–è€…æ¸…é™¤ç¼“å­˜ï¼Œå†…å®¹ä¹Ÿä¸�ä¼šä¸¢å¤±ã€‚\n\n> **æ³¨æ„�ï¼š**è™½ç„¶æµ�è§ˆå™¨å­˜å‚¨å¤§éƒ¨åˆ†æ—¶å€™éƒ½æ¯”è¾ƒå�¯é� ï¼Œä½†ä¸ºäº†æ‚¨çš„æ•°æ�®å®‰å…¨ï¼Œåœ¨è�”ç½‘å�Žï¼Œ**è¯·åŠ¡å¿…å�Šæ—¶å�‘è¡¨æˆ–è€…ä¿�å­˜åˆ°æœ�åŠ¡å™¨è�‰ç¨¿ç®±**', null);
INSERT INTO `tbl_markdown` VALUES ('402880ea5aae3edf015ab22e20740018', '2017-03-09 16:27:31', '0', '2017-03-09 17:29:53', '2', 'BaseFile,Bootstrap-fileinput,é™„ä»¶ä¸Šä¼ ', 'é™„ä»¶ä¸Šä¼ ç»„ä»¶BaseFileä½¿ç”¨è¯´æ˜Ž', '402880e456223e8f015625231d8e0003', '##ä»‹ç»�\nBaseFileæ˜¯AdminEAPæ¡†æž¶ä¸­åŸºäºŽBootstrap-fileinputçš„é™„ä»¶ä¸Šä¼ ç»„ä»¶ï¼Œå®ƒæ”¯æŒ� æ”¯æŒ�å¤šæ–‡ä»¶ã€�åœ¨çº¿é¢„è§ˆã€�æ‹–æ‹½ä¸Šä¼ ç­‰åŠŸèƒ½ï¼Œå°�è£…å�ŽBaseFileä¸»è¦�åŒ…æ‹¬ä»¥ä¸‹åŠŸèƒ½ï¼š\n\n- å¼¹å‡ºçª—å�£çš„é™„ä»¶ä¸Šä¼ \n- å½“å‰�ç•Œé�¢çš„é™„ä»¶ä¸Šä¼ \n- æ˜¾ç¤ºé™„ä»¶æ˜Žç»†\n- å�¯ç¼–è¾‘çš„é™„ä»¶æ˜Žç»†ï¼ˆåˆ é™¤ã€�é¢„è§ˆã€�ä¸�å�¯æ–°å¢žï¼‰\n\nå…³äºŽBaseFileçš„è¯¦ç»†ä½¿ç”¨ï¼Œè¯·å�‚ç…§æœ¬äººå�šå®¢ï¼š[Bootstrap-fileinputç»„ä»¶å°�è£…å�Šä½¿ç”¨ ](blog.csdn.net/jrn1012/article/details/60963714)\nå…³äºŽBootstrap-fileinputçš„APIæ–‡æ¡£å�¯å�‚è€ƒ[http://plugins.krajee.com/file-input](http://plugins.krajee.com/file-input)\n\n##ä½¿ç”¨è¯´æ˜Ž\n###1ã€�åˆ�å§‹åŒ–\nå¦‚æžœéœ€è¦�åœ¨å½“å‰�ç•Œé�¢ä½¿ç”¨é™„ä»¶ä¸Šä¼ åŠŸèƒ½ï¼ˆé�žå¼¹çª—æ–¹å¼�ï¼‰åˆ™éœ€è¦�åœ¨å¤´éƒ¨å¼•å…¥ç›¸å…³çš„csså’Œjsæ–‡ä»¶\n- cssæ–‡ä»¶\n```\n<link rel=\"stylesheet\" href=\"./resources/common/libs/fileinput/css/fileinput.min.css\">\n```\n- jsæ–‡ä»¶\n```\n<script src=\"./resources/common/libs/fileinput/js/fileinput.js\"></script>\n<script src=\"./resources/common/libs/fileinput/js/locales/zh.js\"></script>\n<!--BaseFileç»„ä»¶-->\n<script src=\"./resources/common/js/base-file.js\"></script>\n```\nformè¡¨å�•ä¸Šè¿˜éœ€è¦�é…�ç½®`enctype=\"multipart/form-data\"`å±žæ€§\n\n###2ã€�å¼¹çª—æ–¹å¼�è°ƒç”¨\n\nBaseFileæ”¯æŒ�å¼¹çª—æ–¹å¼�æ‰“å¼€ä¸€ä¸ªé™„ä»¶ä¸Šä¼ çª—å�£ï¼Œç‚¹å‡»é™„ä»¶ä¸Šä¼ å�Žï¼Œå¼¹å‡ºçª—å�£ï¼Œä¸Šä¼ é™„ä»¶å…³é—­çª—å�£å�Žï¼Œä¸Šä¼ çš„é™„ä»¶åœ¨type=fileçš„æŽ§ä»¶å›žå¡«ï¼Œé…�ç½®å¦‚ä¸‹ï¼š\n- htmlä»£ç �\n```\n          <input type=\"hidden\" name=\"fileIds\" id=\"fileIds\">\n          <div class=\"form-group\">\n                <div class=\"btn btn-default btn-file\" id=\"uploadFile\">\n                    <i class=\"fa fa-paperclip\"></i> ä¸Šä¼ é™„ä»¶(Max. 10MB)\n                </div>\n            </div>\n            <div class=\"form-group\" id=\"file_container\">\n                <input type=\"file\" name=\"file\"  id=\"attachment\">\n            </div>    \n```\n- jsä»£ç �\n```javascript\n$(\"#uploadFile\").file({\n            title: \"è¯·ä¸Šä¼ é™„ä»¶\",\n            fileinput: {\n                maxFileSize: 10240,\n                maxFileCount:3\n            },\n            fileIdContainer:\"[name=\'fileIds\']\",\n            showContainer:\'#attachment\',\n            //æ˜¾ç¤ºæ–‡ä»¶ç±»åž‹ edit=å�¯ç¼–è¾‘  detail=æ˜Žç»† é»˜è®¤ä¸ºæ˜Žç»†\n            showType:\'edit\',\n            //å¼¹å‡ºçª—å�£ æ‰§è¡Œä¸Šä¼ é™„ä»¶å�Žçš„å›žè°ƒå‡½æ•°(window:falseä¸�è°ƒç”¨æ­¤æ–¹æ³•)\n			window:true,\n            callback:function(fileIds,oldfileIds){\n                //æ›´æ–°fileIds\n                this.showFiles({\n                    fileIds:fileIds\n                });\n            }\n        });\n```\n###3ã€�æœ¬åœ°ç•Œé�¢è°ƒç”¨\næœ¬åœ°ç•Œé�¢è°ƒç”¨é™„ä»¶ä¸Šä¼ ï¼Œé€šè¿‡ä»¥ä¸‹æ–¹å¼�é…�ç½®ï¼š\n\n- htmlä»£ç �\n```html\n<div class=\"form-group\" id=\"file_container\">\n      <input type=\"file\" name=\"file\"  id=\"attachment\">\n</div>\n```\n- jsä»£ç �\n```javascript\n    $(\"#attachment\").file({\n            fileinput: {\n                maxFileSize: 10240,\n                maxFileCount:3\n            },\n            fileIdContainer:\"[name=\'fileIds\']\",\n            window:false\n        });\n```\n###4ã€�å�‚æ•°è¯´æ˜Ž\n- `window` é»˜è®¤ä¸ºtrue,å¼¹çª—æ–¹å¼�æ‰“å¼€\n\n- `title` window=trueæ—¶é…�ç½®ï¼Œå¼¹çª—çš„æ ‡é¢˜ï¼Œé»˜è®¤ä¸ºâ€œæ–‡ä»¶ä¸Šä¼ â€�\n\n- `width` window=trueæ—¶é…�ç½®ï¼Œå¼¹çª—çš„å®½åº¦ï¼Œé»˜è®¤900\n\n- `winId` window=trueæ—¶é…�ç½®ï¼Œå¼¹å‡ºçš„idï¼Œé»˜è®¤ä¸ºfileWin\n\n- `fileinput` Bootstrap-fileinputçš„é…�ç½®å�‚æ•°ï¼Œä¼šè¦†ç›–é»˜è®¤é…�ç½®ï¼Œæ¯”å¦‚å…�è®¸ä¸Šä¼ å“ªç§�ç±»åž‹çš„é™„ä»¶`allowedFileTypes`ï¼Œå…�è®¸ä¸Šä¼ æœ€å¤§é™„ä»¶å¤§å°�`maxFileSize`ï¼Œå…�è®¸ä¸Šä¼ é™„ä»¶çš„ä¸ªæ•°`maxFileCount`ç­‰ï¼Œå…·ä½“çš„é…�ç½®å�‚æ•°å�¯ä»¥æŸ¥è¯¢Bootstrap-fileinputçš„APIæ–‡æ¡£ã€‚\n\n- `fileIdContainer` å¿…é¡»ï¼Œä¸Šä¼ å�Žçš„é™„ä»¶idå­˜å‚¨çš„ä½�ç½®ï¼Œidä»¥é€—å�·åˆ†éš”\n\n- `showContainer` window=trueå¿…é¡»é…�ç½®ï¼Œæ–‡ä»¶ä¸Šä¼ å�Žå›žå¡«çš„åŒºåŸŸï¼Œwindow=falseæ—¶å¦‚ä¸�é…�ç½®ï¼Œåˆ™å�–base-fileçš„åˆ�å§‹å¯¹è±¡\n\n- `showType` window=trueé…�ç½®ï¼Œå€¼ä¸º`edit`æˆ–è€…`detail`,`edit`è¡¨ç¤ºå›žå¡«å�Žå�¯å¯¹æ•°æ�®è¿›è¡Œåˆ é™¤ã€�é¢„è§ˆï¼Œ`detail`å�ªèƒ½æ˜¾ç¤ºï¼Œä¸�èƒ½åˆ é™¤\n\n- `callback` window=trueé…�ç½®ï¼Œå…³é—­é™„ä»¶ä¸Šä¼ çš„çª—å�£å�Žæ‰§è¡Œçš„å›žè°ƒå‡½æ•°ï¼ˆæ¯”å¦‚æ›´æ–°å½“å‰�çš„æ–‡ä»¶åˆ—è¡¨ï¼‰ï¼Œ`fileIds`,`oldfileIds`ä¸¤ä¸ªå�‚æ•°åˆ†åˆ«æ˜¯æ›´æ–°å�Žæ–‡ä»¶idså’Œæ›´æ–°å‰�çš„æ–‡ä»¶ids\n\n- BaseFileé»˜è®¤é…�ç½®ï¼ŒBaseFileçš„æ›´å¤šå®žçŽ°ï¼Œè¯·æŸ¥çœ‹BaseFileæº�ç �\n```javascript\nBaseFile.prototype.default = {\n        winId: \"fileWin\",\n        width: 900,\n        title: \"æ–‡ä»¶ä¸Šä¼ \",\n        //é€šç”¨æ–‡ä»¶ä¸Šä¼ ç•Œé�¢\n        url: basePath + \"/file/uploader\",\n        //é»˜è®¤æ”¯æŒ�å¤šæ–‡ä»¶ä¸Šä¼ \n        multiple: true,\n        //é»˜è®¤å¼¹å‡ºé™„ä»¶ä¸Šä¼ çª—å�£\n        window:true,\n        showType:\"detail\",\n        fileinput: {\n            language: \'zh\',\n            uploadUrl: basePath + \"/file/uploadMultipleFile\",\n            deleteUrl:basePath+\"/file/delete\",\n            uploadAsync:false,\n            validateInitialCount:true,\n            overwriteInitial: false,\n            allowedPreviewTypes: [\'image\'],\n            previewFileIcon:\'<i class=\"fa fa-file-o\"></i>\',\n            previewFileIconSettings: null,\n            slugCallback: function (text) {\n                var newtext=(!text||text==\'\') ? \'\' : String(text).replace(/[\\-\\[\\]\\/\\{}:;#%=\\(\\)\\*\\+\\?\\\\\\^\\$\\|<>&\"\']/g, \'_\');\n                //åŽ»é™¤ç©ºæ ¼\n                return newtext.replace(/(^\\s+)|(\\s+$)/g,\"\").replace(/\\s/g,\"\");\n            }\n        }\n    }\n```\n\n', 'file');
INSERT INTO `tbl_markdown` VALUES ('402880ed5abdfec1015abe20b0e90000', '2017-03-12 00:08:17', '0', '2017-03-12 00:08:17', '0', 'BaseFile,Bootstrap-fileinput,é™„ä»¶ä¸Šä¼ ,é™„ä»¶ä¸‹è½½', 'é™„ä»¶ä¸Šä¼ ç»„ä»¶BaseFileä½¿ç”¨è¯´æ˜Ž-é™„ä»¶ä¸‹è½½å®žçŽ°', '402880e456223e8f015625231d8e0003', '##ä»‹ç»�\nåœ¨ä¸Šä¸€ç¯‡æ–‡ç« ä¸­ä»‹ç»�äº†Bootstrap-fileinputç»„ä»¶çš„å°�è£…å�Šä½¿ç”¨ï¼Œè¿™ç¯‡æ–‡ç« å»¶ç»­ä¸Šä¸€ç¯‡æ–‡ç« ï¼Œä»‹ç»�äº†åŸºäºŽå°�è£…å�Žçš„ç»„ä»¶BaseFileä¸­ä¸‹è½½åŠŸèƒ½å®žçŽ°ï¼Œä¹Ÿå°±æ˜¯Bootstrap-fileinputä¸­otherActionButtonsä¸­æ‰©å±•è‡ªå®šä¹‰æŒ‰é’®ã€‚å¦‚ä¸‹å›¾æ‰€ç¤ºï¼š\n\n![ä¸‹è½½æŒ‰é’®](http://img.blog.csdn.net/20170311234606744?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n##å®žçŽ°æ­¥éª¤\n\n###1ã€�ä¿®æ”¹fileinput.jsæº�ç �\nï¼ˆfileinput.min.jsä¹Ÿè¦�ç›¸åº”ä¿®æ”¹ï¼‰ï¼Œä¿®æ”¹æ­¤å¤„æ˜¯ä¸ºäº†åœ¨æ–‡ä»¶å°šæœªä¸Šä¼ æ—¶ï¼Œä¸‹è½½æŒ‰é’®ä¸�æ˜¾ç¤ºï¼Œå¦‚ä¸‹å›¾æ‰€ç¤ºï¼š\n![fileinput.jsä»£ç �ä¿®æ”¹](http://img.blog.csdn.net/20170311235027047?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n###2ã€�é…�ç½®ä¸‹è½½æŒ‰é’®\nåœ¨BaseFileæ–‡ä»¶ä¸­ï¼Œé…�ç½®ä¸‹è½½otherActionButtonså±žæ€§ã€‚\n![ä¸‹è½½æŒ‰é’®é…�ç½®](http://img.blog.csdn.net/20170311235325208?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n```\notherActionButtons:\'<button type=\"button\" class=\"kv-file-down btn btn-xs btn-default\" {dataKey} title=\"ä¸‹è½½é™„ä»¶\"><i class=\"fa fa-cloud-download\"></i></button>\',\n```\n###3ã€�ä¸‹è½½æŒ‰é’®äº‹ä»¶ç»‘å®š\nåœ¨æ–‡ä»¶æ˜¾ç¤ºã€�ä¸Šä¼ æ–‡ä»¶æˆ�åŠŸï¼Œæ‰¹é‡�ä¸Šä¼ æ–‡ä»¶æˆ�åŠŸå�Žç»‘å®šä¸‹è½½äº‹ä»¶ï¼Œæ¯�æ¬¡æŠŠå…ˆè§£ç»‘clickäº‹ä»¶å�Žåœ¨ç»‘å®šï¼Œé˜²æ­¢é‡�å¤�ç»‘å®šã€‚\n![ç»‘å®šä¸‹è½½äº‹ä»¶](http://img.blog.csdn.net/20170311235701260?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nç›¸å…³ä»£ç �ï¼š\n\n```javascript\n   BaseFile.prototype.showFiles=function(options){\n        //æ­¤å¤„çœ�ç•¥ä¸€å¤§å †ä»£ç �\n        //console.log(\"config==========\"+JSON.stringify(config));\n        fileComponet.fileinput(\'destroy\');\n        fileComponet.fileinput(config).on(\"filedeleted\",function (event,key) {\n            var newfids=self.deleteFileIds(key,self.options.fileIds);\n            self.options.fileIds=newfids;\n            self.updateFileIds();\n        }).on(\"fileuploaded\",function(event,data,previewId,index){\n            var newfids=self.addFileIds(data.response.fileIds,self.options.fileIds);\n            self.options.fileIds=newfids;\n            self.updateFileIds();\n            //otherActionButtonsç»‘å®šäº‹ä»¶ ä¸‹è½½æŒ‰é’®ç»‘å®š\n            self.downloadHandler(this);\n        }).on(\"filebatchuploadsuccess\",function (event,data,previewId,index) {\n            var newfids=self.addFileIds(data.response.fileIds,self.options.fileIds);\n            self.options.fileIds=newfids;\n            self.updateFileIds();\n            //otherActionButtonsç»‘å®šäº‹ä»¶\n            self.downloadHandler(this);\n        }).on(\"filezoomhidden\", function(event, params) {\n            $(document.body).removeClass(\'modal-open\');\n            $(document.body).css(\"padding-right\",\"0px\");\n        })\n        this.downloadHandler(fileComponet);\n    }\n\n\n    /**\n     * å…¶ä»–æŒ‰é’®ï¼ˆå¦‚ä¸‹è½½ï¼‰ç»‘å®šæ—¶é—´\n     */\n    BaseFile.prototype.downloadHandler=function(fileobj){\n        if(!fileobj)\n            fileobj=$(this.options.showContainer);\n        var objs=$(fileobj).data(\'fileinput\').$preview.find(\".kv-preview-thumb .kv-file-down\");\n        objs.unbind(\"click\");\n        objs.on(\"click\",function(){\n           //ç‚¹å‡»ä¸‹è½½\n            window.location.href=basePath+\"/file/download/\"+$(this).data(\"key\");\n        });\n    }\n```\nå¼¹å‡ºçª—å�£æ–¹å¼�ä¸Šä¼ æ–‡ä»¶ç»‘å®šä¸‹è½½äº‹ä»¶ç±»ä¼¼ï¼Œå�¯åœ¨file_uploader.htmlä¸­æ‰¾åˆ°ç›¸å…³ä»£ç �ã€‚\n\n###4ã€�å�Žå�°ä¸‹è½½æ–‡ä»¶æ–¹æ³•\n\n```java\n  @RequestMapping(value=\"/download/{id}\",method = RequestMethod.GET)\n    public void downloadFile(@PathVariable(\"id\") String id,HttpServletRequest request,HttpServletResponse response) throws IOException {\n        SysFile sysfile = uploaderService.get(SysFile.class, id);\n\n        InputStream is = null;\n        OutputStream os = null;\n        File file = null;\n        try {\n            // PrintWriter out = response.getWriter();\n            if (sysfile != null)\n                file = new File(request.getRealPath(\"/\")+sysfile.getFilePath());\n            if (file != null && file.exists() && file.isFile()) {\n                long filelength = file.length();\n                is = new FileInputStream(file);\n                // è®¾ç½®è¾“å‡ºçš„æ ¼å¼�\n                os = response.getOutputStream();\n                response.setContentType(\"application/x-msdownload\");\n                response.setContentLength((int) filelength);\n                response.addHeader(\"Content-Disposition\", \"attachment; filename=\\\"\" + new String(sysfile.getFileName().getBytes(\"GBK\"),// å�ªæœ‰GBKæ‰�å�¯ä»¥\n                        \"iso8859-1\") + \"\\\"\");\n\n                // å¾ªçŽ¯å�–å‡ºæµ�ä¸­çš„æ•°æ�®\n                byte[] b = new byte[4096];\n                int len;\n                while ((len = is.read(b)) > 0) {\n                    os.write(b, 0, len);\n                }\n            } else {\n                response.getWriter().println(\"<script>\");\n                response.getWriter().println(\" modals.info(\'æ–‡ä»¶ä¸�å­˜åœ¨!\');\");\n                response.getWriter().println(\"</script>\");\n            }\n\n        } catch (IOException e) {\n            // e.printStackTrace();\n        } finally {\n            if (is != null) {\n                is.close();\n            }\n            if (os != null) {\n                os.close();\n            }\n        }\n    }\n```\n\n', null);
INSERT INTO `tbl_markdown` VALUES ('402881935a5f60d3015a5f7d43900000', '2017-02-21 15:05:29', '0', '2017-02-21 15:08:45', '1', 'ä»£ç �ç”Ÿæˆ�å™¨,AdminEAP,AdminLTE,freemarker', 'ä»£ç �ç”Ÿæˆ�å™¨çš„ä½¿ç”¨è¯´æ˜Ž', '402880e456223e8f015625231d8e0003', 'AdminEAPä¸ºæ˜¯åŸºäºŽAdminLTEæ”¹é€ çš„å�Žå�°ç®¡ç�†æ¡†æž¶ï¼ŒåŒ…å�«äº†ç»„ä»¶é›†æˆ�ã€�CURDå¢žåˆ æ”¹æŸ¥ã€�ç³»ç»Ÿå·¥å…·ã€�å·¥ä½œæµ�ã€�ç³»ç»Ÿæ�ƒé™�ä¸Žå®‰å…¨ç­‰åŸºæœ¬çš„ç³»ç»Ÿç®¡ç�†åŠŸèƒ½å’Œå�„ç§�äº¤äº’demoï¼Œé¡¹ç›®æº�ç �å·²ç»�åœ¨Githubä¸Šå¼€æº�ï¼Œå¹¶éƒ¨ç½²åˆ°é˜¿é‡Œäº‘ã€‚\n\n**Github** : https://github.com/bill1012/AdminEAP\n\n**AdminEAP å®˜ç½‘**: http://www.admineap.com\n\næœ¬æ–‡ä»‹ç»�ä½¿ç”¨freemarkeræ¨¡æ�¿ï¼Œåœ¨AdminEAPæ¡†æž¶ä¸‹å®žçŽ°ä»£ç �ç”Ÿæˆ�å™¨ï¼Œä»¥å®žçŽ°CURDåŠŸèƒ½çš„å¿«é€Ÿç”Ÿæˆ�ï¼Œå€ŸåŠ©äºŽä»£ç �ç”Ÿæˆ�å™¨ï¼ŒåŸºç¡€çš„å¼€å�‘å�¯ä»¥èŠ‚çº¦å¤§é‡�çš„æ—¶é—´ï¼Œå�Œæ—¶ä¿�æŒ�äº†ç¼–ç �çš„ä¸€è‡´æ€§ã€‚\n\n![è¿™é‡Œå†™å›¾ç‰‡æ��è¿°](http://img.blog.csdn.net/20170221133333679?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n#ä½¿ç”¨æ­¥éª¤\n\nä¸‹é�¢ä»¥Generatorå®žä½“ä¸ºä¾‹ï¼Œä»‹ç»�ä»£ç �ç”Ÿæˆ�å™¨çš„ä½¿ç”¨\n\n##1ã€�ç¼–å†™å®žä½“ç±»\n\nç¼–å†™å®žä½“ç±»ï¼Œé€šè¿‡è‡ªå®šä¹‰æ³¨è§£Headerå£°æ˜Žç›¸å…³å±žæ€§\n\n![ç¼–å†™å®žä½“ç±»](http://img.blog.csdn.net/20170221142700625?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nHeaderä¸ºè‡ªå®šä¹‰æ³¨è§£ï¼Œå¼€å�‘è€…åœ¨å»ºç«‹å¤–é”®å…³ç³»æ—¶ï¼Œå�¯é€šè¿‡ManyToOneï¼Œä¹Ÿé€šè¿‡joinClassæŒ‡å®šå…³è�”çš„å®žä½“ï¼ŒdataSourceæŒ‡å®šäº†åœ¨ç¼–è¾‘æ—¶ï¼Œè¯¥å±žæ€§çš„æ•°æ�®æ�¥æº�ï¼Œå½“ä¸ºå­—å…¸æ—¶ï¼ŒæŒ‡å®šä¸ºå­—å…¸çˆ¶ç¼–ç �ï¼Œä¹Ÿå�¯ä»¥æŒ‡å®šä¸€ä¸ªurlã€‚\n\n##2ã€�ç”Ÿæˆ�xmlé…�ç½®\n\nå�¯åŠ¨é¡¹ç›®å�Žï¼Œè¾“å…¥queryIdï¼Œå®žä½“å��ï¼Œä¸šåŠ¡å��ï¼Œç‚¹å‡»â€œåŠ è½½é…�ç½®â€œï¼Œå¼¹å‡ºxmlé…�ç½®çª—å�£ï¼Œå�¯åœ¨æ­¤é…�ç½®çª—å�£é…�ç½®æŸ¥è¯¢xml\n\n![ç”Ÿæˆ�xml](http://img.blog.csdn.net/20170221144007125?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nAdminEAPçš„æ‰€æœ‰æ•°æ�®åˆ—è¡¨éƒ½æ˜¯åŸºäºŽxmlé…�ç½®çš„ï¼Œå�¯æ”¯æŒ�å��å°„æŽ¥å�£æŸ¥è¯¢ã€�sqlé…�ç½®çš„æŸ¥è¯¢ã€�ç¦»çº¿æŸ¥è¯¢ï¼ˆhqlï¼‰ã€‚\n\n##3ã€�é‡�å�¯ç³»ç»Ÿä½¿xmlé…�ç½®ç”Ÿæ•ˆ\n\nå¦‚æžœæ˜¯é¦–æ¬¡ç”Ÿæˆ�xmlæ–‡ä»¶ï¼ˆæ³¨æ„�æ˜¯æ–‡ä»¶ï¼Œå¦‚æžœåœ¨å·²æœ‰çš„xmlé…�ç½®å†…å®¹ï¼Œåˆ™ä¸�éœ€è¦�é‡�æ–°ï¼Œåˆ·æ–°ç³»ç»Ÿå�³å�¯ï¼Œç³»ç»Ÿä¼šè¯»å�–æ›´æ–°çš„xmlï¼‰\n\n![é…�ç½®xml](http://img.blog.csdn.net/20170221144603370?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n##4ã€�é…�ç½®å…·ä½“å�‚æ•°\n\nè¾“å…¥queryIdï¼Œç‚¹å‡»â€�åŠ è½½é…�ç½®â€œå�Žï¼Œç³»ç»Ÿè¯»å�–xmlçš„é…�ç½®ï¼Œå¹¶å›žå¡«æ‰€æœ‰çš„é»˜è®¤é…�ç½®ï¼ŒåŒ…æ‹¬è¦�ç”Ÿæˆ�çš„æ–‡ä»¶ï¼Œæ–‡ä»¶è·¯å¾„ç­‰ç­‰ï¼Œå¼€å�‘è€…ä¹Ÿå�¯ä»¥æ ¹æ�®è‡ªå·±çš„éœ€è¦�æ›´æ”¹å�‚æ•°é…�ç½®ã€‚åœ¨ç•Œé�¢å�³ä¾§æ˜¯å®žä½“çš„å±žæ€§åˆ—è¡¨ï¼Œå¼€å�‘è€…å�¯ä»¥å‹¾é€‰æ•°æ�®å†�ç¼–è¾‘æ—¶ä½¿ç”¨çš„æŽ§ä»¶ç±»åž‹ï¼Œä¹Ÿå�¯ä»¥å‹¾é€‰æ˜¯æ˜¯å�¦ä½œä¸ºæŸ¥è¯¢æ�¡ä»¶ï¼Œæ˜¯å�¦åœ¨ç¼–è¾‘ç•Œé�¢ä¸­ç»´æŠ¤ç­‰ç­‰ã€‚\n\n![é…�ç½®å…·ä½“å�‚æ•°](http://img.blog.csdn.net/20170221145011918?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\næ›´å…·ä½“é…�ç½®è¯´æ˜Žï¼ŒåŒ…å�«åœ¨ä»Šå�Žçš„æŠ€æœ¯æ–‡æ¡£ï¼ˆä»˜è´¹ï¼‰ä¸­\n\n##5ã€�æ ¹æ�®freemarkeræ¨¡æ�¿ç”Ÿæˆ�ä»£ç �\n\nä»Žç•Œé�¢ä¸Šæ”¶é›†å¥½ä»¥ä¸Šé…�ç½®å�‚æ•°å�Žï¼Œä»£ç �ç”Ÿæˆ�å™¨å°†è¿™äº›å�‚æ•°ç»™é…�ç½®å¥½çš„freemarkeræ¨¡æ�¿ï¼Œç”Ÿæˆ�ç›¸å…³çš„æº�ä»£ç �ã€‚\n\nä»¥ä¸‹æ˜¯æŽ§åˆ¶å™¨æ¨¡æ�¿controller.html\n```\npackage ${nameSpace}.controller;\n\nimport java.util.Date;\n\nimport javax.annotation.Resource;\nimport javax.servlet.http.HttpServletRequest;\n\nimport com.alibaba.fastjson.JSON;\nimport com.cnpc.framework.base.entity.Dict;\nimport com.cnpc.framework.utils.StrUtil;\nimport org.springframework.beans.BeanUtils;\nimport org.springframework.stereotype.Controller;\nimport org.springframework.web.bind.annotation.PathVariable;\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RequestMethod;\nimport org.springframework.web.bind.annotation.ResponseBody;\n\nimport com.cnpc.framework.base.service.BaseService;\nimport com.cnpc.framework.annotation.RefreshCSRFToken;\nimport com.cnpc.framework.annotation.VerifyCSRFToken;\nimport com.cnpc.framework.base.pojo.Result;\nimport ${className};\n\n/**\n* ${modelName}ç®¡ç�†æŽ§åˆ¶å™¨\n* @author jrn\n* ${curTime?string(\"yyyy-MM-dd HH:mm:ss\")}ç”±ä»£ç �ç”Ÿæˆ�å™¨è‡ªåŠ¨ç”Ÿæˆ�\n*/\n@Controller\n@RequestMapping(\"/${htmlPrefix}\")\npublic class ${javaPrefix}Controller {\n\n    @Resource\n    <#if javaTypes?contains(\"service\")>\n    private ${javaPrefix}Service ${htmlPrefix}Service;\n    <#else>\n    private BaseService baseService;\n    </#if>\n\n    @RequestMapping(value=\"/list\",method = RequestMethod.GET)\n    public String list(){\n        return \"${businessPackage}/${htmlPrefix}_list\";\n    }\n\n    @RefreshCSRFToken\n    @RequestMapping(value=\"/edit\",method = RequestMethod.GET)\n    public String edit(String id,HttpServletRequest request){\n        request.setAttribute(\"id\", id);\n        return \"${businessPackage}/${htmlPrefix}_edit\";\n    }\n\n    @RequestMapping(value=\"/detail\",method = RequestMethod.GET)\n    public String detail(String id,HttpServletRequest request){\n        request.setAttribute(\"id\", id);\n        return \"${businessPackage}/${htmlPrefix}_detail\";\n    }\n\n    @RequestMapping(value=\"/get/{id}\",method = RequestMethod.POST)\n    @ResponseBody\n    public ${javaPrefix} get(@PathVariable(\"id\") String id){\n        return <#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.get(${javaPrefix}.class, id);\n    }\n\n    @VerifyCSRFToken\n    @RequestMapping(value=\"/save\")\n    @ResponseBody\n    <#assign isObj=1>\n    <#list fields as field>\n        <#if field.columnName?contains(\".\")>\n            <#assign isObj=0>\n        </#if>\n    </#list>\n    public Result save(<#if isObj=1>${javaPrefix} ${htmlPrefix}<#else>String obj</#if>){\n        <#if isObj=0>\n        ${javaPrefix} ${htmlPrefix}= JSON.parseObject(obj,${javaPrefix}.class);\n        <#list fields as field>\n        <#if field.columnName?contains(\".\")>\n            <#assign fieldName=field.columnName?substring(0,field.columnName?index_of(\".\"))>\n            <#assign fieldN=fieldName?substring(0,1)?upper_case+fieldName?substring(1)>\n        ${htmlPrefix}.set${fieldN}(<#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.get(${field.type}.class,${htmlPrefix}.get${fieldN}().getId()));\n        </#if>\n        </#list>\n        </#if>\n        if(StrUtil.isEmpty(${htmlPrefix}.getId())){\n        <#if dateFields?exists&&(dateFields?size>0)>\n            <#list dateFields as date>\n            ${date};\n            </#list>\n        </#if>\n            <#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.save(${htmlPrefix});\n        }\n        else{\n        <#if leftFields?exists&&(leftFields?size>0)>\n            ${javaPrefix} ${htmlPrefix}_old=<#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.get(${javaPrefix}.class,${htmlPrefix}.getId());\n            BeanUtils.copyProperties(${htmlPrefix},${htmlPrefix}_old, <#list leftFields as str><#if str_index==0>\"${str}\"<#else>,\"${str}\"</#if></#list>);\n            <#if leftDates?exists&&(leftDates?size>0)>\n                <#list leftDates as ld>\n             ${ld};\n                </#list>\n            </#if>\n            ${htmlPrefix}_old.setUpdateDateTime(new Date());\n            <#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.update(${htmlPrefix}_old);\n            <#else>\n            ${htmlPrefix}.setUpdateDateTime(new Date());\n            <#if javaTypes?contains(\"service\")>${htmlPrefix}Service<#else>baseService</#if>.update(${htmlPrefix});\n            </#if>\n        }\n        return new Result(true);\n    }\n    \n    @RequestMapping(value=\"/delete/{id}\",method = RequestMethod.POST)\n    @ResponseBody\n    public Result delete(@PathVariable(\"id\") String id){\n        ${javaPrefix} ${htmlPrefix}=this.get(id);\n        try{\n            baseService.delete(${htmlPrefix});\n            return new Result();\n        }\n        catch(Exception e){\n            return new Result(false,\"è¯¥æ•°æ�®å·²ç»�è¢«å¼•ç”¨ï¼Œä¸�å�¯åˆ é™¤\");\n        }\n    }\n\n}\n\n```\n\n##6ã€�ä¿®æ”¹ç”Ÿæˆ�çš„ä»£ç �å¹¶é‡�å�¯ç³»ç»ŸæŸ¥çœ‹æ•ˆæžœ\n\nå¼€å�‘è€…æ ¹æ�®éœ€è¦�ä¿®æ”¹ç”Ÿæˆ�çš„ä»£ç �ï¼Œå¹¶é‡�å�¯ç³»ç»Ÿï¼ŒæŸ¥çœ‹æ•ˆæžœï¼Œå¦‚æžœéœ€è¦�åˆ†é…�æ�ƒé™�ï¼Œè¯·å…ˆå°†ç”Ÿæˆ�çš„è�œå�•åŠŸèƒ½æŽˆæ�ƒï¼Œæ‰�å�¯æœ‰ç›¸åº”çš„è�œå�•ã€‚\n\n![ä»£ç �ç”Ÿæˆ�å™¨-åˆ—è¡¨](http://img.blog.csdn.net/20170221145826165?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n![ä»£ç �ç”Ÿæˆ�-ç¼–è¾‘](http://img.blog.csdn.net/20170221145859391?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\né€šè¿‡ä»£ç �ç”Ÿæˆ�ç”Ÿæˆ�äº†ä¸€ä¸ªä¸šåŠ¡åŠŸèƒ½çš„CURDæ“�ä½œã€‚\n\n##7ã€�æ€»ç»“\n\nä»¥ä¸Šæ“�ä½œæ­¥éª¤ï¼Œåœ¨å¼€å�‘çŽ¯å¢ƒä½¿ç”¨ï¼Œåœ¨é¡¹ç›®ä¸­ä½¿ç”¨ä»£ç �ç”Ÿæˆ�å™¨çš„ä¸»è¦�å·¥ä½œé‡�åœ¨ç¼–å†™å®žä½“ï¼Œä¸¤æ¬¡é‡�å�¯ç³»ç»Ÿï¼ˆå¦‚æžœåœ¨ä¹‹å‰�xmlè¿½åŠ å†…å®¹ï¼Œåˆ™æ˜¯ä¸€æ¬¡é‡�å�¯ï¼‰ä¸Šï¼Œå…¶ä½™é‡‡ç”¨é»˜è®¤é…�ç½®å�³å�¯ã€‚\n\næ¬¢è¿Žå¤§å®¶ä½¿ç”¨AdminEAPæ¡†æž¶ï¼Œå¦‚æœ‰æ„�è§�å»ºè®®è¯·ç™»å½•[AdminEAPå®˜ç½‘](http://www.admineap.com)ç»™æˆ‘æ��æ„�è§�ã€‚\n\n\n', 'code');
INSERT INTO `tbl_markdown` VALUES ('8a8a81425a118296015a118d0fda0000', '2017-02-06 11:52:21', '0', '2017-02-06 14:36:07', '3', 'Bootstrap modal,æ¨¡æ€�çª—ä½“', 'æ¨¡æ€�çª—ä½“Modalsä½¿ç”¨è¯´æ˜Ž', '402880e456223e8f015625231d8e0003', '##åŠŸèƒ½è¯´æ˜Ž\nåœ¨AdminEAPæ¡†æž¶ä¸­ï¼Œå°�è£…äº†Bootstrap modalçª—ä½“ï¼Œæ��ä¾›ä»¥ä¸‹åŠŸèƒ½\n- info(æ��ç¤º)\n- correct(æˆ�åŠŸ)\n- warn(è­¦å‘Š)\n- error(é”™è¯¯)\n- confirm(ç¡®è®¤)\n- popup(æ��ç¤ºï¼Œæ— æŒ‰é’®)\n- openWin(æ¨¡æ€�çª—ä½“)\n\n##ä½¿ç”¨ç¤ºä¾‹\nå¼•å…¥æ–‡ä»¶\n`<script type=\"text/javascript\" src=\"${basePath}/resources/common/js/base-modal.js\"></script>`\n###1.æ��ç¤º\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-info\' data-btn-type=\'info\' onclick=\'modals.info(\"æ��ç¤ºä¿¡æ�¯\")\'>æ��ç¤º</button>\n</div>\n\n```\n<button class=\'btn btn-info\' data-btn-type=\'info\' onclick=\'info()\'>æ��ç¤º</button>\n\n<script>\n  function info(){\n     modals.info(\'æ��ç¤ºä¿¡æ�¯\');\n  }\n</script>\n```\n###2.æˆ�åŠŸ\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-success\' data-btn-type=\'success\' onclick=\'modals.correct(\"æ“�ä½œæˆ�åŠŸä¿¡æ�¯\")\'>æˆ�åŠŸ</button>\n</div>\n\n```\n<button class=\'btn btn-success\' data-btn-type=\'success\' onclick=\'correct()\'>æˆ�åŠŸ</button>\n\n<script>\n  function correct(){\n     modals.correct(\'æ“�ä½œæˆ�åŠŸä¿¡æ�¯\');\n  }\n</script>\n```\n###3.è­¦å‘Š\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-warning\' data-btn-type=\'warn\' onclick=\'modals.warn(\"è­¦å‘Šä¿¡æ�¯\")\'>è­¦å‘Š</button>\n</div>\n\n```\n<button class=\'btn btn-warning\' data-btn-type=\'warn\' onclick=\'warn()\'>è­¦å‘Š</button>\n\n<script>\n  function warn(){\n     modals.warn(\'è­¦å‘Šä¿¡æ�¯\');\n  }\n</script>\n```\n###4.é”™è¯¯\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-danger\' data-btn-type=\'error\' onclick=\'modals.error(\"é”™è¯¯æ��ç¤ºä¿¡æ�¯\")\'>é”™è¯¯</button>\n</div>\n\n```\n<button class=\'btn btn-danger\' data-btn-type=\'error\' onclick=\'error()\'>é”™è¯¯</button>\n\n<script>\n  function error(){\n     modals.error(\'é”™è¯¯æ��ç¤ºä¿¡æ�¯\');\n  }\n</script>\n```\n###5.ç¡®è®¤æ��ç¤ºæ¡†\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-primary\' data-btn-type=\'confirm\' onclick=\'modals.confirm(\"é”™è¯¯æ��ç¤ºä¿¡æ�¯\",function(){alert(\"do something\")})\'>ç¡®è®¤æ��ç¤ºæ¡†</button>\n</div>\n\n```\n<button class=\'btn btn-primary\' data-btn-type=\'confirm\' onclick=\'confirm()\'>ç¡®è®¤æ��ç¤ºæ¡†</button>\n\n<script>\n  function confirm(){\n     modals.confirm(\'é”™è¯¯æ��ç¤ºä¿¡æ�¯\'ï¼Œfunction(){\n	    alert(\'do something\');\n	 });\n  }\n</script>\n```\n###6.è‡ªå®šä¹‰æ¨¡æ€�çª—å�£\n<div style=\"padding-bottom:20px;\">\n<button class=\'btn btn-info\' data-btn-type=\'window\' onclick=\'modals.openWin({winId:\"userWin\", title:\"æ–°å¢žç”¨æˆ·\", width:\"900px\", url:basePath+\"/user/edit\"})\'>è‡ªå®šä¹‰æ¨¡æ€�çª—å�£</button>\n</div>\n\n```\n<button class=\'btn btn-info\' data-btn-type=\'window\' onclick=\'openWin()\'>è‡ªå®šä¹‰æ¨¡æ€�çª—å�£</button>\n\n<script>\n  function openWin(){\n     modals.openWin({\n	    winId:\'userWin\',\n        title:\'æ–°å¢žç”¨æˆ·\',\n        width:\'900px\',\n        url:basePath+\"/user/edit\"\n	 });\n  }\n</script>\n```\n\n <button class=\"btn btn-primary\" id=\"btn_msg\" style=\"width: 100%\" onclick=\'modals.openWin({ \n                winId:\"messageWin\",\n                title:\"ç»™ã€�billJiangã€‘ç•™è¨€\",\n                width:\"750px\",\n                url:basePath+\"/message/mail/edit\"\n            });\'><i class=\"fa fa-commenting\"></i>&nbsp;&nbsp;æˆ‘æ˜¯billJiangï¼Œå¦‚æžœæœ‰ä»»ä½•æ„�è§�/å»ºè®®/åˆ›æ„�/é—®é¢˜/æƒ³æ³•ï¼Œç‚¹å‡»è¯¥æŒ‰é’®ç»™æˆ‘ç•™è¨€</button>\n', 'modal');
INSERT INTO `tbl_markdown` VALUES ('8a8a826c5ac5e9a4015ac65cc9630000', '2017-03-13 14:30:54', '0', '2017-03-13 15:03:48', '1', 'CSRF,AdminEAP', 'AdminEAPæ¡†æž¶é˜²èŒƒCSRF', '402880e456223e8f015625231d8e0003', '##ä»‹ç»�\n\nCSRFï¼ˆCross-site request forgeryè·¨ç«™è¯·æ±‚ä¼ªé€ ï¼Œä¹Ÿè¢«ç§°ä¸ºâ€œOne Click Attackâ€�æˆ–è€…Session Ridingï¼Œé€šå¸¸ç¼©å†™ä¸ºCSRFæˆ–è€…XSRFï¼Œæ˜¯ä¸€ç§�å¯¹ç½‘ç«™çš„æ�¶æ„�åˆ©ç”¨ã€‚å°½ç®¡å�¬èµ·æ�¥åƒ�è·¨ç«™è„šæœ¬ï¼ˆXSSï¼‰ï¼Œä½†å®ƒä¸ŽXSSé�žå¸¸ä¸�å�Œï¼Œå¹¶ä¸”æ”»å‡»æ–¹å¼�å‡ ä¹Žç›¸å·¦ã€‚XSSåˆ©ç”¨ç«™ç‚¹å†…çš„ä¿¡ä»»ç”¨æˆ·ï¼Œè€ŒCSRFåˆ™é€šè¿‡ä¼ªè£…æ�¥è‡ªå�—ä¿¡ä»»ç”¨æˆ·çš„è¯·æ±‚æ�¥åˆ©ç”¨å�—ä¿¡ä»»çš„ç½‘ç«™ã€‚ä¸ŽXSSæ”»å‡»ç›¸æ¯”ï¼ŒCSRFæ”»å‡»å¾€å¾€ä¸�å¤§æµ�è¡Œï¼ˆå› æ­¤å¯¹å…¶è¿›è¡Œé˜²èŒƒçš„èµ„æº�ä¹Ÿç›¸å½“ç¨€å°‘ï¼‰å’Œéš¾ä»¥é˜²èŒƒï¼Œæ‰€ä»¥è¢«è®¤ä¸ºæ¯”XSSæ›´å…·å�±é™©æ€§ã€‚\n\næœ¬æ–‡ä»‹ç»�åœ¨AdminEAPæ¡†æž¶ä¸‹ï¼Œå¦‚ä½•é˜²èŒƒCSRFã€‚\n\n##æ€�è·¯\n\nå…·ä½“æ€�è·¯ï¼š\n\n1ã€�è·³è½¬é¡µé�¢å‰�ç”Ÿæˆ�éš�æœºtokenï¼Œå¹¶å­˜æ”¾åœ¨sessionä¸­\n\n2ã€�formä¸­å°†tokenæ”¾åœ¨éš�è—�åŸŸä¸­ï¼Œä¿�å­˜æ—¶å°†tokenæ”¾å¤´éƒ¨ä¸€èµ·æ��äº¤\n\n3ã€�èŽ·å�–å¤´éƒ¨tokenï¼Œä¸Žsessionä¸­çš„tokenæ¯”è¾ƒï¼Œä¸€è‡´åˆ™é€šè¿‡ï¼Œå�¦åˆ™ä¸�äºˆæ��äº¤\n\n4ã€�ç”Ÿæˆ�æ–°çš„tokenï¼Œå¹¶ä¼ ç»™å‰�ç«¯\n\n##å®žçŽ°\n1ã€�Spring MVCä¸­é…�ç½®æ‹¦æˆªå™¨ï¼š\n```xml\n<mvc:interceptors>\n	    <!-- csrfæ”»å‡»é˜²å¾¡ -->\n		<mvc:interceptor>\n			<!-- éœ€æ‹¦æˆªçš„åœ°å�€ -->\n			<mvc:mapping path=\"/**\" />\n			<!-- éœ€æŽ’é™¤æ‹¦æˆªçš„åœ°å�€ -->\n			<mvc:exclude-mapping path=\"/resources/**\" />\n			<mvc:exclude-mapping path=\"/uploadPath/**\" />\n			<!-- <mvc:exclude-mapping path=\"/user/user_login\" />\n			<mvc:exclude-mapping path=\"/user/login\" /> -->\n			<bean class=\"com.cnpc.framework.interceptor.CSRFInterceptor\" />\n		</mvc:interceptor>\n	</mvc:interceptors>\n```\n2ã€�æ‹¦æˆªå™¨çš„å…·ä½“å®žçŽ°ï¼š(å…·ä½“å®žçŽ°ä»£ç �è¯¦è§�CSRFInterceptor.java)\n\n1ï¼‰è¿›å…¥æ–¹æ³•ä¹‹å‰�ï¼Œæ ¡éªŒCSRFï¼Œæ ¡éªŒå¤±è´¥ï¼Œåˆ·æ–°csrftokenï¼Œå�‘å‰�ç«¯æŠ›å‡ºé”™è¯¯ä¿¡æ�¯\n>åœ¨preHandleræ–¹æ³•ä¸Šè¯»å�–verifyCSRFTokenæ³¨è§£é…�ç½®ï¼Œå¦‚æžœæœªé…�ç½®ç›´æŽ¥é€šè¿‡éªŒè¯�ï¼Œå¦‚æžœé…�ç½®äº†ï¼Œä¸ºGETé¡µé�¢è·³è½¬è¯·æ±‚ï¼ˆä¸�å�«@ResponseBodyï¼‰åˆ™åˆ·æ–°sessionä¸­çš„csrftoken,å¹¶å�‘å‰�ç«¯å¼¹å‡ºé”™è¯¯ä¿¡æ�¯ã€‚å¦‚æžœä¸ºajaxè¯·æ±‚ï¼Œåˆ·æ–°sessionä¸­csrftokenï¼Œå¹¶å°†æ–°çš„csrftokenå†™å…¥responseBody,å¹¶åœ¨å‰�ç«¯$.ajaxæ–¹æ³•ä¸­successæ–¹æ³•ä¸­è¿›è¡Œå¤„ç�†å’Œæ��ç¤º(åœ¨successå¤„ç�†tokenä¸�ä¸€è‡´)\n\n```javascript\n$.ajax({\n		type : \'post\',\n		async : false,\n		url : url,\n		data : params,\n		dataType : \'json\',\n		headers:headers,\n		success : function(data, status) {\n			result = data;\n			if(data&&data.code&&data.code==\'101\'){\n				modals.error(\"æ“�ä½œå¤±è´¥ï¼Œè¯·åˆ·æ–°é‡�è¯•ï¼Œå…·ä½“é”™è¯¯ï¼š\"+data.message);\n				return false;\n			}\n			if (callback) { \n				callback.call(this, data, status);\n			}\n		},\n		error : function(err, err1, err2) {\n			console.log(err.responseText);\n		    if(err && err.readyState && err.readyState == \'4\'){\n                var responseBody = err.responseText;\n                if(responseBody){   \n                	 responseBody = \"{\'retData\':\"+responseBody;\n                     var resJson = eval(\'(\' + responseBody + \')\');\n                     $(\"#csrftoken\").val(resJson.csrf.CSRFToken);\n                     this.success(resJson.retData, 200);\n                }\n                return ;\n            } 		    \n			modals.error({\n				text : JSON.stringify(err) + \'<br/>err1:\' + JSON.stringify(err1) + \'<br/>err2:\' + JSON.stringify(err2),\n				large : true\n			});\n		}\n	});\n```\n2ï¼‰æ ¡éªŒCSRFæˆ�åŠŸå�Žï¼Œåœ¨postHandlerä¸­åˆ·æ–°csrftoken\n>è¯»å�–RefreshCSRFTokenæ³¨è§£ï¼Œå¦‚æžœé…�ç½®äº†è¯¥æ³¨è§£åˆ·æ–°sessionä¸­çš„csrftokenï¼Œå¦‚æžœé…�ç½®äº†VerifyCSRFTokenæ³¨è§£ï¼Œåˆ·æ–°å‰�ç«¯csrftoken(é˜²æ­¢é‡�å¤�æ��äº¤)ï¼Œåœ¨ajaxPostçš„errorä¸­å¤„ç�†åˆ·æ–°å�Žçš„csrftokenï¼Œå›žå¡«åˆ°é¡µé�¢ã€‚\n\n##å®žä¾‹\nç”¨æˆ·ç¼–è¾‘ï¼Œç”¨æˆ·ç¼–è¾‘å‰�åˆ·æ–°csrftoken,æ��äº¤æ—¶æ ¡éªŒï¼Œå¦‚æžœå¤šæ¬¡æ��äº¤ï¼Œåˆ™å¼¹å‡ºé”™è¯¯æ��ç¤ºï¼š\n`CSRF ERROR:æ— æ•ˆçš„tokenï¼Œæˆ–è€…tokenè¿‡æœŸ`\n```java \n    @RefreshCSRFToken\n    @RequestMapping(method = RequestMethod.GET, value = \"/edit\")\n    private String edit(String id, HttpServletRequest request) {\n\n        request.setAttribute(\"id\", id);\n        return \"base/user/user_edit\";\n    }\n\n    @VerifyCSRFToken\n    @RequestMapping(method = RequestMethod.POST, value = \"/save\")\n    @ResponseBody\n    private Result saveUser(User user, HttpServletRequest request) {\n        if (StrUtil.isEmpty(user.getId())) {\n            String userId = userService.save(user).toString();\n            //å¤´åƒ�å’Œç”¨æˆ·ç®¡ç�†\n            userService.updateUserAvatar(user, request.getRealPath(\"/\"));\n        } else {\n            user.setUpdateDateTime(new Date());\n            userService.update(user);\n        }\n        return new Result(true);\n    }\n\n```\n', 'csrf');
INSERT INTO `tbl_markdown` VALUES ('8a8a826c5ac5e9a4015ac67d02e00001', '2017-03-13 15:06:05', '0', '2017-03-13 15:58:37', '2', 'render,fnRender,tooltip', 'AdminEAPæ¡†æž¶æ•°æ�®åˆ—è¡¨renderçš„äº”ç§�æ–¹å¼�', '402880e456223e8f015625231d8e0003', '##ä»‹ç»�\nåœ¨AdminEAPæ¡†æž¶ä¸­ï¼Œæ•°æ�®åˆ—è¡¨ä½¿ç”¨Bootstrap-DataTablesç»„ä»¶ï¼ˆåŸºäºŽJquery-DataTablesï¼‰,åœ¨AdminEAPæ¡†æž¶ä¸­è¿›è¡ŒäºŒæ¬¡å°�è£…ï¼Œå…¶ä¸­æœ‰äº›æ•°æ�®åˆ—éœ€è¦�åœ¨åŽŸæ�¥çš„æ•°æ�®åŸºç¡€ä¸Šè¿›è¡ŒäºŒæ¬¡æ¸²æŸ“ï¼Œåˆ†åˆ«æ”¯æŒ�ä»¥ä¸‹å‡ ç§�æ–¹å¼�ï¼š\n- render ï¼ˆtype=eqï¼‰ å›ºå®šå€¼çš„\'ç¿»è¯‘\'\n- render (type=window) å¼¹å‡ºçª—ä½“\n- render (type=link)  è¶…é“¾æŽ¥\n- tooltip é¼ æ ‡æ‚¬å�œæ��ç¤º\n- fnRender æ¸²æŸ“å›žè°ƒå‡½æ•°\n\n##xmlé…�ç½®ç¤ºä¾‹\nä»¥ä¸‹æ˜¯ä»¥ä¸Šå‡ ä¸ªå±žæ€§åœ¨xmlé…�ç½®ä¸­çš„ç¤ºä¾‹å’Œéƒ¨åˆ†è¯´æ˜Žã€‚\n```xml\n <query id=\"message_draft\" key=\"id\" tableName=\"æˆ‘çš„è�‰ç¨¿ç®±\" className=\"com.cnpc.tool.message.entity.Message\" widthType=\"px\">\n        <column key=\"rowIndex\" header=\"åº�å�·\" width=\"80\"/>\n        <column key=\"id\" header=\"id\" hidden=\"true\"/>\n        <column key=\"sendUser\" header=\"å�‘é€�äºº\" hidden=\"true\" classType=\"String\" allowSort=\"false\" width=\"150\"/>\n        <!--enableTootip(æ˜¯å�¦æ˜¾ç¤º) maxLen(æœ€å¤§é•¿åº¦é»˜è®¤10ï¼Œå�¯åœ¨dataTables.jsä¿®æ”¹é»˜è®¤å€¼) tooltipï¼ˆæŒ‡å®štooltipæ�¥æº�ï¼Œå�¯ä¸�é…�ï¼Œç¼ºçœ�ä¸ºæœ¬èº«ï¼‰ é•¿æ–‡æœ¬é¼ æ ‡æ‚¬å�œæ˜¾ç¤º-->\n        <!--å¼¹çª—æ–¹å¼�render=\"type=window\"ä½¿ç”¨;æ‰€éœ€å�‚æ•°å�Œmodals.openWinçš„å�‚æ•°-->\n        <!--<column key=\"sendSubject\" header=\"ä¸»é¢˜\" classType=\"String\" align=\"left\" render=\"type=window,winId=messageEditWin,url=/message/edit?id=[id],title=å¼¹çª—æµ‹è¯•[sendSubject]\" enableTooltip=\"true\" maxLen=\"20\" allowSort=\"true\" width=\"150\"/>-->\n        <!--è¶…é“¾æŽ¥æ–¹å¼� render=\"type=link\",methodæ–¹æ³•å��ç§°ï¼Œparamsæ–¹æ³•å�‚æ•°,åˆ†å�·;åˆ†éš”ï¼Œå¦‚ä¸�éœ€è¦�å�‚æ•°paramsä¸ºå�¯ä¸ºç©ºï¼Œé»˜è®¤æ³¨å…¥rowId-->\n        <!--<column key=\"sendSubject\" header=\"ä¸»é¢˜\" classType=\"String\" align=\"left\" render=\"type=link,method=loadPage,params=\'/message/edit?id=[id]\';\'#contentBody\'\" enableTooltip=\"true\" maxLen=\"20\" allowSort=\"true\" width=\"150\"/>-->\n        <column key=\"sendSubject\" header=\"ä¸»é¢˜\" classType=\"String\" align=\"left\" render=\"type=link,method=showDetail\" enableTooltip=\"true\" maxLen=\"20\" allowSort=\"true\" width=\"150\"/>    \n        <column key=\"sendTime\" header=\"å�‘é€�æ—¶é—´\" classType=\"Date\" allowSort=\"true\" dateFormat=\"yyyy-mm-dd hh:ii\"  operator=\"between\" width=\"150\"/>\n        <column key=\"messageType\" header=\"ç±»åž‹\" classType=\"String\" align=\"left\" width=\"50\" fnRender=\"fnRenderMessageType\"/>\n        <!--isServerCondition=true value=0æ³¨å…¥æœ�åŠ¡å™¨ç«¯æŸ¥è¯¢æ�¡ä»¶ï¼Œä¹Ÿå�¯åœ¨å‰�ç«¯ä»¥type=hiddenéš�è—�åŸŸçš„æ–¹å¼�æ³¨å…¥-->\n        <column key=\"messageStatus\" header=\"çŠ¶æ€�\" isServerCondition=\"true\" value=\"0\" classType=\"String\" allowSort=\"false\" width=\"50\" fnRender=\"fnRenderMessageStatus\"/>\n        <column key=\"messageFlag\" header=\"æ ‡è®°\" classType=\"String\" allowSort=\"true\" width=\"150\" fnRender=\"fnRenderMessageFlag\"/>\n        <column key=\"fileIds\" header=\"é™„ä»¶\" classType=\"String\" width=\"150\" fnRender=\"fnRenderFileIds\"/>     \n		  <!--<column key=\"deleted\" header=\"æ˜¯å�¦åˆ é™¤\" classType=\"String\" allowSort=\"true\" width=\"150\" render=\"0=å�¯ç”¨,1=ç¦�ç”¨\"/>-->\n    </query>\n```\n\n## ä½¿ç”¨è¯´æ˜Ž\n\n### render(type=eq) \nç¤ºä¾‹ï¼š\n(1) render=\"type=eq,0=å�¯ç”¨ï¼Œ1=ç¦�ç”¨\" (å…¶ä¸­type=eqå�¯ç¼ºçœ�)\n(2) render=\"1=ç¦�ç”¨,else=å�¯ç”¨\"\né…�ç½®ä»¥å�Žï¼Œç»„ä»¶ä¼šæŠŠç›¸åº”å€¼ç¿»è¯‘ä¸ºå¯¹åº”å€¼ã€‚\n\n`type=eq` eqç±»åž‹çš„render,å�¯ç¼ºçœ�\n\n### render(type=window)\né…�ç½®å�Žï¼Œç‚¹å‡»è¯¥åˆ—å€¼ï¼Œä¼šå¼¹å‡ºä¸€ä¸ªæ¨¡æ€�çª—ä½“ï¼Œå°†é…�ç½®çš„æ‰€æœ‰å�‚æ•°ä¼ é€’ç»™modals.openWinæ–¹æ³•ã€‚\nç¤ºä¾‹ï¼š\n(1) render=\"type=window,winId=messageEditWin,url=/message/edit?id=[id],title=å¼¹çª—æµ‹è¯•[sendSubject]\n\nå…¶ä¸­[id]ï¼Œ[sendSubject]ä¼šè¢«æ›¿æ�¢ä¸ºå½“å‰�è¡Œå¯¹è±¡çš„è¯¥åˆ—çš„å€¼ï¼Œæ˜¯æŒ‡å®šåˆ—ï¼ˆcolumn key=\'id\'å’Œcolumn key=\'sendSubject\'ï¼‰çš„å€¼\n\n`type=window`:çª—ä½“render,å¿…é…�\n`winId`:çª—ä½“id,å¿…é…�\n`url`:urlè·¯å¾„,å¿…é…�\n\nå…¶ä»–å�‚æ•°é€šmodals.openWinå�‚æ•°ï¼Œå¦‚widthç­‰ç­‰\n\n###render(type=link)\né…�ç½®æŸ�åˆ—çš„è¶…é“¾æŽ¥ã€‚é…�ç½®å½¢å¼�æ˜¯è°ƒç”¨onclickæ–¹æ³•ï¼Œå»ºè®®æ¯”è¾ƒå¤�æ�‚çš„è¶…é“¾æŽ¥é‡‡ç”¨è¿™ç§�é…�ç½®ã€‚\nç¤ºä¾‹ï¼š\n(1) render=\"type=link,method=loadPage,params=\'/message/edit?id=[id]\';\'#contentBody\'\"\n(2) render=\"type=link,method=showDetail\"\n\nå…¶ä¸­[id]ä¼šè¢«æ›¿æ�¢ä¸ºå½“å‰�è¡Œå¯¹è±¡çš„è¯¥åˆ—çš„å€¼ï¼Œæ˜¯æŒ‡å®šåˆ—ï¼ˆcolumn key=\'id\'ï¼‰çš„å€¼\n\n`type=link`:è¶…é“¾æŽ¥render,å¿…é…�\n`method`:è¶…é“¾æŽ¥æ‰§è¡Œæ–¹æ³•å��ç§°ï¼Œå¿…é…�\n`params`ï¼šæ–¹æ³•æ‰§è¡Œå�‚æ•°ï¼Œåˆ†å�·(`;`)åˆ†éš”,è‹¥ç¼ºçœ�ï¼Œä¼šè‡ªåŠ¨å°†å½“å‰�è¡Œ`id`æ³¨å…¥æ–¹æ³•ï¼Œå�Šquery keyæ‰§è¡Œçš„å€¼\n\n`éœ€è¦�æ³¨æ„�çš„æ˜¯`ï¼Œå‰�å�°éœ€è¦�ç›¸å¯¹åº”çš„jsæ–¹æ³•ï¼Œæ¯”å¦‚ï¼Œä»¥ä¸Šä¸¤ä¸ªå®žä¾‹éœ€è¦�å‰�ç«¯ç”±loadPage(url)å’ŒshoWDetail(rowId)æ–¹æ³•ã€‚\n\n###fnRender\næ›´å¤�æ�‚çš„å‰�ç«¯å±•ç¤ºå’Œä¸šåŠ¡é€»è¾‘ï¼Œéœ€è¦�åœ¨å‰�ç«¯ç¼–å†™ç›¸åº”çš„ä¸šåŠ¡é€»è¾‘\nç¤ºä¾‹ï¼š\nï¼ˆ1ï¼‰ï¼šfnRender=\"fnRenderMessageStatus\"\n\nå¯¹åº”å‰�ç«¯è„šæœ¬\n```\nfunction fnRenderMessageStatus(value, type, rowObjï¼ŒoSetting) {\n    if (value == 0) {\n        return \'<span class=\"label label-warning\">è�‰ç¨¿</span>\'\n    } else if (value == 4) {\n        return \'<span class=\"label label-success\">å·²å�‘é€�</span>\';\n    }\n    return value;\n}\n```\næŒ‡å®šçš„fnRenderæ–¹æ³•ä¸­ä¼šé€šè¿‡Jquery-DataTablesæŽ¥å�£è‡ªåŠ¨æ³¨å…¥å››ä¸ªå�‚æ•°\n\n`value`: å½“å‰�å�•å…ƒæ ¼çš„å€¼\n`type`:å�•å…ƒæ ¼æ ·å¼�ï¼Œä¸€èˆ¬ä¸ºdisplay\n`rowObj`:å½“å‰�è¡Œå¯¹è±¡ï¼Œå�¯é€šè¿‡rowObj.nameç­‰å½¢å¼�èŽ·å�–å…¶ä»–åˆ—çš„å€¼\n`oSetting`:è¡¨æ ¼å…¨å±€é…�ç½®å¯¹è±¡\n\n###tooltip\nåœ¨è¡¨æ ¼ä¸­æ˜¾ç¤ºé•¿æ–‡æœ¬çš„æ—¶å€™ï¼Œæœ‰æ—¶å€™éœ€è¦�æˆªæ–­ï¼Œç„¶å�Žé¼ æ ‡æ‚¬å�œæ—¶æ˜¾ç¤ºï¼Œå�¯é‡‡ç”¨è¯¥é…�ç½®\n\nç¤ºä¾‹ï¼š\nï¼ˆ1ï¼‰enableTooltip=\"true\" maxLen=\"20\" tooltip=\"id\"\nï¼ˆ`å�Žç»­å°†ä¿®æ”¹æˆ� render=\"type=tooltip,maxLen=20,tooltip=[id]\"`ï¼‰\n\n`enableTooltip`:é»˜è®¤ä¸ºfalseï¼Œå�ªæœ‰é…�ç½®trueæ‰�ç”Ÿæ•ˆï¼Œæ‰�ä¼šæ‰§è¡Œæˆªæ–­\n`maxLen`:æˆªæ–­é•¿åº¦ï¼Œå¦‚æžœä¸�é…�ç½®ï¼Œé»˜è®¤ä¸º20\n`tooltip`:é¼ æ ‡æ‚¬å�œçš„æ•°æ�®æ�¥æº�ï¼Œå¦‚ä¸�é…�é»˜è®¤ä¸ºå½“å‰�æ•°æ�®æœ¬èº«\n\n\n\n\n\n\n\n\n\n\n      ', 'render');
INSERT INTO `tbl_markdown` VALUES ('8a8a83295a8300ff015a839845890000', '2017-02-28 15:21:19', '0', '2017-02-28 15:21:19', '0', 'quartz,è‡ªåŠ¨ä»»åŠ¡,æ”¯æŒ�é›†ç¾¤', 'åŸºäºŽQuartzçš„è‡ªåŠ¨ä»»åŠ¡è°ƒåº¦å™¨ï¼ˆæ”¯æŒ�é›†ç¾¤ï¼‰', '402880e456223e8f015625231d8e0003', 'æœ¬æ–‡ä»‹ç»�åœ¨AdminEAPæ¡†æž¶ä¸­ï¼Œé›†æˆ�Quartzï¼Œæ�¥è¿›è¡Œè‡ªåŠ¨ä»»åŠ¡ç®¡ç�†ï¼Œä»¥ä¾¿éš�æ—¶ç›‘æŽ§ç³»ç»Ÿä¸­å½“å‰�çš„ä»»åŠ¡ï¼Œå¹¶èƒ½åœ¨çº¿æ–°å¢žä»»åŠ¡ã€�æš‚å�œä»»åŠ¡ã€�æ�¢å¤�ä»»åŠ¡ã€�åˆ é™¤ä»»åŠ¡ã€�ç«‹å�³è¿�è¡Œä»»åŠ¡ã€‚\n\nåœ¨quartzä¸­ä¸€ä¸ªtriggerå�¯å¯¹åº”ä¸€ä¸ªjobï¼Œjobå�¯ä»¥æœ‰å¤šä¸ªtriggerï¼Œtriggeråˆ†ä¸ºCronTriggerä¸ŽSimpleTriggerï¼›CronTriggeré€šè¿‡Cronè¡¨è¾¾å¼�é…�ç½®å®šæ—¶ä»»åŠ¡ï¼ŒSimpleTriggeråˆ™é…�ç½®ä¸€äº›ç®€å�•é‡�å¤�çš„å®šæ—¶ä»»åŠ¡ã€‚\n\nquartzåˆ†ä¸ºåŸºäºŽå†…å­˜çš„æ–¹å¼�å’ŒåŸºäºŽæ•°æ�®åº“çš„æ–¹å¼�ï¼Œåœ¨æœ¬æ–‡ä¸­ä½¿ç”¨äº†åŸºäºŽæ•°æ�®åº“çš„æ–¹å¼�ï¼ˆæ”¯æŒ�é›†ç¾¤ï¼‰ã€‚è¿™æ ·æ��é«˜äº†ç³»ç»Ÿçš„å�¯é� æ€§ï¼Œåœ¨é…�ç½®æ—¶ï¼Œè¯·ä¿�æŒ�åº”ç”¨æœ�åŠ¡å™¨çš„æ—¶é’Ÿå�Œæ­¥ã€‚\n\nå…³äºŽå…·ä½“é›†æˆ�quartzçš„æ­¥éª¤ï¼Œå�¯å�‚è€ƒAdminEAPæº�ç �ï¼Œä¹Ÿå�¯å�‚è€ƒæœ¬äººä¹‹å‰�çš„å�šå®¢ï¼š\n\n-  [ Spring+ç›‘å�¬å™¨+Quartzé›†ç¾¤ï¼ˆ1ï¼‰â€”â€”åŸºæœ¬é…�ç½® ](http://blog.csdn.net/jrn1012/article/details/45582985)\n- [ Spring+ç›‘å�¬å™¨+Quartzé›†ç¾¤ï¼ˆ2ï¼‰â€”â€”quartz2.2.1åˆ›å»ºè¡¨ç»“æž„ï¼ˆoracleï¼‰ ](http://blog.csdn.net/jrn1012/article/details/45583731)\n- [ Spring+ç›‘å�¬å™¨+Quartzé›†ç¾¤ï¼ˆ3ï¼‰â€”â€”ä»»åŠ¡ç®¡ç�† ](http://blog.csdn.net/jrn1012/article/details/45583801)\n\nä»¥ä¸‹ä¸ºå®žçŽ°çš„ä»»åŠ¡è°ƒåº¦ç®¡ç�†å™¨ï¼š\n\n![ä»»åŠ¡è°ƒåº¦å™¨](http://img.blog.csdn.net/20170228145717110?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n##ä½¿ç”¨è¯´æ˜Ž\n\nAdminEAPæ¡†æž¶ä½¿ç”¨mysqlæ•°æ�®åº“ï¼Œæ‰€ä»¥è¦�åœ¨mysqlä¸­åˆ›å»ºquartzæ‰€éœ€è¦�çš„è¡¨ã€‚\n###1ã€�mysqlåˆ›å»ºè¡¨ç»“æž„\n\n```\n    --  \n    -- A hint submitted by a user: Oracle DB MUST be created as \"shared\" and the   \n    -- job_queue_processes parameter  must be greater than 2  \n    -- However, these settings are pretty much standard after any  \n    -- Oracle install, so most users need not worry about this.  \n    --  \n    -- Many other users (including the primary author of Quartz) have had success  \n    -- runing in dedicated mode, so only consider the above as a hint ;-)  \n    --  \n      \n    delete from qrtz_fired_triggers;  \n    delete from qrtz_simple_triggers;  \n    delete from qrtz_simprop_triggers;  \n    delete from qrtz_cron_triggers;  \n    delete from qrtz_blob_triggers;  \n    delete from qrtz_triggers;  \n    delete from qrtz_job_details;  \n    delete from qrtz_calendars;  \n    delete from qrtz_paused_trigger_grps;  \n    delete from qrtz_locks;  \n    delete from qrtz_scheduler_state;  \n      \n    drop table qrtz_calendars;  \n    drop table qrtz_fired_triggers;  \n    drop table qrtz_blob_triggers;  \n    drop table qrtz_cron_triggers;  \n    drop table qrtz_simple_triggers;  \n    drop table qrtz_simprop_triggers;  \n    drop table qrtz_triggers;  \n    drop table qrtz_job_details;  \n    drop table qrtz_paused_trigger_grps;  \n    drop table qrtz_locks;  \n    drop table qrtz_scheduler_state;  \n      \n    -- å­˜å‚¨æ¯�ä¸€ä¸ªå·²é…�ç½®çš„ Job çš„è¯¦ç»†ä¿¡æ�¯  \n    CREATE TABLE qrtz_job_details  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        JOB_NAME  VARCHAR2(200) NOT NULL,  \n        JOB_GROUP VARCHAR2(200) NOT NULL,  \n        DESCRIPTION VARCHAR2(250) NULL,  \n        JOB_CLASS_NAME   VARCHAR2(250) NOT NULL,   \n        IS_DURABLE VARCHAR2(1) NOT NULL,  \n        IS_NONCONCURRENT VARCHAR2(1) NOT NULL,  \n        IS_UPDATE_DATA VARCHAR2(1) NOT NULL,  \n        REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,  \n        JOB_DATA BLOB NULL,  \n        CONSTRAINT QRTZ_JOB_DETAILS_PK PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)  \n    );  \n    --  å­˜å‚¨å·²é…�ç½®çš„ Trigger çš„ä¿¡æ�¯  \n    CREATE TABLE qrtz_triggers  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        JOB_NAME  VARCHAR2(200) NOT NULL,   \n        JOB_GROUP VARCHAR2(200) NOT NULL,  \n        DESCRIPTION VARCHAR2(250) NULL,  \n        NEXT_FIRE_TIME NUMBER(13) NULL,  \n        PREV_FIRE_TIME NUMBER(13) NULL,  \n        PRIORITY NUMBER(13) NULL,  \n        TRIGGER_STATE VARCHAR2(16) NOT NULL,  \n        TRIGGER_TYPE VARCHAR2(8) NOT NULL,  \n        START_TIME NUMBER(13) NOT NULL,  \n        END_TIME NUMBER(13) NULL,  \n        CALENDAR_NAME VARCHAR2(200) NULL,  \n        MISFIRE_INSTR NUMBER(2) NULL,  \n        JOB_DATA BLOB NULL,  \n        CONSTRAINT QRTZ_TRIGGERS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),  \n        CONSTRAINT QRTZ_TRIGGER_TO_JOBS_FK FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)   \n          REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)   \n    );  \n    -- å­˜å‚¨ç®€å�•çš„ Triggerï¼ŒåŒ…æ‹¬é‡�å¤�æ¬¡æ•°ï¼Œé—´éš”ï¼Œä»¥å�Šå·²è§¦çš„æ¬¡æ•°  \n    CREATE TABLE qrtz_simple_triggers  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        REPEAT_COUNT NUMBER(7) NOT NULL,  \n        REPEAT_INTERVAL NUMBER(12) NOT NULL,  \n        TIMES_TRIGGERED NUMBER(10) NOT NULL,  \n        CONSTRAINT QRTZ_SIMPLE_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),  \n        CONSTRAINT QRTZ_SIMPLE_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)   \n        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)  \n    );  \n    -- å­˜å‚¨ Cron Triggerï¼ŒåŒ…æ‹¬ Cron è¡¨è¾¾å¼�å’Œæ—¶åŒºä¿¡æ�¯  \n    CREATE TABLE qrtz_cron_triggers  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        CRON_EXPRESSION VARCHAR2(120) NOT NULL,  \n        TIME_ZONE_ID VARCHAR2(80),  \n        CONSTRAINT QRTZ_CRON_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),  \n        CONSTRAINT QRTZ_CRON_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)   \n          REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)  \n    );  \n    CREATE TABLE qrtz_simprop_triggers  \n      (            \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        STR_PROP_1 VARCHAR2(512) NULL,  \n        STR_PROP_2 VARCHAR2(512) NULL,  \n        STR_PROP_3 VARCHAR2(512) NULL,  \n        INT_PROP_1 NUMBER(10) NULL,  \n        INT_PROP_2 NUMBER(10) NULL,  \n        LONG_PROP_1 NUMBER(13) NULL,  \n        LONG_PROP_2 NUMBER(13) NULL,  \n        DEC_PROP_1 NUMERIC(13,4) NULL,  \n        DEC_PROP_2 NUMERIC(13,4) NULL,  \n        BOOL_PROP_1 VARCHAR2(1) NULL,  \n        BOOL_PROP_2 VARCHAR2(1) NULL,  \n        CONSTRAINT QRTZ_SIMPROP_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),  \n        CONSTRAINT QRTZ_SIMPROP_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)   \n          REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)  \n    );  \n    -- Trigger ä½œä¸º Blob ç±»åž‹å­˜å‚¨(ç”¨äºŽ Quartz ç”¨æˆ·ç”¨ JDBC åˆ›å»ºä»–ä»¬è‡ªå·±å®šåˆ¶çš„ Trigger ç±»åž‹ï¼Œ<span style=\"color:#800080;\">JobStore</span> å¹¶ä¸�çŸ¥é�“å¦‚ä½•å­˜å‚¨å®žä¾‹çš„æ—¶å€™)  \n    CREATE TABLE qrtz_blob_triggers  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        BLOB_DATA BLOB NULL,  \n        CONSTRAINT QRTZ_BLOB_TRIG_PK PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),  \n        CONSTRAINT QRTZ_BLOB_TRIG_TO_TRIG_FK FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)   \n            REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)  \n    );  \n    -- ä»¥ Blob ç±»åž‹å­˜å‚¨ Quartz çš„ Calendar ä¿¡æ�¯  \n    CREATE TABLE qrtz_calendars  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        CALENDAR_NAME  VARCHAR2(200) NOT NULL,   \n        CALENDAR BLOB NOT NULL,  \n        CONSTRAINT QRTZ_CALENDARS_PK PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)  \n    );  \n    -- å­˜å‚¨å·²æš‚å�œçš„ Trigger ç»„çš„ä¿¡æ�¯   \n    CREATE TABLE qrtz_paused_trigger_grps  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        TRIGGER_GROUP  VARCHAR2(200) NOT NULL,   \n        CONSTRAINT QRTZ_PAUSED_TRIG_GRPS_PK PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)  \n    );  \n    -- å­˜å‚¨ä¸Žå·²è§¦å�‘çš„ Trigger ç›¸å…³çš„çŠ¶æ€�ä¿¡æ�¯ï¼Œä»¥å�Šç›¸è�” Job çš„æ‰§è¡Œä¿¡æ�¯  \n    CREATE TABLE qrtz_fired_triggers   \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        ENTRY_ID VARCHAR2(95) NOT NULL,  \n        TRIGGER_NAME VARCHAR2(200) NOT NULL,  \n        TRIGGER_GROUP VARCHAR2(200) NOT NULL,  \n        INSTANCE_NAME VARCHAR2(200) NOT NULL,  \n        FIRED_TIME NUMBER(13) NOT NULL,  \n        PRIORITY NUMBER(13) NOT NULL,  \n        STATE VARCHAR2(16) NOT NULL,  \n        JOB_NAME VARCHAR2(200) NULL,  \n        JOB_GROUP VARCHAR2(200) NULL,  \n        IS_NONCONCURRENT VARCHAR2(1) NULL,  \n        REQUESTS_RECOVERY VARCHAR2(1) NULL,  \n        CONSTRAINT QRTZ_FIRED_TRIGGER_PK PRIMARY KEY (SCHED_NAME,ENTRY_ID)  \n    );  \n    -- å­˜å‚¨å°‘é‡�çš„æœ‰å…³ Scheduler çš„çŠ¶æ€�ä¿¡æ�¯ï¼Œå’Œåˆ«çš„ Scheduler å®žä¾‹(å�‡å¦‚æ˜¯ç”¨äºŽä¸€ä¸ªé›†ç¾¤ä¸­)  \n    CREATE TABLE qrtz_scheduler_state   \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        INSTANCE_NAME VARCHAR2(200) NOT NULL,  \n        LAST_CHECKIN_TIME NUMBER(13) NOT NULL,  \n        CHECKIN_INTERVAL NUMBER(13) NOT NULL,  \n        CONSTRAINT QRTZ_SCHEDULER_STATE_PK PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)  \n    );  \n    -- å­˜å‚¨ç¨‹åº�çš„æ‚²è§‚é”�çš„ä¿¡æ�¯(å�‡å¦‚ä½¿ç”¨äº†æ‚²è§‚é”�)  \n    CREATE TABLE qrtz_locks  \n      (  \n        SCHED_NAME VARCHAR2(120) NOT NULL,  \n        LOCK_NAME  VARCHAR2(40) NOT NULL,   \n        CONSTRAINT QRTZ_LOCKS_PK PRIMARY KEY (SCHED_NAME,LOCK_NAME)  \n    );  \n      \n    create index idx_qrtz_j_req_recovery on qrtz_job_details(SCHED_NAME,REQUESTS_RECOVERY);  \n    create index idx_qrtz_j_grp on qrtz_job_details(SCHED_NAME,JOB_GROUP);  \n      \n    create index idx_qrtz_t_j on qrtz_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);  \n    create index idx_qrtz_t_jg on qrtz_triggers(SCHED_NAME,JOB_GROUP);  \n    create index idx_qrtz_t_c on qrtz_triggers(SCHED_NAME,CALENDAR_NAME);  \n    create index idx_qrtz_t_g on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP);  \n    create index idx_qrtz_t_state on qrtz_triggers(SCHED_NAME,TRIGGER_STATE);  \n    create index idx_qrtz_t_n_state on qrtz_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);  \n    create index idx_qrtz_t_n_g_state on qrtz_triggers(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);  \n    create index idx_qrtz_t_next_fire_time on qrtz_triggers(SCHED_NAME,NEXT_FIRE_TIME);  \n    create index idx_qrtz_t_nft_st on qrtz_triggers(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);  \n    create index idx_qrtz_t_nft_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);  \n    create index idx_qrtz_t_nft_st_misfire on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);  \n    create index idx_qrtz_t_nft_st_misfire_grp on qrtz_triggers(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);  \n      \n    create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME);  \n    create index idx_qrtz_ft_inst_job_req_rcvry on qrtz_fired_triggers(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);  \n    create index idx_qrtz_ft_j_g on qrtz_fired_triggers(SCHED_NAME,JOB_NAME,JOB_GROUP);  \n    create index idx_qrtz_ft_jg on qrtz_fired_triggers(SCHED_NAME,JOB_GROUP);  \n    create index idx_qrtz_ft_t_g on qrtz_fired_triggers(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);  \n    create index idx_qrtz_ft_tg on qrtz_fired_triggers(SCHED_NAME,TRIGGER_GROUP);  \n```\n###2ã€�åˆ›å»ºSimpleTriggerä»»åŠ¡\n![SimpleTriggerä»»åŠ¡](http://img.blog.csdn.net/20170228145913674?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nåˆ›å»ºSimpleTriggerä»»åŠ¡ä¸�ç”¨æŒ‡å®šCronè¡¨è¾¾å¼�ï¼Œå�¯æ ¹æ�®é‡�å¤�ç±»åž‹å¡«å†™ç›¸åº”çš„é‡�å¤�æ¬¡æ•°ä¸Žé‡�å¤�é—´éš”ï¼ˆå�¯ä»¥ä»»åŠ¡é‡�å¤�æ¬¡æ•°repeatCountä¸Žé‡�å¤�é—´éš”repeatIntervalæ˜¯ä¸ºé‡�å¤�ç±»åž‹æŒ‡å®šå�‚æ•°ï¼‰ã€‚\n\n###3ã€�åˆ›å»ºCronTriggerä»»åŠ¡\n![CronTriggerä»»åŠ¡](http://img.blog.csdn.net/20170228150302971?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvanJuMTAxMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nCronTriggerä»»åŠ¡åˆ™æ˜¯é€šè¿‡Cronè¡¨è¾¾å¼�åˆ›å»ºçš„ä»»åŠ¡ï¼Œå�ªéœ€è¦�åœ¨ç•Œé�¢é…�ç½®å¿…å¡«é€‰é¡¹å’ŒCronè¡¨è¾¾å¼�å�³å�¯ã€‚\n\n###4ã€�ä¿®æ”¹ä»»åŠ¡\nç‚¹å‡»ä¿®æ”¹ä»»åŠ¡å�Žï¼Œå�¯è¿›å…¥åˆ°ä»»åŠ¡ç¼–è¾‘ç•Œé�¢ï¼Œä¿®æ”¹ä»»åŠ¡ç›¸å…³å�‚æ•°ï¼ˆä»»åŠ¡å��å’Œä»»åŠ¡ç»„ä¸�å�¯ä¿®æ”¹ï¼‰ã€‚ç³»ç»Ÿä¼šé€šè¿‡rescheduleJobæ–¹æ³•é‡�æ–°è°ƒåº¦ã€‚\n\n```\n     // triggerå·²ç»�å­˜åœ¨ï¼Œæ›´æ–°ç›¸åº”çš„å®šæ—¶è®¾ç½®\n     TriggerBuilder triggerBuilder = trigger.getTriggerBuilder();\n     trigger = setTriggerParam(job, triggerKey, triggerBuilder, trigger);\n     // æŒ‰æ–°çš„triggeré‡�æ–°è®¾ç½®jobæ‰§è¡Œ\n     scheduler.rescheduleJob(triggerKey, trigger);\n```\n\n###5ã€�æš‚å�œä»»åŠ¡\nç‚¹å‡»æš‚å�œä»»åŠ¡ï¼Œä»»åŠ¡å°†æŒ‚èµ·ï¼Œä»»åŠ¡çŠ¶æ€�ç”±\"NORMAL\"å�˜ä¸ºâ€œPAUSEâ€�\n\n```java\n      /**\n     * æš‚å�œ\n     */\n    public void pauseJob(ScheduleJob scheduleJob) throws SchedulerException {\n        Scheduler scheduler = schedulerFactoryBean.getScheduler();\n        JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());\n        scheduler.pauseJob(jobKey);\n    }\n\n```\n\n###6ã€�æ�¢å¤�ä»»åŠ¡\nç‚¹å‡»å›žå¤�ä»»åŠ¡ï¼Œä»»åŠ¡å°†å�˜ä¸ºå�¯æ‰§è¡ŒçŠ¶æ€�ï¼Œä»»åŠ¡çŠ¶æ€�ç”±\"PAUSE\"å�˜ä¸ºâ€œNORMALâ€�\n\n```\n  /**\n     * æ�¢å¤�è¿�è¡Œ\n     */\n    public void resumeJob(ScheduleJob scheduleJob) throws SchedulerException {\n        Scheduler scheduler = schedulerFactoryBean.getScheduler();\n        JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());\n        scheduler.resumeJob(jobKey);\n    }\n\n```\n\n###7ã€�åˆ é™¤ä»»åŠ¡\nä»Žæ•°æ�®åº“ä¸­åˆ é™¤ä»»åŠ¡\n\n```\n    /**\n     * åˆ é™¤\n     */\n    public void deleteJob(ScheduleJob scheduleJob) throws SchedulerException {\n        Scheduler scheduler = schedulerFactoryBean.getScheduler();\n        JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());\n        scheduler.deleteJob(jobKey);\n    }\n```\n    \n\n###8ã€�ç«‹å�³è¿�è¡Œä¸€æ¬¡\nç‚¹å‡»â€œç«‹å�³è¿�è¡Œä¸€æ¬¡â€�ï¼Œä»»åŠ¡åˆ™é©¬ä¸Šæ‰§è¡Œä¸€æ¬¡\n```\n    /**\n     * è¿�è¡Œä¸€æ¬¡\n     */\n    public void triggerJob(ScheduleJob scheduleJob) throws SchedulerException {\n        Scheduler scheduler = schedulerFactoryBean.getScheduler();\n        JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());\n        scheduler.triggerJob(jobKey);\n    }\n\n```\n\n\n\n\n', 'quartz');

-- ----------------------------
-- Table structure for tbl_message
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message`;
CREATE TABLE `tbl_message` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `messageFlag` varchar(255) DEFAULT NULL,
  `messageStatus` varchar(255) DEFAULT NULL,
  `messageType` varchar(255) DEFAULT NULL,
  `receiveUsers` longtext,
  `remark` longtext,
  `sendContent` longtext,
  `sendSubject` varchar(255) DEFAULT NULL,
  `sendTime` datetime DEFAULT NULL,
  `sendUser` varchar(255) DEFAULT NULL,
  `sendUserID` varchar(255) DEFAULT NULL,
  `fileIds` longtext,
  `receiverIds` longtext,
  `receiverType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message
-- ----------------------------
INSERT INTO `tbl_message` VALUES ('8a8a84995ab64a5c015ab64b8af10000', '2017-03-10 11:38:08', '0', '2017-03-12 09:40:28', '2', '0', '4', '0,1', null, null, '<p>test2<br></p>', 'å•†åŠžå”±ä¸»è§’åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€å•†åŠžå”±ä¸»è§’åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€AdminEAPæ¡†æž¶æ¶ˆæ�¯ç®¡ç�†ç³»ç»Ÿ', '2017-03-12 09:40:28', 'billJiang-test', '402880e456223e8f015625231d8e0003', '402880ed5abbe288015abc3e1c3c0002,402880ed5abdfec1015ac02c71f10001,402880ed5abdfec1015ac02c71f50002,402880ed5abdfec1015ac02c71f80003', '4028818458d40f4f0158d4169f9d0007,402880e65a7facdb015a7fca61830000,402880e456223e8f0156225736a40001,402880e456223e8f0156223feee10000,402880e456223e8f015625231d8e0003', '1');
INSERT INTO `tbl_message` VALUES ('8a8a84995ab654d1015ab675cf830009', '2017-03-10 12:24:18', '0', '2017-03-10 12:24:18', '0', '0', '0', '0,1', null, null, '<p>\n<h1>åŒ—äº¬å¸‚å±€å…¨åŠ›æœ�åŠ¡åŸŽå¸‚å‰¯ä¸­å¿ƒå»ºè®¾</h1>\n\n<br>\n</p><p>æ�®äº†è§£ï¼Œå¸‚å·¥å•†å±€å…šç»„æˆ�å‘˜æ­¤å‰�å¤šæ¬¡åˆ°åŒ—äº¬åŸŽå¸‚å‰¯ä¸­å¿ƒå¼€å±•è°ƒæŸ¥ç ”ç©¶ï¼Œæ·±å…¥ä¸€çº¿æŒ‡å¯¼åŸºå±‚å·¥å•†éƒ¨é—¨çš„å·¥ä½œï¼ŒçŽ°åœºè§£å†³åŸºå±‚é�‡åˆ°çš„éš¾ç‚¹å’Œé—®é¢˜ã€‚æ�®æ‚‰ï¼Œå¸‚å·¥å•†å±€åˆ¶å®šçš„æŽªæ–½åŒ…æ‹¬ï¼ŒåŠ å¼ºåŸŽå¸‚å‰¯ä¸­å¿ƒæ‰§æ³•æœºæž„è®¾ç½®ï¼Œä»Žç»„ç»‡ä¸ŠæŽ¨è¿›åŸºå±‚æ‰§æ³•åŠ›é‡�è�½å®žåˆ°ä¹¡é•‡ï¼›å……åˆ†åˆ©ç”¨å·¥å•†æ•°æ�®èµ„æº�ï¼Œä¸ºæœ�åŠ¡å‰¯ä¸­å¿ƒå�‘å±•å’Œå¸‚åœºç›‘ç®¡æ��ä¾›æ•°æ�®æ”¯æ’‘ï¼Œæ��ä¾›å‰¯ä¸­å¿ƒå¸‚åœºä¸»ä½“å�‘å±•æŠ¥å‘Šï¼›åœ¨å®žè¡ŒåŸŽå…­åŒºäº§ä¸šç¦�é™�ç›®å½•çš„åŸºç¡€ä¸Šï¼Œæ”¯æŒ�å‡ºå�°æ›´åŠ ä¸¥æ ¼çš„äº§ä¸šç¦�é™�æ”¿ç­–ï¼Œæ��å�‡å‰¯ä¸­å¿ƒå¸‚åœºä¸»ä½“è´¨é‡�ï¼ŒæŽ¨åŠ¨å‰¯ä¸­å¿ƒäº§ä¸šè½¬åž‹å�‡çº§ï¼›å……åˆ†å�‘æŒ¥äº¬æ´¥å†€ä¸‰åœ°å·¥å•†å’Œå¸‚åœºç›‘ç®¡å��ä½œå¹³å�°ä½œç”¨ï¼ŒåŠ å¼ºä¸‰åœ°åŸºå±‚å·¥å•†å’Œå¸‚åœºç›‘ç®¡éƒ¨é—¨æƒ…æŠ¥äº¤æµ�ã€�ä¿¡æ�¯å…±äº«å’Œæ‰§æ³•å��ä½œã€‚\n\n<br></p>', 'åŒ—äº¬å¸‚å±€å…¨åŠ›æœ�åŠ¡åŸŽå¸‚å‰¯ä¸­å¿ƒå»ºè®¾', null, 'billJiang-test', '402880e456223e8f015625231d8e0003', '8a8a84995ab654d1015ab6759e960007,8a8a84995ab654d1015ab6759e9e0008', '402880e55a998466015a998e208d0003', '0');
INSERT INTO `tbl_message` VALUES ('8a8a84995ab654d1015ab69aa7e8000c', '2017-03-10 13:04:33', '0', '2017-03-10 13:04:33', '0', '1', '0', '0,1', null, null, '<p>\n<p>åœ¨åŒ—äº¬æ–°æˆ¿ä¾›åº”é”�å‡�ã€�ä»·æ ¼ä¸�æ–­æ”€å�‡çš„æƒ…å†µä¸‹ï¼Œå•†ä½�ä¸¤ç”¨æ¥¼ç›˜æˆ�ä¸ºä¸€å¹´å¤šæ�¥åŒ—äº¬æ¥¼å¸‚çš„ç„¦ç‚¹ï¼Œå¯¹äºŽè´­æˆ¿è€…æ�¥è¯´ï¼Œä½Žæ€»ä»·çš„å•†ä½�ä¸¤ç”¨ä¿¨ç„¶å·²æˆ�ä¸ºå…ˆâ€œä¸Šè½¦â€�çš„æ— å¥ˆä¹‹é€‰ã€‚æ•°æ�®æ˜¾ç¤ºï¼Œ2æœˆåŒ—äº¬å•†å“�æˆ¿æˆ�äº¤ä¸­ï¼Œè¿‘å…­æˆ�ä¸ºå•†åŠžç±»æ¥¼ç›˜ï¼Œå…¥å¸‚çš„å•†åŠžç±»æ¥¼ç›˜å�‡è¡¨çŽ°è¾ƒå¥½ã€‚å®žé™…ä¸Šï¼Œè‡ª2016å¹´äºŒå­£åº¦å¼€å§‹ï¼Œå…³äºŽå•†ä½�å…¨é�¢é™�è´­çš„ä¼ é—»ä¸�æ–­ï¼Œè‡ªæ­¤å•†ä½�å¸‚åœºæˆ�äº¤ä¹Ÿè¿›å…¥å¿«è½¦é�“ã€‚ä¸šå†…è®¤ä¸ºï¼Œé™�è´­æ”¿ç­–ã€�å¤§é‡�è´­æˆ¿éœ€æ±‚çš„å­˜åœ¨ã€�åŒ—äº¬æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä»¥å�Šè°ƒæŽ§é¢„æœŸçš„åˆºæ¿€æ˜¯å•†åŠžç±»å¸‚åœºæˆ�äº¤ç�«çƒ­çš„ä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; <strong>å•†åŠžæˆ�æ¥¼å¸‚ä¸»è§’</strong></p>\n<p>&nbsp; &nbsp; 2014å¹´å¤�å¤©ï¼Œå°�éƒ­ä»ŽåŒ—äº¬æŸ�é«˜æ ¡æ¯•ä¸šå�Žé€‰æ‹©ç•™äº¬å·¥ä½œï¼Œè¿›å…¥ä¸€å®¶äº’è�”ç½‘å…¬å�¸ï¼Œå¼€å§‹äº†â€œåŒ—æ¼‚â€�çš„æ—¥å­�ã€‚èƒ½åœ¨åŒ—äº¬å®‰ä¸ªå®¶ï¼Œæ˜¯å°�éƒ­ä¸€ç›´çš„å¿ƒæ„¿ã€‚å¯¹äºŽä»–æ�¥è¯´ï¼Œå®‰å®¶å°±éœ€è¦�ä¹°æˆ¿ã€‚2016å¹´9æœˆï¼Œæ¯•ä¸šä¸¤å¹´å�Žï¼Œå°�éƒ­æœ‰äº†ç‚¹ç§¯è“„ï¼Œå†�åŠ ä¸Šå®¶é‡Œèƒ½æ‹¿å‡ºä¸€éƒ¨åˆ†é’±ï¼Œå°�éƒ­å¼€å§‹ç­¹å¤‡è´­æˆ¿çš„äº‹æƒ…ã€‚</p>\n<p>&nbsp; &nbsp; å½“æ—¶ï¼Œæ�°é€¢â€œ9Â·30â€�æ–°æ”¿å‡ºå�°ï¼Œæˆ¿åœ°äº§å¸‚åœºæˆ�äº¤å¼€å§‹æ”¾ç¼“ï¼Œå°�éƒ­å°±å†³å®šç­‰2016å¹´åº•æˆ–è€…2017å¹´å†�è¯´ã€‚æ•°æœˆæ—¶é—´è¿‡åŽ»äº†ï¼Œåœ¨å°�éƒ­çœ‹æ�¥ï¼Œæˆ¿åœ°äº§å¸‚åœºè™½ç„¶æˆ�äº¤æ”¾ç¼“äº†ï¼Œä½†ä»·æ ¼è¿˜æ˜¯å¾ˆç¨³å®šçš„ï¼Œå†�åŠ ä¸Šä¹‹å‰�è�”ç³»çš„é”€å”®äººå‘˜éƒ½åœ¨è¯´æˆ¿åœ°äº§ä»·æ ¼ä¸�ä¼šå‡ºçŽ°ä¸‹è·Œï¼Œæƒ³åˆ°ä»Žè‡ªå·±è¯»ä¹¦å¼€å§‹åˆ°çŽ°åœ¨ï¼ŒåŒ—äº¬çš„æˆ¿ä»·æ¶¨äº†å‡ å€�ï¼Œå°�éƒ­çª�ç„¶æœ‰äº†ä¸€ç§�æƒ³æ³•ï¼šâ€œå¦‚æžœå†�ä¸�ä¹°æˆ¿çš„è¯�ï¼Œå�¯èƒ½å†�ä¹Ÿä¸Šä¸�äº†è½¦äº†ã€‚â€�</p>\n<p>&nbsp; &nbsp; æ˜¥èŠ‚è¿‡å�Žï¼Œå°�éƒ­ä¸‹å®šäº†ä¹°æˆ¿çš„å†³å¿ƒã€‚å› ä¸ºåŒ—äº¬çš„é™�è´­æ”¿ç­–ï¼Œå°�éƒ­æš‚æ—¶ä¸�å…·å¤‡è´­ä¹°70å¹´ä½�å®…çš„èµ„è´¨ï¼Œå› æ­¤ï¼Œå¸‚åœºä¸­å­˜åœ¨çš„å•†ä½�æˆ¿æˆ�ä¸ºå°�éƒ­æƒŸä¸€çš„é€‰æ‹©ã€‚2æœˆï¼Œåœ¨å¸‚åœºä¸­å…œå…œè½¬è½¬çœ‹äº†è®¸å¤šä¸ªåœ¨å”®å•†ä½�é¡¹ç›®å�Žï¼Œå°�éƒ­åœ¨å¤§å…´åŒºæŸ�å•†ä½�é¡¹ç›®è´­ä¹°äº†ä¸€å¥—LOFTæˆ¿å±‹ã€‚</p>\n<p>&nbsp; &nbsp; åŒ—äº¬å•†æŠ¥è®°è€…åœ¨èµ°è®¿å¸‚åœºæ—¶äº†è§£åˆ°ï¼Œç±»ä¼¼å°�éƒ­è¿™ç§�æƒ…å†µçš„è´­æˆ¿è€…å¹¶ä¸�åœ¨å°‘æ•°ï¼Œåœ¨ç»�è¿‡ä¸€æ®µæ—¶é—´è§‚æœ›å�Žï¼Œè´­æˆ¿è€…çš„é›†ä¸­å…¥å¸‚ï¼Œå¯¼è‡´2æœˆä¸‹æ—¬åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºé˜¶æ®µæ€§å›žæ¸©ã€‚å€¼å¾—æ³¨æ„�çš„æ˜¯ï¼Œæ ¹æ�®ç»Ÿè®¡æ•°æ�®æ˜¾ç¤ºï¼Œ2æœˆåŒ—äº¬å•†å“�æˆ¿æˆ�äº¤é‡�ä¸­ï¼Œè¿‘å…­æˆ�ä¸ºå•†åŠžç±»æ¥¼ç›˜ï¼ŒåŽ»å¹´å�ŒæœŸçš„å•†åŠžæˆ�äº¤å� æ¯”è¿˜ä¸�åˆ°å››æˆ�ã€‚</p>\n<p>&nbsp; &nbsp; å®žé™…ä¸Šï¼Œ2016å¹´æ˜¯åŒ—äº¬å•†ä½�å¸‚åœºæˆ�äº¤æœ€çƒ­çš„ä¸€å¹´ã€‚æ�®ç»Ÿè®¡ï¼Œ2016å¹´åŒ—äº¬å•†ä½�å¸‚åœºå…±è®¡æˆ�äº¤63703å¥—ï¼Œè¿™ä¸€æˆ�äº¤æ€»é‡�è¶…è¿‡äº†ä¹‹å‰�ä¸‰å¹´çš„æ€»å’Œã€‚æœ‰æ•°æ�®æ˜¾ç¤ºï¼Œ2010-2015å¹´æœŸé—´ï¼ŒåŒ—äº¬å•†ä½�å…¬å¯“é¡¹ç›®çš„æˆ�äº¤é‡�ç›¸å¯¹å¹³ç¨³ï¼›é™¤2014å¹´å› å¸‚åœºé™�æ¸©è€Œä¸‹æ»‘è‡³1.3ä¸‡å¥—ä»¥å¤–ï¼Œå…¶ä½™å‡ å¹´çš„æˆ�äº¤å¥—æ•°å�‡ç»´æŒ�åœ¨2ä¸‡-3ä¸‡å¥—ä¹‹é—´ã€‚</p>\n<p>&nbsp; &nbsp; æœ‰ä¸šå†…äººå£«åˆ†æž�è®¤ä¸ºï¼Œä¸€ç›´ä»¥æ�¥ï¼Œå•†ä½�æˆ¿éƒ½æ˜¯ä½œä¸ºæˆ¿åœ°äº§å¸‚åœºçš„ä¸€ç§�è¡¥å……äº§å“�å­˜åœ¨ç�€ï¼Œä¸�è¿‡åœ¨2016å¹´ä¸Šå�Šå¹´ï¼ŒåŒ—äº¬å•†ä½�æˆ¿æˆ�äº¤é‡�é¦–æ¬¡è¶…è¿‡ä½�å®…ï¼Œéš�å�Žå•†ä½�æˆ¿å¸‚åœºç»�åŽ†è¿‡å‡ æ¬¡èµ·ä¼�ï¼Œä½†æ˜¯ï¼Œåœ¨åŒ—äº¬çº¯ä½�å®…ä¾›åº”è¾ƒå°‘çš„æƒ…å†µä¸‹ï¼Œå•†ä½�æˆ¿å¼€å§‹è¶…è¿‡ä½�å®…äº§å“�æˆ�ä¸ºåŒ—äº¬æ¥¼å¸‚çš„ä¸»è§’ï¼Œè¿™ä¹Ÿæˆ�ä¸ºç›®å‰�åŒ—äº¬æ¥¼å¸‚çš„ç‰¹ç‚¹ä¹‹ä¸€ã€‚</p>\n<p>&nbsp; &nbsp; <strong>å¤šå› ç´ å� åŠ æ•ˆåº”</strong></p>\n<p>&nbsp; &nbsp; â€œåŒ—äº¬å•†ä½�æˆ¿çš„â€˜ä¸Šä½�â€™å¹¶é�žå�¶ç„¶â€�ï¼Œä¸€ä½�ä»Žäº‹æˆ¿åœ°äº§è�¥é”€å·¥ä½œè¿‘å��å¹´çš„ä¸šå†…äººå£«è®¤ä¸ºï¼ŒåŒ—äº¬å¸‚å¯¹çº¯ä½�å®…äº§å“�çš„é™�è´­æ”¿ç­–ã€�å¤§é‡�è´­æˆ¿éœ€æ±‚çš„å­˜åœ¨ã€�æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä»¥å�Šè°ƒæŽ§é¢„æœŸçš„åˆºæ¿€æ˜¯å•†ä½�ç±»å¸‚åœºæˆ�äº¤ç�«çƒ­çš„å‡ ä¸ªä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; ç¬¬ä¸€å¤ªå¹³æˆ´ç»´æ–¯å�ŽåŒ—åŒºä½�å®…é”€å”®éƒ¨åŠ©ç�†è‘£äº‹æ¢�çˆ½åœ¨æŽ¥å�—åŒ—äº¬å•†æŠ¥è®°è€…é‡‡è®¿æ—¶è¡¨ç¤ºï¼Œå•†åŠžç±»äº§å“�å�—ä½¿ç”¨æˆ�æœ¬é«˜ã€�åœŸåœ°å¹´é™�çŸ­ç­‰æ�¡ä»¶é™�åˆ¶ï¼Œç›¸æ¯”äºŽä½�å®…å¹¶æ²¡æœ‰ä¼˜åŠ¿ï¼Œå¢žå€¼é€Ÿåº¦ä¹Ÿä½ŽäºŽæ™®é€šä½�å®…ï¼Œç„¶è€Œå�—é™�è´­æ”¿ç­–é™�åˆ¶å�ŠåŒ—äº¬æ¥¼å¸‚ä¾›ç»™ä¸�è¶³çš„å½±å“�ï¼Œå¯¼è‡´æœ‰è‡ªä½�å�ŠæŠ•èµ„éœ€æ±‚çš„å®¢æˆ·éƒ½éœ€è¦�è¿™ç§�èµ„äº§é…�ç½®ã€‚å› æ­¤ï¼Œé’ˆå¯¹æ™®é€šä½�å®…çš„é™�è´­æ”¿ç­–æ˜¯å•†åŠžæˆ�äº¤ç�«çƒ­çš„ä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; ä¸šå†…äººå£«è®¤ä¸ºï¼Œé™¤äº†é’ˆå¯¹æ™®é€šä½�å®…çš„é™�è´­æ”¿ç­–ä¹‹å¤–ï¼ŒåŒ—äº¬æ‹¥æœ‰ä¸­å›½æœ€é¡¶çº§çš„æ•™è‚²ã€�åŒ»ç–—ç­‰èµ„æº�ï¼ŒåŒ…æ‹¬é¦–æ¬¡ç½®ä¸šä»¥å�Šæ”¹å–„åž‹ç½®ä¸šçš„è´­æˆ¿éœ€æ±‚å�‡è¾ƒä¸ºæ—ºç››ã€‚ä¸�ä»…å¦‚æ­¤ï¼Œæˆ¿åœ°äº§æ˜¯ç›®å‰�èµ„äº§ä¿�å€¼å¢žå€¼çš„ä¸€ç§�é‡�è¦�å·¥å…·ï¼Œå› æ­¤ï¼ŒåŒ—äº¬æˆ¿åœ°äº§å¸‚åœºä¹Ÿå­˜åœ¨ä¸€å®šè§„æ¨¡çš„æŠ•èµ„éœ€æ±‚ã€‚å�Œæ—¶ï¼Œå�—é™�è´­æ”¿ç­–å½±å“�ï¼Œæš‚ä¸�å…·å¤‡è´­æˆ¿èµ„è´¨çš„æŠ•èµ„è€…å°±ä¼šæµ�å…¥å•†ä½�æˆ¿å¸‚åœºï¼Œè¿™éƒ¨åˆ†éœ€æ±‚æ”¯æ’‘ç�€å•†ä½�æˆ¿å¸‚åœºçš„æˆ�äº¤çƒ­åº¦ã€‚</p>\n<p>&nbsp; &nbsp; æ­¤å¤–ï¼ŒåŒ—äº¬æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä¹Ÿæ˜¯å¯¼è‡´å•†ä½�æˆ¿èµ°çƒ­çš„åŽŸå› ä¹‹ä¸€ã€‚è¿‘å¹´æ�¥ï¼ŒåŒ—äº¬å¸‚åœŸåœ°ä¾›åº”é€�æ¸�å‡�å°‘ï¼Œ2016å¹´åŒ—äº¬åœŸåœ°å¸‚åœºä»…æˆ�äº¤ç»�è�¥æ€§ç”¨åœ°ï¼ˆä¸�åŒ…å�«3å®—æ£šæˆ·åŒºæ”¹é€ ï¼‰28å®—ï¼Œå¤‡å�—å…³æ³¨çš„ä½�å®…ç±»ç”¨åœ°ï¼Œä»…æˆ�äº¤15å®—ï¼Œå…¶ä¸­å�¯å”®çº¯å•†å“�ä½�å®…ç”¨åœ°å�ªæœ‰7å®—ï¼Œè§„åˆ’æ€»å»ºç­‘é�¢ç§¯ä»…39ä¸‡å¹³æ–¹ç±³ã€‚å�Œæ—¶ï¼ŒåœŸåœ°æˆ�äº¤ä»·æ ¼ä¸�æ–­æ”€å�‡ï¼Œåœ°ä»·é«˜ä¼�å¯¼è‡´åŒ—äº¬æ–°æˆ¿å¸‚åœºè±ªå®…åŒ–ã€‚å› æ­¤ï¼Œå�—åˆ°è´­æˆ¿æ‰¿å�—èƒ½åŠ›é™�åˆ¶ï¼Œä½Žæ€»ä»·çš„å•†åŠžç±»äº§å“�å¼€å§‹å�—åˆ°åˆšéœ€è´­æˆ¿è€…çš„é�’ç��ã€‚</p>\n<p>&nbsp; &nbsp; è¿˜æœ‰ä¸€ä¸ªä¸�å¾—ä¸�æ��çš„åŽŸå› æ˜¯ï¼Œå…³äºŽå•†ä½�æˆ¿å°†å…¨é�¢é™�è´­çš„å‡ åº¦ä¼ é—»ã€‚è‡ª2016å¹´5æœˆé€šå·žå•†ä½�é™�è´­æ”¿ç­–å®žæ–½å�Žï¼Œå…¨å¸‚å•†ä½�æˆ¿å°†é™�è´­çš„æ¶ˆæ�¯å‡ åº¦ä¼ å‡ºï¼Œå°½ç®¡æ”¿åºœéƒ¨é—¨æ›¾è¾Ÿè°£ï¼Œä½†å¼€å�‘å•†åˆ©ç”¨ä¼ è¨€ä½œä¸ºè�¥é”€å™±å¤´ï¼Œè¿˜æ˜¯åŠ é€Ÿè´­æˆ¿è€…æ¶Œå…¥å•†ä½�æˆ¿å¸‚åœºã€‚</p>\n\n<br></p>', 'å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€', null, 'billJiang-test', '402880e456223e8f015625231d8e0003', '8a8a84995ab654d1015ab69a75c0000a,8a8a84995ab654d1015ab69a75c7000b', '402880e55a998466015a998e208d0003', '0');
INSERT INTO `tbl_message` VALUES ('8a8a84995ab654d1015ab69bebc7000f', '2017-03-10 13:05:56', '0', '2017-03-10 13:05:56', '0', '1', '0', '0', null, null, '<p>\n<p>åœ¨åŒ—äº¬æ–°æˆ¿ä¾›åº”é”�å‡�ã€�ä»·æ ¼ä¸�æ–­æ”€å�‡çš„æƒ…å†µä¸‹ï¼Œå•†ä½�ä¸¤ç”¨æ¥¼ç›˜æˆ�ä¸ºä¸€å¹´å¤šæ�¥åŒ—äº¬æ¥¼å¸‚çš„ç„¦ç‚¹ï¼Œå¯¹äºŽè´­æˆ¿è€…æ�¥è¯´ï¼Œä½Žæ€»ä»·çš„å•†ä½�ä¸¤ç”¨ä¿¨ç„¶å·²æˆ�ä¸ºå…ˆâ€œä¸Šè½¦â€�çš„æ— å¥ˆä¹‹é€‰ã€‚æ•°æ�®æ˜¾ç¤ºï¼Œ2æœˆåŒ—äº¬å•†å“�æˆ¿æˆ�äº¤ä¸­ï¼Œè¿‘å…­æˆ�ä¸ºå•†åŠžç±»æ¥¼ç›˜ï¼Œå…¥å¸‚çš„å•†åŠžç±»æ¥¼ç›˜å�‡è¡¨çŽ°è¾ƒå¥½ã€‚å®žé™…ä¸Šï¼Œè‡ª2016å¹´äºŒå­£åº¦å¼€å§‹ï¼Œå…³äºŽå•†ä½�å…¨é�¢é™�è´­çš„ä¼ é—»ä¸�æ–­ï¼Œè‡ªæ­¤å•†ä½�å¸‚åœºæˆ�äº¤ä¹Ÿè¿›å…¥å¿«è½¦é�“ã€‚ä¸šå†…è®¤ä¸ºï¼Œé™�è´­æ”¿ç­–ã€�å¤§é‡�è´­æˆ¿éœ€æ±‚çš„å­˜åœ¨ã€�åŒ—äº¬æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä»¥å�Šè°ƒæŽ§é¢„æœŸçš„åˆºæ¿€æ˜¯å•†åŠžç±»å¸‚åœºæˆ�äº¤ç�«çƒ­çš„ä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; <strong>å•†åŠžæˆ�æ¥¼å¸‚ä¸»è§’</strong></p>\n<p>&nbsp; &nbsp; 2014å¹´å¤�å¤©ï¼Œå°�éƒ­ä»ŽåŒ—äº¬æŸ�é«˜æ ¡æ¯•ä¸šå�Žé€‰æ‹©ç•™äº¬å·¥ä½œï¼Œè¿›å…¥ä¸€å®¶äº’è�”ç½‘å…¬å�¸ï¼Œå¼€å§‹äº†â€œåŒ—æ¼‚â€�çš„æ—¥å­�ã€‚èƒ½åœ¨åŒ—äº¬å®‰ä¸ªå®¶ï¼Œæ˜¯å°�éƒ­ä¸€ç›´çš„å¿ƒæ„¿ã€‚å¯¹äºŽä»–æ�¥è¯´ï¼Œå®‰å®¶å°±éœ€è¦�ä¹°æˆ¿ã€‚2016å¹´9æœˆï¼Œæ¯•ä¸šä¸¤å¹´å�Žï¼Œå°�éƒ­æœ‰äº†ç‚¹ç§¯è“„ï¼Œå†�åŠ ä¸Šå®¶é‡Œèƒ½æ‹¿å‡ºä¸€éƒ¨åˆ†é’±ï¼Œå°�éƒ­å¼€å§‹ç­¹å¤‡è´­æˆ¿çš„äº‹æƒ…ã€‚</p>\n<p>&nbsp; &nbsp; å½“æ—¶ï¼Œæ�°é€¢â€œ9Â·30â€�æ–°æ”¿å‡ºå�°ï¼Œæˆ¿åœ°äº§å¸‚åœºæˆ�äº¤å¼€å§‹æ”¾ç¼“ï¼Œå°�éƒ­å°±å†³å®šç­‰2016å¹´åº•æˆ–è€…2017å¹´å†�è¯´ã€‚æ•°æœˆæ—¶é—´è¿‡åŽ»äº†ï¼Œåœ¨å°�éƒ­çœ‹æ�¥ï¼Œæˆ¿åœ°äº§å¸‚åœºè™½ç„¶æˆ�äº¤æ”¾ç¼“äº†ï¼Œä½†ä»·æ ¼è¿˜æ˜¯å¾ˆç¨³å®šçš„ï¼Œå†�åŠ ä¸Šä¹‹å‰�è�”ç³»çš„é”€å”®äººå‘˜éƒ½åœ¨è¯´æˆ¿åœ°äº§ä»·æ ¼ä¸�ä¼šå‡ºçŽ°ä¸‹è·Œï¼Œæƒ³åˆ°ä»Žè‡ªå·±è¯»ä¹¦å¼€å§‹åˆ°çŽ°åœ¨ï¼ŒåŒ—äº¬çš„æˆ¿ä»·æ¶¨äº†å‡ å€�ï¼Œå°�éƒ­çª�ç„¶æœ‰äº†ä¸€ç§�æƒ³æ³•ï¼šâ€œå¦‚æžœå†�ä¸�ä¹°æˆ¿çš„è¯�ï¼Œå�¯èƒ½å†�ä¹Ÿä¸Šä¸�äº†è½¦äº†ã€‚â€�</p>\n<p>&nbsp; &nbsp; æ˜¥èŠ‚è¿‡å�Žï¼Œå°�éƒ­ä¸‹å®šäº†ä¹°æˆ¿çš„å†³å¿ƒã€‚å› ä¸ºåŒ—äº¬çš„é™�è´­æ”¿ç­–ï¼Œå°�éƒ­æš‚æ—¶ä¸�å…·å¤‡è´­ä¹°70å¹´ä½�å®…çš„èµ„è´¨ï¼Œå› æ­¤ï¼Œå¸‚åœºä¸­å­˜åœ¨çš„å•†ä½�æˆ¿æˆ�ä¸ºå°�éƒ­æƒŸä¸€çš„é€‰æ‹©ã€‚2æœˆï¼Œåœ¨å¸‚åœºä¸­å…œå…œè½¬è½¬çœ‹äº†è®¸å¤šä¸ªåœ¨å”®å•†ä½�é¡¹ç›®å�Žï¼Œå°�éƒ­åœ¨å¤§å…´åŒºæŸ�å•†ä½�é¡¹ç›®è´­ä¹°äº†ä¸€å¥—LOFTæˆ¿å±‹ã€‚</p>\n<p>&nbsp; &nbsp; åŒ—äº¬å•†æŠ¥è®°è€…åœ¨èµ°è®¿å¸‚åœºæ—¶äº†è§£åˆ°ï¼Œç±»ä¼¼å°�éƒ­è¿™ç§�æƒ…å†µçš„è´­æˆ¿è€…å¹¶ä¸�åœ¨å°‘æ•°ï¼Œåœ¨ç»�è¿‡ä¸€æ®µæ—¶é—´è§‚æœ›å�Žï¼Œè´­æˆ¿è€…çš„é›†ä¸­å…¥å¸‚ï¼Œå¯¼è‡´2æœˆä¸‹æ—¬åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºé˜¶æ®µæ€§å›žæ¸©ã€‚å€¼å¾—æ³¨æ„�çš„æ˜¯ï¼Œæ ¹æ�®ç»Ÿè®¡æ•°æ�®æ˜¾ç¤ºï¼Œ2æœˆåŒ—äº¬å•†å“�æˆ¿æˆ�äº¤é‡�ä¸­ï¼Œè¿‘å…­æˆ�ä¸ºå•†åŠžç±»æ¥¼ç›˜ï¼ŒåŽ»å¹´å�ŒæœŸçš„å•†åŠžæˆ�äº¤å� æ¯”è¿˜ä¸�åˆ°å››æˆ�ã€‚</p>\n<p>&nbsp; &nbsp; å®žé™…ä¸Šï¼Œ2016å¹´æ˜¯åŒ—äº¬å•†ä½�å¸‚åœºæˆ�äº¤æœ€çƒ­çš„ä¸€å¹´ã€‚æ�®ç»Ÿè®¡ï¼Œ2016å¹´åŒ—äº¬å•†ä½�å¸‚åœºå…±è®¡æˆ�äº¤63703å¥—ï¼Œè¿™ä¸€æˆ�äº¤æ€»é‡�è¶…è¿‡äº†ä¹‹å‰�ä¸‰å¹´çš„æ€»å’Œã€‚æœ‰æ•°æ�®æ˜¾ç¤ºï¼Œ2010-2015å¹´æœŸé—´ï¼ŒåŒ—äº¬å•†ä½�å…¬å¯“é¡¹ç›®çš„æˆ�äº¤é‡�ç›¸å¯¹å¹³ç¨³ï¼›é™¤2014å¹´å› å¸‚åœºé™�æ¸©è€Œä¸‹æ»‘è‡³1.3ä¸‡å¥—ä»¥å¤–ï¼Œå…¶ä½™å‡ å¹´çš„æˆ�äº¤å¥—æ•°å�‡ç»´æŒ�åœ¨2ä¸‡-3ä¸‡å¥—ä¹‹é—´ã€‚</p>\n<p>&nbsp; &nbsp; æœ‰ä¸šå†…äººå£«åˆ†æž�è®¤ä¸ºï¼Œä¸€ç›´ä»¥æ�¥ï¼Œå•†ä½�æˆ¿éƒ½æ˜¯ä½œä¸ºæˆ¿åœ°äº§å¸‚åœºçš„ä¸€ç§�è¡¥å……äº§å“�å­˜åœ¨ç�€ï¼Œä¸�è¿‡åœ¨2016å¹´ä¸Šå�Šå¹´ï¼ŒåŒ—äº¬å•†ä½�æˆ¿æˆ�äº¤é‡�é¦–æ¬¡è¶…è¿‡ä½�å®…ï¼Œéš�å�Žå•†ä½�æˆ¿å¸‚åœºç»�åŽ†è¿‡å‡ æ¬¡èµ·ä¼�ï¼Œä½†æ˜¯ï¼Œåœ¨åŒ—äº¬çº¯ä½�å®…ä¾›åº”è¾ƒå°‘çš„æƒ…å†µä¸‹ï¼Œå•†ä½�æˆ¿å¼€å§‹è¶…è¿‡ä½�å®…äº§å“�æˆ�ä¸ºåŒ—äº¬æ¥¼å¸‚çš„ä¸»è§’ï¼Œè¿™ä¹Ÿæˆ�ä¸ºç›®å‰�åŒ—äº¬æ¥¼å¸‚çš„ç‰¹ç‚¹ä¹‹ä¸€ã€‚</p>\n<p>&nbsp; &nbsp; <strong>å¤šå› ç´ å� åŠ æ•ˆåº”</strong></p>\n<p>&nbsp; &nbsp; â€œåŒ—äº¬å•†ä½�æˆ¿çš„â€˜ä¸Šä½�â€™å¹¶é�žå�¶ç„¶â€�ï¼Œä¸€ä½�ä»Žäº‹æˆ¿åœ°äº§è�¥é”€å·¥ä½œè¿‘å��å¹´çš„ä¸šå†…äººå£«è®¤ä¸ºï¼ŒåŒ—äº¬å¸‚å¯¹çº¯ä½�å®…äº§å“�çš„é™�è´­æ”¿ç­–ã€�å¤§é‡�è´­æˆ¿éœ€æ±‚çš„å­˜åœ¨ã€�æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä»¥å�Šè°ƒæŽ§é¢„æœŸçš„åˆºæ¿€æ˜¯å•†ä½�ç±»å¸‚åœºæˆ�äº¤ç�«çƒ­çš„å‡ ä¸ªä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; ç¬¬ä¸€å¤ªå¹³æˆ´ç»´æ–¯å�ŽåŒ—åŒºä½�å®…é”€å”®éƒ¨åŠ©ç�†è‘£äº‹æ¢�çˆ½åœ¨æŽ¥å�—åŒ—äº¬å•†æŠ¥è®°è€…é‡‡è®¿æ—¶è¡¨ç¤ºï¼Œå•†åŠžç±»äº§å“�å�—ä½¿ç”¨æˆ�æœ¬é«˜ã€�åœŸåœ°å¹´é™�çŸ­ç­‰æ�¡ä»¶é™�åˆ¶ï¼Œç›¸æ¯”äºŽä½�å®…å¹¶æ²¡æœ‰ä¼˜åŠ¿ï¼Œå¢žå€¼é€Ÿåº¦ä¹Ÿä½ŽäºŽæ™®é€šä½�å®…ï¼Œç„¶è€Œå�—é™�è´­æ”¿ç­–é™�åˆ¶å�ŠåŒ—äº¬æ¥¼å¸‚ä¾›ç»™ä¸�è¶³çš„å½±å“�ï¼Œå¯¼è‡´æœ‰è‡ªä½�å�ŠæŠ•èµ„éœ€æ±‚çš„å®¢æˆ·éƒ½éœ€è¦�è¿™ç§�èµ„äº§é…�ç½®ã€‚å› æ­¤ï¼Œé’ˆå¯¹æ™®é€šä½�å®…çš„é™�è´­æ”¿ç­–æ˜¯å•†åŠžæˆ�äº¤ç�«çƒ­çš„ä¸»è¦�åŽŸå› ã€‚</p>\n<p>&nbsp; &nbsp; ä¸šå†…äººå£«è®¤ä¸ºï¼Œé™¤äº†é’ˆå¯¹æ™®é€šä½�å®…çš„é™�è´­æ”¿ç­–ä¹‹å¤–ï¼ŒåŒ—äº¬æ‹¥æœ‰ä¸­å›½æœ€é¡¶çº§çš„æ•™è‚²ã€�åŒ»ç–—ç­‰èµ„æº�ï¼ŒåŒ…æ‹¬é¦–æ¬¡ç½®ä¸šä»¥å�Šæ”¹å–„åž‹ç½®ä¸šçš„è´­æˆ¿éœ€æ±‚å�‡è¾ƒä¸ºæ—ºç››ã€‚ä¸�ä»…å¦‚æ­¤ï¼Œæˆ¿åœ°äº§æ˜¯ç›®å‰�èµ„äº§ä¿�å€¼å¢žå€¼çš„ä¸€ç§�é‡�è¦�å·¥å…·ï¼Œå› æ­¤ï¼ŒåŒ—äº¬æˆ¿åœ°äº§å¸‚åœºä¹Ÿå­˜åœ¨ä¸€å®šè§„æ¨¡çš„æŠ•èµ„éœ€æ±‚ã€‚å�Œæ—¶ï¼Œå�—é™�è´­æ”¿ç­–å½±å“�ï¼Œæš‚ä¸�å…·å¤‡è´­æˆ¿èµ„è´¨çš„æŠ•èµ„è€…å°±ä¼šæµ�å…¥å•†ä½�æˆ¿å¸‚åœºï¼Œè¿™éƒ¨åˆ†éœ€æ±‚æ”¯æ’‘ç�€å•†ä½�æˆ¿å¸‚åœºçš„æˆ�äº¤çƒ­åº¦ã€‚</p>\n<p>&nbsp; &nbsp; æ­¤å¤–ï¼ŒåŒ—äº¬æ–°æˆ¿å¸‚åœºä¸­ä½Žä»·ä½�äº§å“�çš„åŒ®ä¹�ä¹Ÿæ˜¯å¯¼è‡´å•†ä½�æˆ¿èµ°çƒ­çš„åŽŸå› ä¹‹ä¸€ã€‚è¿‘å¹´æ�¥ï¼ŒåŒ—äº¬å¸‚åœŸåœ°ä¾›åº”é€�æ¸�å‡�å°‘ï¼Œ2016å¹´åŒ—äº¬åœŸåœ°å¸‚åœºä»…æˆ�äº¤ç»�è�¥æ€§ç”¨åœ°ï¼ˆä¸�åŒ…å�«3å®—æ£šæˆ·åŒºæ”¹é€ ï¼‰28å®—ï¼Œå¤‡å�—å…³æ³¨çš„ä½�å®…ç±»ç”¨åœ°ï¼Œä»…æˆ�äº¤15å®—ï¼Œå…¶ä¸­å�¯å”®çº¯å•†å“�ä½�å®…ç”¨åœ°å�ªæœ‰7å®—ï¼Œè§„åˆ’æ€»å»ºç­‘é�¢ç§¯ä»…39ä¸‡å¹³æ–¹ç±³ã€‚å�Œæ—¶ï¼ŒåœŸåœ°æˆ�äº¤ä»·æ ¼ä¸�æ–­æ”€å�‡ï¼Œåœ°ä»·é«˜ä¼�å¯¼è‡´åŒ—äº¬æ–°æˆ¿å¸‚åœºè±ªå®…åŒ–ã€‚å› æ­¤ï¼Œå�—åˆ°è´­æˆ¿æ‰¿å�—èƒ½åŠ›é™�åˆ¶ï¼Œä½Žæ€»ä»·çš„å•†åŠžç±»äº§å“�å¼€å§‹å�—åˆ°åˆšéœ€è´­æˆ¿è€…çš„é�’ç��ã€‚</p>\n<p>&nbsp; &nbsp; è¿˜æœ‰ä¸€ä¸ªä¸�å¾—ä¸�æ��çš„åŽŸå› æ˜¯ï¼Œå…³äºŽå•†ä½�æˆ¿å°†å…¨é�¢é™�è´­çš„å‡ åº¦ä¼ é—»ã€‚è‡ª2016å¹´5æœˆé€šå·žå•†ä½�é™�è´­æ”¿ç­–å®žæ–½å�Žï¼Œå…¨å¸‚å•†ä½�æˆ¿å°†é™�è´­çš„æ¶ˆæ�¯å‡ åº¦ä¼ å‡ºï¼Œå°½ç®¡æ”¿åºœéƒ¨é—¨æ›¾è¾Ÿè°£ï¼Œä½†å¼€å�‘å•†åˆ©ç”¨ä¼ è¨€ä½œä¸ºè�¥é”€å™±å¤´ï¼Œè¿˜æ˜¯åŠ é€Ÿè´­æˆ¿è€…æ¶Œå…¥å•†ä½�æˆ¿å¸‚åœºã€‚</p>\n\n<br></p>', 'å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€ å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€ å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€ å•†åŠžå”±ä¸»è§’ åŒ—äº¬æˆ¿åœ°äº§å¸‚åœºæ–°æ ¼å±€ ', null, 'billJiang-test', '402880e456223e8f015625231d8e0003', '8a8a84995ab654d1015ab69be272000d,8a8a84995ab654d1015ab69be276000e', '402880e55a998466015a998e208d0003', '0');
INSERT INTO `tbl_message` VALUES ('8a8a84995ab76f13015abbc8b8a00000', '2017-03-11 13:12:58', '0', '2017-03-11 13:42:56', '1', '0', '4', '0,1', null, null, '<p>\n</p><h1>åŒ—äº¬å¸‚å±€å…¨åŠ›æœ�åŠ¡åŸŽå¸‚å‰¯ä¸­å¿ƒå»ºè®¾</h1>\n\n<br>\n<p></p><p>æ�®äº†è§£ï¼Œå¸‚å·¥å•†å±€å…šç»„æˆ�å‘˜æ­¤å‰�å¤šæ¬¡åˆ°åŒ—äº¬åŸŽå¸‚å‰¯ä¸­å¿ƒå¼€å±•è°ƒæŸ¥ç ”ç©¶ï¼Œæ·±å…¥ä¸€çº¿æŒ‡å¯¼åŸºå±‚å·¥å•†éƒ¨é—¨çš„å·¥ä½œï¼ŒçŽ°åœºè§£å†³åŸºå±‚é�‡åˆ°çš„éš¾ç‚¹å’Œé—®é¢˜ã€‚æ�®æ‚‰ï¼Œå¸‚å·¥å•†å±€åˆ¶å®šçš„æŽªæ–½åŒ…æ‹¬ï¼ŒåŠ å¼ºåŸŽå¸‚å‰¯ä¸­å¿ƒæ‰§æ³•æœºæž„è®¾ç½®ï¼Œä»Žç»„ç»‡ä¸ŠæŽ¨è¿›åŸºå±‚æ‰§æ³•åŠ›é‡�è�½å®žåˆ°ä¹¡é•‡ï¼›å……åˆ†åˆ©ç”¨å·¥å•†æ•°æ�®èµ„æº�ï¼Œä¸ºæœ�åŠ¡å‰¯ä¸­å¿ƒå�‘å±•å’Œå¸‚åœºç›‘ç®¡æ��ä¾›æ•°æ�®æ”¯æ’‘ï¼Œæ��ä¾›å‰¯ä¸­å¿ƒå¸‚åœºä¸»ä½“å�‘å±•æŠ¥å‘Šï¼›åœ¨å®žè¡ŒåŸŽå…­åŒºäº§ä¸šç¦�é™�ç›®å½•çš„åŸºç¡€ä¸Šï¼Œæ”¯æŒ�å‡ºå�°æ›´åŠ ä¸¥æ ¼çš„äº§ä¸šç¦�é™�æ”¿ç­–ï¼Œæ��å�‡å‰¯ä¸­å¿ƒå¸‚åœºä¸»ä½“è´¨é‡�ï¼ŒæŽ¨åŠ¨å‰¯ä¸­å¿ƒäº§ä¸šè½¬åž‹å�‡çº§ï¼›å……åˆ†å�‘æŒ¥äº¬æ´¥å†€ä¸‰åœ°å·¥å•†å’Œå¸‚åœºç›‘ç®¡å��ä½œå¹³å�°ä½œç”¨ï¼ŒåŠ å¼ºä¸‰åœ°åŸºå±‚å·¥å•†å’Œå¸‚åœºç›‘ç®¡éƒ¨é—¨æƒ…æŠ¥äº¤æµ�ã€�ä¿¡æ�¯å…±äº«å’Œæ‰§æ³•å��ä½œã€‚\n\n<br></p>', 'åŒ—äº¬å¸‚å±€å…¨åŠ›æœ�åŠ¡åŸŽå¸‚å‰¯ä¸­å¿ƒå»ºè®¾test', '2017-03-11 13:42:56', 'billJiang-test', '402880e456223e8f015625231d8e0003', '8a8a84995ab654d1015ab6759e960007,8a8a84995ab654d1015ab6759e9e0008', '402880e55a998466015a998e208d0003', '0');

-- ----------------------------
-- Table structure for tbl_message_attachment
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message_attachment`;
CREATE TABLE `tbl_message_attachment` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `messageid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mcncia3i9t8e3sakiasxap8gw` (`messageid`),
  CONSTRAINT `FK_mcncia3i9t8e3sakiasxap8gw` FOREIGN KEY (`messageid`) REFERENCES `tbl_message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_message_group
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message_group`;
CREATE TABLE `tbl_message_group` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `sort` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message_group
-- ----------------------------
INSERT INTO `tbl_message_group` VALUES ('402880e456223e8f015625231d8e0001', '2017-03-03 14:38:36', '0', '2017-03-03 14:38:41', '0', 'å¥½å�‹', 'test', '1', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group` VALUES ('402880e456223e8f015625231d8e0002', '2017-03-03 14:38:38', '0', '2017-03-03 14:38:44', '0', 'å�Œäº‹', 'test', '2', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group` VALUES ('402880e456223e8f015625231d8e0003', '2017-03-03 14:38:55', '0', '2017-03-03 14:38:59', '0', 'é¡¹ç›®ç»„', 'test', '3', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group` VALUES ('402880e45a9c67f5015a9c6a26d10000', '2017-03-05 11:01:26', '0', '2017-03-05 11:01:26', '0', 'test1', 'test1', '5', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group` VALUES ('402880e55a998466015a99894e020000', '2017-03-04 21:36:36', null, '2017-03-04 21:36:36', '0', '12', null, null, null);
INSERT INTO `tbl_message_group` VALUES ('402880e55a998466015a998e208d0003', '2017-03-04 21:41:52', null, '2017-03-04 21:41:52', '0', '33', null, null, '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group` VALUES ('402880e55a99936a015a999463000000', '2017-03-04 21:48:43', '0', '2017-03-04 21:48:43', '0', 'test', 'test', '5', '402880e456223e8f015625231d8e0003');

-- ----------------------------
-- Table structure for tbl_message_group_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message_group_user`;
CREATE TABLE `tbl_message_group_user` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `group_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message_group_user
-- ----------------------------
INSERT INTO `tbl_message_group_user` VALUES ('1', null, '0', null, '0', '402880e456223e8f015625231d8e0001', '1', '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_message_group_user` VALUES ('2', null, '0', null, '0', '402880e456223e8f015625231d8e0002', '1', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group_user` VALUES ('3', null, '0', null, '0', '402880e456223e8f015625231d8e0003', '1', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_message_group_user` VALUES ('402880e45a9c67f5015a9c6a26e20001', '2017-03-05 11:01:26', '0', '2017-03-05 11:01:26', '0', '402880e45a9c67f5015a9c6a26d10000', null, '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_message_group_user` VALUES ('402880e45a9c67f5015a9c6a26f40002', '2017-03-05 11:01:26', '0', '2017-03-05 11:01:26', '0', '402880e45a9c67f5015a9c6a26d10000', null, '4028818458d3f33d0158d40197dd0004');
INSERT INTO `tbl_message_group_user` VALUES ('402880e45a9c67f5015a9c6a26f40003', '2017-03-05 11:01:26', '0', '2017-03-05 11:01:26', '0', '402880e45a9c67f5015a9c6a26d10000', null, '402880e65a7facdb015a7fca61830000');
INSERT INTO `tbl_message_group_user` VALUES ('402880e45a9c67f5015a9c6a26f40004', '2017-03-05 11:01:26', '0', '2017-03-05 11:01:26', '0', '402880e45a9c67f5015a9c6a26d10000', null, '4028818458d40f4f0158d4169f9d0007');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a998466015a99894e0a0001', '2017-03-04 21:36:36', '0', '2017-03-04 21:36:36', '0', '402880e55a998466015a99894e020000', null, '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a998466015a99894e170002', '2017-03-04 21:36:36', '0', '2017-03-04 21:36:36', '0', '402880e55a998466015a99894e020000', null, '4028818458d3f33d0158d40197dd0004');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a998466015a998e208e0004', '2017-03-04 21:41:52', '0', '2017-03-04 21:41:52', '0', '402880e55a998466015a998e208d0003', null, '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a998466015a998e20900005', '2017-03-04 21:41:52', '0', '2017-03-04 21:41:52', '0', '402880e55a998466015a998e208d0003', null, '4028818458d3f33d0158d40197dd0004');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a998466015a998e20900006', '2017-03-04 21:41:52', '0', '2017-03-04 21:41:52', '0', '402880e55a998466015a998e208d0003', null, '402880e65a7facdb015a7fca61830000');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a99936a015a9994630d0001', '2017-03-04 21:48:43', '0', '2017-03-04 21:48:43', '0', '402880e55a99936a015a999463000000', null, '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_message_group_user` VALUES ('402880e55a99936a015a9994631b0002', '2017-03-04 21:48:43', '0', '2017-03-04 21:48:43', '0', '402880e55a99936a015a999463000000', null, '4028818458d3f33d0158d40197dd0004');

-- ----------------------------
-- Table structure for tbl_message_receiver
-- ----------------------------
DROP TABLE IF EXISTS `tbl_message_receiver`;
CREATE TABLE `tbl_message_receiver` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `isRead` varchar(255) DEFAULT NULL,
  `messageFlag` varchar(255) DEFAULT NULL,
  `messageType` varchar(255) DEFAULT NULL,
  `readTime` datetime DEFAULT NULL,
  `receiveAddress` varchar(255) DEFAULT NULL,
  `receiveUserID` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `message` varchar(36) DEFAULT NULL,
  `readYet` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_4opt20g1s1vej8lay6pb31sdp` (`message`),
  CONSTRAINT `FK_4opt20g1s1vej8lay6pb31sdp` FOREIGN KEY (`message`) REFERENCES `tbl_message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_message_receiver
-- ----------------------------
INSERT INTO `tbl_message_receiver` VALUES ('402880ed5abdfec1015ac02c89850004', '2017-03-12 09:40:28', '0', '2017-03-12 09:40:28', '0', '0', '0', '0,1', null, 'test@163.com', '402880e456223e8f0156223feee10000', null, '8a8a84995ab64a5c015ab64b8af10000', '0');
INSERT INTO `tbl_message_receiver` VALUES ('402880ed5abdfec1015ac02c89890005', '2017-03-12 09:40:28', '0', '2017-03-12 09:40:28', '0', '0', '0', '0,1', null, 'test@163.com', '402880e456223e8f0156225736a40001', null, '8a8a84995ab64a5c015ab64b8af10000', '0');
INSERT INTO `tbl_message_receiver` VALUES ('402880ed5abdfec1015ac02c898a0006', '2017-03-12 09:40:28', '1', '2017-03-12 09:40:28', '11', '0', '0', '0,1', null, 'test@163.com', '402880e456223e8f015625231d8e0003', null, '8a8a84995ab64a5c015ab64b8af10000', '0');
INSERT INTO `tbl_message_receiver` VALUES ('402880ed5abdfec1015ac02c898a0007', '2017-03-12 09:40:28', '0', '2017-03-12 09:40:28', '0', '0', '0', '0,1', null, 'test@163.com', '402880e65a7facdb015a7fca61830000', null, '8a8a84995ab64a5c015ab64b8af10000', '0');
INSERT INTO `tbl_message_receiver` VALUES ('402880ed5abdfec1015ac02c898a0008', '2017-03-12 09:40:28', '0', '2017-03-12 09:40:28', '0', '0', '0', '0,1', null, 'test@163.com', '4028818458d40f4f0158d4169f9d0007', null, '8a8a84995ab64a5c015ab64b8af10000', '0');

-- ----------------------------
-- Table structure for tbl_role
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role`;
CREATE TABLE `tbl_role` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `remark` longtext,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_role
-- ----------------------------
INSERT INTO `tbl_role` VALUES ('4028818a56fd502f015700209b040000', '2016-09-06 23:31:59', '0', '2017-01-04 09:25:43', '42', '1232', 'bill jiang', 'bill jiang \'s test', '2');
INSERT INTO `tbl_role` VALUES ('bc4d163c5880ab4901588b6681e50003', '2016-11-22 17:38:20', '0', '2016-11-22 17:38:20', '0', 'ADMIN', 'ç®¡ç�†å‘˜', '', '1');

-- ----------------------------
-- Table structure for tbl_role_function
-- ----------------------------
DROP TABLE IF EXISTS `tbl_role_function`;
CREATE TABLE `tbl_role_function` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `functionId` varchar(36) DEFAULT NULL,
  `roleId` varchar(36) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_role_function
-- ----------------------------
INSERT INTO `tbl_role_function` VALUES ('8a8a83295a8e4242015a8f49d1380000', '2017-03-02 21:51:04', null, '2017-03-02 21:51:04', '0', '402880eb56875b7f0156876338100000', 'bc4d163c5880ab4901588b6681e50003', null);
INSERT INTO `tbl_role_function` VALUES ('8a8a83295a8e4242015a8f49d1610001', '2017-03-02 21:51:04', null, '2017-03-02 21:51:04', '0', '402880eb56875b7f01568763ac630001', 'bc4d163c5880ab4901588b6681e50003', null);
INSERT INTO `tbl_role_function` VALUES ('8a8a83295a8e4242015a8f49d1620002', '2017-03-02 21:51:04', null, '2017-03-02 21:51:04', '0', '40288182579e398f0157a25ca29a0002', 'bc4d163c5880ab4901588b6681e50003', null);

-- ----------------------------
-- Table structure for tbl_simple_mail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_simple_mail`;
CREATE TABLE `tbl_simple_mail` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `content` longtext,
  `mail_type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `fromUser` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_simple_mail
-- ----------------------------
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f7d51500001', '2016-12-27 16:54:54', '0', '2016-12-27 16:54:54', '0', '<p>è¾…å¯¼è´¹<br></p>', 'bugå��é¦ˆ', '243232', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f7fcec10002', '2016-12-27 16:57:37', '0', '2016-12-27 16:57:37', '0', '<p>tttt<br></p>', 'æ„�è§�/å»ºè®®', 'test', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f9787440003', '2016-12-27 17:23:32', '0', '2016-12-27 17:23:32', '0', '<p>test<br></p>', 'æ„�è§�/å»ºè®®', 'test', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f980e700004', '2016-12-27 17:24:06', '0', '2016-12-27 17:24:06', '0', '<p>bug test<br></p>', 'bugå��é¦ˆ', 'test', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f9d09300005', '2016-12-27 17:29:33', '0', '2016-12-27 17:29:33', '0', '<p>ds<br></p>', 'æ„�è§�/å»ºè®®', 'dsd', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f9d31b90006', '2016-12-27 17:29:43', '0', '2016-12-27 17:29:43', '0', '<p>ds<br></p>', 'æ„�è§�/å»ºè®®', 'dsd', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593f9e4dcb0007', '2016-12-27 17:30:56', '0', '2016-12-27 17:30:56', '0', '<p>ttt<br></p>', 'bugå��é¦ˆ', 'ttt', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593fa018700008', '2016-12-27 17:32:53', '0', '2016-12-27 17:32:53', '0', '<p>test<br></p>', 'æ„�è§�/å»ºè®®', '243232', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593fa18e900009', '2016-12-27 17:34:29', '0', '2016-12-27 17:34:29', '0', '<p>3980-<br></p>', 'åˆ›æ„�/æƒ³æ³•', 'dsd', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593fa2ec27000a', '2016-12-27 17:35:59', '0', '2016-12-27 17:35:59', '0', '<p>test1234567<br></p>', 'æ„�è§�/å»ºè®®', 'test1234567', null);
INSERT INTO `tbl_simple_mail` VALUES ('40288193593f158301593fa5a57c000b', '2016-12-27 17:38:57', '0', '2016-12-27 17:38:57', '0', '<p>fdfd<br></p>', 'bugå��é¦ˆ', 'fdsfd', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a807a59633d0a0159634675a90000', '2017-01-03 15:41:19', '0', '2017-01-03 15:41:19', '0', '<p>bill jiangçš„æµ‹è¯•</p>', 'bugå��é¦ˆ', 'æˆ‘è¦�æµ‹è¯•', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a807a59633d0a01596346807a0001', '2017-01-03 15:41:21', '0', '2017-01-03 15:41:21', '0', '<p>bill jiangçš„æµ‹è¯•</p>', 'bugå��é¦ˆ', 'æˆ‘è¦�æµ‹è¯•', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a807a59633d0a0159634941b00002', '2017-01-03 15:44:22', '0', '2017-01-03 15:44:22', '0', '<p>\n<div>\n					<h2>2016ï¼Œæˆ‘ä»¬åŠªåŠ›æ‰“é€ æ›´ä¸°å¯Œã€�æ›´æ˜“ç”¨ã€�æ›´ä½Žæˆ�æœ¬çš„äº‘æ•°æ�®åº“ï¼Œè®©æ‚¨èŽ·å¾—æ›´é«˜æ€§ä»·æ¯”ï¼š</h2>\n					<ul>\n						\n							<li><div>239ä¸ª<br>åŠŸèƒ½ç‚¹</div><div>2016å¹´ï¼Œæ•°æ�®åº“å�‘å¸ƒäº†<br>239ä¸ªæ–°åŠŸèƒ½å�ŠåŠŸèƒ½<br>ä¼˜åŒ–</div></li>\n						\n							<li><div>5æ¬¾<br>æ–°äº§å“�</div><div>2016å¹´ï¼Œæ•°æ�®åº“å�‘å¸ƒäº†<br>5æ¬¾æ–°äº§å“�åŒ…æ‹¬äº‘æ•°æ�®åº“<br>MongoDBç‰ˆç­‰</div></li>\n						\n							<li><div>69%<br>æœ€é«˜é™�å¹…</div><div>2016å¹´ï¼Œæ•°æ�®åº“è¿›è¡Œäº†<br>2æ¬¡é™�ä»·å¹³å�‡é™�å¹…39%ï¼Œ<br>æœ€é«˜é™�å¹…69%</div></li>\n						\n					</ul>\n					<div>\n						<div>ä»–ä»¬éƒ½ä¿¡ä»»å’Œé€‰æ‹©é˜¿é‡Œäº‘æ•°æ�®åº“äº§å“�ï¼š</div>\n						<div>\n							\n								<div><img alt=\"\" src=\"https://img.alicdn.com/tps/TB1DkRYKXXXXXb0XpXXXXXXXXXX-140-140.png\"></div>\n							\n								<div><img alt=\"\" src=\"https://img.alicdn.com/tps/TB126T6KXXXXXc8XFXXXXXXXXXX-140-140.jpg\"></div>\n							\n								<div><img alt=\"\" src=\"https://img.alicdn.com/tps/TB12gchKXXXXXafXpXXXXXXXXXX-140-140.jpg\"></div>\n							\n								<div><img alt=\"\" src=\"http://pic.paopaoche.net/up/2015-3/201532141132.png\"></div>\n							\n								<div><img alt=\"\" src=\"https://img.alicdn.com/tps/TB1L6K8OVXXXXXoXpXXXXXXXXXX-256-256.png\"></div>\n							\n						</div>\n					</div>\n				</div>\n\n</p>', 'åˆ›æ„�/æƒ³æ³•', 'æˆ‘äº†ä¸ªå¤©', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a807a59633d0a0159634a98c50003', '2017-01-03 15:45:50', '0', '2017-01-03 15:45:50', '0', '<p>test</p>', 'bugå��é¦ˆ', 'bill jiangçš„æµ‹è¯•', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a807a59634b280159634c1eb20000', '2017-01-03 15:47:30', '0', '2017-01-03 15:47:30', '0', '<p>2017-01-03 15:46:50,132 [freemarker.cache]-[DEBUG] Could not find template in cache, creating new one; id=[\"homePage.html\"[\"zh_CN\",utf-8,parsed] ]<br>2017-01-03 15:46:50,134 [freemarker.cache]-[DEBUG] Compiling FreeMarker template \"homePage.html\"[\"zh_CN\",utf-8,parsed]  from \"C:\\\\work\\\\github\\\\AdminEAP\\\\AdminEAP-web\\\\src\\\\main\\\\webapp\\\\WEB-INF\\\\views\\\\homePage.html\"<br>2017-01-03 15:46:50,162 [freemarker.cache]-[DEBUG] \"homePage.html\"[\"zh_CN\",utf-8,parsed]  cached copy not yet stale; using cached.<br><a href=\"http://127.0.0.1:8080/AdminEAP/message/mail/edit\">http://127.0.0.1:8080/AdminEAP/message/mail/edit</a>ï»¿<br></p>', 'åˆ›æ„�/æƒ³æ³•', 'bill jiangçš„æµ‹è¯•', 'jrn1012@petrochina.com.cn');
INSERT INTO `tbl_simple_mail` VALUES ('8a8a80a0593fa68f01593fb4374b0000', '2016-12-27 17:54:52', '0', '2016-12-27 17:54:52', '0', '<p> \n<h1>1. è®¡è´¹æ–¹æ³•</h1><p>é‚®ä»¶æŽ¨é€�äº§å“�ï¼ˆDirect Mailï¼‰è®¡è´¹æ–¹æ³•æ˜¯æŒ‰ç…§é‚®ä»¶å�‘é€�é‡�è®¡è´¹ï¼Œç›®å‰�æœ‰ä¸¤ç§�ä»˜è´¹æ–¹å¼�ï¼šèµ„æº�åŒ…ã€�æŒ‰é‡�ä»˜è´¹ã€‚</p>\n<ul>\n<li><p>é‚®ä»¶å�‘é€�é‡�ï¼šæŒ‡é‚®ä»¶æŽ¨é€�ä¸ºç”¨æˆ·å�‘é€�çš„é‚®ä»¶æ€»é‡�ã€‚</p>\n</li><li><p>ä¸€å°�é‚®ä»¶çš„å®šä¹‰ä¸ºï¼šå�‘é€�è‡³ä¸€ä¸ªç”µå­�é‚®ä»¶åœ°å�€çš„ä¸€æ¬¡ç”µå­�é‚®ä»¶é€šä¿¡ã€‚å�‘é€�ç»™å¤šä¸ªæ”¶ä»¶äººçš„ä¸€æ¬¡ç”µå­�é‚®ä»¶é€šä¿¡å°†è§†ä¸ºåˆ†åˆ«å�‘æ¯�ä¸ªæ”¶ä»¶äººå�‘é€�ä¸€å°�é‚®ä»¶ã€‚</p>\n</li></ul>\n<h2><a target=\"_blank\" rel=\"nofollow\"></a>1.1 èµ„æº�åŒ…</h2><ol>\n<li>èµ„æº�åŒ…æ˜¯é¢„ä»˜è´¹æ–¹å¼�ï¼Œæ”¯ä»˜è´¹ç”¨è´­ä¹°æˆ�åŠŸå�Žï¼Œèµ„æº�åŒ…ç«‹å�³ç”Ÿæ•ˆã€‚</li><li>è´­ä¹°æ—¶é•¿ï¼ˆå�³æœ‰æ•ˆæœŸï¼‰ï¼š6ä¸ªæœˆã€‚æ¯�ä¸ªèµ„æº�åŒ…çš„æœ‰æ•ˆæœŸç‹¬ç«‹è®¡ç®—ï¼Œå¤šä¸ªèµ„æº�åŒ…æœ‰æ•ˆæœŸä¸�ä¼šå� åŠ ã€‚</li><li>æ‰£å‡�æ–¹å¼�ï¼šè´­ä¹°çš„èµ„æº�åŒ…åœ¨æœ‰æ•ˆæœŸå†…ï¼Œä¼˜å…ˆæŠµæ‰£èµ„æº�åŒ…å†…çš„é‚®ä»¶é‡�ï¼Œå¤šä¸ªèµ„æº�åŒ…æŒ‰æœ‰æ•ˆæœŸå…ˆç»“æ�Ÿçš„ä¼˜å…ˆæ‰£å‡�ï¼Œå½“æ‰€æœ‰èµ„æº�åŒ…æ‰£å‡�å®Œæ¯•å�Žï¼Œè‡ªåŠ¨è½¬ä¸ºæŒ‰é‡�è®¡è´¹çš„æ–¹å¼�æ‰£å‡�ã€‚</li><li><strong>èµ„æº�åŒ…ä½¿ç”¨å�Žæˆ–èµ„æº�åŒ…åˆ°æœŸå�Žï¼Œå‰©ä½™æµ�é‡�ä¸�æ”¯æŒ�é€€è®¢ã€�ä¸�æ”¯æŒ�é€€æ¬¾ã€‚</strong></li></ol>\n\n<br></p>', 'æ„�è§�/å»ºè®®', 'test1234567', null);
INSERT INTO `tbl_simple_mail` VALUES ('8a8a81d65a3ba9a5015a3c23fe7d0000', '2017-02-14 18:21:16', '0', '2017-02-14 18:21:16', '0', '<p>test<br></p>', 'bugå��é¦ˆ', 'test', 'test');
INSERT INTO `tbl_simple_mail` VALUES ('8a8a81d65a3c252f015a3c25e0350000', '2017-02-14 18:23:19', '0', '2017-02-14 18:23:19', '0', '<p>test<br></p>', 'æ„�è§�/å»ºè®®', 'test1', 'test');
INSERT INTO `tbl_simple_mail` VALUES ('8a8a81d65a3c285d015a3c28e0c80000', '2017-02-14 18:26:36', '0', '2017-02-14 18:26:36', '0', '<p>ffff<br></p>', 'æ„�è§�/å»ºè®®', 'test1233434534', 'test1');

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `login_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `open_account` varchar(5) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `telphone` varchar(255) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `isSuperAdmin` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('1f150ec4321411e6a46d10a0f3df85fa', '2016-06-14 17:41:14', '0', '2016-06-14 17:41:14', '1', null, '2016-06-14 17:41:14', 'test@163.com', 'tester', '13813888888', 'tester3', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('23c87eb0321411e6a46d10a0f3df85fa', '2016-06-14 17:41:22', '0', '2016-06-14 17:41:22', '1', null, '2016-06-14 17:41:22', 'test@163.com', 'tester', '13813888888', 'tester5', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('23e6e45d321411e6a46d10a0f3df85fa', '2016-06-14 17:41:23', '0', '2016-12-05 19:35:29', '13', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester6', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2405dc64321411e6a46d10a0f3df85fa', '2016-06-14 17:41:23', '0', '2016-06-14 17:41:23', '1', null, '2016-06-14 17:41:23', 'test@163.com', 'tester', '13813888888', 'tester7', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('24961408321411e6a46d10a0f3df85fa', '2016-06-14 17:41:24', '0', '2016-07-26 22:24:16', '2', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester9', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('24b7164a321411e6a46d10a0f3df85fa', '2016-06-14 17:41:24', '0', '2016-06-14 17:41:24', '1', null, '2016-06-14 17:41:24', 'test@163.com', 'tester', '13813888888', 'tester10', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('24f40c7b321411e6a46d10a0f3df85fa', '2016-06-14 17:41:24', '0', '2016-12-05 19:51:00', '2', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester12', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2510c36e321411e6a46d10a0f3df85fa', '2016-06-14 17:41:24', '0', '2016-06-14 17:41:24', '1', null, '2016-06-14 17:41:24', 'test@163.com', 'tester', '13813888888', 'tester13', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('252caeaf321411e6a46d10a0f3df85fa', '2016-06-14 17:41:25', '0', '2016-06-14 17:41:25', '1', null, '2016-06-14 17:41:25', 'test@163.com', 'tester', '13813888888', 'tester14', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('254f9b64321411e6a46d10a0f3df85fa', '2016-06-14 17:41:25', '0', '2016-12-05 19:44:37', '13', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester15', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('25713641321411e6a46d10a0f3df85fa', '2016-06-14 17:41:25', '0', '2016-06-14 17:41:25', '1', null, '2016-06-14 17:41:25', 'test@163.com', 'tester', '13813888888', 'tester16', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('25924d86321411e6a46d10a0f3df85fa', '2016-06-14 17:41:25', '0', '2016-12-05 21:27:23', '2', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester17', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('25b24324321411e6a46d10a0f3df85fa', '2016-06-14 17:41:26', '0', '2016-06-14 17:41:26', '1', null, '2016-06-14 17:41:26', 'test@163.com', 'tester', '13813888888', 'tester18', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('25eff07c321411e6a46d10a0f3df85fa', '2016-06-14 17:41:26', '0', '2016-06-14 17:41:26', '1', null, '2016-06-14 17:41:26', 'test@163.com', 'tester', '13813888888', 'tester20', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('262a3774321411e6a46d10a0f3df85fa', '2016-06-14 17:41:26', '0', '2016-06-14 17:41:26', '1', null, '2016-06-14 17:41:26', 'test@163.com', 'tester', '13813888888', 'tester21', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('266ce1a2321411e6a46d10a0f3df85fa', '2016-06-14 17:41:27', '0', '2016-06-14 17:41:27', '1', null, '2016-06-14 17:41:27', 'test@163.com', 'tester', '13813888888', 'tester23', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('268d44bf321411e6a46d10a0f3df85fa', '2016-06-14 17:41:27', '0', '2016-06-14 17:41:27', '1', null, '2016-06-14 17:41:27', 'test@163.com', 'tester', '13813888888', 'tester24', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('26abb5d0321411e6a46d10a0f3df85fa', '2016-06-14 17:41:27', '0', '2016-06-14 17:41:27', '1', null, '2016-06-14 17:41:27', 'test@163.com', 'tester', '13813888888', 'tester25', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('26cabdc3321411e6a46d10a0f3df85fa', '2016-06-14 17:41:27', '0', '2016-06-14 17:41:27', '1', null, '2016-06-14 17:41:27', 'test@163.com', 'tester', '13813888888', 'tester26', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('275a01e2321411e6a46d10a0f3df85fa', '2016-06-14 17:41:28', '0', '2016-12-05 19:47:31', '5', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester31fdsfdsf', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('27773eda321411e6a46d10a0f3df85fa', '2016-06-14 17:41:29', '0', '2016-12-05 19:47:21', '6', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester32', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2793c5eb321411e6a46d10a0f3df85fa', '2016-06-14 17:41:29', '0', '2016-07-29 12:30:52', '4', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', '243567890', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('27b24306321411e6a46d10a0f3df85fa', '2016-06-14 17:41:29', '0', '2016-06-14 17:41:29', '1', null, '2016-06-14 17:41:29', 'test@163.com', 'tester', '13813888888', 'tester34', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('27cc52be321411e6a46d10a0f3df85fa', '2016-06-14 17:41:29', '0', '2016-06-14 17:41:29', '1', null, '2016-06-14 17:41:29', 'test@163.com', 'tester', '13813888888', 'tester35', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('27ea2ce3321411e6a46d10a0f3df85fa', '2016-06-14 17:41:29', '0', '2016-06-14 17:41:29', '1', null, '2016-06-14 17:41:29', 'test@163.com', 'tester', '13813888888', 'tester36', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('28268c27321411e6a46d10a0f3df85fa', '2016-06-14 17:41:30', '0', '2016-06-14 17:41:30', '1', null, '2016-06-14 17:41:30', 'test@163.com', 'tester', '13813888888', 'tester38', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2d7e7f00321411e6a46d10a0f3df85fa', '2016-06-14 17:41:39', '0', '2016-07-26 22:15:37', '5', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester39fdsfsdfds', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2d9b6d58321411e6a46d10a0f3df85fa', '2016-06-14 17:41:39', '0', '2016-06-14 17:41:39', '1', null, '2016-06-14 17:41:39', 'test@163.com', 'tester', '13813888888', 'tester40', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2db9a18c321411e6a46d10a0f3df85fa', '2016-06-14 17:41:39', '0', '2016-06-14 17:41:39', '1', null, '2016-06-14 17:41:39', 'test@163.com', 'tester', '13813888888', 'tester41', '1', '070501020f040600050c050a0d0b020902070501', null, '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2dd55c4e321411e6a46d10a0f3df85fa', '2016-06-14 17:41:39', '0', '2016-10-07 17:20:11', '10', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester42', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2df1e46d321411e6a46d10a0f3df85fa', '2016-06-14 17:41:39', '0', '2016-07-26 22:05:08', '3', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester43', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('2e5f797a321411e6a46d10a0f3df85fa', '2016-06-14 17:41:40', '0', '2016-07-26 22:24:27', '4', null, '2016-06-14 00:00:00', 'test@163.com', 'tester', '13813888888', 'tester45', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '1');
INSERT INTO `tbl_user` VALUES ('402880e456223e8f0156223feee10000', '2016-07-25 21:30:30', '0', '2016-10-07 17:19:19', '3', null, '2016-07-06 00:00:00', 'test@163.com', 'jrn', '13813888888', 'billJiang', null, '070501020f040600050c050a0d0b020902070501', '475572229', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('402880e456223e8f0156225736a40001', '2016-07-25 21:55:56', '0', '2016-12-05 19:47:14', '9', null, '2016-07-06 00:00:00', 'test@163.com', 'jrn', '13813888888', 'billJiang', null, '070501020f040600050c050a0d0b020902070501', '475572229', '1', '', null, '');
INSERT INTO `tbl_user` VALUES ('402880e456223e8f015625231d8e0003', '2016-07-26 19:02:18', null, '2016-07-26 18:59:59', '2', null, '2016-07-22 00:00:00', 'test@163.com', 'test', '13813888888', 'billJiang-test', null, '070501020f040600050c050a0d0b020902070501', '475572229', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('402880e65a7facdb015a7fca61830000', '2017-02-27 21:37:34', '0', '2017-03-13 14:37:43', '1', null, '2017-02-16 00:00:00', 'test@163.com', 'test', '', '12345678', null, null, '', '1', '', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d281780158d31c9d940000', '2016-12-06 15:50:17', '0', '2016-12-06 15:51:30', '1', null, '2016-12-18 00:00:00', 'test@163.com', 'fd', '13813888888', '12345678', null, '070501020f040600050c050a0d0b020902070501', '', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d3f33d0158d3f5ca120001', '2016-12-06 19:47:30', '0', '2016-12-06 19:47:30', '0', null, '2016-12-19 00:00:00', 'test@163.com', 'tester', '13813888888', '232323', null, '070501020f040600050c050a0d0b020902070501', '', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d3f33d0158d400a71c0003', '2016-12-06 19:59:22', '0', '2016-12-06 19:59:22', '0', null, '2016-12-05 00:00:00', 'test@163.com', 'tester', '13813888888', 'fdfs', null, '070501020f040600050c050a0d0b020902070501', '', '1', 'test', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d3f33d0158d40197dd0004', '2016-12-06 20:00:24', '0', '2017-03-13 14:34:45', '8', null, '2017-02-28 00:00:00', 'test@163.com', 'tester', '13813888888', 'test', null, null, '', '1', 'test', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d3f33d0158d407b7de0005', '2016-12-06 20:07:05', '0', '2016-12-06 20:07:05', '0', null, '2016-12-01 00:00:00', 'jrn1012@petrochina.com.cn', 'tester', '13813888888', 'TEST1243433', null, '070501020f040600050c050a0d0b020902070501', '', '1', '13601047561', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d40f4f0158d4108eb60001', '2016-12-06 20:16:44', '0', '2017-03-13 14:41:14', '6', null, '2017-02-15 00:00:00', '517208243@qq.com', '43', '13813888888', '1234567765432', null, null, '475572229', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('4028818458d40f4f0158d4169f9d0007', '2016-12-06 20:23:22', '0', '2017-02-20 14:59:54', '3', null, '2017-02-23 00:00:00', 'test@163.com', '2', '2', '1323232', null, null, '', '1', '2', null, '');
INSERT INTO `tbl_user` VALUES ('8a8a801b58c829670158c86deb5a0000', '2016-12-04 14:03:16', null, '2016-12-04 14:03:16', '0', null, '2016-11-29 00:00:00', 'test@163.com', '11', '13813888888', 'fdfs', null, '070501020f040600050c050a0d0b020902070501', '', '1', '01083595052', null, '');
INSERT INTO `tbl_user` VALUES ('8a8a801b58ce0f500158ce7999690001', '2016-12-05 18:13:45', '0', '2016-12-05 19:45:29', '2', null, '2016-12-01 00:00:00', 'test@163.com', 'tester', '13813888888', 'hello world', null, '070501020f040600050c050a0d0b020902070501', '475572229', '1', '13601047561', null, '');
INSERT INTO `tbl_user` VALUES ('8afa96f6564a787601564a79fd970000', '2016-08-02 16:58:44', '0', '2016-12-05 19:44:54', '2', null, '2016-02-29 00:00:00', 'test@163.com', 'tt', '13813888888', 'test', null, '070501020f040600050c050a0d0b020902070501', '', '0', 'test', null, '');
INSERT INTO `tbl_user` VALUES ('8afa96f6564a787601564a818bf80002', '2016-08-02 17:06:59', '0', '2016-09-02 22:26:01', '1', null, '2016-03-03 00:00:00', 'test@163.com', 'qqqfr', '13813888888', 'zzz', null, '070501020f040600050c050a0d0b020902070501', '10599w2e3de', '1', '', null, '');

-- ----------------------------
-- Table structure for tbl_user_avatar
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_avatar`;
CREATE TABLE `tbl_user_avatar` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `src` varchar(255) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_avatar
-- ----------------------------
INSERT INTO `tbl_user_avatar` VALUES ('4028818458d40f4f0158d41667830006', '2016-12-06 20:23:07', null, '2016-12-11 16:42:17', '3', '1323232_1481445737480.jpg', '\\uploadPath\\avatar\\1323232_1481445737480.jpg', '4028818458d40f4f0158d4169f9d0007');
INSERT INTO `tbl_user_avatar` VALUES ('8a8a83295a845220015a847d3e3c0000', '2017-02-28 19:31:24', null, '2017-02-28 19:31:24', '0', '1234567765432_1488281484853.jpg', '\\uploadPath\\avatar\\1234567765432_1488281484853.jpg', '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_user_avatar` VALUES ('8afa96f658f1071d0158f10892a80000', '2016-12-12 11:17:00', null, '2016-12-12 11:17:00', '0', 'new_1481512619938.jpg', '\\uploadPath\\avatar\\new_1481512619938.jpg', '0');
INSERT INTO `tbl_user_avatar` VALUES ('8afa96f658f1071d0158f109333f0001', '2016-12-12 11:17:41', null, '2016-12-12 11:17:41', '0', 'new_1481512661820.jpg', '\\uploadPath\\avatar\\new_1481512661820.jpg', '0');

-- ----------------------------
-- Table structure for tbl_user_oauth
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_oauth`;
CREATE TABLE `tbl_user_oauth` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `oauth_id` varchar(255) DEFAULT NULL,
  `oauth_type` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_oauth
-- ----------------------------
INSERT INTO `tbl_user_oauth` VALUES ('402880e459a7cb440159a7d0793b0001', '2017-01-16 23:06:14', null, '2017-01-16 23:06:14', '0', '7886696', 'github', '402880e459a7cb440159a7d079220000', null);

-- ----------------------------
-- Table structure for tbl_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_role`;
CREATE TABLE `tbl_user_role` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `roleId` varchar(36) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ds15bcoaufaq7shnl3445nc3o` (`userId`) USING BTREE,
  CONSTRAINT `tbl_user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `tbl_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_role
-- ----------------------------
INSERT INTO `tbl_user_role` VALUES ('4028819359637b580159638f46a00001', '2017-01-03 17:00:51', null, '2017-01-03 17:00:51', '0', 'bc4d163c5880ab4901588b6681e50003', '4028818458d40f4f0158d4108eb60001');
INSERT INTO `tbl_user_role` VALUES ('4028819359637b580159638f46a10002', '2017-01-03 17:00:51', null, '2017-01-03 17:00:51', '0', 'bc4d163c5880ab4901588b6681e50003', '4028818458d3f33d0158d400a71c0003');
INSERT INTO `tbl_user_role` VALUES ('4028819359637b580159638f46a10003', '2017-01-03 17:00:51', null, '2017-01-03 17:00:51', '0', 'bc4d163c5880ab4901588b6681e50003', '4028818458d3f33d0158d3f5ca120001');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927b94030001', '2017-01-12 19:41:29', null, '2017-01-12 19:41:29', '0', 'bc4d163c5880ab4901588b6681e50003', '402880e456223e8f015625231d8e0003');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bb1d40002', '2017-01-12 19:41:37', null, '2017-01-12 19:41:37', '0', 'bc4d163c5880ab4901588b6681e50003', '2e5f797a321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bb1d50003', '2017-01-12 19:41:37', null, '2017-01-12 19:41:37', '0', 'bc4d163c5880ab4901588b6681e50003', '27ea2ce3321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bbef30004', '2017-01-12 19:41:40', null, '2017-01-12 19:41:40', '0', 'bc4d163c5880ab4901588b6681e50003', '24961408321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bbef40005', '2017-01-12 19:41:40', null, '2017-01-12 19:41:40', '0', 'bc4d163c5880ab4901588b6681e50003', '268d44bf321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf0007', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '2df1e46d321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf0008', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '2d9b6d58321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf0009', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '2db9a18c321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000a', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '28268c27321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000b', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '27b24306321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000c', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '27cc52be321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000d', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '266ce1a2321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000e', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '26abb5d0321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bdbcf000f', '2017-01-12 19:41:47', null, '2017-01-12 19:41:47', '0', 'bc4d163c5880ab4901588b6681e50003', '26cabdc3321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6ae0010', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '25b24324321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00011', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '25eff07c321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00012', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '262a3774321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00013', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '252caeaf321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00014', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '25713641321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00015', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '24b7164a321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b00016', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '2510c36e321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b10017', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '2405dc64321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b10018', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '23c87eb0321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927bf6b10019', '2017-01-12 19:41:54', null, '2017-01-12 19:41:54', '0', 'bc4d163c5880ab4901588b6681e50003', '1f150ec4321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a95001a', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '4028818458d3f33d0158d407b7de0005');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a96001b', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '4028818458d3f33d0158d40197dd0004');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a96001c', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '25924d86321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a96001d', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '24f40c7b321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a96001e', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '275a01e2321411e6a46d10a0f3df85fa');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a960020', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '8afa96f6564a787601564a79fd970000');
INSERT INTO `tbl_user_role` VALUES ('8a8a859359927a930159927c2a960021', '2017-01-12 19:42:08', null, '2017-01-12 19:42:08', '0', 'bc4d163c5880ab4901588b6681e50003', '254f9b64321411e6a46d10a0f3df85fa');



DROP TABLE IF EXISTS `tbl_alert_rule`;
CREATE TABLE `tbl_alert_rule` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cron` varchar(255) DEFAULT NULL,
  `textCondition` varchar(255) DEFAULT NULL,
  `timeRange` varchar(255) DEFAULT NULL,
  `resultNumCompareFlag` varchar(255) DEFAULT NULL,
  `resultNumCompareNum` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `email_subject` varchar(255) DEFAULT NULL,
  `email_body` varchar(255) DEFAULT NULL,
  `restrain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_alert_history`;
CREATE TABLE `tbl_alert_history` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `id_alert_rule` varchar(255) DEFAULT NULL,
  `rule_name` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `email_subject` varchar(255) DEFAULT NULL,
  `email_body` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_system_flow`;
CREATE TABLE `tbl_system_flow` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `tracknumtype` varchar(255) DEFAULT NULL,
  `nodeno` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nomarl_pattern` varchar(255) DEFAULT NULL,
  `exception_pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_saved_query`;
CREATE TABLE `tbl_system_flow` (
  `id` varchar(36) NOT NULL,
  `create_date_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `update_date_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
