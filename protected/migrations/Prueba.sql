--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-09-25 20:07:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 148640)
-- Name: odbclink; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA odbclink;


ALTER SCHEMA odbclink OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 148641)
-- Name: pdi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pdi;


ALTER SCHEMA pdi OWNER TO postgres;

--
-- TOC entry 224 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 224
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 225 (class 3079 OID 148644)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 225
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET search_path = odbclink, pg_catalog;

--
-- TOC entry 616 (class 1247 OID 148692)
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
-- TOC entry 279 (class 1255 OID 148700)
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
-- TOC entry 174 (class 1259 OID 148701)
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
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.id IS 'numero secuencial para identificar el activo';


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.descripcion IS 'descripción del activo';


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.fecha_registro IS 'fecha de registro del activo';


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.valido IS 'campo para indicar si el registro esta vigente (1) o no (0)';


--
-- TOC entry 175 (class 1259 OID 148706)
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
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE activos_id_seq OWNED BY activos.id;


--
-- TOC entry 176 (class 1259 OID 148708)
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
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.id IS 'numero secuencial de para identificar los aranceles de las empresas';


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.descripcion IS 'descripción del arancel';


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.empresa_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.empresa_id IS 'campo foráneo que contiene el identificador de la empresa que viene de la tabla gen_juridico de BDCADIVI';


--
-- TOC entry 177 (class 1259 OID 148713)
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
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE arancelesempresas_id_seq OWNED BY arancelesempresas.id;


--
-- TOC entry 178 (class 1259 OID 148715)
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
-- TOC entry 179 (class 1259 OID 148719)
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
-- TOC entry 180 (class 1259 OID 148723)
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
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.id IS 'número secuencial de identificación de los bienes';


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 181 (class 1259 OID 148728)
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
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE bienes_id_seq OWNED BY bienes.id;


--
-- TOC entry 182 (class 1259 OID 148730)
-- Name: cronogramaexport; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE cronogramaexport (
    id integer NOT NULL,
    insumo character varying(30) NOT NULL,
    cod_arancelario integer NOT NULL,
    unidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    costo_total integer NOT NULL,
    fecha_estimada date NOT NULL,
    pais_destino integer NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE pdi.cronogramaexport OWNER TO postgres;

--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cronogramaexport.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaexport.id IS 'número secuencial para identificar el cronograma de exportación';


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cronogramaexport.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaexport.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cronogramaexport.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaexport.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cronogramaexport.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaexport.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN cronogramaexport.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaexport.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';


--
-- TOC entry 183 (class 1259 OID 148735)
-- Name: cronogramaexport_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE cronogramaexport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.cronogramaexport_id_seq OWNER TO postgres;

--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 183
-- Name: cronogramaexport_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE cronogramaexport_id_seq OWNED BY cronogramaexport.id;


--
-- TOC entry 184 (class 1259 OID 148737)
-- Name: cronogramaimport; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE cronogramaimport (
    id integer NOT NULL,
    insumo character varying(30) NOT NULL,
    cod_arancelario integer NOT NULL,
    unidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    costo_total integer NOT NULL,
    fecha_estimada date NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    valido character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL
);


ALTER TABLE pdi.cronogramaimport OWNER TO postgres;

--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cronogramaimport.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaimport.id IS 'número secuencial que identifica el cronograma d importación';


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cronogramaimport.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaimport.unidad_id IS ' campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cronogramaimport.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaimport.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cronogramaimport.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaimport.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN cronogramaimport.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN cronogramaimport.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';


--
-- TOC entry 185 (class 1259 OID 148742)
-- Name: cronogramaimport_id_seq; Type: SEQUENCE; Schema: pdi; Owner: postgres
--

CREATE SEQUENCE cronogramaimport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pdi.cronogramaimport_id_seq OWNER TO postgres;

--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 185
-- Name: cronogramaimport_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE cronogramaimport_id_seq OWNED BY cronogramaimport.id;


--
-- TOC entry 186 (class 1259 OID 148744)
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
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN datosbasicos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.id IS 'número secuencial que identifica el conjunto de datos basicos de la empresas';


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN datosbasicos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 187 (class 1259 OID 148749)
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
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 187
-- Name: datosbasicos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE datosbasicos_id_seq OWNED BY datosbasicos.id;


--
-- TOC entry 188 (class 1259 OID 148751)
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
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN entidadesfinancieras.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.id IS 'número secuencial que identifica la entidad financiera';


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN entidadesfinancieras.financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.financiamiento_id IS 'campo foráneo que viene de la tabla financiamientos';


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN entidadesfinancieras.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN entidadesfinancieras.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 189 (class 1259 OID 148756)
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
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 189
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE entidadesfinancieras_id_seq OWNED BY entidadesfinancieras.id;


--
-- TOC entry 190 (class 1259 OID 148758)
-- Name: estado; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE pdi.estado OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 148761)
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
-- TOC entry 192 (class 1259 OID 148764)
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
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN financiamientos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.id IS 'número secuencial para identificar el financiamiento';


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN financiamientos.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.proyecto_id IS 'campo foránero que viene de la tabla proyectos';


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN financiamientos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN financiamientos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN financiamientos.tipo_financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.tipo_financiamiento_id IS 'campo foráneo que viene de la tabla tipo financiamiento';


--
-- TOC entry 193 (class 1259 OID 148769)
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
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 193
-- Name: financiamientos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE financiamientos_id_seq OWNED BY financiamientos.id;


--
-- TOC entry 194 (class 1259 OID 148771)
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
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    proyecto_id integer NOT NULL,
    periodo_id integer NOT NULL,
    num_per integer NOT NULL,
    anos integer NOT NULL
);


ALTER TABLE pdi.flujocajas OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 148776)
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
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 195
-- Name: flujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE flujocajas_id_seq OWNED BY flujocajas.id;


--
-- TOC entry 196 (class 1259 OID 148778)
-- Name: municipio; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE municipio (
    id integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE pdi.municipio OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 148781)
-- Name: parroquia; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE parroquia (
    id integer NOT NULL,
    descripcion character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE pdi.parroquia OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 149087)
-- Name: periodos; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE periodos (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE pdi.periodos OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 149085)
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
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 222
-- Name: periodos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE periodos_id_seq OWNED BY periodos.id;


--
-- TOC entry 198 (class 1259 OID 148784)
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
-- TOC entry 199 (class 1259 OID 148789)
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
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 199
-- Name: planinversion_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE planinversion_id_seq OWNED BY planinversion.id;


--
-- TOC entry 200 (class 1259 OID 148791)
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
-- TOC entry 201 (class 1259 OID 148796)
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
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 201
-- Name: presupuestos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE presupuestos_id_seq OWNED BY presupuestos.id;


--
-- TOC entry 202 (class 1259 OID 148798)
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
-- TOC entry 203 (class 1259 OID 148806)
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
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 203
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- TOC entry 204 (class 1259 OID 148808)
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
-- TOC entry 205 (class 1259 OID 148813)
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
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 205
-- Name: tipoproyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tipoproyectos_id_seq OWNED BY tipoproyectos.id;


--
-- TOC entry 206 (class 1259 OID 148815)
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
-- TOC entry 207 (class 1259 OID 148820)
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
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 207
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tiposfinanciamiento_id_seq OWNED BY tiposfinanciamiento.id;


--
-- TOC entry 208 (class 1259 OID 148822)
-- Name: totalflujocajas; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE totalflujocajas (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    valor_neto double precision NOT NULL,
    costo_beneficio double precision NOT NULL,
    tasa_retorno double precision NOT NULL,
    tasa_rendimineto double precision NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    estatus character varying(1) DEFAULT 1 NOT NULL,
    anos integer NOT NULL
);


ALTER TABLE pdi.totalflujocajas OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 148827)
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
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 209
-- Name: totalflujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE totalflujocajas_id_seq OWNED BY totalflujocajas.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 210 (class 1259 OID 148829)
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
-- TOC entry 211 (class 1259 OID 148832)
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
-- TOC entry 212 (class 1259 OID 148835)
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
-- TOC entry 213 (class 1259 OID 148838)
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
-- TOC entry 214 (class 1259 OID 148841)
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
-- TOC entry 215 (class 1259 OID 148844)
-- Name: gen_estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE public.gen_estado OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 148847)
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
-- TOC entry 217 (class 1259 OID 148850)
-- Name: gen_municipio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_municipio (
    id integer NOT NULL,
    dmunicipio character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE public.gen_municipio OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 148853)
-- Name: gen_parroquia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_parroquia (
    id integer NOT NULL,
    dparroquia character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE public.gen_parroquia OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 148856)
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
-- TOC entry 220 (class 1259 OID 148862)
-- Name: gen_tipo_financiamiento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_tipo_financiamiento (
    id integer NOT NULL,
    dtipofinaciamiento character(250) NOT NULL
);


ALTER TABLE public.gen_tipo_financiamiento OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 148865)
-- Name: gen_tipo_proyecto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_tipo_proyecto (
    id integer NOT NULL,
    dtipoproyecto character varying(80) NOT NULL,
    fregistro date NOT NULL,
    bestatus character(1) NOT NULL
);


ALTER TABLE public.gen_tipo_proyecto OWNER TO postgres;

SET search_path = pdi, pg_catalog;

--
-- TOC entry 2043 (class 2604 OID 148868)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY activos ALTER COLUMN id SET DEFAULT nextval('activos_id_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 148869)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY arancelesempresas ALTER COLUMN id SET DEFAULT nextval('arancelesempresas_id_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 148870)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes ALTER COLUMN id SET DEFAULT nextval('bienes_id_seq'::regclass);


--
-- TOC entry 2054 (class 2604 OID 148871)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY cronogramaexport ALTER COLUMN id SET DEFAULT nextval('cronogramaexport_id_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 148872)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY cronogramaimport ALTER COLUMN id SET DEFAULT nextval('cronogramaimport_id_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 148873)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY datosbasicos ALTER COLUMN id SET DEFAULT nextval('datosbasicos_id_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 148874)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras ALTER COLUMN id SET DEFAULT nextval('entidadesfinancieras_id_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 148875)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos ALTER COLUMN id SET DEFAULT nextval('financiamientos_id_seq'::regclass);


--
-- TOC entry 2069 (class 2604 OID 148876)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas ALTER COLUMN id SET DEFAULT nextval('flujocajas_id_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 149090)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY periodos ALTER COLUMN id SET DEFAULT nextval('periodos_id_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 148877)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion ALTER COLUMN id SET DEFAULT nextval('planinversion_id_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 148878)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY presupuestos ALTER COLUMN id SET DEFAULT nextval('presupuestos_id_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 148879)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 148880)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tipoproyectos ALTER COLUMN id SET DEFAULT nextval('tipoproyectos_id_seq'::regclass);


--
-- TOC entry 2084 (class 2604 OID 148881)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tiposfinanciamiento ALTER COLUMN id SET DEFAULT nextval('tiposfinanciamiento_id_seq'::regclass);


--
-- TOC entry 2087 (class 2604 OID 148882)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas ALTER COLUMN id SET DEFAULT nextval('totalflujocajas_id_seq'::regclass);


--
-- TOC entry 2301 (class 0 OID 148701)
-- Dependencies: 174
-- Data for Name: activos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY activos (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('activos_id_seq', 1, false);


--
-- TOC entry 2303 (class 0 OID 148708)
-- Dependencies: 176
-- Data for Name: arancelesempresas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY arancelesempresas (id, descripcion, cod_arancelario, unidad_id, cantidad, monto_anual, fecha_registro, valido, empresa_id) FROM stdin;
\.


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('arancelesempresas_id_seq', 1, false);


--
-- TOC entry 2305 (class 0 OID 148715)
-- Dependencies: 178
-- Data for Name: archivo_estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_estatus (archivo_id, estatus_id, valido, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2306 (class 0 OID 148719)
-- Dependencies: 179
-- Data for Name: archivo_presupuestos_tmp; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_presupuestos_tmp (codarancel_id, unidad_id, fecha_cierre, montousd, cantidad, num_empleados, fecha_registro, valido, empresa_id, id_archivo_presupuesto) FROM stdin;
\.


--
-- TOC entry 2307 (class 0 OID 148723)
-- Dependencies: 180
-- Data for Name: bienes; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY bienes (id, codarancel_id, unidad_id, cant_pro_actual, capac_max_anual_actual, proyecto_id, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('bienes_id_seq', 1, false);


--
-- TOC entry 2309 (class 0 OID 148730)
-- Dependencies: 182
-- Data for Name: cronogramaexport; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY cronogramaexport (id, insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, pais_destino, fecha_registro, valido, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 183
-- Name: cronogramaexport_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('cronogramaexport_id_seq', 1, false);


--
-- TOC entry 2311 (class 0 OID 148737)
-- Dependencies: 184
-- Data for Name: cronogramaimport; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY cronogramaimport (id, insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, fecha_registro, valido, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 185
-- Name: cronogramaimport_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('cronogramaimport_id_seq', 1, false);


--
-- TOC entry 2313 (class 0 OID 148744)
-- Dependencies: 186
-- Data for Name: datosbasicos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY datosbasicos (id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss, valido, empresa_id, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 187
-- Name: datosbasicos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('datosbasicos_id_seq', 19, true);


--
-- TOC entry 2315 (class 0 OID 148751)
-- Dependencies: 188
-- Data for Name: entidadesfinancieras; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY entidadesfinancieras (id, financiamiento_id, capitalfinanciado, banco_id, tasainteres, anualidades, plazoprestamo, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 189
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('entidadesfinancieras_id_seq', 1, false);


--
-- TOC entry 2317 (class 0 OID 148758)
-- Dependencies: 190
-- Data for Name: estado; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2318 (class 0 OID 148761)
-- Dependencies: 191
-- Data for Name: estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2319 (class 0 OID 148764)
-- Dependencies: 192
-- Data for Name: financiamientos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY financiamientos (id, capitalpropio, proyecto_id, fecha_registro, valido, tipo_financiamiento_id) FROM stdin;
\.


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 193
-- Name: financiamientos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('financiamientos_id_seq', 1, false);


--
-- TOC entry 2321 (class 0 OID 148771)
-- Dependencies: 194
-- Data for Name: flujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY flujocajas (id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id, periodo_id, num_per, anos) FROM stdin;
\.


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 195
-- Name: flujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('flujocajas_id_seq', 1, false);


--
-- TOC entry 2323 (class 0 OID 148778)
-- Dependencies: 196
-- Data for Name: municipio; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY municipio (id, descripcion, estado_id) FROM stdin;
\.


--
-- TOC entry 2324 (class 0 OID 148781)
-- Dependencies: 197
-- Data for Name: parroquia; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY parroquia (id, descripcion, municipio_id) FROM stdin;
\.


--
-- TOC entry 2350 (class 0 OID 149087)
-- Dependencies: 223
-- Data for Name: periodos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY periodos (id, nombre) FROM stdin;
\.


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 222
-- Name: periodos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('periodos_id_seq', 1, false);


--
-- TOC entry 2325 (class 0 OID 148784)
-- Dependencies: 198
-- Data for Name: planinversion; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY planinversion (id, activo_id, monto_total, fondospropios, financiamiento, fecha_registro, estatus, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 199
-- Name: planinversion_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('planinversion_id_seq', 1, false);


--
-- TOC entry 2327 (class 0 OID 148791)
-- Dependencies: 200
-- Data for Name: presupuestos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY presupuestos (id, codarancel_id, unidad_id, fecha_cierre, cantidad, montousd, fecha_registro, estatus, empresa_id) FROM stdin;
\.


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 201
-- Name: presupuestos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('presupuestos_id_seq', 1, false);


--
-- TOC entry 2329 (class 0 OID 148798)
-- Dependencies: 202
-- Data for Name: proyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY proyectos (id, objetivoproducto, nom_proyecto, puntoreferencia, calleavenida, coordenadasutm, empresa_id, tipo_proyecto_id, estado_id, municipio_id, ciudad, fecha_registro, estatus, mes_inicio, ano_inicio, mes_fin, ano_fin) FROM stdin;
\.


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 203
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('proyectos_id_seq', 1, false);


--
-- TOC entry 2331 (class 0 OID 148808)
-- Dependencies: 204
-- Data for Name: tipoproyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tipoproyectos (id, descripcion, fecha_registro, estatus) FROM stdin;
\.


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 205
-- Name: tipoproyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tipoproyectos_id_seq', 1, false);


--
-- TOC entry 2333 (class 0 OID 148815)
-- Dependencies: 206
-- Data for Name: tiposfinanciamiento; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tiposfinanciamiento (id, descripcion, fecha_registro, estatus) FROM stdin;
\.


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 207
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tiposfinanciamiento_id_seq', 1, false);


--
-- TOC entry 2335 (class 0 OID 148822)
-- Dependencies: 208
-- Data for Name: totalflujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY totalflujocajas (id, proyecto_id, valor_neto, costo_beneficio, tasa_retorno, tasa_rendimineto, fecha_registro, estatus, anos) FROM stdin;
\.


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 209
-- Name: totalflujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('totalflujocajas_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 2337 (class 0 OID 148829)
-- Dependencies: 210
-- Data for Name: det_bienes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_bienes (id, carancelario, nunidadmedida, cant_pro_actual, capac_max_anual_actual, proyecto_id, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2338 (class 0 OID 148832)
-- Dependencies: 211
-- Data for Name: det_plan_inversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_plan_inversion (id, activo_id, mtotal, mfondospropios, nfinanciamiento, nempresa, fregistro, bestatus, cusuario, gen_activos_id) FROM stdin;
\.


--
-- TOC entry 2339 (class 0 OID 148835)
-- Dependencies: 212
-- Data for Name: det_presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_presupuesto (id, codarancelsol, carancelario, cunidadmedida, montousd, festimadacierre, fregistro, nusuario, bestatus, cusuario, cid, estado_id, municipio_id, parroquia_id) FROM stdin;
\.


--
-- TOC entry 2340 (class 0 OID 148838)
-- Dependencies: 213
-- Data for Name: estatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2341 (class 0 OID 148841)
-- Dependencies: 214
-- Data for Name: gen_activos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_activos (id, dactivo, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2342 (class 0 OID 148844)
-- Dependencies: 215
-- Data for Name: gen_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2343 (class 0 OID 148847)
-- Dependencies: 216
-- Data for Name: gen_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_financiamiento (id, mcapitalpropio, mcapitalfinanciado, nbanco, ctasainteres, manualidades, fplazoprestamo, nempresa, fregistro, bestatus, get_tipo_financiamiento_id, cusuario) FROM stdin;
\.


--
-- TOC entry 2344 (class 0 OID 148850)
-- Dependencies: 217
-- Data for Name: gen_municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_municipio (id, dmunicipio, estado_id) FROM stdin;
\.


--
-- TOC entry 2345 (class 0 OID 148853)
-- Dependencies: 218
-- Data for Name: gen_parroquia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_parroquia (id, dparroquia, municipio_id) FROM stdin;
\.


--
-- TOC entry 2346 (class 0 OID 148856)
-- Dependencies: 219
-- Data for Name: gen_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_proyecto (id, dobjetivoproducto, dnombreproyecto, dpuntoreferencia, dcalleavenida, ccoordenadasutm, finicio, ffin, fregistro, nempresa, bestatus, cusuario, gen_tipo_proyecto_id) FROM stdin;
\.


--
-- TOC entry 2347 (class 0 OID 148862)
-- Dependencies: 220
-- Data for Name: gen_tipo_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_financiamiento (id, dtipofinaciamiento) FROM stdin;
\.


--
-- TOC entry 2348 (class 0 OID 148865)
-- Dependencies: 221
-- Data for Name: gen_tipo_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_proyecto (id, dtipoproyecto, fregistro, bestatus) FROM stdin;
\.


SET search_path = pdi, pg_catalog;

--
-- TOC entry 2098 (class 2606 OID 148884)
-- Name: bienes_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT bienes_pk PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 148886)
-- Name: estado_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2090 (class 2606 OID 148888)
-- Name: id_activos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY activos
    ADD CONSTRAINT id_activos PRIMARY KEY (id);


--
-- TOC entry 2092 (class 2606 OID 148890)
-- Name: id_arancelesempresa; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY arancelesempresas
    ADD CONSTRAINT id_arancelesempresa PRIMARY KEY (id);


--
-- TOC entry 2094 (class 2606 OID 148892)
-- Name: id_archivo_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT id_archivo_estatus PRIMARY KEY (archivo_id, estatus_id);


--
-- TOC entry 2096 (class 2606 OID 148894)
-- Name: id_archivo_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT id_archivo_presupuestos PRIMARY KEY (id_archivo_presupuesto);


--
-- TOC entry 2104 (class 2606 OID 148896)
-- Name: id_datosbasicos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY datosbasicos
    ADD CONSTRAINT id_datosbasicos PRIMARY KEY (id);


--
-- TOC entry 2106 (class 2606 OID 148898)
-- Name: id_entidadesfinancieras; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT id_entidadesfinancieras PRIMARY KEY (id);


--
-- TOC entry 2110 (class 2606 OID 148900)
-- Name: id_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2100 (class 2606 OID 148902)
-- Name: id_exportaciones; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cronogramaexport
    ADD CONSTRAINT id_exportaciones PRIMARY KEY (id);


--
-- TOC entry 2112 (class 2606 OID 148904)
-- Name: id_financiamientos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT id_financiamientos PRIMARY KEY (id);


--
-- TOC entry 2114 (class 2606 OID 148906)
-- Name: id_flujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT id_flujocajas PRIMARY KEY (id);


--
-- TOC entry 2102 (class 2606 OID 148908)
-- Name: id_importaciones; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cronogramaimport
    ADD CONSTRAINT id_importaciones PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 148910)
-- Name: id_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY presupuestos
    ADD CONSTRAINT id_presupuestos PRIMARY KEY (id);


--
-- TOC entry 2128 (class 2606 OID 148912)
-- Name: id_tipofinanciamiento; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tiposfinanciamiento
    ADD CONSTRAINT id_tipofinanciamiento PRIMARY KEY (id);


--
-- TOC entry 2126 (class 2606 OID 148914)
-- Name: id_tipoproyectos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoproyectos
    ADD CONSTRAINT id_tipoproyectos PRIMARY KEY (id);


--
-- TOC entry 2130 (class 2606 OID 148916)
-- Name: id_totalflujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT id_totalflujocajas PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 148918)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2118 (class 2606 OID 148920)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2166 (class 2606 OID 149094)
-- Name: periodos_nombre_key; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY periodos
    ADD CONSTRAINT periodos_nombre_key UNIQUE (nombre);


--
-- TOC entry 2168 (class 2606 OID 149092)
-- Name: periodos_pkey; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY periodos
    ADD CONSTRAINT periodos_pkey PRIMARY KEY (id);


--
-- TOC entry 2120 (class 2606 OID 148922)
-- Name: planinversion_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT planinversion_pk PRIMARY KEY (id);


--
-- TOC entry 2124 (class 2606 OID 148924)
-- Name: proyectos_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pk PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2150 (class 2606 OID 148926)
-- Name: descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT descripcion__un UNIQUE (dmunicipio);


--
-- TOC entry 2132 (class 2606 OID 148928)
-- Name: det_bienes_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT "det_bienes_PK" PRIMARY KEY (id);


--
-- TOC entry 2134 (class 2606 OID 148930)
-- Name: det_plan_inversion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_pk PRIMARY KEY (id);


--
-- TOC entry 2136 (class 2606 OID 148932)
-- Name: det_presupuesto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_pk PRIMARY KEY (id);


--
-- TOC entry 2162 (class 2606 OID 148934)
-- Name: dtipoproyecto__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT dtipoproyecto__un UNIQUE (dtipoproyecto);


--
-- TOC entry 2144 (class 2606 OID 148936)
-- Name: estado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2140 (class 2606 OID 148938)
-- Name: gen_activos_descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_descripcion__un UNIQUE (dactivo);


--
-- TOC entry 2142 (class 2606 OID 148940)
-- Name: gen_activos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_pk PRIMARY KEY (id);


--
-- TOC entry 2146 (class 2606 OID 148942)
-- Name: gen_estado__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT gen_estado__un UNIQUE (destado);


--
-- TOC entry 2148 (class 2606 OID 148944)
-- Name: gen_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2156 (class 2606 OID 148946)
-- Name: gen_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_pk PRIMARY KEY (id);


--
-- TOC entry 2158 (class 2606 OID 148948)
-- Name: gen_tipo_financiamiento__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT gen_tipo_financiamiento__un UNIQUE (dtipofinaciamiento);


--
-- TOC entry 2160 (class 2606 OID 148950)
-- Name: get_tipo_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT get_tipo_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2138 (class 2606 OID 148952)
-- Name: id_estatus; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2152 (class 2606 OID 148954)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2154 (class 2606 OID 148956)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2164 (class 2606 OID 148958)
-- Name: tipo_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT tipo_proyecto_pk PRIMARY KEY (id);


SET search_path = pdi, pg_catalog;

--
-- TOC entry 2181 (class 2606 OID 148960)
-- Name: activos_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT activos_plan FOREIGN KEY (activo_id) REFERENCES activos(id);


--
-- TOC entry 2169 (class 2606 OID 148965)
-- Name: archivo_estatus_estus_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_estus_fk FOREIGN KEY (estatus_id) REFERENCES estatus(id) ON DELETE RESTRICT;


--
-- TOC entry 2170 (class 2606 OID 148970)
-- Name: archivo_estatus_presupuestos_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_presupuestos_fk FOREIGN KEY (archivo_id) REFERENCES archivo_presupuestos_tmp(id_archivo_presupuesto) ON DELETE RESTRICT;


--
-- TOC entry 2171 (class 2606 OID 148975)
-- Name: archivo_presupuestos_tmp_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT archivo_presupuestos_tmp_fk FOREIGN KEY (id_archivo_presupuesto) REFERENCES presupuestos(id) ON DELETE RESTRICT;


--
-- TOC entry 2175 (class 2606 OID 148980)
-- Name: financiamiento_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT financiamiento_fk FOREIGN KEY (financiamiento_id) REFERENCES financiamientos(id);


--
-- TOC entry 2176 (class 2606 OID 148985)
-- Name: financiamiento_tipo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT financiamiento_tipo FOREIGN KEY (tipo_financiamiento_id) REFERENCES tiposfinanciamiento(id);


--
-- TOC entry 2179 (class 2606 OID 148990)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2180 (class 2606 OID 148995)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES municipio(id);


--
-- TOC entry 2177 (class 2606 OID 149000)
-- Name: poyecto_financiamiento; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT poyecto_financiamiento FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2172 (class 2606 OID 149005)
-- Name: proyecto_bienes; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT proyecto_bienes FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2173 (class 2606 OID 149010)
-- Name: proyecto_export; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY cronogramaexport
    ADD CONSTRAINT proyecto_export FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2178 (class 2606 OID 149015)
-- Name: proyecto_flujo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT proyecto_flujo FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2184 (class 2606 OID 149020)
-- Name: proyecto_flujototal; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT proyecto_flujototal FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2174 (class 2606 OID 149025)
-- Name: proyecto_import; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY cronogramaimport
    ADD CONSTRAINT proyecto_import FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2182 (class 2606 OID 149030)
-- Name: proyecto_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT proyecto_plan FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2183 (class 2606 OID 149035)
-- Name: tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT tipo_proyecto_fk FOREIGN KEY (tipo_proyecto_id) REFERENCES tipoproyectos(id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2185 (class 2606 OID 149040)
-- Name: det_bienes_gen_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT det_bienes_gen_proyecto_fk FOREIGN KEY (proyecto_id) REFERENCES gen_proyecto(id);


--
-- TOC entry 2186 (class 2606 OID 149045)
-- Name: det_plan_inversion_gen_activos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_gen_activos_fk FOREIGN KEY (gen_activos_id) REFERENCES gen_activos(id);


--
-- TOC entry 2187 (class 2606 OID 149050)
-- Name: det_presupuesto_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2188 (class 2606 OID 149055)
-- Name: det_presupuesto_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2189 (class 2606 OID 149060)
-- Name: det_presupuesto_parroquia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_parroquia_fk FOREIGN KEY (parroquia_id) REFERENCES gen_parroquia(id);


--
-- TOC entry 2190 (class 2606 OID 149065)
-- Name: gen_financiamiento_get_tipo_financiamiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_get_tipo_financiamiento_fk FOREIGN KEY (get_tipo_financiamiento_id) REFERENCES gen_tipo_financiamiento(id);


--
-- TOC entry 2193 (class 2606 OID 149070)
-- Name: gen_proyecto_gen_tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_gen_tipo_proyecto_fk FOREIGN KEY (gen_tipo_proyecto_id) REFERENCES gen_tipo_proyecto(id);


--
-- TOC entry 2191 (class 2606 OID 149075)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2192 (class 2606 OID 149080)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 7
-- Name: odbclink; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA odbclink FROM PUBLIC;
REVOKE ALL ON SCHEMA odbclink FROM postgres;
GRANT ALL ON SCHEMA odbclink TO postgres;
GRANT USAGE ON SCHEMA odbclink TO PUBLIC;


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-09-25 20:07:41

--
-- PostgreSQL database dump complete
--

