--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-09-27 17:58:38 VET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 22603)
-- Name: odbclink; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA odbclink;


ALTER SCHEMA odbclink OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 22604)
-- Name: pdi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pdi;


ALTER SCHEMA pdi OWNER TO postgres;

--
-- TOC entry 223 (class 3079 OID 11833)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 223
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 224 (class 3079 OID 22607)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 224
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET search_path = odbclink, pg_catalog;

--
-- TOC entry 615 (class 1247 OID 22655)
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
-- TOC entry 278 (class 1255 OID 22663)
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
-- TOC entry 174 (class 1259 OID 22664)
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
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.id IS 'numero secuencial para identificar el activo';


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.descripcion IS 'descripción del activo';


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.fecha_registro IS 'fecha de registro del activo';


--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN activos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN activos.valido IS 'campo para indicar si el registro esta vigente (1) o no (0)';


--
-- TOC entry 175 (class 1259 OID 22669)
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
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE activos_id_seq OWNED BY activos.id;


--
-- TOC entry 176 (class 1259 OID 22671)
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
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.id IS 'numero secuencial de para identificar los aranceles de las empresas';


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.descripcion; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.descripcion IS 'descripción del arancel';


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN arancelesempresas.empresa_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN arancelesempresas.empresa_id IS 'campo foráneo que contiene el identificador de la empresa que viene de la tabla gen_juridico de BDCADIVI';


--
-- TOC entry 177 (class 1259 OID 22676)
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
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE arancelesempresas_id_seq OWNED BY arancelesempresas.id;


--
-- TOC entry 178 (class 1259 OID 22678)
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
-- TOC entry 179 (class 1259 OID 22682)
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
-- TOC entry 180 (class 1259 OID 22686)
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
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.id IS 'número secuencial de identificación de los bienes';


--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.unidad_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.unidad_id IS 'campo foráneo que viene de la tabla gen_unidad de BDCADIVI';


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.proyecto_id IS 'campo foráneo que viene de la tabla proyecto';


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN bienes.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN bienes.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 181 (class 1259 OID 22691)
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
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE bienes_id_seq OWNED BY bienes.id;


--
-- TOC entry 182 (class 1259 OID 22707)
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
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN datosbasicos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.id IS 'número secuencial que identifica el conjunto de datos basicos de la empresas';


--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN datosbasicos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN datosbasicos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 183 (class 1259 OID 22712)
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
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 183
-- Name: datosbasicos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE datosbasicos_id_seq OWNED BY datosbasicos.id;


--
-- TOC entry 184 (class 1259 OID 22714)
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
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.id IS 'número secuencial que identifica la entidad financiera';


--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.financiamiento_id IS 'campo foráneo que viene de la tabla financiamientos';


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN entidadesfinancieras.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN entidadesfinancieras.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 185 (class 1259 OID 22719)
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
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 185
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE entidadesfinancieras_id_seq OWNED BY entidadesfinancieras.id;


--
-- TOC entry 186 (class 1259 OID 22721)
-- Name: estado; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE pdi.estado OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 22724)
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
-- TOC entry 222 (class 1259 OID 23080)
-- Name: exportaciones_paises; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE exportaciones_paises (
    id integer NOT NULL,
    cpais character varying(6),
    import_export_id integer
);


ALTER TABLE pdi.exportaciones_paises OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23078)
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
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 221
-- Name: exportaciones_paises_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE exportaciones_paises_id_seq OWNED BY exportaciones_paises.id;


--
-- TOC entry 188 (class 1259 OID 22727)
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
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN financiamientos.id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.id IS 'número secuencial para identificar el financiamiento';


--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN financiamientos.proyecto_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.proyecto_id IS 'campo foránero que viene de la tabla proyectos';


--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN financiamientos.fecha_registro; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.fecha_registro IS 'fecha de registro del arancel';


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN financiamientos.valido; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.valido IS 'campo para identificar si el registro esta vigente o no';


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN financiamientos.tipo_financiamiento_id; Type: COMMENT; Schema: pdi; Owner: postgres
--

COMMENT ON COLUMN financiamientos.tipo_financiamiento_id IS 'campo foráneo que viene de la tabla tipo financiamiento';


--
-- TOC entry 189 (class 1259 OID 22732)
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
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 189
-- Name: financiamientos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE financiamientos_id_seq OWNED BY financiamientos.id;


--
-- TOC entry 190 (class 1259 OID 22734)
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
    proyecto_id integer NOT NULL
);


ALTER TABLE pdi.flujocajas OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 22739)
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
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 191
-- Name: flujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE flujocajas_id_seq OWNED BY flujocajas.id;


--
-- TOC entry 220 (class 1259 OID 23073)
-- Name: import_export; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE import_export (
    id integer NOT NULL,
    insumo character varying(30),
    cod_arancelario integer,
    unidad_id integer,
    cantidad integer,
    costo_total integer,
    fecha_estimada date,
    pais_destino integer,
    fecha_registro timestamp without time zone,
    valido character varying(1),
    proyecto_id integer,
    tipo character varying(100)
);


ALTER TABLE pdi.import_export OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 22741)
-- Name: municipio; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE municipio (
    id integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE pdi.municipio OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 22744)
-- Name: parroquia; Type: TABLE; Schema: pdi; Owner: postgres; Tablespace: 
--

CREATE TABLE parroquia (
    id integer NOT NULL,
    descripcion character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE pdi.parroquia OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 22747)
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
-- TOC entry 195 (class 1259 OID 22752)
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
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 195
-- Name: planinversion_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE planinversion_id_seq OWNED BY planinversion.id;


--
-- TOC entry 196 (class 1259 OID 22754)
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
-- TOC entry 197 (class 1259 OID 22759)
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
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 197
-- Name: presupuestos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE presupuestos_id_seq OWNED BY presupuestos.id;


--
-- TOC entry 198 (class 1259 OID 22761)
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
-- TOC entry 199 (class 1259 OID 22769)
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
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 199
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- TOC entry 200 (class 1259 OID 22771)
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
-- TOC entry 201 (class 1259 OID 22776)
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
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 201
-- Name: tipoproyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tipoproyectos_id_seq OWNED BY tipoproyectos.id;


--
-- TOC entry 202 (class 1259 OID 22778)
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
-- TOC entry 203 (class 1259 OID 22783)
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
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 203
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE tiposfinanciamiento_id_seq OWNED BY tiposfinanciamiento.id;


--
-- TOC entry 204 (class 1259 OID 22785)
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
    estatus character varying(1) DEFAULT 1 NOT NULL
);


ALTER TABLE pdi.totalflujocajas OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 22790)
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
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 205
-- Name: totalflujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE totalflujocajas_id_seq OWNED BY totalflujocajas.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 206 (class 1259 OID 22792)
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
-- TOC entry 207 (class 1259 OID 22795)
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
-- TOC entry 208 (class 1259 OID 22798)
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
-- TOC entry 209 (class 1259 OID 22801)
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
-- TOC entry 210 (class 1259 OID 22804)
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
-- TOC entry 211 (class 1259 OID 22807)
-- Name: gen_estado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_estado (
    id integer NOT NULL,
    destado character varying(150) NOT NULL
);


ALTER TABLE public.gen_estado OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 22810)
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
-- TOC entry 213 (class 1259 OID 22813)
-- Name: gen_municipio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_municipio (
    id integer NOT NULL,
    dmunicipio character varying(45) NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE public.gen_municipio OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23064)
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
-- TOC entry 214 (class 1259 OID 22816)
-- Name: gen_parroquia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_parroquia (
    id integer NOT NULL,
    dparroquia character varying(65) NOT NULL,
    municipio_id integer NOT NULL
);


ALTER TABLE public.gen_parroquia OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 22819)
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
-- TOC entry 216 (class 1259 OID 22825)
-- Name: gen_tipo_financiamiento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gen_tipo_financiamiento (
    id integer NOT NULL,
    dtipofinaciamiento character(250) NOT NULL
);


ALTER TABLE public.gen_tipo_financiamiento OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 22828)
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
-- TOC entry 218 (class 1259 OID 23058)
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
-- TOC entry 2125 (class 2604 OID 22831)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY activos ALTER COLUMN id SET DEFAULT nextval('activos_id_seq'::regclass);


--
-- TOC entry 2128 (class 2604 OID 22832)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY arancelesempresas ALTER COLUMN id SET DEFAULT nextval('arancelesempresas_id_seq'::regclass);


--
-- TOC entry 2133 (class 2604 OID 22833)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes ALTER COLUMN id SET DEFAULT nextval('bienes_id_seq'::regclass);


--
-- TOC entry 2136 (class 2604 OID 22836)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY datosbasicos ALTER COLUMN id SET DEFAULT nextval('datosbasicos_id_seq'::regclass);


--
-- TOC entry 2139 (class 2604 OID 22837)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras ALTER COLUMN id SET DEFAULT nextval('entidadesfinancieras_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 23083)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY exportaciones_paises ALTER COLUMN id SET DEFAULT nextval('exportaciones_paises_id_seq'::regclass);


--
-- TOC entry 2142 (class 2604 OID 22838)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos ALTER COLUMN id SET DEFAULT nextval('financiamientos_id_seq'::regclass);


--
-- TOC entry 2145 (class 2604 OID 22839)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas ALTER COLUMN id SET DEFAULT nextval('flujocajas_id_seq'::regclass);


--
-- TOC entry 2148 (class 2604 OID 22840)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion ALTER COLUMN id SET DEFAULT nextval('planinversion_id_seq'::regclass);


--
-- TOC entry 2151 (class 2604 OID 22841)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY presupuestos ALTER COLUMN id SET DEFAULT nextval('presupuestos_id_seq'::regclass);


--
-- TOC entry 2152 (class 2604 OID 22842)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- TOC entry 2157 (class 2604 OID 22843)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tipoproyectos ALTER COLUMN id SET DEFAULT nextval('tipoproyectos_id_seq'::regclass);


--
-- TOC entry 2160 (class 2604 OID 22844)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY tiposfinanciamiento ALTER COLUMN id SET DEFAULT nextval('tiposfinanciamiento_id_seq'::regclass);


--
-- TOC entry 2163 (class 2604 OID 22845)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas ALTER COLUMN id SET DEFAULT nextval('totalflujocajas_id_seq'::regclass);


--
-- TOC entry 2381 (class 0 OID 22664)
-- Dependencies: 174
-- Data for Name: activos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY activos (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 175
-- Name: activos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('activos_id_seq', 1, false);


--
-- TOC entry 2383 (class 0 OID 22671)
-- Dependencies: 176
-- Data for Name: arancelesempresas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY arancelesempresas (id, descripcion, cod_arancelario, unidad_id, cantidad, monto_anual, fecha_registro, valido, empresa_id) FROM stdin;
\.


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 177
-- Name: arancelesempresas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('arancelesempresas_id_seq', 1, false);


--
-- TOC entry 2385 (class 0 OID 22678)
-- Dependencies: 178
-- Data for Name: archivo_estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_estatus (archivo_id, estatus_id, valido, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2386 (class 0 OID 22682)
-- Dependencies: 179
-- Data for Name: archivo_presupuestos_tmp; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY archivo_presupuestos_tmp (codarancel_id, unidad_id, fecha_cierre, montousd, cantidad, num_empleados, fecha_registro, valido, empresa_id, id_archivo_presupuesto) FROM stdin;
\.


--
-- TOC entry 2387 (class 0 OID 22686)
-- Dependencies: 180
-- Data for Name: bienes; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY bienes (id, codarancel_id, unidad_id, cant_pro_actual, capac_max_anual_actual, proyecto_id, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 181
-- Name: bienes_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('bienes_id_seq', 1, false);


--
-- TOC entry 2389 (class 0 OID 22707)
-- Dependencies: 182
-- Data for Name: datosbasicos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY datosbasicos (id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss, valido, empresa_id, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 183
-- Name: datosbasicos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('datosbasicos_id_seq', 19, true);


--
-- TOC entry 2391 (class 0 OID 22714)
-- Dependencies: 184
-- Data for Name: entidadesfinancieras; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY entidadesfinancieras (id, financiamiento_id, capitalfinanciado, banco_id, tasainteres, anualidades, plazoprestamo, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 185
-- Name: entidadesfinancieras_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('entidadesfinancieras_id_seq', 1, false);


--
-- TOC entry 2393 (class 0 OID 22721)
-- Dependencies: 186
-- Data for Name: estado; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2394 (class 0 OID 22724)
-- Dependencies: 187
-- Data for Name: estatus; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2429 (class 0 OID 23080)
-- Dependencies: 222
-- Data for Name: exportaciones_paises; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY exportaciones_paises (id, cpais, import_export_id) FROM stdin;
\.


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 221
-- Name: exportaciones_paises_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('exportaciones_paises_id_seq', 1, false);


--
-- TOC entry 2395 (class 0 OID 22727)
-- Dependencies: 188
-- Data for Name: financiamientos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY financiamientos (id, capitalpropio, proyecto_id, fecha_registro, valido, tipo_financiamiento_id) FROM stdin;
\.


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 189
-- Name: financiamientos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('financiamientos_id_seq', 1, false);


--
-- TOC entry 2397 (class 0 OID 22734)
-- Dependencies: 190
-- Data for Name: flujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY flujocajas (id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 191
-- Name: flujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('flujocajas_id_seq', 1, false);


--
-- TOC entry 2427 (class 0 OID 23073)
-- Dependencies: 220
-- Data for Name: import_export; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY import_export (id, insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, pais_destino, fecha_registro, valido, proyecto_id, tipo) FROM stdin;
\.


--
-- TOC entry 2399 (class 0 OID 22741)
-- Dependencies: 192
-- Data for Name: municipio; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY municipio (id, descripcion, estado_id) FROM stdin;
\.


--
-- TOC entry 2400 (class 0 OID 22744)
-- Dependencies: 193
-- Data for Name: parroquia; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY parroquia (id, descripcion, municipio_id) FROM stdin;
\.


--
-- TOC entry 2401 (class 0 OID 22747)
-- Dependencies: 194
-- Data for Name: planinversion; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY planinversion (id, activo_id, monto_total, fondospropios, financiamiento, fecha_registro, estatus, proyecto_id) FROM stdin;
\.


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 195
-- Name: planinversion_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('planinversion_id_seq', 1, false);


--
-- TOC entry 2403 (class 0 OID 22754)
-- Dependencies: 196
-- Data for Name: presupuestos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY presupuestos (id, codarancel_id, unidad_id, fecha_cierre, cantidad, montousd, fecha_registro, estatus, empresa_id) FROM stdin;
\.


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 197
-- Name: presupuestos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('presupuestos_id_seq', 1, false);


--
-- TOC entry 2405 (class 0 OID 22761)
-- Dependencies: 198
-- Data for Name: proyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY proyectos (id, objetivoproducto, nom_proyecto, puntoreferencia, calleavenida, coordenadasutm, empresa_id, tipo_proyecto_id, estado_id, municipio_id, ciudad, fecha_registro, estatus, mes_inicio, ano_inicio, mes_fin, ano_fin) FROM stdin;
3	Diseño de computadores	Cataplam	asdf	asdf	1	1	1	1	1	gffg	2014-09-26 11:29:59	1	1	1	2	1
\.


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 199
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('proyectos_id_seq', 1, false);


--
-- TOC entry 2407 (class 0 OID 22771)
-- Dependencies: 200
-- Data for Name: tipoproyectos; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tipoproyectos (id, descripcion, fecha_registro, estatus) FROM stdin;
1	computadoras	2014-09-24 11:30:48	s
\.


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 201
-- Name: tipoproyectos_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tipoproyectos_id_seq', 1, false);


--
-- TOC entry 2409 (class 0 OID 22778)
-- Dependencies: 202
-- Data for Name: tiposfinanciamiento; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY tiposfinanciamiento (id, descripcion, fecha_registro, estatus) FROM stdin;
\.


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 203
-- Name: tiposfinanciamiento_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('tiposfinanciamiento_id_seq', 1, false);


--
-- TOC entry 2411 (class 0 OID 22785)
-- Dependencies: 204
-- Data for Name: totalflujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY totalflujocajas (id, proyecto_id, valor_neto, costo_beneficio, tasa_retorno, tasa_rendimineto, fecha_registro, estatus) FROM stdin;
\.


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 205
-- Name: totalflujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('totalflujocajas_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 2413 (class 0 OID 22792)
-- Dependencies: 206
-- Data for Name: det_bienes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_bienes (id, carancelario, nunidadmedida, cant_pro_actual, capac_max_anual_actual, proyecto_id, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2414 (class 0 OID 22795)
-- Dependencies: 207
-- Data for Name: det_plan_inversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_plan_inversion (id, activo_id, mtotal, mfondospropios, nfinanciamiento, nempresa, fregistro, bestatus, cusuario, gen_activos_id) FROM stdin;
\.


--
-- TOC entry 2415 (class 0 OID 22798)
-- Dependencies: 208
-- Data for Name: det_presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY det_presupuesto (id, codarancelsol, carancelario, cunidadmedida, montousd, festimadacierre, fregistro, nusuario, bestatus, cusuario, cid, estado_id, municipio_id, parroquia_id) FROM stdin;
\.


--
-- TOC entry 2416 (class 0 OID 22801)
-- Dependencies: 209
-- Data for Name: estatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estatus (id, descripcion, fecha_registro, valido) FROM stdin;
\.


--
-- TOC entry 2417 (class 0 OID 22804)
-- Dependencies: 210
-- Data for Name: gen_activos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_activos (id, dactivo, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2418 (class 0 OID 22807)
-- Dependencies: 211
-- Data for Name: gen_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_estado (id, destado) FROM stdin;
\.


--
-- TOC entry 2419 (class 0 OID 22810)
-- Dependencies: 212
-- Data for Name: gen_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_financiamiento (id, mcapitalpropio, mcapitalfinanciado, nbanco, ctasainteres, manualidades, fplazoprestamo, nempresa, fregistro, bestatus, get_tipo_financiamiento_id, cusuario) FROM stdin;
\.


--
-- TOC entry 2420 (class 0 OID 22813)
-- Dependencies: 213
-- Data for Name: gen_municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_municipio (id, dmunicipio, estado_id) FROM stdin;
\.


--
-- TOC entry 2426 (class 0 OID 23064)
-- Dependencies: 219
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
-- TOC entry 2421 (class 0 OID 22816)
-- Dependencies: 214
-- Data for Name: gen_parroquia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_parroquia (id, dparroquia, municipio_id) FROM stdin;
\.


--
-- TOC entry 2422 (class 0 OID 22819)
-- Dependencies: 215
-- Data for Name: gen_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_proyecto (id, dobjetivoproducto, dnombreproyecto, dpuntoreferencia, dcalleavenida, ccoordenadasutm, finicio, ffin, fregistro, nempresa, bestatus, cusuario, gen_tipo_proyecto_id) FROM stdin;
\.


--
-- TOC entry 2423 (class 0 OID 22825)
-- Dependencies: 216
-- Data for Name: gen_tipo_financiamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_financiamiento (id, dtipofinaciamiento) FROM stdin;
\.


--
-- TOC entry 2424 (class 0 OID 22828)
-- Dependencies: 217
-- Data for Name: gen_tipo_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gen_tipo_proyecto (id, dtipoproyecto, fregistro, bestatus) FROM stdin;
\.


--
-- TOC entry 2425 (class 0 OID 23058)
-- Dependencies: 218
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
-- TOC entry 2179 (class 2606 OID 22847)
-- Name: bienes_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT bienes_pk PRIMARY KEY (id);


--
-- TOC entry 2185 (class 2606 OID 22849)
-- Name: estado_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2249 (class 2606 OID 23085)
-- Name: exportacion_pais_id; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exportaciones_paises
    ADD CONSTRAINT exportacion_pais_id PRIMARY KEY (id);


--
-- TOC entry 2171 (class 2606 OID 22851)
-- Name: id_activos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY activos
    ADD CONSTRAINT id_activos PRIMARY KEY (id);


--
-- TOC entry 2173 (class 2606 OID 22853)
-- Name: id_arancelesempresa; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY arancelesempresas
    ADD CONSTRAINT id_arancelesempresa PRIMARY KEY (id);


--
-- TOC entry 2175 (class 2606 OID 22855)
-- Name: id_archivo_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT id_archivo_estatus PRIMARY KEY (archivo_id, estatus_id);


--
-- TOC entry 2177 (class 2606 OID 22857)
-- Name: id_archivo_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT id_archivo_presupuestos PRIMARY KEY (id_archivo_presupuesto);


--
-- TOC entry 2181 (class 2606 OID 22859)
-- Name: id_datosbasicos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY datosbasicos
    ADD CONSTRAINT id_datosbasicos PRIMARY KEY (id);


--
-- TOC entry 2183 (class 2606 OID 22861)
-- Name: id_entidadesfinancieras; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT id_entidadesfinancieras PRIMARY KEY (id);


--
-- TOC entry 2187 (class 2606 OID 22863)
-- Name: id_estatus; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2189 (class 2606 OID 22867)
-- Name: id_financiamientos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT id_financiamientos PRIMARY KEY (id);


--
-- TOC entry 2191 (class 2606 OID 22869)
-- Name: id_flujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT id_flujocajas PRIMARY KEY (id);


--
-- TOC entry 2199 (class 2606 OID 22873)
-- Name: id_presupuestos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY presupuestos
    ADD CONSTRAINT id_presupuestos PRIMARY KEY (id);


--
-- TOC entry 2205 (class 2606 OID 22875)
-- Name: id_tipofinanciamiento; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tiposfinanciamiento
    ADD CONSTRAINT id_tipofinanciamiento PRIMARY KEY (id);


--
-- TOC entry 2203 (class 2606 OID 22877)
-- Name: id_tipoproyectos; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoproyectos
    ADD CONSTRAINT id_tipoproyectos PRIMARY KEY (id);


--
-- TOC entry 2207 (class 2606 OID 22879)
-- Name: id_totalflujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT id_totalflujocajas PRIMARY KEY (id);


--
-- TOC entry 2193 (class 2606 OID 22881)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2195 (class 2606 OID 22883)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2247 (class 2606 OID 23077)
-- Name: pk_import_export_id; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY import_export
    ADD CONSTRAINT pk_import_export_id PRIMARY KEY (id);


--
-- TOC entry 2197 (class 2606 OID 22885)
-- Name: planinversion_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT planinversion_pk PRIMARY KEY (id);


--
-- TOC entry 2201 (class 2606 OID 22887)
-- Name: proyectos_pk; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pk PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2227 (class 2606 OID 22889)
-- Name: descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT descripcion__un UNIQUE (dmunicipio);


--
-- TOC entry 2209 (class 2606 OID 22891)
-- Name: det_bienes_PK; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT "det_bienes_PK" PRIMARY KEY (id);


--
-- TOC entry 2211 (class 2606 OID 22893)
-- Name: det_plan_inversion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_pk PRIMARY KEY (id);


--
-- TOC entry 2213 (class 2606 OID 22895)
-- Name: det_presupuesto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_pk PRIMARY KEY (id);


--
-- TOC entry 2239 (class 2606 OID 22897)
-- Name: dtipoproyecto__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT dtipoproyecto__un UNIQUE (dtipoproyecto);


--
-- TOC entry 2221 (class 2606 OID 22899)
-- Name: estado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (id);


--
-- TOC entry 2217 (class 2606 OID 22901)
-- Name: gen_activos_descripcion__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_descripcion__un UNIQUE (dactivo);


--
-- TOC entry 2219 (class 2606 OID 22903)
-- Name: gen_activos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_activos
    ADD CONSTRAINT gen_activos_pk PRIMARY KEY (id);


--
-- TOC entry 2223 (class 2606 OID 22905)
-- Name: gen_estado__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_estado
    ADD CONSTRAINT gen_estado__un UNIQUE (destado);


--
-- TOC entry 2225 (class 2606 OID 22907)
-- Name: gen_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2245 (class 2606 OID 23072)
-- Name: gen_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_pais
    ADD CONSTRAINT gen_pais_pkey PRIMARY KEY (cpais);


--
-- TOC entry 2233 (class 2606 OID 22909)
-- Name: gen_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_pk PRIMARY KEY (id);


--
-- TOC entry 2235 (class 2606 OID 22911)
-- Name: gen_tipo_financiamiento__un; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT gen_tipo_financiamiento__un UNIQUE (dtipofinaciamiento);


--
-- TOC entry 2237 (class 2606 OID 22913)
-- Name: get_tipo_financiamiento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_financiamiento
    ADD CONSTRAINT get_tipo_financiamiento_pk PRIMARY KEY (id);


--
-- TOC entry 2215 (class 2606 OID 22915)
-- Name: id_estatus; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estatus
    ADD CONSTRAINT id_estatus PRIMARY KEY (id);


--
-- TOC entry 2229 (class 2606 OID 22917)
-- Name: municipio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (id);


--
-- TOC entry 2231 (class 2606 OID 22919)
-- Name: parroquia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_pk PRIMARY KEY (id);


--
-- TOC entry 2243 (class 2606 OID 23063)
-- Name: pk_gun_spkunidad; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_unidades
    ADD CONSTRAINT pk_gun_spkunidad PRIMARY KEY (cunidad);


--
-- TOC entry 2241 (class 2606 OID 22921)
-- Name: tipo_proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gen_tipo_proyecto
    ADD CONSTRAINT tipo_proyecto_pk PRIMARY KEY (id);


SET search_path = pdi, pg_catalog;

--
-- TOC entry 2260 (class 2606 OID 22922)
-- Name: activos_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT activos_plan FOREIGN KEY (activo_id) REFERENCES activos(id);


--
-- TOC entry 2250 (class 2606 OID 22927)
-- Name: archivo_estatus_estus_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_estus_fk FOREIGN KEY (estatus_id) REFERENCES estatus(id) ON DELETE RESTRICT;


--
-- TOC entry 2251 (class 2606 OID 22932)
-- Name: archivo_estatus_presupuestos_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_estatus
    ADD CONSTRAINT archivo_estatus_presupuestos_fk FOREIGN KEY (archivo_id) REFERENCES archivo_presupuestos_tmp(id_archivo_presupuesto) ON DELETE RESTRICT;


--
-- TOC entry 2252 (class 2606 OID 22937)
-- Name: archivo_presupuestos_tmp_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY archivo_presupuestos_tmp
    ADD CONSTRAINT archivo_presupuestos_tmp_fk FOREIGN KEY (id_archivo_presupuesto) REFERENCES presupuestos(id) ON DELETE RESTRICT;


--
-- TOC entry 2254 (class 2606 OID 22942)
-- Name: financiamiento_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY entidadesfinancieras
    ADD CONSTRAINT financiamiento_fk FOREIGN KEY (financiamiento_id) REFERENCES financiamientos(id);


--
-- TOC entry 2255 (class 2606 OID 22947)
-- Name: financiamiento_tipo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT financiamiento_tipo FOREIGN KEY (tipo_financiamiento_id) REFERENCES tiposfinanciamiento(id);


--
-- TOC entry 2273 (class 2606 OID 23086)
-- Name: fk_import_export_id; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY exportaciones_paises
    ADD CONSTRAINT fk_import_export_id FOREIGN KEY (import_export_id) REFERENCES import_export(id);


--
-- TOC entry 2258 (class 2606 OID 22952)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES estado(id);


--
-- TOC entry 2259 (class 2606 OID 22957)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES municipio(id);


--
-- TOC entry 2256 (class 2606 OID 22962)
-- Name: poyecto_financiamiento; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY financiamientos
    ADD CONSTRAINT poyecto_financiamiento FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2253 (class 2606 OID 22967)
-- Name: proyecto_bienes; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY bienes
    ADD CONSTRAINT proyecto_bienes FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2257 (class 2606 OID 22977)
-- Name: proyecto_flujo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT proyecto_flujo FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2263 (class 2606 OID 22982)
-- Name: proyecto_flujototal; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY totalflujocajas
    ADD CONSTRAINT proyecto_flujototal FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2261 (class 2606 OID 22992)
-- Name: proyecto_plan; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY planinversion
    ADD CONSTRAINT proyecto_plan FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


--
-- TOC entry 2262 (class 2606 OID 22997)
-- Name: tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT tipo_proyecto_fk FOREIGN KEY (tipo_proyecto_id) REFERENCES tipoproyectos(id);


SET search_path = public, pg_catalog;

--
-- TOC entry 2264 (class 2606 OID 23002)
-- Name: det_bienes_gen_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_bienes
    ADD CONSTRAINT det_bienes_gen_proyecto_fk FOREIGN KEY (proyecto_id) REFERENCES gen_proyecto(id);


--
-- TOC entry 2265 (class 2606 OID 23007)
-- Name: det_plan_inversion_gen_activos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_plan_inversion
    ADD CONSTRAINT det_plan_inversion_gen_activos_fk FOREIGN KEY (gen_activos_id) REFERENCES gen_activos(id);


--
-- TOC entry 2266 (class 2606 OID 23012)
-- Name: det_presupuesto_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2267 (class 2606 OID 23017)
-- Name: det_presupuesto_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2268 (class 2606 OID 23022)
-- Name: det_presupuesto_parroquia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY det_presupuesto
    ADD CONSTRAINT det_presupuesto_parroquia_fk FOREIGN KEY (parroquia_id) REFERENCES gen_parroquia(id);


--
-- TOC entry 2269 (class 2606 OID 23027)
-- Name: gen_financiamiento_get_tipo_financiamiento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_financiamiento
    ADD CONSTRAINT gen_financiamiento_get_tipo_financiamiento_fk FOREIGN KEY (get_tipo_financiamiento_id) REFERENCES gen_tipo_financiamiento(id);


--
-- TOC entry 2272 (class 2606 OID 23032)
-- Name: gen_proyecto_gen_tipo_proyecto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_proyecto
    ADD CONSTRAINT gen_proyecto_gen_tipo_proyecto_fk FOREIGN KEY (gen_tipo_proyecto_id) REFERENCES gen_tipo_proyecto(id);


--
-- TOC entry 2270 (class 2606 OID 23037)
-- Name: municipio_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY (estado_id) REFERENCES gen_estado(id);


--
-- TOC entry 2271 (class 2606 OID 23042)
-- Name: parroquia_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gen_parroquia
    ADD CONSTRAINT parroquia_municipio_fk FOREIGN KEY (municipio_id) REFERENCES gen_municipio(id);


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 7
-- Name: odbclink; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA odbclink FROM PUBLIC;
REVOKE ALL ON SCHEMA odbclink FROM postgres;
GRANT ALL ON SCHEMA odbclink TO postgres;
GRANT USAGE ON SCHEMA odbclink TO PUBLIC;


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-09-27 17:58:39 VET

--
-- PostgreSQL database dump complete
--

