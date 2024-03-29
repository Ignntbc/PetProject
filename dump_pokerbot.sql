--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-2.pgdg110+2)
-- Dumped by pg_dump version 14.5 (Debian 14.5-2.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: maintainer
--

CREATE TABLE public.goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goose_db_version OWNER TO maintainer;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: maintainer
--

CREATE SEQUENCE public.goose_db_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goose_db_version_id_seq OWNER TO maintainer;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maintainer
--

ALTER SEQUENCE public.goose_db_version_id_seq OWNED BY public.goose_db_version.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: maintainer
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    player_id bigint NOT NULL,
    is_creator boolean NOT NULL
);


ALTER TABLE public.rooms OWNER TO maintainer;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: maintainer
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO maintainer;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maintainer
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: maintainer
--

CREATE TABLE public.test (
    id integer NOT NULL,
    test_name character varying(255) NOT NULL
);


ALTER TABLE public.test OWNER TO maintainer;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: maintainer
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO maintainer;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: maintainer
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.goose_db_version ALTER COLUMN id SET DEFAULT nextval('public.goose_db_version_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: maintainer
--

COPY public.goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2024-01-24 10:07:53.361244
2	20240119103040	t	2024-01-24 10:07:53.3785
3	20240123070655	t	2024-01-24 10:07:53.409408
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: maintainer
--

COPY public.rooms (id, player_name, player_id, is_creator) FROM stdin;
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: maintainer
--

COPY public.test (id, test_name) FROM stdin;
\.


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maintainer
--

SELECT pg_catalog.setval('public.goose_db_version_id_seq', 3, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maintainer
--

SELECT pg_catalog.setval('public.rooms_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maintainer
--

SELECT pg_catalog.setval('public.test_id_seq', 1, false);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: maintainer
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

