/*
Navicat PGSQL Data Transfer

Source Server         : PostgreSQL
Source Server Version : 90204
Source Host           : localhost:5432
Source Database       : prueba
Source Schema         : pdi

Target Server Type    : PGSQL
Target Server Version : 90204
File Encoding         : 65001

Date: 2014-09-26 11:36:14
*/


-- ----------------------------
-- Table structure for tipoproyectos
-- ----------------------------
DROP TABLE IF EXISTS "pdi"."tipoproyectos";
CREATE TABLE "pdi"."tipoproyectos" (
"id" int4 DEFAULT nextval('"pdi".tipoproyectos_id_seq'::regclass) NOT NULL,
"descripcion" varchar(20) COLLATE "default" NOT NULL,
"fecha_registro" timestamp(6) DEFAULT now() NOT NULL,
"estatus" varchar(1) COLLATE "default" DEFAULT 1 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of tipoproyectos
-- ----------------------------
INSERT INTO "pdi"."tipoproyectos" VALUES ('1', 'computadoras', '2014-09-24 11:30:48', 's');

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table tipoproyectos
-- ----------------------------
ALTER TABLE "pdi"."tipoproyectos" ADD PRIMARY KEY ("id");
