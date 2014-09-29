--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-09-29 09:51:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = pdi, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 193
-- Name: flujocajas_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: postgres
--

ALTER SEQUENCE flujocajas_id_seq OWNED BY flujocajas.id;


--
-- TOC entry 2017 (class 2604 OID 157520)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas ALTER COLUMN id SET DEFAULT nextval('flujocajas_id_seq'::regclass);


--
-- TOC entry 2129 (class 0 OID 157402)
-- Dependencies: 192
-- Data for Name: flujocajas; Type: TABLE DATA; Schema: pdi; Owner: postgres
--

COPY flujocajas (id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id, periodo, ano) FROM stdin;
\.


--
-- TOC entry 2136 (class 0 OID 0)
-- Dependencies: 193
-- Name: flujocajas_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: postgres
--

SELECT pg_catalog.setval('flujocajas_id_seq', 1, false);


--
-- TOC entry 2020 (class 2606 OID 157550)
-- Name: id_flujocajas; Type: CONSTRAINT; Schema: pdi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT id_flujocajas PRIMARY KEY (id);


--
-- TOC entry 2021 (class 2606 OID 157662)
-- Name: proyecto_flujo; Type: FK CONSTRAINT; Schema: pdi; Owner: postgres
--

ALTER TABLE ONLY flujocajas
    ADD CONSTRAINT proyecto_flujo FOREIGN KEY (proyecto_id) REFERENCES proyectos(id);


-- Completed on 2014-09-29 09:52:00

--
-- PostgreSQL database dump complete
--

