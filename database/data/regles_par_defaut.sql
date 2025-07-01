--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

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

--
-- Data for Name: regles_approbation_bons; Type: TABLE DATA; Schema: public; Owner: sushiwan_admin
--

COPY public.regles_approbation_bons (id, nom_regle, origine, type_bon, montant_max_auto_approuve, niveau_staff_requis, max_par_client_jour, max_par_client_mois, risk_score_max, actif, priorite, date_debut, date_fin, created_at, created_by, notes) FROM stdin;
5b845b26-8c63-48b7-802a-3a174239868a	Incidents mineurs auto	incident_compensation	\N	15.00	caissier	2	5	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
5986f1d5-3882-41ff-90ae-ee79575d34d3	Cadeaux staff	cadeau_staff	\N	5.00	caissier	1	3	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
ed114fb4-62f0-4a57-a332-8ab496c08507	Anniversaires clients	anniversaire_client	\N	12.00	manager	1	1	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
f2222531-4e1f-4b44-ab72-bae895e376fa	Première commande	premiere_commande	\N	8.00	caissier	1	1	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
281ffab4-6b79-4d28-9f8e-d63a712759a6	Conversion points	conversion_points	\N	999.00	caissier	10	50	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
7789c15d-b0aa-493a-b2c0-c39d4b65b438	Parrainage ami	parrainage	\N	20.00	manager	1	2	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
ed6ae97b-5a2f-442f-aa3b-984186ef2c80	Jeux concours	jeu_concours	\N	25.00	manager	1	3	50	t	10	2025-07-01	\N	2025-07-01 18:11:18.709986+00	\N	\N
\.


--
-- PostgreSQL database dump complete
--

