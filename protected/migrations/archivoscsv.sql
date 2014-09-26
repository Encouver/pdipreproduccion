--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-09-26 18:19:39

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
-- TOC entry 225 (class 1259 OID 149839)
-- Name: archivoscsv; Type: TABLE; Schema: pdi; Owner: divisa; Tablespace: 
--

CREATE TABLE archivoscsv (
    id integer NOT NULL,
    proyecto_id integer NOT NULL,
    archivo character varying(255) NOT NULL,
    tipo_csv integer NOT NULL,
    fecha date DEFAULT now() NOT NULL
);


ALTER TABLE pdi.archivoscsv OWNER TO divisa;

--
-- TOC entry 224 (class 1259 OID 149837)
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
-- TOC entry 2129 (class 0 OID 0)
-- Dependencies: 224
-- Name: archivoscsv_id_seq; Type: SEQUENCE OWNED BY; Schema: pdi; Owner: divisa
--

ALTER SEQUENCE archivoscsv_id_seq OWNED BY archivoscsv.id;


--
-- TOC entry 2010 (class 2604 OID 149842)
-- Name: id; Type: DEFAULT; Schema: pdi; Owner: divisa
--

ALTER TABLE ONLY archivoscsv ALTER COLUMN id SET DEFAULT nextval('archivoscsv_id_seq'::regclass);


--
-- TOC entry 2124 (class 0 OID 149839)
-- Dependencies: 225
-- Data for Name: archivoscsv; Type: TABLE DATA; Schema: pdi; Owner: divisa
--

COPY archivoscsv (id, proyecto_id, archivo, tipo_csv, fecha) FROM stdin;
\.


--
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 224
-- Name: archivoscsv_id_seq; Type: SEQUENCE SET; Schema: pdi; Owner: divisa
--

SELECT pg_catalog.setval('archivoscsv_id_seq', 1, false);


--
-- TOC entry 2013 (class 2606 OID 149845)
-- Name: archivoscsv_pkey; Type: CONSTRAINT; Schema: pdi; Owner: divisa; Tablespace: 
--

ALTER TABLE ONLY archivoscsv
    ADD CONSTRAINT archivoscsv_pkey PRIMARY KEY (id);


--
-- TOC entry 2014 (class 1259 OID 149851)
-- Name: fki_proyectos_archivos; Type: INDEX; Schema: pdi; Owner: divisa; Tablespace: 
--

CREATE INDEX fki_proyectos_archivos ON archivoscsv USING btree (proyecto_id);


--
-- TOC entry 2015 (class 2606 OID 149846)
-- Name: fk_proyectos_archivos; Type: FK CONSTRAINT; Schema: pdi; Owner: divisa
--

ALTER TABLE ONLY archivoscsv
    ADD CONSTRAINT fk_proyectos_archivos FOREIGN KEY (proyecto_id) REFERENCES proyectos(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2014-09-26 18:19:39

--
-- PostgreSQL database dump complete
--

