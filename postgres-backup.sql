--
-- PostgreSQL database dump
--

\restrict 5SclmjPwNTOFzZRnsR9fyCKfPwd9gpkq7d1gjNukb8Q06amXnMp6iBW147Vbwx4

-- Dumped from database version 16.15 (Debian 16.15-1.pgdg13+2)
-- Dumped by pg_dump version 16.15 (Debian 16.15-1.pgdg13+2)

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
-- Name: message_table; Type: TABLE; Schema: public; Owner: gopika
--

CREATE TABLE public.message_table (
    id integer NOT NULL,
    message character varying(255) NOT NULL
);


ALTER TABLE public.message_table OWNER TO gopika;

--
-- Name: message_table_id_seq; Type: SEQUENCE; Schema: public; Owner: gopika
--

CREATE SEQUENCE public.message_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_table_id_seq OWNER TO gopika;

--
-- Name: message_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gopika
--

ALTER SEQUENCE public.message_table_id_seq OWNED BY public.message_table.id;


--
-- Name: test_data; Type: TABLE; Schema: public; Owner: gopika
--

CREATE TABLE public.test_data (
    id integer NOT NULL,
    message text
);


ALTER TABLE public.test_data OWNER TO gopika;

--
-- Name: test_data_id_seq; Type: SEQUENCE; Schema: public; Owner: gopika
--

CREATE SEQUENCE public.test_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_data_id_seq OWNER TO gopika;

--
-- Name: test_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gopika
--

ALTER SEQUENCE public.test_data_id_seq OWNED BY public.test_data.id;


--
-- Name: message_table id; Type: DEFAULT; Schema: public; Owner: gopika
--

ALTER TABLE ONLY public.message_table ALTER COLUMN id SET DEFAULT nextval('public.message_table_id_seq'::regclass);


--
-- Name: test_data id; Type: DEFAULT; Schema: public; Owner: gopika
--

ALTER TABLE ONLY public.test_data ALTER COLUMN id SET DEFAULT nextval('public.test_data_id_seq'::regclass);


--
-- Data for Name: message_table; Type: TABLE DATA; Schema: public; Owner: gopika
--

COPY public.message_table (id, message) FROM stdin;
1	persistent volume work
\.


--
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: gopika
--

COPY public.test_data (id, message) FROM stdin;
\.


--
-- Name: message_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gopika
--

SELECT pg_catalog.setval('public.message_table_id_seq', 1, true);


--
-- Name: test_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gopika
--

SELECT pg_catalog.setval('public.test_data_id_seq', 1, false);


--
-- Name: message_table message_table_pkey; Type: CONSTRAINT; Schema: public; Owner: gopika
--

ALTER TABLE ONLY public.message_table
    ADD CONSTRAINT message_table_pkey PRIMARY KEY (id);


--
-- Name: test_data test_data_pkey; Type: CONSTRAINT; Schema: public; Owner: gopika
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5SclmjPwNTOFzZRnsR9fyCKfPwd9gpkq7d1gjNukb8Q06amXnMp6iBW147Vbwx4

