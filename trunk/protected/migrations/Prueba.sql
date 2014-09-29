--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-09-29 10:14:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 157289)
-- Name: odbclink; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA odbclink;


ALTER SCHEMA odbclink OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 157290)
-- Name: pdi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pdi;


ALTER SCHEMA pdi OWNER TO postgres;

--
-- TOC entry 228 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 228
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 229 (class 3079 OID 157291)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 229
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET search_path = odbclink, pg_catalog;

--
-- TOC entry 620 (class 1247 OID 157339)
-- Name: conns; Type: TYPE; Schema: odbclink; Owner: postgres
--

CREATE TYPE conns AS (
	id integer,
	connected boolean,
	dsn text,
	uid text,
	pwd text,
	connstr text
);


ALTER TYPE odbclink.conns OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 283 (class 1255 OID 157340)
-- Name: unnest(anyarray); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION unnest(anyarray) RETURNS SETOF anyelement
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
select $1[i] from generate_series(array_lower($1,1), array_upper($1,1)) as i
$_$;


ALTER FUNCTION public.unnest(anyarray) OWNER TO postgres;

SET search_path = pdi, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 157341)
-- Name: activos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE activos (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.activos OWNER TO postgres;

--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.id IS 'numero secuencial para identificar el activo';


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.descripcion IS 'descripción del activo';


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.fecha_registro IS 'fecha de registro del activo';


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.valido IS 'campo para indicar si el registro esta vigente (1) o no (0)';


--
-- TOC entry 175 (class 1259 OID 157346)
-- Name: activos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE activos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.activos_id_seq OWNER TO postgres;

--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE activos_id_seq OWNED BY activos.id;


--
-- TOC entry 176 (class 1259 OID 157348)
-- Name: arancelesempresas; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE arancelesempresas (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    cod_arancelario integer NOT NULL,
    unidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    monto_anual double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL
);


ALTER TABLE pdi.arancelesempresas OWNER TO postgres;

--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.id IS 'numero secuencial de para identificar los aranceles de las empresas';


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.descripcion IS 'descripción del arancel';


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.empresa_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.empresa_id IS 'campo foráneo que contiene el identificador de la empresa que viene de la tabla gen_juridico de BDCADIVI';


--
-- TOC entry 177 (class 1259 OID 157353)
-- Name: arancelesempresas_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE arancelesempresas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.arancelesempresas_id_seq OWNER TO postgres;

--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE arancelesempresas_id_seq OWNED BY arancelesempresas.id;


--
-- TOC entry 178 (class 1259 OID 157355)
-- Name: archivo_estatus; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE archivo_estatus (
    archivo_id integer NOT NULL,
    estatus_id integer NOT NULL,
    valido character varying(1),
    fecha_registro timestamp without time zone DEFAULT now()
);


ALTER TABLE pdi.archivo_estatus OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 157359)
-- Name: archivo_presupuestos_tmp; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE archivo_presupuestos_tmp (
    codarancel_id integer,
    unidad_id integer,
    fecha_cierre date,
    montousd double precision,
    cantidad integer NOT NULL,
    num_empleados integer,
    fecha_registro timestamp without time zone DEFAULT now(),
    valido character varying(1) NOT NULL,
    empresa_id integer,
    id_archivo_presupuesto integer NOT NULL
);


ALTER TABLE pdi.archivo_presupuestos_tmp OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 157728)
-- Name: archivoscsv; Type: TABLE; Schema: pdi; Owner: divisa; Tablespace: 
--

CREATE TABLE archivoscsv (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    archivo character varying(255) NOT NULL,
    tipo_csv character varying(25) NOT NULL,
    fecha date DEFAULT now() NOT NULL
);


ALTER TABLE pdi.archivoscsv OWNER TO divisa;

--
-- TOC entry 224 (class 1259 OID 157732)
-- Name: archivoscsv_id_seq; Type: SEQUENCE; Schema: pdi; Owner: divisa
--

CREATE SEQUENCE archivoscsv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.archivoscsv_id_seq OWNER TO divisa;

--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 224
-- Name: archivoscsv_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: divisa
--

ALTER SEQUENCE archivoscsv_id_seq OWNED BY archivoscsv.id;


--
-- TOC entry 180 (class 1259 OID 157363)
-- Name: bienes; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE bienes (
    id integer NOT NULL,
    codarancel_id integer NOT NULL,
    unidad_id integer NOT NULL,
    cant_pro_actual double precision NOT NULL,
    capac_max_anual_actual double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.bienes OWNER TO postgres;

--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.id IS 'número secuencial de identificación de los bienes';


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 181 (class 1259 OID 157368)
-- Name: bienes_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE bienes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.bienes_id_seq OWNER TO postgres;

--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE bienes_id_seq OWNED BY bienes.id;


--
-- TOC entry 194 (class 1259 OID 157409)
-- Name: cronogramas; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE cronogramas (
    insumo character varying(30),
    cod_arancelario integer,
    unidad_id integer,
    cantidad integer,
    costo_total real,
    fecha_estimada date,
    fecha_registro date DEFAULT now(),
    valido character varying(1),
    proyecto_id integer,
    tipo character varying(100),
    id integer NOT NULL
);


ALTER TABLE pdi.cronogramas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 157753)
-- Name: cronograma_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE cronograma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.cronograma_id_seq OWNER TO postgres;

--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 225
-- Name: cronograma_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE cronograma_id_seq OWNED BY cronogramas.id;


--
-- TOC entry 182 (class 1259 OID 157370)
-- Name: datosbasicos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE datosbasicos (
    id integer NOT NULL,
    num_declaracion character varying(10) NOT NULL,
    fecha_islr date NOT NULL,
    monto_islr double precision NOT NULL,
    num_empleados integer NOT NULL,
    numero_declaracionivss character varying(10) NOT NULL,
    fecha_ivss date NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE pdi.datosbasicos OWNER TO postgres;

--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN datosbasicos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.id IS 'número secuencial que identifica el conjunto de datos basicos de la empresas';


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN datosbasicos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 183 (class 1259 OID 157375)
-- Name: datosbasicos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE datosbasicos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.datosbasicos_id_seq OWNER TO postgres;

--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 183
-- Name: datosbasicos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE datosbasicos_id_seq OWNED BY datosbasicos.id;


--
-- TOC entry 184 (class 1259 OID 157377)
-- Name: entidadesfinancieras; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE entidadesfinancieras (
    id integer NOT NULL,
    financiamiento_id integer NOT NULL,
    capitalfinanciado double precision NOT NULL,
    banco_id integer NOT NULL,
    tasainteres double precision NOT NULL,
    anualidades double precision NOT NULL,
    plazoprestamo date NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.entidadesfinancieras OWNER TO postgres;

--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.id IS 'número secuencial que identifica la entidad financiera';


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.financiamiento_id IS 'campo foráneo que viene de la tabla financiamientos';


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 185 (class 1259 OID 157382)
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE entidadesfinancieras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.entidadesfinancieras_id_seq OWNER TO postgres;

--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 185
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE entidadesfinancieras_id_seq OWNED BY entidadesfinancieras.id;


--
-- TOC entry 186 (class 1259 OID 157384)
-- Name: estado; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE pdi.estado OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 157387)
-- Name: estatus; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE estatus (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    fecha_registro date,
    valido character varying(1) NOT NULL
);


ALTER TABLE pdi.estatus OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 157390)
-- Name: exportaciones_paises; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE exportaciones_paises (
    id integer NOT NULL,
    cpais character varying(6),
    cronograma_id integer,
    proyecto_id integer NOT NULL
);


ALTER TABLE pdi.exportaciones_paises OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 157393)
-- Name: exportaciones_paises_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE exportaciones_paises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.exportaciones_paises_id_seq OWNER TO postgres;

--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 189
-- Name: exportaciones_paises_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE exportaciones_paises_id_seq OWNED BY exportaciones_paises.id;


--
-- TOC entry 190 (class 1259 OID 157395)
-- Name: financiamientos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE financiamientos (
    id integer NOT NULL,
    capitalpropio double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    tipo_financiamiento_id integer NOT NULL
);


ALTER TABLE pdi.financiamientos OWNER TO postgres;

--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN financiamientos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.id IS 'número secuencial para identificar el financiamiento';


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN financiamientos.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.proyecto_id IS 'campo foránero que viene de la tabla proyectos';


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN financiamientos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN financiamientos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN financiamientos.tipo_financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.tipo_financiamiento_id IS 'campo foráneo que viene de la tabla tipo financiamiento';


--
-- TOC entry 191 (class 1259 OID 157400)
-- Name: financiamientos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE financiamientos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.financiamientos_id_seq OWNER TO postgres;

--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 191
-- Name: financiamientos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE financiamientos_id_seq OWNED BY financiamientos.id;


--
-- TOC entry 192 (class 1259 OID 157402)
-- Name: flujocajas; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE flujocajas (
    id integer NOT NULL,
    inversion double precision NOT NULL,
    prestamo double precision NOT NULL,
    ingresos double precision NOT NULL,
    costos double precision NOT NULL,
    reinversion double precision NOT NULL,
    valor_residual double precision NOT NULL,
    pagos double precision NOT NULL,
    depreciacion_negativo double precision NOT NULL,
    utilidad_antesimp double precision NOT NULL,
    utilidad_despuesimp double precision NOT NULL,
    impuestos double precision NOT NULL,
    depreciacion_positivo double precision NOT NULL,
    flujo_operativo double precision NOT NULL,
    flujo_proyectado double precision NOT NULL,
    ingresos_rcb double precision NOT NULL,
    costos_rcb double precision NOT NULL,
    ingresos_rcbact double precision NOT NULL,
    costos_rcbact double precision NOT NULL,
    fecha_registro date DEFAULT now(),
    estatus character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL,
    periodo integer NOT NULL,
    ano integer NOT NULL
);


ALTER TABLE pdi.flujocajas OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 157407)
-- Name: flujocajas_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE flujocajas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.flujocajas_id_seq OWNER TO postgres;

--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 193
-- Name: flujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE flujocajas_id_seq OWNED BY flujocajas.id;


--
-- TOC entry 195 (class 1259 OID 157412)
-- Name: municipio; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE municipio (
    id integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE pdi.municipio OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 157415)
-- Name: parroquia; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE parroquia (
    id integer NOT NULL,
    descripcion character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE pdi.parroquia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 157777)
-- Name: periodos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE periodos (
    id integer NOT NULL,
    nombre character varying(45) NOT NULL,
    valor integer NOT NULL
);


ALTER TABLE pdi.periodos OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 157775)
-- Name: periodos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE periodos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.periodos_id_seq OWNER TO postgres;

--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 226
-- Name: periodos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE periodos_id_seq OWNED BY periodos.id;


--
-- TOC entry 197 (class 1259 OID 157418)
-- Name: planinversion; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE planinversion (
    id integer NOT NULL,
    activo_id integer NOT NULL,
    monto_total double precision NOT NULL,
    fondospropios double precision NOT NULL,
    financiamiento double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE pdi.planinversion OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 157423)
-- Name: planinversion_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE planinversion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.planinversion_id_seq OWNER TO postgres;

--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 198
-- Name: planinversion_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE planinversion_id_seq OWNED BY planinversion.id;


--
-- TOC entry 199 (class 1259 OID 157425)
-- Name: presupuestos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE presupuestos (
    id integer NOT NULL,
    codarancel_id integer NOT NULL,
    unidad_id integer NOT NULL,
    fecha_cierre date NOT NULL,
    cantidad integer NOT NULL,
    montousd double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    empresa_id integer NOT NULL
);


ALTER TABLE pdi.presupuestos OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 157430)
-- Name: presupuestos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE presupuestos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.presupuestos_id_seq OWNER TO postgres;

--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 200
-- Name: presupuestos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE presupuestos_id_seq OWNED BY presupuestos.id;


--
-- TOC entry 201 (class 1259 OID 157432)
-- Name: proyectos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE proyectos (
    id integer NOT NULL,
    objetivoproducto text NOT NULL,
    nom_proyecto text NOT NULL,
    puntoreferencia text NOT NULL,
    calleavenida text NOT NULL,
    coordenadasutm text NOT NULL,
    empresa_id integer NOT NULL,
    tipo_proyecto_id integer NOT NULL,
    estado_id integer NOT NULL,
    municipio_id integer NOT NULL,
    ciudad character varying(30) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    mes_inicio character varying(15) NOT NULL,
    ano_inicio character varying(4) NOT NULL,
    mes_fin character varying(15) NOT NULL,
    ano_fin character varying(4) NOT NULL
);


ALTER TABLE pdi.proyectos OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 157440)
-- Name: proyectos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.proyectos_id_seq OWNER TO postgres;

--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 202
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- TOC entry 203 (class 1259 OID 157442)
-- Name: tipoproyectos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE tipoproyectos (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.tipoproyectos OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 157447)
-- Name: tipoproyectos_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE tipoproyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.tipoproyectos_id_seq OWNER TO postgres;

--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 204
-- Name: tipoproyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tipoproyectos_id_seq OWNED BY tipoproyectos.id;


--
-- TOC entry 205 (class 1259 OID 157449)
-- Name: tiposfinanciamiento; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE tiposfinanciamiento (
    id integer NOT NULL,
    descripcion character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.tiposfinanciamiento OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 157454)
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE tiposfinanciamiento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.tiposfinanciamiento_id_seq OWNER TO postgres;

--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 206
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tiposfinanciamiento_id_seq OWNED BY tiposfinanciamiento.id;


--
-- TOC entry 207 (class 1259 OID 157456)
-- Name: totalflujocajas; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE totalflujocajas (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    valor_neto double precision NOT NULL,
    costo_beneficio double precision NOT NULL,
    tasa_retorno double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    anos integer NOT NULL,
    periodo_id integer NOT NULL
);


ALTER TABLE pdi.totalflujocajas OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 157461)
-- Name: totalflujocajas_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE totalflujocajas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.totalflujocajas_id_seq OWNER TO postgres;

--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 208
-- Name: totalflujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE totalflujocajas_id_seq OWNED BY totalflujocajas.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 209 (class 1259 OID 157463)
-- Name: det_bienes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE det_bienes (
    id integer NOT NULL,
    carancelario integer NOT NULL,
    nunidadmedida double precision NOT NULL,
    cant_pro_actual double precision NOT NULL,
    capac_max_anual_actual double precision NOT NULL,
    proyecto_id integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);


ALTER TABLE public.det_bienes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 157466)
-- Name: det_plan_inversion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE det_plan_inversion (
    id integer NOT NULL,
    activo_id integer NOT NULL,
    mtotal double precision NOT NULL,
    mfondospropios double precision NOT NULL,
    nfinanciamiento double precision NOT NULL,
    nempresa integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL,
    cusuario character varying(50) NOT NULL,
    gen_activos_id integer NOT NULL
);


ALTER TABLE public.det_plan_inversion OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 157469)
-- Name: det_presupuesto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE det_presupuesto (
    id integer NOT NULL,
    codarancelsol integer NOT NULL,
    carancelario integer NOT NULL,
    cunidadmedida character varying(15) NOT NULL,
    montousd double precision NOT NULL,
    festimadacierre date NOT NULL,
    fregistro date NOT NULL,
    nusuario integer NOT NULL,
    bestatus character(1) NOT NULL,
    cusuario character varying(50) NOT NULL,
    cid integer NOT NULL,
    estado_id integer NOT NULL,
    municipio_id integer NOT NULL,
    parroquia_id integer NOT NULL
);


ALTER TABLE public.det_presupuesto OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 157472)
-- Name: estatus; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estatus (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    fecha_registro date,
    valido character varying(1) NOT NULL
);


ALTER TABLE public.estatus OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 157475)
-- Name: gen_activos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_activos (
    id integer NOT NULL,
    dactivo character varying(150) NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);


ALTER TABLE public.gen_activos OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 157478)
-- Name: gen_estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE public.gen_estado OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 157481)
-- Name: gen_financiamiento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_financiamiento (
    id integer NOT NULL,
    mcapitalpropio double precision NOT NULL,
    mcapitalfinanciado double precision NOT NULL,
    nbanco integer NOT NULL,
    ctasainteres character varying(10) NOT NULL,
    manualidades double precision NOT NULL,
    fplazoprestamo date NOT NULL,
    nempresa integer NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL,
    get_tipo_financiamiento_id integer NOT NULL,
    cusuario character varying(50) NOT NULL
);


ALTER TABLE public.gen_financiamiento OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 157484)
-- Name: gen_municipio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_municipio (
    id integer NOT NULL,
    dmunicipio character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE public.gen_municipio OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 157487)
-- Name: gen_pais; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_pais (
    cpais character varying(6) DEFAULT 1000 NOT NULL,
    dpais character varying(30) NOT NULL,
    sesion_id character varying(30) DEFAULT 0 NOT NULL,
    ddocumento_identificacion character varying(30) DEFAULT 0 NOT NULL,
    cdivisa_aceptada character varying(100) NOT NULL,
    bfiltroliq character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE public.gen_pais OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 157494)
-- Name: gen_parroquia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_parroquia (
    id integer NOT NULL,
    dparroquia character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE public.gen_parroquia OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 157497)
-- Name: gen_proyecto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_proyecto (
    id integer NOT NULL,
    dobjetivoproducto character varying(150) NOT NULL,
    dnombreproyecto character varying(150) NOT NULL,
    dpuntoreferencia character varying(150) NOT NULL,
    dcalleavenida character varying(150) NOT NULL,
    ccoordenadasutm character varying(100) NOT NULL,
    finicio date NOT NULL,
    ffin date NOT NULL,
    fregistro date NOT NULL,
    nempresa integer NOT NULL,
    bestatus character(1),
    cusuario character varying(50) NOT NULL,
    gen_tipo_proyecto_id integer NOT NULL
);


ALTER TABLE public.gen_proyecto OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 157503)
-- Name: gen_tipo_financiamiento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_tipo_financiamiento (
    id integer NOT NULL,
    dtipofinaciamiento character(250) NOT NULL
);


ALTER TABLE public.gen_tipo_financiamiento OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 157506)
-- Name: gen_tipo_proyecto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_tipo_proyecto (
    id integer NOT NULL,
    dtipoproyecto character varying(80) NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);


ALTER TABLE public.gen_tipo_proyecto OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 157509)
-- Name: gen_unidades; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_unidades (
    cunidad character varying(4) NOT NULL,
    dunidad character varying(70) NOT NULL,
    sesion_id character varying(30) DEFAULT 0 NOT NULL
);


ALTER TABLE public.gen_unidades OWNER TO postgres;

SET search_path = pdi, pg_catalog;

--
-- TOC entry 2057 (class 2604 OID 157513)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY activos ALTER COLUMN id SET DEFAULT nextval('activos_id_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 157514)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY arancelesempresas ALTER COLUMN id SET DEFAULT nextval('arancelesempresas_id_seq'::regclass);


--
-- TOC entry 2105 (class 2604 OID 157734)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: divisa
--

ALTER TABLE ONLY archivoscsv ALTER COLUMN id SET DEFAULT nextval('archivoscsv_id_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 157515)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes ALTER COLUMN id SET DEFAULT nextval('bienes_id_seq'::regclass);


--
-- TOC entry 2080 (class 2604 OID 157755)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY cronogramas ALTER COLUMN id SET DEFAULT nextval('cronograma_id_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 157516)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY datosbasicos ALTER COLUMN id SET DEFAULT nextval('datosbasicos_id_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 157517)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras ALTER COLUMN id SET DEFAULT nextval('entidadesfinancieras_id_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 157518)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY exportaciones_paises ALTER COLUMN id SET DEFAULT nextval('exportaciones_paises_id_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 157519)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos ALTER COLUMN id SET DEFAULT nextval('financiamientos_id_seq'::regclass);


--
-- TOC entry 2077 (class 2604 OID 157520)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas ALTER COLUMN id SET DEFAULT nextval('flujocajas_id_seq'::regclass);


--
-- TOC entry 2106 (class 2604 OID 157780)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY periodos ALTER COLUMN id SET DEFAULT nextval('periodos_id_seq'::regclass);


--
-- TOC entry 2083 (class 2604 OID 157521)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion ALTER COLUMN id SET DEFAULT nextval('planinversion_id_seq'::regclass);


--
-- TOC entry 2086 (class 2604 OID 157522)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY presupuestos ALTER COLUMN id SET DEFAULT nextval('presupuestos_id_seq'::regclass);


--
-- TOC entry 2089 (class 2604 OID 157523)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- TOC entry 2092 (class 2604 OID 157524)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tipoproyectos ALTER COLUMN id SET DEFAULT nextval('tipoproyectos_id_seq'::regclass);


--
-- TOC entry 2095 (class 2604 OID 157525)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tiposfinanciamiento ALTER COLUMN id SET DEFAULT nextval('tiposfinanciamiento_id_seq'::regclass);


--
-- TOC entry 2098 (class 2604 OID 157526)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas ALTER COLUMN id SET DEFAULT nextval('totalflujocajas_id_seq'::regclass);


--
-- TOC entry 2326 (class 0 OID 157341)
-- Dependencies: 174
-- Data for Name: activos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY activos (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('activos_id_seq', 1, false);


--
-- TOC entry 2328 (class 0 OID 157348)
-- Dependencies: 176
-- Data for Name: arancelesempresas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY arancelesempresas (id, descripcion, cod_arancelario, unidad_id, cantidad, monto_anual, fecha_registro, valido, empresa_id) FROM stdin;
\.


--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('arancelesempresas_id_seq', 1, false);


--
-- TOC entry 2330 (class 0 OID 157355)
-- Dependencies: 178
-- Data for Name: archivo_estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_estatus (archivo_id, estatus_id, valido, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2331 (class 0 OID 157359)
-- Dependencies: 179
-- Data for Name: archivo_presupuestos_tmp; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_presupuestos_tmp (codarancel_id, unidad_id, fecha_cierre, montousd, cantidad, num_empleados, fecha_registro, valido, empresa_id, id_archivo_presupuesto) FROM stdin;
\.


--
-- TOC entry 2375 (class 0 OID 157728)
-- Dependencies: 223
-- Data for Name: archivoscsv; Type: TABLE DATA; Schema: pdi; Owner: divisa
--

COPY archivoscsv (id, proyecto_id, archivo, tipo_csv, fecha) FROM stdin;
48	3	EEA7807BE911E7F5AED5F46864C2873C.csv	importacion	2014-09-28
52	3	AD80BD278C74CAA0F9B2367706A1FA66.csv	exportacion	2014-09-29
\.


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 224
-- Name: archivoscsv_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: divisa
--

SELECT pg_catalog.setval('archivoscsv_id_seq', 52, true);


--
-- TOC entry 2332 (class 0 OID 157363)
-- Dependencies: 180
-- Data for Name: bienes; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY bienes (id, codarancel_id, unidad_id, cant_pro_actual, capac_max_anual_actual, proyecto_id, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('bienes_id_seq', 1, false);


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 225
-- Name: cronograma_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('cronograma_id_seq', 300023, true);


--
-- TOC entry 2346 (class 0 OID 157409)
-- Dependencies: 194
-- Data for Name: cronogramas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY cronogramas (insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, fecha_registro, valido, proyecto_id, tipo, id) FROM stdin;
\.


--
-- TOC entry 2334 (class 0 OID 157370)
-- Dependencies: 182
-- Data for Name: datosbasicos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY datosbasicos (id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss, valido, empresa_id, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 183
-- Name: datosbasicos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('datosbasicos_id_seq', 19, true);


--
-- TOC entry 2336 (class 0 OID 157377)
-- Dependencies: 184
-- Data for Name: entidadesfinancieras; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY entidadesfinancieras (id, financiamiento_id, capitalfinanciado, banco_id, tasainteres, anualidades, plazoprestamo, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 185
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('entidadesfinancieras_id_seq', 1, false);


--
-- TOC entry 2338 (class 0 OID 157384)
-- Dependencies: 186
-- Data for Name: estado; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2339 (class 0 OID 157387)
-- Dependencies: 187
-- Data for Name: estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2340 (class 0 OID 157390)
-- Dependencies: 188
-- Data for Name: exportaciones_paises; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY exportaciones_paises (id, cpais, cronograma_id, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 189
-- Name: exportaciones_paises_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('exportaciones_paises_id_seq', 100019, true);


--
-- TOC entry 2342 (class 0 OID 157395)
-- Dependencies: 190
-- Data for Name: financiamientos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY financiamientos (id, capitalpropio, proyecto_id, fecha_registro, valido, tipo_financiamiento_id) FROM stdin;
\.


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 191
-- Name: financiamientos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('financiamientos_id_seq', 1, false);


--
-- TOC entry 2344 (class 0 OID 157402)
-- Dependencies: 192
-- Data for Name: flujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY flujocajas (id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id, periodo, ano) FROM stdin;
\.


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 193
-- Name: flujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('flujocajas_id_seq', 1, false);


--
-- TOC entry 2347 (class 0 OID 157412)
-- Dependencies: 195
-- Data for Name: municipio; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY municipio (id, descripcion, estado_id) FROM stdin;
\.


--
-- TOC entry 2348 (class 0 OID 157415)
-- Dependencies: 196
-- Data for Name: parroquia; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY parroquia (id, descripcion, municipio_id) FROM stdin;
\.


--
-- TOC entry 2379 (class 0 OID 157777)
-- Dependencies: 227
-- Data for Name: periodos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY periodos (id, nombre, valor) FROM stdin;
1	Semestre	2
2	Trimestre	4
3	Mes	12
\.


--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 226
-- Name: periodos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('periodos_id_seq', 3, true);


--
-- TOC entry 2349 (class 0 OID 157418)
-- Dependencies: 197
-- Data for Name: planinversion; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY planinversion (id, activo_id, monto_total, fondospropios, financiamiento, fecha_registro, estatus, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 198
-- Name: planinversion_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('planinversion_id_seq', 1, false);


--
-- TOC entry 2351 (class 0 OID 157425)
-- Dependencies: 199
-- Data for Name: presupuestos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY presupuestos (id, codarancel_id, unidad_id, fecha_cierre, cantidad, montousd, fecha_registro, estatus, empresa_id) FROM stdin;
\.


--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 200
-- Name: presupuestos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('presupuestos_id_seq', 1, false);


--
-- TOC entry 2353 (class 0 OID 157432)
-- Dependencies: 201
-- Data for Name: proyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY proyectos (id, objetivoproducto, nom_proyecto, puntoreferencia, calleavenida, coordenadasutm, empresa_id, tipo_proyecto_id, estado_id, municipio_id, ciudad, fecha_registro, estatus, mes_inicio, ano_inicio, mes_fin, ano_fin) FROM stdin;
3	Diseño de computadores	Cataplam	asdf	asdf	1	1	1	1	1	gffg	2014-09-26 11:29:59	1	1	1	2	1
\.


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 202
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('proyectos_id_seq', 1, false);


--
-- TOC entry 2355 (class 0 OID 157442)
-- Dependencies: 203
-- Data for Name: tipoproyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tipoproyectos (id, descripcion, fecha_registro, estatus) FROM stdin;
1	computadoras	2014-09-24 11:30:48	s
\.


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 204
-- Name: tipoproyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tipoproyectos_id_seq', 1, false);


--
-- TOC entry 2357 (class 0 OID 157449)
-- Dependencies: 205
-- Data for Name: tiposfinanciamiento; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tiposfinanciamiento (id, descripcion, fecha_registro, estatus) FROM stdin;
\.


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 206
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tiposfinanciamiento_id_seq', 1, false);


--
-- TOC entry 2359 (class 0 OID 157456)
-- Dependencies: 207
-- Data for Name: totalflujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY totalflujocajas (id, proyecto_id, valor_neto, costo_beneficio, tasa_retorno, fecha_registro, estatus, anos, periodo_id) FROM stdin;
\.


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 208
-- Name: totalflujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('totalflujocajas_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 2361 (class 0 OID 157463)
-- Dependencies: 209
-- Data for Name: det_bienes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_bienes (id, carancelario, nunidadmedida, cant_pro_actual, capac_max_anual_actual, proyecto_id, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2362 (class 0 OID 157466)
-- Dependencies: 210
-- Data for Name: det_plan_inversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_plan_inversion (id, activo_id, mtotal, mfondospropios, nfinanciamiento, nempresa, fregistro, bestatus, cusuario, gen_activos_id) FROM stdin;
\.


--
-- TOC entry 2363 (class 0 OID 157469)
-- Dependencies: 211
-- Data for Name: det_presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_presupuesto (id, codarancelsol, carancelario, cunidadmedida, montousd, festimadacierre, fregistro, nusuario, bestatus, cusuario, cid, estado_id, municipio_id, parroquia_id) FROM stdin;
\.


--
-- TOC entry 2364 (class 0 OID 157472)
-- Dependencies: 212
-- Data for Name: estatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2365 (class 0 OID 157475)
-- Dependencies: 213
-- Data for Name: gen_activos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_activos (id, dactivo, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2366 (class 0 OID 157478)
-- Dependencies: 214
-- Data for Name: gen_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2367 (class 0 OID 157481)
-- Dependencies: 215
-- Data for Name: gen_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_financiamiento (id, mcapitalpropio, mcapitalfinanciado, nbanco, ctasainteres, manualidades, fplazoprestamo, nempresa, fregistro, bestatus, get_tipo_financiamiento_id, cusuario) FROM stdin;
\.


--
-- TOC entry 2368 (class 0 OID 157484)
-- Dependencies: 216
-- Data for Name: gen_municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_municipio (id, dmunicipio, estado_id) FROM stdin;
\.


--
-- TOC entry 2369 (class 0 OID 157487)
-- Dependencies: 217
-- Data for Name: gen_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_pais (cpais, dpais, sesion_id, ddocumento_identificacion, cdivisa_aceptada, bfiltroliq) FROM stdin;
1963	Costa de Marfil	0	0	904	1
0620	Afganist�	0	0	001	1
0621	Albania	0	0	904	1
0622	Alemania	0	0	904	1
0623	Andorra	0	0	904	1
0624	Angola	0	0	904	1
0625	Antigua y Barbuda 	0	0	001	1
0626	Arabia Saudita	0	0	001	1
0597	Argelia	0	0	001	1
0633	Argentina	0	0	001	1
0266	Armenia	0	0	001	1
0698	Australia	0	0	001	1
0627	Austria	0	0	904	1
0628	Azerbaiy�n 	0	0	001	1
0629	Bahamas	0	0	001	1
0630	Bahrein 	0	0	001	1
817	Bangladesh	0	0	001	1
0832	Barbados	0	0	001	1
0874	B�lgica	0	0	904	1
0882	Belice	0	0	001	1
2297	Benin 	0	0	904	1
0902	Bermudas 	0	0	001	1
0973	Bolivia	0	0	001	1
1017	Botswana	0	0	001	1
1053	Brasil 	C�dula de Identidad	C�dula de Identidad	001	1
1114	Bulgaria	0	0	904	1
1157	Burundi	0	0	001	1
1195	But�	0	0	001	1
1277	Cabo Verde	0	0	001	1
1413	Camboya	0	0	001	1
1457	Camer�	0	0	904	1
1491	Canad�	0	0	001	1
2037	Chad	0	0	904	1
2113	Chile	0	0	001	1
2155	China	0	0	001	1
2215	Chipre	0	0	904	1
1693	Colombia	C�dula de Ciudadania	C�dula de Ciudadania	001	1
1777	Congo	0	0	904	1
1875	Corea del Norte	0	0	904	1
1905	Corea del Sur	0	0	001	1
1962	Costa Rica	C�dula de Identidad	C�dula de Identidad	001	1
1984	Croacia	0	0	904	1
1992	Cuba	0	0	904	1
2324	Dinamarca	0	0	904	1
2352	Dominica	0	0	001	1
2393	Ecuador	0	0	001	1
2407	Egipto	0	0	001	1
2422	El Salvador	0	0	001	1
2445	Emiratos Arabes Unidos	0	0	001	1
2464	Eslovaquia	0	0	904	1
2474	Eslovenia	0	0	904	1
2454	Espa�	Permiso de Residencia	Permiso de Residencia	904	1
2491	Estados Unidos	Permanet Resident Card	Permanet Resident Card	001	1
2516	Estonia	0	0	904	1
2537	Etiopia	0	0	001	1
8708	Fiji	0	0	001	1
2675	Filipinas	0	0	001	1
2714	Finlandia	0	0	904	1
2754	Francia	0	0	904	1
2817	Gab�	0	0	904	1
2857	Gambia	0	0	001	1
2897	Ghana	0	0	001	1
3014	Grecia	0	0	904	1
3172	Guatemala	0	0	001	1
3317	Guinea Ecuatorial	0	0	904	1
3297	Guinea y Portuguesa	0	0	001	1
3347	Guinea Bissau	0	0	904	1
3373	Guyana	0	0	001	1
3253	Guyana Francesa	0	0	001	1
7703	Guyana Holandesa	0	0	001	1
3412	Hait�	0	0	001	1
3452	Honduras	0	0	001	1
3354	Hungr�	0	0	904	1
3615	India	0	0	001	1
3655	Indonesia	0	0	001	1
3695	Irak	0	0	904	1
3725	Iran	0	0	904	1
3754	Irlanda	0	0	904	1
3835	Israel	0	0	001	1
3864	Italia	Caita de Identidad	Caita de Identidad	904	1
3912	Jamaica	0	0	001	1
3995	Jap�	0	0	001	1
4035	Jordania	0	0	001	1
4066	Kazajstan	0	0	001	1
4107	Kenia	0	0	001	1
4124	Kirguizistan	0	0	001	1
4118	Kiribati	0	0	001	1
4135	Kuwait	0	0	001	1
4205	Laos	0	0	001	1
4267	Lesotho	0	0	001	1
4347	Liberia	0	0	904	1
4315	L�bano	0	0	001	0
4387	Libia	0	0	904	1
4436	Lituania	0	0	904	1
3092	Luxemburgo	0	0	904	1
4484	Macedonia	0	0	904	1
4507	Madagascar	0	0	001	1
4555	Malasia	0	0	001	1
4587	Malawi	0	0	001	1
4615	Maldivas	0	0	001	1
4647	Mal�	0	0	904	1
4674	Malta	0	0	904	1
4747	Marruecos	0	0	001	1
4857	Mauricio	0	0	001	1
4887	Mauritania	0	0	001	1
4931	M�xico	0	0	001	1
4947	Micronesia	0	0	001	1
4984	M�naco	0	0	904	1
4975	Mongolia	0	0	001	1
4966	Moldavia	0	0	904	1
5057	Mozambique	0	0	001	1
0935	Myanmar	0	0	904	1
5077	Nambia	0	0	001	1
5088	Nauru	0	0	001	1
5175	Nepal	0	0	001	1
5212	Nicaragua	0	0	001	1
5257	Niger	0	0	904	1
5287	Nigeria	0	0	001	1
5318	Niue	0	0	001	1
5384	Noruega	0	0	904	1
5488	Nueva Zelanda	0	0	001	1
5565	Om�	0	0	001	1
5734	Paises Bajos	0	0	904	1
5765	Pakist�	0	0	001	1
5802	Panama	0	0	001	1
5838	Papua	0	0	001	1
5836	Paraguay	0	0	001	1
5893	Per�	DNI - Doc. Nac. de Identidad	DNI - Doc. Nac. de Identidad	001	1
6034	Polonia	0	0	904	1
6074	Portugal	Trj. Identidad/C�dula Personal	Trj. Identidad/C�dula Personal	904	1
6112	Puerto Rico	0	0	001	1
6185	Qatar	0	0	001	1
6284	Reino Unido	0	0	904	1
6407	Rep�blica Centro Africana	0	0	904	1
6444	Rep�blica Checa	0	0	904	1
6472	Rep�blica Dominicana	0	0	001	1
6757	Ruanda	0	0	001	1
6704	Rumania	0	0	904	1
6766	Rusia	0	0	904	1
6878	Samoa	0	0	001	1
6952	San Crist�bal	0	0	001	1
6974	San Marino	0	0	904	1
7052	San Vicente y las Granadinas	0	0	001	1
7152	Santa Luc�	0	0	001	1
7287	Senegal	0	0	904	1
7597	Sud�	0	0	904	1
7644	Suecia	0	0	904	1
7567	Sud�frica	0	0	001	1
7674	Suiza	0	0	904	1
7737	Swazilandia	0	0	001	1
7765	Tailandia	0	0	001	1
2185	Taiwan	0	0	001	1
7807	Tanzania	0	0	001	1
7955	Timor	0	0	001	1
8007	Togo	0	0	904	1
8108	Tonga	0	0	001	1
8152	Trinidad y Tobago	0	0	001	1
8207	T�	0	0	001	1
8256	Turkmenistan	0	0	001	1
8275	Turqu�	0	0	904	1
8288	Tuval�	0	0	001	1
8306	Ucrania	0	0	904	1
8337	Uganda	0	0	001	1
8453	Uruguay	0	0	001	1
8476	Uzbekistan	0	0	001	1
5518	Vanatu	0	0	001	1
5519	Vaticano	0	0	904	1
8503	Venezuela	C�dula de Identidad	C�dula de Identidad	001	1
8555	Vietnam	0	0	001	1
8805	Yemen	0	0	001	1
8907	Zambia	0	0	001	1
6657	Zimbabwe	0	0	904	1
8808	Aruba	0	0	001	1
8809	Curazao	0	0	001	1
8806	Siria	0	0	904	1
8807	Singapur	0	0	001	1
8810	St. Martin	0	0	001	1
8811	Srylanka	0	0	001	1
8813	Serbia	0	0	904	1
8812	Monte Negro	0	0	904	1
8814	Islas Virgenes Britanicas	0	0	001	1
8815	Islas Caiman	0	0	001	1
1000	Grenada	0	0	001	1
8906	Surinan	0	0	001	1
8908	Bonaire	0	0	001	1
8816	Islandia	0	0	904	1
4388	Liechtenstein	0	0	904	1
4290	Letonia	0	0	904	1
0903	Bielorrusia	0	0	904	1
0974	Bosnia	0	0	904	1
1115	Burkina Faso	0	0	904	1
7288	Sierra Leona	0	0	904	1
4740	Martinica	0	0	001	1
8909	HONG KONG	0	0	904	1
8910	Holanda	0	0	904	1
8911	Somalia	0	0	001	1
8912	Escocia	0	0	001	1
8913	Polinesia	0	0	001	1
8914	Palestina	0	0	232	1
8915	Brun�	0	0	001	1
\.


--
-- TOC entry 2370 (class 0 OID 157494)
-- Dependencies: 218
-- Data for Name: gen_parroquia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_parroquia (id, dparroquia, municipio_id) FROM stdin;
\.


--
-- TOC entry 2371 (class 0 OID 157497)
-- Dependencies: 219
-- Data for Name: gen_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_proyecto (id, dobjetivoproducto, dnombreproyecto, dpuntoreferencia, dcalleavenida, ccoordenadasutm, finicio, ffin, fregistro, nempresa, bestatus, cusuario, gen_tipo_proyecto_id) FROM stdin;
\.


--
-- TOC entry 2372 (class 0 OID 157503)
-- Dependencies: 220
-- Data for Name: gen_tipo_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_financiamiento (id, dtipofinaciamiento) FROM stdin;
\.


--
-- TOC entry 2373 (class 0 OID 157506)
-- Dependencies: 221
-- Data for Name: gen_tipo_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_proyecto (id, dtipoproyecto, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2374 (class 0 OID 157509)
-- Dependencies: 222
-- Data for Name: gen_unidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_unidades (cunidad, dunidad, sesion_id) FROM stdin;
01	Bolsas	0
02	Cajas	0
03	Centímetros	0
04	Centímetros Cuadrados	0
05	Centímetros Cúbicos	0
06	Cuartos	0
07	Galones	0
08	Gramos	0
09	Gruesas	0
10	Kilogramos	0
11	Kilómetros	0
12	Kilómetros Cuadrados	0
13	Libras	0
14	Litros	0
15	Madejas	0
16	Metros	0
17	Metros Cuadrados	0
18	Metros Cúbicos	0
19	Mililitros	0
20	Milímetros	0
22	Onzas	0
23	Paletas	0
24	Panelas	0
25	Pies	0
26	Pies Cuadrados	0
27	Pies Cúbicos	0
28	Piezas	0
29	Pulgadas	0
30	Rollos	0
31	Sacos	0
32	Toneladas	0
33	Toneladas Métricas	0
34	Toneladas Cúbicas	0
35	Unidades	0
36	Yardas	0
37	Docenas	0
38	Pares	0
39	Miles de Semillas	0
40	Millar	0
41	Juegos de Kit	0
42	Tambores	0
43	Paquetes	AAACFGAAGAAAALiAAq
44	Miles	0
\.


SET search_path = pdi, pg_catalog;

--
-- TOC entry 2190 (class 2606 OID 157736)
-- Name: archivoscsv_pkey; Type: CONSTRAINT; Schema: pdi; Owner: divisa; Tablespace: 
--

ALTER TABLE ONLY archivoscsv
    ADD CONSTRAINT archivoscsv_pkey PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 157528)
-- Name: bienes_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT bienes_pk PRIMARY KEY (id);


--
-- TOC entry 2133 (class 2606 OID 157760)
-- Name: cronograma_pkey; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cronogramas
    ADD CONSTRAINT cronograma_pkey PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 157530)
-- Name: estado_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2126 (class 2606 OID 157532)
-- Name: exportacion_pais_id; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exportaciones_paises
    ADD CONSTRAINT exportacion_pais_id PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 157534)
-- Name: id_activos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY activos
    ADD CONSTRAINT id_activos PRIMARY KEY (id);


--
-- TOC entry 2110 (class 2606 OID 157536)
-- Name: id_arancelesempresa; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY arancelesempresas
    ADD CONSTRAINT id_arancelesempresa PRIMARY KEY (id);


--
-- TOC entry 2112 (class 2606 OID 157538)
-- Name: id_archivo_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT id_archivo_estatus PRIMARY KEY (archivo_id, estatus_id);


--
-- TOC entry 2114 (class 2606 OID 157540)
-- Name: id_archivo_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT id_archivo_presupuestos PRIMARY KEY (id_archivo_presupuesto);


--
-- TOC entry 2118 (class 2606 OID 157542)
-- Name: id_datosbasicos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY datosbasicos
    ADD CONSTRAINT id_datosbasicos PRIMARY KEY (id);


--
-- TOC entry 2120 (class 2606 OID 157544)
-- Name: id_entidadesfinancieras; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT id_entidadesfinancieras PRIMARY KEY (id);


--
-- TOC entry 2124 (class 2606 OID 157546)
-- Name: id_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2129 (class 2606 OID 157548)
-- Name: id_financiamientos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT id_financiamientos PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 157550)
-- Name: id_flujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT id_flujocajas PRIMARY KEY (id);


--
-- TOC entry 2141 (class 2606 OID 157552)
-- Name: id_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY presupuestos
    ADD CONSTRAINT id_presupuestos PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 157554)
-- Name: id_tipofinanciamiento; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tiposfinanciamiento
    ADD CONSTRAINT id_tipofinanciamiento PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 157556)
-- Name: id_tipoproyectos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoproyectos
    ADD CONSTRAINT id_tipoproyectos PRIMARY KEY (id);


--
-- TOC entry 2150 (class 2606 OID 157558)
-- Name: id_totalflujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT id_totalflujocajas PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 157560)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 157562)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2193 (class 2606 OID 157782)
-- Name: periodos_pkey; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY periodos
    ADD CONSTRAINT periodos_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 157566)
-- Name: planinversion_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT planinversion_pk PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 157568)
-- Name: proyectos_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pk PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2170 (class 2606 OID 157570)
-- Name: descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT descripcion__un UNIQUE (dmunicipio);


--
-- TOC entry 2152 (class 2606 OID 157572)
-- Name: det_bienes_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT "det_bienes_PK" PRIMARY KEY (id);


--
-- TOC entry 2154 (class 2606 OID 157574)
-- Name: det_plan_inversion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_pk PRIMARY KEY (id);


--
-- TOC entry 2156 (class 2606 OID 157576)
-- Name: det_presupuesto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_pk PRIMARY KEY (id);


--
-- TOC entry 2184 (class 2606 OID 157578)
-- Name: dtipoproyecto__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT dtipoproyecto__un UNIQUE (dtipoproyecto);


--
-- TOC entry 2164 (class 2606 OID 157580)
-- Name: estado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2160 (class 2606 OID 157582)
-- Name: gen_activos_descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_descripcion__un UNIQUE (dactivo);


--
-- TOC entry 2162 (class 2606 OID 157584)
-- Name: gen_activos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_pk PRIMARY KEY (id);


--
-- TOC entry 2166 (class 2606 OID 157586)
-- Name: gen_estado__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT gen_estado__un UNIQUE (destado);


--
-- TOC entry 2168 (class 2606 OID 157588)
-- Name: gen_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2174 (class 2606 OID 157590)
-- Name: gen_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_pais
    ADD CONSTRAINT gen_pais_pkey PRIMARY KEY (cpais);


--
-- TOC entry 2178 (class 2606 OID 157592)
-- Name: gen_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_pk PRIMARY KEY (id);


--
-- TOC entry 2180 (class 2606 OID 157594)
-- Name: gen_tipo_financiamiento__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT gen_tipo_financiamiento__un UNIQUE (dtipofinaciamiento);


--
-- TOC entry 2182 (class 2606 OID 157596)
-- Name: get_tipo_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT get_tipo_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2158 (class 2606 OID 157598)
-- Name: id_estatus; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2172 (class 2606 OID 157600)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2176 (class 2606 OID 157602)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2188 (class 2606 OID 157604)
-- Name: pk_gun_spkunidad; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_unidades
    ADD CONSTRAINT pk_gun_spkunidad PRIMARY KEY (cunidad);


--
-- TOC entry 2186 (class 2606 OID 157606)
-- Name: tipo_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT tipo_proyecto_pk PRIMARY KEY (id);


SET search_path = pdi, pg_catalog;

--
-- TOC entry 2148 (class 1259 OID 157788)
-- Name: fki_periodo_flujocajas; Type: INDEX; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_periodo_flujocajas ON totalflujocajas USING btree (periodo_id);


--
-- TOC entry 2127 (class 1259 OID 157766)
-- Name: fki_pki_exportaciones_cronograma; Type: INDEX; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_pki_exportaciones_cronograma ON exportaciones_paises USING btree (cronograma_id);


--
-- TOC entry 2191 (class 1259 OID 157737)
-- Name: fki_proyectos_archivos; Type: INDEX; Schema: pdi; Owner: divisa; Tablespace: 
--

CREATE INDEX fki_proyectos_archivos ON archivoscsv USING btree (proyecto_id);


--
-- TOC entry 2204 (class 2606 OID 157607)
-- Name: activos_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT activos_plan FOREIGN KEY (activo_id) REFERENCES activos(id);


--
-- TOC entry 2194 (class 2606 OID 157612)
-- Name: archivo_estatus_estus_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_estus_fk FOREIGN KEY (estatus_id) REFERENCES estatus(id) ON DELETE RESTRICT;


--
-- TOC entry 2195 (class 2606 OID 157617)
-- Name: archivo_estatus_presupuestos_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_presupuestos_fk FOREIGN KEY (archivo_id) REFERENCES archivo_presupuestos_tmp(id_archivo_presupuesto) ON DELETE RESTRICT;


--
-- TOC entry 2196 (class 2606 OID 157622)
-- Name: archivo_presupuestos_tmp_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT archivo_presupuestos_tmp_fk FOREIGN KEY (id_archivo_presupuesto) REFERENCES presupuestos(id) ON DELETE RESTRICT;


--
-- TOC entry 2198 (class 2606 OID 157627)
-- Name: financiamiento_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT financiamiento_fk FOREIGN KEY (financiamiento_id) REFERENCES financiamientos(id);


--
-- TOC entry 2199 (class 2606 OID 157632)
-- Name: financiamiento_tipo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT financiamiento_tipo FOREIGN KEY (tipo_financiamiento_id) REFERENCES tiposfinanciamiento(id);


--
-- TOC entry 2208 (class 2606 OID 157783)
-- Name: fk_periodo_flujocajas; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT fk_periodo_flujocajas FOREIGN KEY (periodo_id) REFERENCES periodos(id);


--
-- TOC entry 2218 (class 2606 OID 157738)
-- Name: fk_proyectos_archivos; Type: FK CONSTRAINT; Schema: pdi; Owner: divisa
--

ALTER TABLE ONLY archivoscsv
    ADD CONSTRAINT fk_proyectos_archivos FOREIGN KEY (proyecto_id) REFERENCES proyectos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2202 (class 2606 OID 157642)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2203 (class 2606 OID 157647)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES municipio(id);


--
-- TOC entry 2200 (class 2606 OID 157652)
-- Name: poyecto_financiamiento; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT poyecto_financiamiento FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2197 (class 2606 OID 157657)
-- Name: proyecto_bienes; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT proyecto_bienes FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2201 (class 2606 OID 157662)
-- Name: proyecto_flujo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT proyecto_flujo FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2207 (class 2606 OID 157667)
-- Name: proyecto_flujototal; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT proyecto_flujototal FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2205 (class 2606 OID 157672)
-- Name: proyecto_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT proyecto_plan FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2206 (class 2606 OID 157677)
-- Name: tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT tipo_proyecto_fk FOREIGN KEY (tipo_proyecto_id) REFERENCES tipoproyectos(id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2209 (class 2606 OID 157682)
-- Name: det_bienes_gen_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT det_bienes_gen_proyecto_fk FOREIGN KEY (proyecto_id) REFERENCES gen_proyecto(id);


--
-- TOC entry 2210 (class 2606 OID 157687)
-- Name: det_plan_inversion_gen_activos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_gen_activos_fk FOREIGN KEY (gen_activos_id) REFERENCES gen_activos(id);


--
-- TOC entry 2211 (class 2606 OID 157692)
-- Name: det_presupuesto_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2212 (class 2606 OID 157697)
-- Name: det_presupuesto_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2213 (class 2606 OID 157702)
-- Name: det_presupuesto_parroquia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_parroquia_fk FOREIGN KEY (parroquia_id) REFERENCES gen_parroquia(id);


--
-- TOC entry 2214 (class 2606 OID 157707)
-- Name: gen_financiamiento_get_tipo_financiamiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_get_tipo_financiamiento_fk FOREIGN KEY (get_tipo_financiamiento_id) REFERENCES gen_tipo_financiamiento(id);


--
-- TOC entry 2217 (class 2606 OID 157712)
-- Name: gen_proyecto_gen_tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_gen_tipo_proyecto_fk FOREIGN KEY (gen_tipo_proyecto_id) REFERENCES gen_tipo_proyecto(id);


--
-- TOC entry 2215 (class 2606 OID 157717)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2216 (class 2606 OID 157722)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 7
-- Name: odbclink; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA odbclink FROM PUBLIC;
REVOKE ALL ON SCHEMA odbclink FROM postgres;
GRANT ALL ON SCHEMA odbclink TO postgres;
GRANT USAGE ON SCHEMA odbclink TO PUBLIC;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-09-29 10:14:09

--
-- PostgreSQL database dump complete
--

