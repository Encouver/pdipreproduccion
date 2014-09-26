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

Date: 2014-09-26 11:36:07
*/


-- ----------------------------
-- Table structure for proyectos
-- ----------------------------
DROP TABLE IF EXISTS "pdi"."proyectos";
CREATE TABLE "pdi"."proyectos" (
"id" int4 DEFAULT nextval('"pdi".proyectos_id_seq'::regclass) NOT NULL,
"objetivoproducto" text COLLATE "default" NOT NULL,
"nom_proyecto" text COLLATE "default" NOT NULL,
"puntoreferencia" text COLLATE "default" NOT NULL,
"calleavenida" text COLLATE "default" NOT NULL,
"coordenadasutm" text COLLATE "default" NOT NULL,
"empresa_id" int4 NOT NULL,
"tipo_proyecto_id" int4 NOT NULL,
"estado_id" int4 NOT NULL,
"municipio_id" int4 NOT NULL,
"ciudad" varchar(30) COLLATE "default" NOT NULL,
"fecha_registro" timestamp(6) DEFAULT now() NOT NULL,
"estatus" varchar(1) COLLATE "default" DEFAULT 1 NOT NULL,
"mes_inicio" varchar(15) COLLATE "default" NOT NULL,
"ano_inicio" varchar(4) COLLATE "default" NOT NULL,
"mes_fin" varchar(15) COLLATE "default" NOT NULL,
"ano_fin" varchar(4) COLLATE "default" NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of proyectos
-- ----------------------------
INSERT INTO "pdi"."proyectos" VALUES ('3', 'Diseño de computadores', 'Cataplam', 'asdf', 'asdf', '1', '1', '1', '1', '1', 'gffg', '2014-09-26 11:29:59', '1', '1', '1', '2', '1');

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table proyectos
-- ----------------------------
ALTER TABLE "pdi"."proyectos" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Key structure for table "pdi"."proyectos"
-- ----------------------------
ALTER TABLE "pdi"."proyectos" ADD FOREIGN KEY ("tipo_proyecto_id") REFERENCES "pdi"."tipoproyectos" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
