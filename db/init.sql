
-- Installing nessecary extensions for us to use. 
CREATE EXTENSION IF NOT EXISTS pgcrypto
    SCHEMA public
    VERSION "1.3";

CREATE EXTENSION IF NOT EXISTS plpgsql
    SCHEMA pg_catalog
    VERSION "1.0";

-- building our tables. 


CREATE TABLE public.users (
    user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    email_address character varying(250) NOT NULL,
    first_name character varying(250) NOT NULL,
    last_name character varying(250) NOT NULL,
    password_hash character varying NOT NULL,
    stored_salt character varying NOT NULL,
    birthdate date,
    created_dttm timestamp without time zone DEFAULT CURRENT_DATE NOT NULL
);

--
-- TOC entry 3383 (class 0 OID 16407)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: blog_admin
--

INSERT INTO public.users (user_id, email_address, first_name, last_name, password_hash, stored_salt, birthdate, created_dttm) VALUES ('3cbce4cb-7a96-4e48-9024-7804b54ff612', 'dlonicholas@gmail.com', 'david', 'nicholas', '$2a$08$bgNvBQG/DnGfR5Pw6Y4BweGWGtDLly1dnF6Lb6mlXRFoDPjEKe5w2', '$2a$08$bgNvBQG/DnGfR5Pw6Y4Bwe', '1992-11-10', '2023-09-24 00:00:00');
INSERT INTO public.users (user_id, email_address, first_name, last_name, password_hash, stored_salt, birthdate, created_dttm) VALUES ('a7d7599c-8c4a-43ae-907a-41e669a526d6', 'testing@test.com', 'david', 'nicholas', '$2a$08$dbl8qHuw8oEFGNqADbh.4uOUq5ufipP3fYfhbNP9/JAFjGh9rBvBe', '$2a$08$dbl8qHuw8oEFGNqADbh.4u', '2023-11-01', '2023-11-13 00:00:00');


--
-- TOC entry 3240 (class 2606 OID 16415)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


CREATE TABLE public.reports (
    report_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    post_id uuid NOT NULL,
    ref_report_reason_id integer NOT NULL,
    created_dttm timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);

--
-- TOC entry 3384 (class 0 OID 16463)
-- Dependencies: 224
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: blog_admin
--

INSERT INTO public.reports (report_id, user_id, post_id, ref_report_reason_id, created_dttm, is_deleted) VALUES
	('d9a05670-5c4f-46f9-9f7f-d47ad8dd57a8', '3cbce4cb-7a96-4e48-9024-7804b54ff612', '44fcaa04-6b6b-4d73-b7d6-f9b33607f091', 2, '2023-10-08 14:37:12.585744', false),
	('16f1c202-f9fc-4198-83de-1c2e7148a797', '3cbce4cb-7a96-4e48-9024-7804b54ff612', '44fcaa04-6b6b-4d73-b7d6-f9b33607f091', 1, '2023-10-08 14:37:44.505106', false),
	('8613840f-73b5-4ced-b89c-8a48892a5566', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '44fcaa04-6b6b-4d73-b7d6-f9b33607f091', 2, '2023-11-27 18:56:15.12385', false),
	('23a8ca65-a584-40c1-970e-d1022117c912', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '44fcaa04-6b6b-4d73-b7d6-f9b33607f091', 2, '2023-11-27 18:56:15.12674', false),
	('81a014c4-8d1b-4ded-8e0f-895b1c227058', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '42939844-5ac0-4b65-b214-ad43bfa90bb9', 1, '2023-11-27 20:02:33.519724', true),
	('6d632c11-b521-4a00-81cb-1ee8a17622ed', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '42939844-5ac0-4b65-b214-ad43bfa90bb9', 3, '2023-11-27 20:29:26.125023', true),
	('b928d734-3918-4c47-9a47-7eebee7c218c', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '42939844-5ac0-4b65-b214-ad43bfa90bb9', 5, '2023-11-28 18:54:36.437618', false),
	('ccaa8293-85cc-4887-bcf9-3d60b9b8cd11', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '967d5f8a-24f7-4002-9b01-868393bfa76b', 5, '2023-11-28 18:55:07.377466', false),
	('2f3a73df-4d2c-42c8-9ff3-18c0b52ace58', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '608e9fde-acf6-40f1-9b87-e7dfe9f62ef2', 3, '2023-11-28 18:55:08.638705', false),
	('a4abce9b-441f-4fb1-b7ed-06066493602a', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '3fa4422e-7f56-4fd9-b7a8-ff3a492d55b2', 4, '2023-11-28 18:55:09.952993', false);


--
-- TOC entry 3241 (class 2606 OID 16470)
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_admin
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (report_id);



CREATE TABLE public.admins (
    admin_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    start_dt date NOT NULL,
    end_dt date,
    created_dttm timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    granted_by_user_id uuid NOT NULL
);


--
-- TOC entry 3383 (class 0 OID 16442)
-- Dependencies: 219
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: blog_admin
--

INSERT INTO public.admins (admin_id, user_id, start_dt, end_dt, created_dttm, granted_by_user_id) VALUES ('83a3e4b7-8037-4dac-914f-c793cbf18ad5', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', '2023-11-27', NULL, '2023-11-27 19:49:32.761144', 'a7d7599c-8c4a-43ae-907a-41e669a526d6');


--
-- TOC entry 3240 (class 2606 OID 16448)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_admin
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (admin_id, user_id);



CREATE TABLE public.ref_report_reasons (
    ref_report_reason_id integer NOT NULL,
    report_reason character varying(100) NOT NULL,
    report_reason_desc character varying,
    created_dttm timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

--
-- TOC entry 216 (class 1259 OID 16416)
-- Name: ref_report_reasons_ref_report_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: blog_admin
--

ALTER TABLE public.ref_report_reasons ALTER COLUMN ref_report_reason_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ref_report_reasons_ref_report_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3383 (class 0 OID 16417)
-- Dependencies: 217
-- Data for Name: ref_report_reasons; Type: TABLE DATA; Schema: public; Owner: blog_admin
--

INSERT INTO public.ref_report_reasons (ref_report_reason_id, report_reason, report_reason_desc, created_dttm) OVERRIDING SYSTEM VALUE VALUES (1, 'Misinformation', 'The post has information that is factually incorrect that will mislead individuals', '2023-10-08 13:55:47.911263');
INSERT INTO public.ref_report_reasons (ref_report_reason_id, report_reason, report_reason_desc, created_dttm) OVERRIDING SYSTEM VALUE VALUES (2, 'Harm to Others', 'The post has content that promotes harms to others or has a call to action against a group of people or person.', '2023-10-08 13:55:47.911263');
INSERT INTO public.ref_report_reasons (ref_report_reason_id, report_reason, report_reason_desc, created_dttm) OVERRIDING SYSTEM VALUE VALUES (3, 'Inappropriate Content', 'The post has content that is not suitable to others', '2023-10-08 13:55:47.911263');
INSERT INTO public.ref_report_reasons (ref_report_reason_id, report_reason, report_reason_desc, created_dttm) OVERRIDING SYSTEM VALUE VALUES (4, 'Illegal Content', 'The post promotes, educates, or calls others to illegal content or actions', '2023-10-08 13:55:47.911263');
INSERT INTO public.ref_report_reasons (ref_report_reason_id, report_reason, report_reason_desc, created_dttm) OVERRIDING SYSTEM VALUE VALUES (5, 'Plagarism', 'The post was created using content not belonging to the author and is not correctly attributed.', '2023-11-27 20:03:28.545214');


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 216
-- Name: ref_report_reasons_ref_report_reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog_admin
--

SELECT pg_catalog.setval('public.ref_report_reasons_ref_report_reason_id_seq', 5, true);


--
-- TOC entry 3239 (class 2606 OID 16424)
-- Name: ref_report_reasons ref_report_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_admin
--

ALTER TABLE ONLY public.ref_report_reasons
    ADD CONSTRAINT ref_report_reasons_pkey PRIMARY KEY (ref_report_reason_id);


CREATE TABLE IF NOT EXISTS public.authentications
(
    authentication_id uuid NOT NULL DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL,
    created_dttm timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT authentications_pkey PRIMARY KEY (authentication_id, user_id, created_dttm)
)

TABLESPACE pg_default;


--
-- TOC entry 3385 (class 0 OID 16610)
-- Dependencies: 225
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: blog_admin
--

CREATE TABLE public.posts (
    post_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    post_title character varying(100) NOT NULL,
    post_content text NOT NULL,
    created_dttm timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    views bigint DEFAULT 0 NOT NULL,
    finished bigint DEFAULT 0 NOT NULL
);


INSERT INTO public.posts (post_id, user_id, post_title, post_content, created_dttm, is_deleted, views) VALUES
	('1104ef01-d4ca-4222-ba4e-9b59d3c29d9b', '3cbce4cb-7a96-4e48-9024-7804b54ff612', 'A new title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2023-09-24 21:05:17.143234', false, 0),
	('e721d211-e1bf-4596-a6f3-dbc522e29d72', '3cbce4cb-7a96-4e48-9024-7804b54ff612', 'New title. ', 'Hello



## new heading




Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

`sdfasdfasdfsadf  `

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2023-09-25 20:19:38.379594', false, 0),
	('f929f080-efba-4428-a344-e0e54d3220e5', '3cbce4cb-7a96-4e48-9024-7804b54ff612', 'New title 2 3 f', 'Hello



> some content



more conent.&#x20;

## new heading

hedding .


Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

`sdfasdfasdfsadf  `

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2023-09-25 20:23:40.186455', false, 0),
	('474d3c1f-3c66-4a09-a3a0-d23a7dad2ac9', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'a new blog today', 'hello i''m david I am testing a new feature for my app.&#x20;

I need to post 500 words so here is anew blg.&#x20;

When building user interfaces, there are many governing laws and recommendations that one should consider when designing how users should interact with applications or other user interfaces. There are two laws however that provide that individuals should always consider when designing them, Hick’s Law, and Fitts’ Law. Violations of Hick’s Law and Fitts’ Law will cause user error, panic, confusion, and drive people away from experiences. Hick’s Law and Fitts’ Law are the building blocks of creating user interfaces that help our users make informed choices and avoid confusion when trying to make any decision.

### Fitt’s Law

Fitts’ law is defined as that the time required to rapidly move to a target area is a function of the ratio between the distance to the target and the width of the target. In other words, it means that the speed someone can find something is directly correlated with the size and how close it is to where they are currently looking. The motion we use to interact with something initially beings with a rapid movement and then a finer tune movement as we get closer to our intended target. We can find things better if they are bigger and closer to where we are currently drawing attention.

#### In Violation of Fitts’ Law

There are many examples of Fitts’ Law in action, but we will look at an example of where it can cause material harm and its importance when considering design decisions. Bradley provides a concise summary of an event where in 1996 Chrysler was being investigated over complaints that Jeep Cherokees were accelerating instead of braking as drivers intended. Chrysler cited the cause of this complaint was that drivers were hitting the gas pedal instead of the brake pedal and that users were at fault. However, during the design and creation of the Jeep, it was uncovered that the pedals were moved a few inches to the left reducing the distance between the gas and brake pedal. This then caused drivers to hit the gas pedal instead of the brake pedal as they were too close together. Chrysler had violated Fitts’ law by placing the pedals too closely together.

#### How to Design Towards Fitts’ Law

We can take Fitts’ law and help us design better interfaces for our users that better help them and guide them by providing what actions or information they need in bigger context as well as closer to what they are interacting it. Take for example a simple button. Budiu provides a recommendation that buttons that users interact with should include a label if also accompanied by an icon. By including this label as well as the icon, we naturally enlarge the area of the button for users to interact making our button easier to acquire according to Fitts’ Law.

On the other hand, we can make items that our users need to have, but should not normally interact with smaller than the other interactable elements on the screen or spacing them farther away from other elements. Examples of these sorts of interactions are things like opening the engine bay of a car. Normally on gas powered cars, opening the hood of the engine bay is much smaller than other elements in the driver’s view, and farther away from other elements that a driver would need to interact with. This can cause disaster for those who are driving if they inadvertently interact with it. Manufacturers have taken this interaction and moved it farther away from things like the steering wheel or turn signals and made it smaller than other elements, so it is harder for users to interact with unless they are specifically looking for it.

To further highlight the significance of Fitts’ law, we will review a study conducted by Juras, Slomka, and Latash (2009) in which participants were instructed to jump on targets of various sizes and distances, measuring preparation and movement times. In summary of this study, participants took longer to prepare for jumping on smaller targets than jumping on larger targets. When gathering information, we take longer to interact with something that is smaller as we adjust for our fine motor movement. In situations where individuals do not have time to adjust for these fine movements, like for example slamming on a brake pedal, this could potentially lead to mistakes.

### Hick’s Law

As defined by Hick, Hick’s law states that the response time in simple decision tasks is a linear function of the transmitted information. To provide more context into this definition it can be said that the amount of time it takes to decide is directly correlated with the number of choices that are present. The more choices that are present to make means that it takes longer to decide.

#### In Violation of Hick’s Law

The New York Times reports of the story in June of 2008, individuals living in Hawaii were notified that a ballistic missile strike was incoming and to take immediate shelter. The alert was sent by mistake and was rolled back 38 minutes later. Citizens and guests of Hawaii were sent into a panic by this alert and caused numerous investigations into how a mistake of this magnitude could have been made. The cause was ultimately determined to be a bad user interface. The options to send out the alerts, including live and test alerts from the Hawaii Emergency Management Agency were many, bundled closely together, and had little contrast from each other. Hick’s law has been violated as a decision to send a test alert took too long as there were too many choices to make in one screen.

### Which and When Should We Consider Each Law

Unlike the laws of gravity and thermodynamics, Fitts’ and Hick’s Laws can be moved and broken if it is the right place. Often one cannot place all the elements we need close together or separate out choices that users can interact with. One reason to use one over the other is the users understanding or mastery over the interface or process. To help us understand the differences we will refer to Logan, Ulrich, and Lindsey’s study (2016) in how users of varying types interacted with keyboards and typing tests. Here we will go over that experience with a system that can overcome the limitations of Fitts’ and Hick’s Laws.

In this study it was concluded that those who use a standard typing technique using the QWERTY keyboard layout can type faster and more consistently than those who use a nonstandard technique or use less fingers than the standard model. If we study a standard QWERTY keyboard, we are found with many keys that are very close together and are often the same size and dimension. Also, many keys that are commonly used together are spaced away from each other.

In studying this interaction and why it’s used to measure Fitts’ and Hick’s law, we need to understand that using more fingers to find a key is a complication of Hick’s law. Standard typists use all ten of their fingers to interact with a keyboard, while nonstandard typists use less than 10. According to Hick’s law those who use less than 10 fingers to type on a keyboard should be faster at typing a key as they have less choices to interact with that key. The inverse, however, is true. Mastery or repeated interaction with a system, even if it has a lot of choices, makes users faster with the intended system.

This is the case because with practice individuals learn that certain fingers play certain roles when interacting with systems. One finger oversees certain letters, and when using all those fingers, typists using a standard finger layout can outperform nonstandard typists as this mastery of which fingers are used for what role outperform those who give one finger more roles. Users naturally find a balance between Fitts’ and Hick’s law as they interact with a system more.

We can further balance our systems and user interfaces when designing it by considering how much training our users will have with a system. We do not need to remove choices from a system if the users of the system are well versed in the system. Other examples of this phenomenon are musical instruments like pianos and accordions where keys or notes are played with the same finger as they learn a new song. These instruments have many keys and choices, but users naturally find a balance between the two laws to create or reproduce music. When interacting with an interface repeatedly, users find the balance between these two laws to better help them be faster and more efficient than those who give themselves more options (fingers).

### Conculsion

It is important to balance the Fitts’ and Hick’s law, however, users if given enough experience will find this balance and incorporate that into their workflow. Choices do not have to be removed if users are expected to be trained and develop mastery over specific interfaces. One does need to consider if their application will warrant enough interaction that users will naturally gain this affinity, or if design choices need to be made to help guide the user as they may be unfamiliar with the interface of do not interact with it often enough.

### References

* Bradley, S. (2010, March 22). How To Improve Usability With Fitts’ and Hick’s Laws. Vanseo Design. Retrieved from https://vanseodesign.com/web-design/fitts-law-hicks-law/
* Budiu, R. (2022, July 31). Fitts’s Law and Its Applications in UX. Nielsen Norman Group. Retrieved from https://www.nngroup.com/articles/fitts-law/
* Fitts, Paul M. (June 1954). The Information Capacity of the Human Motor System in Controlling the Amplitude of Movement. Journal of Experimental Psychology.
* Hick, W.E. (1952). On the Rate of Gain of Information. Quarterly Journal of Experimental Psychology. Retrieved from http://www2.psychology.uiowa.edu/faculty/mordkoff/InfoProc/pdfs/Hick%201952.pdf
* Hick’s and Fitts’ laws: Two important psychological principles to consider when designing navigational menu structures. (2015, February 19). The Usability People. Retrieved from https://www.theusabilitypeople.com/thought\_leadership/hick-s-and-fitt-s-laws-two-important-psychological-principles-consider-when
* Juras, G., Slomka, K., & Latash, M. (2009). Violations of Fitts’ Law in a Ballistic Task. Journal of Motor Behavior, 41(6), 525–528. https://doi-org.mylibrary.wilmu.edu/10.3200/35-08-015
* Logan, G. D., Ulrich, J. E., & Lindsey, D. R. B. (2016). Different (key)strokes for different folks: How standard and nonstandard typists balance Fitts’ law and Hick’s law. Journal of Experimental Psychology. Human Perception & Performance, 42(12), 2084–2102. https://doi-org.mylibrary.wilmu.edu/10.1037/xhp0000272', '2023-11-27 18:06:09.854484', false, 0),
	('0ae7ad19-1558-4d14-a77d-d8fdac15cecd', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'adfsasfd asdf ', 'The pandemic changed everything in March 2020, including the way we work. Now, as we transition back to the office, we must find new ways to stay productive and focused. For the last three years I have manicured and tailored my workspace at home to accommodate my ADHD. Now as pandemic winds down, my work has started opening it’s doors and recommending to come back into the office. I have taken this torch and have started coming back to our beautiful and accommodating office about 2-3 times a week. This transition has been hard in large part due to my ADHD. Being productive at the office has been a challenge, but not an obstacle that can’t be overcome.

Surviving the transition of a changing workspace is hard, especially when you are a little more neuro diverse than most. I have been able to keep or change a few rituals to keep me close to as productive as if I was home while in the office. These changes have really helped me and how I deal with my brain’s different approaches to environments and problems. Working the office is great. Helping and interacting with my team is even better, and in large part the reason why going back into the office is fulfilling. However, you can’t succeed in your own roles if distractions keep you from completing your own task. These are the lessons I have learned that have kept me close to as productive at home as in the office.

### Staying Medicated and Mindful of your Differences

Understanding your brain and how you are different is critical in keeping successful and productive. One cannot ignore a problem away, especially if the problem is how easily your attention can be diverted away. Being mindful of my disorder has been critical so when I reflect at the end of the day about the wins and fails of the day, I can chalk up problems to my disorder (when appropriate), and how to solve them for the next day. Remembering you are different, and that you need different things to stay successful is ok and a key part of keeping productive regardless of our environment.

Another key to success is staying medicated. In my state, it has been hard to keep up a prescription due to Adderall shortages. However, it’s critical to keep up your medication as prescribed by your doctor. For me, medication is a great tool to keep my grounded, calm, and collected. If you are thinking about making any changes to your medication or regime, please work with your doctor to make sure that is the right choice. In my case about a half hour before I start my commute, I make sure I take my medication so it’s working by the time I sit down and start my day in the office.

### Bringing Home to the Office

Part of the success that I have working from home is that I am able to use the tools that I want. I love my Logitech G915 TKL keyboard and my Logitech Pro Wireless Mouse. I find not having these when working distracting to a fault as I compare other keyboards provided at work to these great products. Instead of comparing what I have at the office versus at home, I just bring them to work. I wish I could bring my whole office at home to work, but alas, it makes more sense to have everyone use standard issue equipment instead of accommodating to a handful of employees.

Why is bringing home to the office so important to stay productive? I have solve this workflow at home with some equipment and rituals. Keeping these rituals and equipment as similar as possible between environments is important to ensure my success. Having differences between workflows and traditions at home and in the office is distracting, and can remove my particular train of thought of the task at hand instead and into why I like or dislike the differences. Keeping things as close as possible to home as it is at the office has been a huge factor of my success in transitioning back into the office.

### Finding Ways to Minimize Distractions; Long Live Noise Cancelling Headphones

Over hearing coworkers talk about the recent buzz around town, problems about their current project, or just talking in general is enough to rip my out of my focus and into their problems or issues. Long live the Air Pods Pro and their great noise cancellation. Here I can be apart of the team, with just enough sensory deprivation to keep me focused in my tasks. Its amazing what little background noise and deprivation can do to keep one with ADHD productive. At home I do not have the pleasure of having my team next to me, but I also don’t have anyone at home to take me away from my task.

The other way to keep distractions at bay for me is to move to a dedicated meeting space when meetings are required. Having other people take meetings next to you can be vexing, however, seeing someone constantly distracted by their surroundings during a meeting can be even worse as you aren’t sure they are even focused on what you are saying. It is ok to move your whole workspace, if it can be done for a short amount of time, to focus on a meeting or a hard task for a short time to minimize the distractions your current environment may have.

These are the three biggest factors that have helped my stay productive while transitioning back into the office. It has been hard, and I don’t feel as if I am as productive as if I was at home, but these factors have helped me get pretty close. Transitioning back to the office after working from home can be challenging for anyone, but it can be especially difficult for individuals with ADHD. However, by staying mindful of your differences, staying medicated as prescribed, and bringing the tools and rituals that work for you from home to the office, you can increase your chances of success. Minimizing distractions through the use of noise-cancelling headphones or other methods can also help you stay focused on your tasks. With the right approach and mindset, you can thrive in the office and continue to be a valuable member of your team.', '2023-11-27 18:09:07.272563', false, 0),
	('6fda2924-f77d-491d-8143-8075a82b31a4', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'How Hicks and Fitts Law Drive User Experiences', 'When building user interfaces, there are many governing laws and recommendations that one should consider when designing how users should interact with applications or other user interfaces. There are two laws however that provide that individuals should always consider when designing them, Hick’s Law, and Fitts’ Law. Violations of Hick’s Law and Fitts’ Law will cause user error, panic, confusion, and drive people away from experiences. Hick’s Law and Fitts’ Law are the building blocks of creating user interfaces that help our users make informed choices and avoid confusion when trying to make any decision.

### Fitt’s Law

Fitts’ law is defined as that the time required to rapidly move to a target area is a function of the ratio between the distance to the target and the width of the target. In other words, it means that the speed someone can find something is directly correlated with the size and how close it is to where they are currently looking. The motion we use to interact with something initially beings with a rapid movement and then a finer tune movement as we get closer to our intended target. We can find things better if they are bigger and closer to where we are currently drawing attention.

#### In Violation of Fitts’ Law

There are many examples of Fitts’ Law in action, but we will look at an example of where it can cause material harm and its importance when considering design decisions. Bradley provides a concise summary of an event where in 1996 Chrysler was being investigated over complaints that Jeep Cherokees were accelerating instead of braking as drivers intended. Chrysler cited the cause of this complaint was that drivers were hitting the gas pedal instead of the brake pedal and that users were at fault. However, during the design and creation of the Jeep, it was uncovered that the pedals were moved a few inches to the left reducing the distance between the gas and brake pedal. This then caused drivers to hit the gas pedal instead of the brake pedal as they were too close together. Chrysler had violated Fitts’ law by placing the pedals too closely together.

#### How to Design Towards Fitts’ Law

We can take Fitts’ law and help us design better interfaces for our users that better help them and guide them by providing what actions or information they need in bigger context as well as closer to what they are interacting it. Take for example a simple button. Budiu provides a recommendation that buttons that users interact with should include a label if also accompanied by an icon. By including this label as well as the icon, we naturally enlarge the area of the button for users to interact making our button easier to acquire according to Fitts’ Law.

On the other hand, we can make items that our users need to have, but should not normally interact with smaller than the other interactable elements on the screen or spacing them farther away from other elements. Examples of these sorts of interactions are things like opening the engine bay of a car. Normally on gas powered cars, opening the hood of the engine bay is much smaller than other elements in the driver’s view, and farther away from other elements that a driver would need to interact with. This can cause disaster for those who are driving if they inadvertently interact with it. Manufacturers have taken this interaction and moved it farther away from things like the steering wheel or turn signals and made it smaller than other elements, so it is harder for users to interact with unless they are specifically looking for it.

To further highlight the significance of Fitts’ law, we will review a study conducted by Juras, Slomka, and Latash (2009) in which participants were instructed to jump on targets of various sizes and distances, measuring preparation and movement times. In summary of this study, participants took longer to prepare for jumping on smaller targets than jumping on larger targets. When gathering information, we take longer to interact with something that is smaller as we adjust for our fine motor movement. In situations where individuals do not have time to adjust for these fine movements, like for example slamming on a brake pedal, this could potentially lead to mistakes.

### Hick’s Law

As defined by Hick, Hick’s law states that the response time in simple decision tasks is a linear function of the transmitted information. To provide more context into this definition it can be said that the amount of time it takes to decide is directly correlated with the number of choices that are present. The more choices that are present to make means that it takes longer to decide.

#### In Violation of Hick’s Law

The New York Times reports of the story in June of 2008, individuals living in Hawaii were notified that a ballistic missile strike was incoming and to take immediate shelter. The alert was sent by mistake and was rolled back 38 minutes later. Citizens and guests of Hawaii were sent into a panic by this alert and caused numerous investigations into how a mistake of this magnitude could have been made. The cause was ultimately determined to be a bad user interface. The options to send out the alerts, including live and test alerts from the Hawaii Emergency Management Agency were many, bundled closely together, and had little contrast from each other. Hick’s law has been violated as a decision to send a test alert took too long as there were too many choices to make in one screen.

### Which and When Should We Consider Each Law

Unlike the laws of gravity and thermodynamics, Fitts’ and Hick’s Laws can be moved and broken if it is the right place. Often one cannot place all the elements we need close together or separate out choices that users can interact with. One reason to use one over the other is the users understanding or mastery over the interface or process. To help us understand the differences we will refer to Logan, Ulrich, and Lindsey’s study (2016) in how users of varying types interacted with keyboards and typing tests. Here we will go over that experience with a system that can overcome the limitations of Fitts’ and Hick’s Laws.

In this study it was concluded that those who use a standard typing technique using the QWERTY keyboard layout can type faster and more consistently than those who use a nonstandard technique or use less fingers than the standard model. If we study a standard QWERTY keyboard, we are found with many keys that are very close together and are often the same size and dimension. Also, many keys that are commonly used together are spaced away from each other.

In studying this interaction and why it’s used to measure Fitts’ and Hick’s law, we need to understand that using more fingers to find a key is a complication of Hick’s law. Standard typists use all ten of their fingers to interact with a keyboard, while nonstandard typists use less than 10. According to Hick’s law those who use less than 10 fingers to type on a keyboard should be faster at typing a key as they have less choices to interact with that key. The inverse, however, is true. Mastery or repeated interaction with a system, even if it has a lot of choices, makes users faster with the intended system.

This is the case because with practice individuals learn that certain fingers play certain roles when interacting with systems. One finger oversees certain letters, and when using all those fingers, typists using a standard finger layout can outperform nonstandard typists as this mastery of which fingers are used for what role outperform those who give one finger more roles. Users naturally find a balance between Fitts’ and Hick’s law as they interact with a system more.

We can further balance our systems and user interfaces when designing it by considering how much training our users will have with a system. We do not need to remove choices from a system if the users of the system are well versed in the system. Other examples of this phenomenon are musical instruments like pianos and accordions where keys or notes are played with the same finger as they learn a new song. These instruments have many keys and choices, but users naturally find a balance between the two laws to create or reproduce music. When interacting with an interface repeatedly, users find the balance between these two laws to better help them be faster and more efficient than those who give themselves more options (fingers).

### Conculsion

It is important to balance the Fitts’ and Hick’s law, however, users if given enough experience will find this balance and incorporate that into their workflow. Choices do not have to be removed if users are expected to be trained and develop mastery over specific interfaces. One does need to consider if their application will warrant enough interaction that users will naturally gain this affinity, or if design choices need to be made to help guide the user as they may be unfamiliar with the interface of do not interact with it often enough.

### References

* Bradley, S. (2010, March 22). How To Improve Usability With Fitts’ and Hick’s Laws. Vanseo Design. Retrieved from https://vanseodesign.com/web-design/fitts-law-hicks-law/
* Budiu, R. (2022, July 31). Fitts’s Law and Its Applications in UX. Nielsen Norman Group. Retrieved from https://www.nngroup.com/articles/fitts-law/
* Fitts, Paul M. (June 1954). The Information Capacity of the Human Motor System in Controlling the Amplitude of Movement. Journal of Experimental Psychology.
* Hick, W.E. (1952). On the Rate of Gain of Information. Quarterly Journal of Experimental Psychology. Retrieved from http://www2.psychology.uiowa.edu/faculty/mordkoff/InfoProc/pdfs/Hick%201952.pdf
* Hick’s and Fitts’ laws: Two important psychological principles to consider when designing navigational menu structures. (2015, February 19). The Usability People. Retrieved from https://www.theusabilitypeople.com/thought\_leadership/hick-s-and-fitt-s-laws-two-important-psychological-principles-consider-when
* Juras, G., Slomka, K., & Latash, M. (2009). Violations of Fitts’ Law in a Ballistic Task. Journal of Motor Behavior, 41(6), 525–528. https://doi-org.mylibrary.wilmu.edu/10.3200/35-08-015
* Logan, G. D., Ulrich, J. E., & Lindsey, D. R. B. (2016). Different (key)strokes for different folks: How standard and nonstandard typists balance Fitts’ law and Hick’s law. Journal of Experimental Psychology. Human Perception & Performance, 42(12), 2084–2102. https://doi-org.mylibrary.wilmu.edu/10.1037/xhp0000272', '2023-11-27 18:12:01.631324', false, 0),
	('44fcaa04-6b6b-4d73-b7d6-f9b33607f091', '3cbce4cb-7a96-4e48-9024-7804b54ff612', 'A new title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2023-09-24 21:36:16.576222', true, 0),
	('42939844-5ac0-4b65-b214-ad43bfa90bb9', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'How Hicks and Fitts Law Drive User Experiences', 'When building user interfaces, there are many governing laws and recommendations that one should consider when designing how users should interact with applications or other user interfaces. There are two laws however that provide that individuals should always consider when designing them, Hick’s Law, and Fitts’ Law. Violations of Hick’s Law and Fitts’ Law will cause user error, panic, confusion, and drive people away from experiences. Hick’s Law and Fitts’ Law are the building blocks of creating user interfaces that help our users make informed choices and avoid confusion when trying to make any decision.

### Fitt’s Law

Fitts’ law is defined as that the time required to rapidly move to a target area is a function of the ratio between the distance to the target and the width of the target. In other words, it means that the speed someone can find something is directly correlated with the size and how close it is to where they are currently looking. The motion we use to interact with something initially beings with a rapid movement and then a finer tune movement as we get closer to our intended target. We can find things better if they are bigger and closer to where we are currently drawing attention.

#### In Violation of Fitts’ Law

There are many examples of Fitts’ Law in action, but we will look at an example of where it can cause material harm and its importance when considering design decisions. Bradley provides a concise summary of an event where in 1996 Chrysler was being investigated over complaints that Jeep Cherokees were accelerating instead of braking as drivers intended. Chrysler cited the cause of this complaint was that drivers were hitting the gas pedal instead of the brake pedal and that users were at fault. However, during the design and creation of the Jeep, it was uncovered that the pedals were moved a few inches to the left reducing the distance between the gas and brake pedal. This then caused drivers to hit the gas pedal instead of the brake pedal as they were too close together. Chrysler had violated Fitts’ law by placing the pedals too closely together.

#### How to Design Towards Fitts’ Law

We can take Fitts’ law and help us design better interfaces for our users that better help them and guide them by providing what actions or information they need in bigger context as well as closer to what they are interacting it. Take for example a simple button. Budiu provides a recommendation that buttons that users interact with should include a label if also accompanied by an icon. By including this label as well as the icon, we naturally enlarge the area of the button for users to interact making our button easier to acquire according to Fitts’ Law.

On the other hand, we can make items that our users need to have, but should not normally interact with smaller than the other interactable elements on the screen or spacing them farther away from other elements. Examples of these sorts of interactions are things like opening the engine bay of a car. Normally on gas powered cars, opening the hood of the engine bay is much smaller than other elements in the driver’s view, and farther away from other elements that a driver would need to interact with. This can cause disaster for those who are driving if they inadvertently interact with it. Manufacturers have taken this interaction and moved it farther away from things like the steering wheel or turn signals and made it smaller than other elements, so it is harder for users to interact with unless they are specifically looking for it.

To further highlight the significance of Fitts’ law, we will review a study conducted by Juras, Slomka, and Latash (2009) in which participants were instructed to jump on targets of various sizes and distances, measuring preparation and movement times. In summary of this study, participants took longer to prepare for jumping on smaller targets than jumping on larger targets. When gathering information, we take longer to interact with something that is smaller as we adjust for our fine motor movement. In situations where individuals do not have time to adjust for these fine movements, like for example slamming on a brake pedal, this could potentially lead to mistakes.

### Hick’s Law

As defined by Hick, Hick’s law states that the response time in simple decision tasks is a linear function of the transmitted information. To provide more context into this definition it can be said that the amount of time it takes to decide is directly correlated with the number of choices that are present. The more choices that are present to make means that it takes longer to decide.

#### In Violation of Hick’s Law

The New York Times reports of the story in June of 2008, individuals living in Hawaii were notified that a ballistic missile strike was incoming and to take immediate shelter. The alert was sent by mistake and was rolled back 38 minutes later. Citizens and guests of Hawaii were sent into a panic by this alert and caused numerous investigations into how a mistake of this magnitude could have been made. The cause was ultimately determined to be a bad user interface. The options to send out the alerts, including live and test alerts from the Hawaii Emergency Management Agency were many, bundled closely together, and had little contrast from each other. Hick’s law has been violated as a decision to send a test alert took too long as there were too many choices to make in one screen.

### Which and When Should We Consider Each Law

Unlike the laws of gravity and thermodynamics, Fitts’ and Hick’s Laws can be moved and broken if it is the right place. Often one cannot place all the elements we need close together or separate out choices that users can interact with. One reason to use one over the other is the users understanding or mastery over the interface or process. To help us understand the differences we will refer to Logan, Ulrich, and Lindsey’s study (2016) in how users of varying types interacted with keyboards and typing tests. Here we will go over that experience with a system that can overcome the limitations of Fitts’ and Hick’s Laws.

In this study it was concluded that those who use a standard typing technique using the QWERTY keyboard layout can type faster and more consistently than those who use a nonstandard technique or use less fingers than the standard model. If we study a standard QWERTY keyboard, we are found with many keys that are very close together and are often the same size and dimension. Also, many keys that are commonly used together are spaced away from each other.

In studying this interaction and why it’s used to measure Fitts’ and Hick’s law, we need to understand that using more fingers to find a key is a complication of Hick’s law. Standard typists use all ten of their fingers to interact with a keyboard, while nonstandard typists use less than 10. According to Hick’s law those who use less than 10 fingers to type on a keyboard should be faster at typing a key as they have less choices to interact with that key. The inverse, however, is true. Mastery or repeated interaction with a system, even if it has a lot of choices, makes users faster with the intended system.

This is the case because with practice individuals learn that certain fingers play certain roles when interacting with systems. One finger oversees certain letters, and when using all those fingers, typists using a standard finger layout can outperform nonstandard typists as this mastery of which fingers are used for what role outperform those who give one finger more roles. Users naturally find a balance between Fitts’ and Hick’s law as they interact with a system more.

We can further balance our systems and user interfaces when designing it by considering how much training our users will have with a system. We do not need to remove choices from a system if the users of the system are well versed in the system. Other examples of this phenomenon are musical instruments like pianos and accordions where keys or notes are played with the same finger as they learn a new song. These instruments have many keys and choices, but users naturally find a balance between the two laws to create or reproduce music. When interacting with an interface repeatedly, users find the balance between these two laws to better help them be faster and more efficient than those who give themselves more options (fingers).

### Conculsion

It is important to balance the Fitts’ and Hick’s law, however, users if given enough experience will find this balance and incorporate that into their workflow. Choices do not have to be removed if users are expected to be trained and develop mastery over specific interfaces. One does need to consider if their application will warrant enough interaction that users will naturally gain this affinity, or if design choices need to be made to help guide the user as they may be unfamiliar with the interface of do not interact with it often enough.

### References

* Bradley, S. (2010, March 22). How To Improve Usability With Fitts’ and Hick’s Laws. Vanseo Design. Retrieved from https://vanseodesign.com/web-design/fitts-law-hicks-law/
* Budiu, R. (2022, July 31). Fitts’s Law and Its Applications in UX. Nielsen Norman Group. Retrieved from https://www.nngroup.com/articles/fitts-law/
* Fitts, Paul M. (June 1954). The Information Capacity of the Human Motor System in Controlling the Amplitude of Movement. Journal of Experimental Psychology.
* Hick, W.E. (1952). On the Rate of Gain of Information. Quarterly Journal of Experimental Psychology. Retrieved from http://www2.psychology.uiowa.edu/faculty/mordkoff/InfoProc/pdfs/Hick%201952.pdf
* Hick’s and Fitts’ laws: Two important psychological principles to consider when designing navigational menu structures. (2015, February 19). The Usability People. Retrieved from https://www.theusabilitypeople.com/thought\_leadership/hick-s-and-fitt-s-laws-two-important-psychological-principles-consider-when
* Juras, G., Slomka, K., & Latash, M. (2009). Violations of Fitts’ Law in a Ballistic Task. Journal of Motor Behavior, 41(6), 525–528. https://doi-org.mylibrary.wilmu.edu/10.3200/35-08-015
* Logan, G. D., Ulrich, J. E., & Lindsey, D. R. B. (2016). Different (key)strokes for different folks: How standard and nonstandard typists balance Fitts’ law and Hick’s law. Journal of Experimental Psychology. Human Perception & Performance, 42(12), 2084–2102. https://doi-org.mylibrary.wilmu.edu/10.1037/xhp0000272', '2023-11-27 18:10:59.525794', true, 0),
	('3fa4422e-7f56-4fd9-b7a8-ff3a492d55b2', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'adfsasfd asdf ', 'The pandemic changed everything in March 2020, including the way we work. Now, as we transition back to the office, we must find new ways to stay productive and focused. For the last three years I have manicured and tailored my workspace at home to accommodate my ADHD. Now as pandemic winds down, my work has started opening it’s doors and recommending to come back into the office. I have taken this torch and have started coming back to our beautiful and accommodating office about 2-3 times a week. This transition has been hard in large part due to my ADHD. Being productive at the office has been a challenge, but not an obstacle that can’t be overcome.

Surviving the transition of a changing workspace is hard, especially when you are a little more neuro diverse than most. I have been able to keep or change a few rituals to keep me close to as productive as if I was home while in the office. These changes have really helped me and how I deal with my brain’s different approaches to environments and problems. Working the office is great. Helping and interacting with my team is even better, and in large part the reason why going back into the office is fulfilling. However, you can’t succeed in your own roles if distractions keep you from completing your own task. These are the lessons I have learned that have kept me close to as productive at home as in the office.

### Staying Medicated and Mindful of your Differences

Understanding your brain and how you are different is critical in keeping successful and productive. One cannot ignore a problem away, especially if the problem is how easily your attention can be diverted away. Being mindful of my disorder has been critical so when I reflect at the end of the day about the wins and fails of the day, I can chalk up problems to my disorder (when appropriate), and how to solve them for the next day. Remembering you are different, and that you need different things to stay successful is ok and a key part of keeping productive regardless of our environment.

Another key to success is staying medicated. In my state, it has been hard to keep up a prescription due to Adderall shortages. However, it’s critical to keep up your medication as prescribed by your doctor. For me, medication is a great tool to keep my grounded, calm, and collected. If you are thinking about making any changes to your medication or regime, please work with your doctor to make sure that is the right choice. In my case about a half hour before I start my commute, I make sure I take my medication so it’s working by the time I sit down and start my day in the office.

### Bringing Home to the Office

Part of the success that I have working from home is that I am able to use the tools that I want. I love my Logitech G915 TKL keyboard and my Logitech Pro Wireless Mouse. I find not having these when working distracting to a fault as I compare other keyboards provided at work to these great products. Instead of comparing what I have at the office versus at home, I just bring them to work. I wish I could bring my whole office at home to work, but alas, it makes more sense to have everyone use standard issue equipment instead of accommodating to a handful of employees.

Why is bringing home to the office so important to stay productive? I have solve this workflow at home with some equipment and rituals. Keeping these rituals and equipment as similar as possible between environments is important to ensure my success. Having differences between workflows and traditions at home and in the office is distracting, and can remove my particular train of thought of the task at hand instead and into why I like or dislike the differences. Keeping things as close as possible to home as it is at the office has been a huge factor of my success in transitioning back into the office.

### Finding Ways to Minimize Distractions; Long Live Noise Cancelling Headphones

Over hearing coworkers talk about the recent buzz around town, problems about their current project, or just talking in general is enough to rip my out of my focus and into their problems or issues. Long live the Air Pods Pro and their great noise cancellation. Here I can be apart of the team, with just enough sensory deprivation to keep me focused in my tasks. Its amazing what little background noise and deprivation can do to keep one with ADHD productive. At home I do not have the pleasure of having my team next to me, but I also don’t have anyone at home to take me away from my task.

The other way to keep distractions at bay for me is to move to a dedicated meeting space when meetings are required. Having other people take meetings next to you can be vexing, however, seeing someone constantly distracted by their surroundings during a meeting can be even worse as you aren’t sure they are even focused on what you are saying. It is ok to move your whole workspace, if it can be done for a short amount of time, to focus on a meeting or a hard task for a short time to minimize the distractions your current environment may have.

These are the three biggest factors that have helped my stay productive while transitioning back into the office. It has been hard, and I don’t feel as if I am as productive as if I was at home, but these factors have helped me get pretty close. Transitioning back to the office after working from home can be challenging for anyone, but it can be especially difficult for individuals with ADHD. However, by staying mindful of your differences, staying medicated as prescribed, and bringing the tools and rituals that work for you from home to the office, you can increase your chances of success. Minimizing distractions through the use of noise-cancelling headphones or other methods can also help you stay focused on your tasks. With the right approach and mindset, you can thrive in the office and continue to be a valuable member of your team.', '2023-11-27 18:07:29.978775', true, 0),
	('608e9fde-acf6-40f1-9b87-e7dfe9f62ef2', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'adfsasfd asdf ', 'The pandemic changed everything in March 2020, including the way we work. Now, as we transition back to the office, we must find new ways to stay productive and focused. For the last three years I have manicured and tailored my workspace at home to accommodate my ADHD. Now as pandemic winds down, my work has started opening it’s doors and recommending to come back into the office. I have taken this torch and have started coming back to our beautiful and accommodating office about 2-3 times a week. This transition has been hard in large part due to my ADHD. Being productive at the office has been a challenge, but not an obstacle that can’t be overcome.

Surviving the transition of a changing workspace is hard, especially when you are a little more neuro diverse than most. I have been able to keep or change a few rituals to keep me close to as productive as if I was home while in the office. These changes have really helped me and how I deal with my brain’s different approaches to environments and problems. Working the office is great. Helping and interacting with my team is even better, and in large part the reason why going back into the office is fulfilling. However, you can’t succeed in your own roles if distractions keep you from completing your own task. These are the lessons I have learned that have kept me close to as productive at home as in the office.

### Staying Medicated and Mindful of your Differences

Understanding your brain and how you are different is critical in keeping successful and productive. One cannot ignore a problem away, especially if the problem is how easily your attention can be diverted away. Being mindful of my disorder has been critical so when I reflect at the end of the day about the wins and fails of the day, I can chalk up problems to my disorder (when appropriate), and how to solve them for the next day. Remembering you are different, and that you need different things to stay successful is ok and a key part of keeping productive regardless of our environment.

Another key to success is staying medicated. In my state, it has been hard to keep up a prescription due to Adderall shortages. However, it’s critical to keep up your medication as prescribed by your doctor. For me, medication is a great tool to keep my grounded, calm, and collected. If you are thinking about making any changes to your medication or regime, please work with your doctor to make sure that is the right choice. In my case about a half hour before I start my commute, I make sure I take my medication so it’s working by the time I sit down and start my day in the office.

### Bringing Home to the Office

Part of the success that I have working from home is that I am able to use the tools that I want. I love my Logitech G915 TKL keyboard and my Logitech Pro Wireless Mouse. I find not having these when working distracting to a fault as I compare other keyboards provided at work to these great products. Instead of comparing what I have at the office versus at home, I just bring them to work. I wish I could bring my whole office at home to work, but alas, it makes more sense to have everyone use standard issue equipment instead of accommodating to a handful of employees.

Why is bringing home to the office so important to stay productive? I have solve this workflow at home with some equipment and rituals. Keeping these rituals and equipment as similar as possible between environments is important to ensure my success. Having differences between workflows and traditions at home and in the office is distracting, and can remove my particular train of thought of the task at hand instead and into why I like or dislike the differences. Keeping things as close as possible to home as it is at the office has been a huge factor of my success in transitioning back into the office.

### Finding Ways to Minimize Distractions; Long Live Noise Cancelling Headphones

Over hearing coworkers talk about the recent buzz around town, problems about their current project, or just talking in general is enough to rip my out of my focus and into their problems or issues. Long live the Air Pods Pro and their great noise cancellation. Here I can be apart of the team, with just enough sensory deprivation to keep me focused in my tasks. Its amazing what little background noise and deprivation can do to keep one with ADHD productive. At home I do not have the pleasure of having my team next to me, but I also don’t have anyone at home to take me away from my task.

The other way to keep distractions at bay for me is to move to a dedicated meeting space when meetings are required. Having other people take meetings next to you can be vexing, however, seeing someone constantly distracted by their surroundings during a meeting can be even worse as you aren’t sure they are even focused on what you are saying. It is ok to move your whole workspace, if it can be done for a short amount of time, to focus on a meeting or a hard task for a short time to minimize the distractions your current environment may have.

These are the three biggest factors that have helped my stay productive while transitioning back into the office. It has been hard, and I don’t feel as if I am as productive as if I was at home, but these factors have helped me get pretty close. Transitioning back to the office after working from home can be challenging for anyone, but it can be especially difficult for individuals with ADHD. However, by staying mindful of your differences, staying medicated as prescribed, and bringing the tools and rituals that work for you from home to the office, you can increase your chances of success. Minimizing distractions through the use of noise-cancelling headphones or other methods can also help you stay focused on your tasks. With the right approach and mindset, you can thrive in the office and continue to be a valuable member of your team.', '2023-11-27 18:08:06.872159', true, 0),
	('967d5f8a-24f7-4002-9b01-868393bfa76b', 'a7d7599c-8c4a-43ae-907a-41e669a526d6', 'adfsasfd asdf ', 'The pandemic changed everything in March 2020, including the way we work. Now, as we transition back to the office, we must find new ways to stay productive and focused. For the last three years I have manicured and tailored my workspace at home to accommodate my ADHD. Now as pandemic winds down, my work has started opening it’s doors and recommending to come back into the office. I have taken this torch and have started coming back to our beautiful and accommodating office about 2-3 times a week. This transition has been hard in large part due to my ADHD. Being productive at the office has been a challenge, but not an obstacle that can’t be overcome.

Surviving the transition of a changing workspace is hard, especially when you are a little more neuro diverse than most. I have been able to keep or change a few rituals to keep me close to as productive as if I was home while in the office. These changes have really helped me and how I deal with my brain’s different approaches to environments and problems. Working the office is great. Helping and interacting with my team is even better, and in large part the reason why going back into the office is fulfilling. However, you can’t succeed in your own roles if distractions keep you from completing your own task. These are the lessons I have learned that have kept me close to as productive at home as in the office.

### Staying Medicated and Mindful of your Differences

Understanding your brain and how you are different is critical in keeping successful and productive. One cannot ignore a problem away, especially if the problem is how easily your attention can be diverted away. Being mindful of my disorder has been critical so when I reflect at the end of the day about the wins and fails of the day, I can chalk up problems to my disorder (when appropriate), and how to solve them for the next day. Remembering you are different, and that you need different things to stay successful is ok and a key part of keeping productive regardless of our environment.

Another key to success is staying medicated. In my state, it has been hard to keep up a prescription due to Adderall shortages. However, it’s critical to keep up your medication as prescribed by your doctor. For me, medication is a great tool to keep my grounded, calm, and collected. If you are thinking about making any changes to your medication or regime, please work with your doctor to make sure that is the right choice. In my case about a half hour before I start my commute, I make sure I take my medication so it’s working by the time I sit down and start my day in the office.

### Bringing Home to the Office

Part of the success that I have working from home is that I am able to use the tools that I want. I love my Logitech G915 TKL keyboard and my Logitech Pro Wireless Mouse. I find not having these when working distracting to a fault as I compare other keyboards provided at work to these great products. Instead of comparing what I have at the office versus at home, I just bring them to work. I wish I could bring my whole office at home to work, but alas, it makes more sense to have everyone use standard issue equipment instead of accommodating to a handful of employees.

Why is bringing home to the office so important to stay productive? I have solve this workflow at home with some equipment and rituals. Keeping these rituals and equipment as similar as possible between environments is important to ensure my success. Having differences between workflows and traditions at home and in the office is distracting, and can remove my particular train of thought of the task at hand instead and into why I like or dislike the differences. Keeping things as close as possible to home as it is at the office has been a huge factor of my success in transitioning back into the office.

### Finding Ways to Minimize Distractions; Long Live Noise Cancelling Headphones

Over hearing coworkers talk about the recent buzz around town, problems about their current project, or just talking in general is enough to rip my out of my focus and into their problems or issues. Long live the Air Pods Pro and their great noise cancellation. Here I can be apart of the team, with just enough sensory deprivation to keep me focused in my tasks. Its amazing what little background noise and deprivation can do to keep one with ADHD productive. At home I do not have the pleasure of having my team next to me, but I also don’t have anyone at home to take me away from my task.

The other way to keep distractions at bay for me is to move to a dedicated meeting space when meetings are required. Having other people take meetings next to you can be vexing, however, seeing someone constantly distracted by their surroundings during a meeting can be even worse as you aren’t sure they are even focused on what you are saying. It is ok to move your whole workspace, if it can be done for a short amount of time, to focus on a meeting or a hard task for a short time to minimize the distractions your current environment may have.

These are the three biggest factors that have helped my stay productive while transitioning back into the office. It has been hard, and I don’t feel as if I am as productive as if I was at home, but these factors have helped me get pretty close. Transitioning back to the office after working from home can be challenging for anyone, but it can be especially difficult for individuals with ADHD. However, by staying mindful of your differences, staying medicated as prescribed, and bringing the tools and rituals that work for you from home to the office, you can increase your chances of success. Minimizing distractions through the use of noise-cancelling headphones or other methods can also help you stay focused on your tasks. With the right approach and mindset, you can thrive in the office and continue to be a valuable member of your team.', '2023-11-27 18:08:39.304377', true, 0);


--
-- TOC entry 3242 (class 2606 OID 16620)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_admin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


CREATE OR REPLACE PROCEDURE public.check_auth(
	IN p_user_id uuid,
	IN p_authentication_id uuid,
	OUT authenticated boolean)
LANGUAGE 'plpgsql'
AS $BODY$
begin

	select authentication_id = p_authentication_id into authenticated
	from authentications
	where   user_id = p_user_id
	order by created_dttm desc
	limit 1;
 
end;
$BODY$;

CREATE OR REPLACE PROCEDURE public.check_email_proc(
	IN p_email_address text,
	OUT email_check boolean)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    SELECT COUNT(*) = 0 INTO email_check
    FROM users
    WHERE email_address = p_email_address;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.create_user(
	IN p_email_address text,
	IN p_first_name text,
	IN p_last_name text,
	IN p_password text,
	IN p_birthdate date,
	OUT user_id uuid,
	OUT authentication_id uuid)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_salt text;
BEGIN
    -- Generate a salt
    SELECT gen_salt('bf', 8) INTO v_salt;

    -- Insert user into the "users" table
    INSERT INTO users (
        email_address,
        first_name,
        last_name,
        password_hash,
        stored_salt,
        birthdate
    )
    VALUES (
        p_email_address,
        p_first_name,
        p_last_name,
        crypt(p_password, v_salt),
        v_salt,
        p_birthdate
    )
    RETURNING users.user_id INTO user_id;

    -- Insert authentication record into the "authentications" table
    INSERT INTO authentications (user_id)
    VALUES (user_id)
    RETURNING authentications.authentication_id INTO authentication_id;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.update_password(
	IN p_user_id uuid,
	IN p_password text,
	OUT authentication_id uuid)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_salt text;
BEGIN
    -- Generate a salt
    SELECT gen_salt('bf', 8) INTO v_salt;

    -- Insert user into the "users" table
    UPDATE users
        set 	password_hash = crypt(p_password, v_salt)
        	, 	stored_salt = v_salt
	where user_id = p_user_id
    ;

    -- Insert authentication record into the "authentications" table
    INSERT INTO authentications (user_id)
    VALUES (p_user_id)
    RETURNING authentications.authentication_id INTO authentication_id;
END;
$BODY$;

CREATE OR REPLACE PROCEDURE public.validate_and_insert_authentication(
	IN p_email_address character varying,
	IN p_password character varying,
	OUT p_user_id uuid,
	OUT p_authentication_id uuid)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_user_id UUID;
BEGIN
    -- Check if the provided email exists in the users table
    SELECT user_id INTO v_user_id
    FROM public.users
    WHERE email_address = p_email_address;

    -- If user does not exist, return NULL
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'User with email % not found', p_email_address;
    END IF;

    -- Check if the provided password matches the stored password_hash
    IF EXISTS (
        SELECT 1
        FROM public.users
        WHERE user_id = v_user_id
        AND password_hash = crypt(p_password, stored_salt)
    ) THEN
        -- Insert a new record into the authentications table
        INSERT INTO public.authentications (user_id)
        VALUES (v_user_id)
        RETURNING user_id, authentication_id INTO p_user_id, p_authentication_id;
    ELSE
        -- Password does not match, raise an exception
        RAISE EXCEPTION 'Password for user % is incorrect', p_email_address;
    END IF;
END;
$BODY$;

