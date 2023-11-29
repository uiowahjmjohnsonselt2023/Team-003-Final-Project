--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

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
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO knguyen;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO knguyen;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO knguyen;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO knguyen;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO knguyen;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO knguyen;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO knguyen;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.cart_items OWNER TO knguyen;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_items_id_seq OWNER TO knguyen;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.carts OWNER TO knguyen;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO knguyen;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    image character varying
);


ALTER TABLE public.categories OWNER TO knguyen;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO knguyen;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    sender_id bigint,
    recipient_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_id bigint
);


ALTER TABLE public.conversations OWNER TO knguyen;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversations_id_seq OWNER TO knguyen;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.favorites OWNER TO knguyen;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO knguyen;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.feedbacks (
    id bigint NOT NULL,
    content text,
    order_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    rating integer,
    comment text
);


ALTER TABLE public.feedbacks OWNER TO knguyen;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO knguyen;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: listings; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.listings (
    id bigint NOT NULL,
    title character varying,
    description text,
    price character varying,
    condition character varying,
    quantity character varying,
    images character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.listings OWNER TO knguyen;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listings_id_seq OWNER TO knguyen;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    sender_id integer,
    recipient_id integer,
    body text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    read boolean DEFAULT false,
    conversation_id bigint,
    receiver_id integer,
    user_id bigint
);


ALTER TABLE public.messages OWNER TO knguyen;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO knguyen;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    recipient_id bigint NOT NULL,
    actor_id bigint NOT NULL,
    action character varying,
    notifiable_type character varying NOT NULL,
    notifiable_id bigint NOT NULL,
    read_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO knguyen;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO knguyen;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    quantity integer,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.order_items OWNER TO knguyen;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO knguyen;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    quantity integer,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    street character varying,
    city character varying,
    postal_code character varying,
    credit_card_number character varying,
    expiration_date character varying,
    cvv character varying,
    email character varying,
    phone character varying,
    additional_instructions text,
    save_payment_info boolean,
    product_id bigint
);


ALTER TABLE public.orders OWNER TO knguyen;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO knguyen;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    title character varying,
    user_id bigint NOT NULL,
    condition character varying,
    location character varying,
    price numeric,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sales_count integer DEFAULT 0,
    featured boolean DEFAULT false,
    average_rating double precision DEFAULT 0.0,
    category character varying,
    category_id bigint NOT NULL,
    buy_now_price numeric(10,2)
);


ALTER TABLE public.products OWNER TO knguyen;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO knguyen;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    rating integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    comment character varying,
    reviewer_id bigint NOT NULL,
    reviewee_id bigint
);


ALTER TABLE public.reviews OWNER TO knguyen;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO knguyen;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.sales (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sales OWNER TO knguyen;

--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_id_seq OWNER TO knguyen;

--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO knguyen;

--
-- Name: trackings; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.trackings (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    order_id bigint NOT NULL,
    status integer,
    tracking_number character varying,
    shipping_carrier character varying
);


ALTER TABLE public.trackings OWNER TO knguyen;

--
-- Name: trackings_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.trackings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackings_id_seq OWNER TO knguyen;

--
-- Name: trackings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.trackings_id_seq OWNED BY public.trackings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: knguyen
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    username character varying,
    email character varying,
    password_digest character varying,
    bio text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    reset_token character varying,
    reset_digest character varying,
    reset_sent_at timestamp without time zone,
    verified boolean,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO knguyen;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: knguyen
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO knguyen;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: knguyen
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- Name: trackings id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.trackings ALTER COLUMN id SET DEFAULT nextval('public.trackings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	image	Category	1	1	2023-11-17 18:05:29.003832
2	image	Category	2	2	2023-11-17 18:05:29.02294
3	image	Category	3	3	2023-11-17 18:05:29.034162
4	image	Category	4	4	2023-11-17 18:05:29.046634
5	image	Category	5	5	2023-11-17 18:05:29.129503
6	image	Category	7	6	2023-11-17 22:37:51.989531
7	image	Category	8	7	2023-11-17 22:37:52.007106
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	ytnd7c0828sq4i3sxpjfoc09ebhp	electronics_icon.png	image/png	{"identified":true}	local	15291	jRBJeKU7tgUpBZjZzML+8w==	2023-11-17 18:05:29.002286
2	4kn8cmx8mg8kpv1t13m1c6fljzhl	books_icon.png	image/png	{"identified":true}	local	69226	jfSWMogbc/W+l4LRKSkIyg==	2023-11-17 18:05:29.022066
3	iv7lt09dgob84lmkxnj568mah6rw	clothing_icon.png	image/png	{"identified":true}	local	246619	JPb5eU80+9ddxSvzZgqx3Q==	2023-11-17 18:05:29.033208
4	6wef57rcf6fngyp03bj2epzz1z12	toys_icon.png	image/png	{"identified":true}	local	303494	u6N12SL2/93kR91uvBrj3w==	2023-11-17 18:05:29.045485
5	y52cuxo6ctjyzmuk3xufk9htyor4	furniture_icon.png	image/png	{"identified":true}	local	219639	ldRrs+KS8xpV6dOxjSf/fA==	2023-11-17 18:05:29.127046
6	6vol6jcdf9t7jlu0jgwqzsi1f5pj	arts_icon.png	image/png	{"identified":true}	local	84914	Gslb7OaQkpPMUQ4LLHIDlg==	2023-11-17 22:37:51.987848
7	ui83uyvqrguqxnkhje9wlajyxur1	kitchen_icon.png	image/png	{"identified":true}	local	58252	sCaa1PqBhazhHbuajj4GMw==	2023-11-17 22:37:52.006268
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-11-17 18:05:28.696007	2023-11-17 18:05:28.696009
schema_sha1	2ffe71475d85ea0846e28a5de2f9bb5adf814b0e	2023-11-17 18:05:28.697666	2023-11-17 18:05:28.697667
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.cart_items (id, cart_id, product_id, quantity, created_at, updated_at) FROM stdin;
11	10	3	1	2023-11-24 22:06:21.917024	2023-11-24 22:06:21.917024
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
10	1	2023-11-24 22:06:21.894477	2023-11-24 22:06:21.894477
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.categories (id, name, created_at, updated_at, image) FROM stdin;
1	Electronics	2023-11-17 18:05:28.964341	2023-11-17 18:05:29.005232	\N
2	Books	2023-11-17 18:05:29.016769	2023-11-17 18:05:29.023775	\N
3	Clothing	2023-11-17 18:05:29.027235	2023-11-17 18:05:29.034943	\N
4	Toys	2023-11-17 18:05:29.038987	2023-11-17 18:05:29.047459	\N
5	Furniture	2023-11-17 18:05:29.099745	2023-11-17 18:05:29.147269	\N
7	Arts and Crafts	2023-11-17 22:37:51.960152	2023-11-17 22:37:51.990551	\N
8	Kitchen Appliances	2023-11-17 22:37:52.001331	2023-11-17 22:37:52.007882	\N
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.conversations (id, sender_id, recipient_id, created_at, updated_at, product_id) FROM stdin;
8	1	2	2023-11-22 21:04:47.17154	2023-11-22 21:04:47.17154	2
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.favorites (id, user_id, product_id, created_at, updated_at) FROM stdin;
1	1	2	2023-11-19 18:54:47.297919	2023-11-19 18:54:47.297919
2	2	3	2023-11-22 19:44:37.386394	2023-11-22 19:44:37.386394
3	1	5	2023-11-24 21:56:25.203838	2023-11-24 21:56:25.203838
4	1	5	2023-11-24 21:56:27.232224	2023-11-24 21:56:27.232224
5	1	3	2023-11-24 22:06:17.230931	2023-11-24 22:06:17.230931
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.feedbacks (id, content, order_id, created_at, updated_at, rating, comment) FROM stdin;
1	\N	4	2023-11-24 22:17:31.485748	2023-11-24 22:19:40.938803	5	:)
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.listings (id, title, description, price, condition, quantity, images, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.messages (id, sender_id, recipient_id, body, created_at, updated_at, read, conversation_id, receiver_id, user_id) FROM stdin;
1	1	1	Hello	2023-11-19 22:27:52.768758	2023-11-19 22:27:52.768758	f	\N	\N	\N
4	3	\N	Your custom message here	2023-11-22 17:38:40.20166	2023-11-22 17:38:40.20166	f	\N	2	\N
5	3	\N	Your custom message here	2023-11-22 17:41:56.109638	2023-11-22 17:41:56.109638	f	\N	2	\N
6	3	\N	Your custom message here	2023-11-22 17:41:58.813134	2023-11-22 17:41:58.813134	f	\N	2	\N
7	3	\N	Hi, can I make an offer?	2023-11-22 17:44:55.69434	2023-11-22 17:44:55.69434	f	\N	2	\N
14	\N	\N	Hi John	2023-11-22 21:19:09.542995	2023-11-22 21:19:09.542995	f	8	\N	1
15	\N	\N	Can I make an offer for $80?\r\n	2023-11-22 21:22:07.57298	2023-11-22 21:22:07.57298	f	8	\N	1
16	\N	\N	Hi Mary, I can accept that!	2023-11-22 22:28:00.191661	2023-11-22 22:28:00.191661	f	8	\N	2
17	\N	\N	Great!	2023-11-22 23:46:47.967914	2023-11-22 23:46:47.967914	f	8	\N	1
18	\N	\N	Great!	2023-11-22 23:47:14.376374	2023-11-22 23:47:14.376374	f	8	\N	1
19	\N	\N	Great!	2023-11-22 23:47:25.451789	2023-11-22 23:47:25.451789	f	8	\N	1
20	\N	\N	Great!	2023-11-22 23:48:20.730039	2023-11-22 23:48:20.730039	f	8	\N	1
21	\N	\N	:)	2023-11-23 15:46:35.299442	2023-11-23 15:46:35.299442	f	8	\N	2
22	\N	\N	:)	2023-11-23 15:47:18.287017	2023-11-23 15:47:18.287017	f	8	\N	2
23	\N	\N	test	2023-11-23 15:48:08.164429	2023-11-23 15:48:08.164429	f	8	\N	2
24	\N	\N	test	2023-11-23 15:51:30.790376	2023-11-23 15:51:30.790376	f	8	\N	2
25	\N	\N	Hi	2023-11-24 19:58:11.214329	2023-11-24 19:58:11.214329	f	8	1	2
26	\N	\N	Hi	2023-11-24 20:06:31.68207	2023-11-24 20:06:31.68207	f	8	\N	2
27	\N	\N	Hi\r\n	2023-11-24 20:18:20.521243	2023-11-24 20:18:20.521243	f	8	\N	1
28	\N	\N	Hi	2023-11-24 20:31:25.239906	2023-11-24 20:31:25.239906	f	8	\N	2
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.notifications (id, recipient_id, actor_id, action, notifiable_type, notifiable_id, read_at, created_at, updated_at) FROM stdin;
1	1	2	sent you a message	Message	26	2023-11-24 20:15:56.963937	2023-11-24 20:06:31.697001	2023-11-24 20:15:56.964215
2	2	1	sent you a message	Message	27	2023-11-24 20:22:52.86287	2023-11-24 20:18:20.525051	2023-11-24 20:22:52.863951
3	1	2	sent you a message	Message	28	2023-11-24 20:34:24.790805	2023-11-24 20:31:25.249751	2023-11-24 20:34:24.79185
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.order_items (id, quantity, order_id, product_id, created_at, updated_at) FROM stdin;
1	1	1	2	2023-11-19 03:13:19.638538	2023-11-19 03:13:19.638538
2	1	2	2	2023-11-19 03:18:56.593795	2023-11-19 03:18:56.593795
3	1	3	2	2023-11-19 03:20:29.269188	2023-11-19 03:20:29.269188
4	1	4	2	2023-11-19 03:24:56.55351	2023-11-19 03:24:56.55351
5	1	5	2	2023-11-19 18:55:09.440838	2023-11-19 18:55:09.440838
6	1	6	2	2023-11-19 19:32:25.657116	2023-11-19 19:32:25.657116
7	1	7	2	2023-11-19 19:37:34.707299	2023-11-19 19:37:34.707299
8	1	8	4	2023-11-24 21:32:12.811747	2023-11-24 21:32:12.811747
9	1	9	5	2023-11-24 21:57:01.090712	2023-11-24 21:57:01.090712
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.orders (id, user_id, quantity, status, created_at, updated_at, street, city, postal_code, credit_card_number, expiration_date, cvv, email, phone, additional_instructions, save_payment_info, product_id) FROM stdin;
1	1	\N	\N	2023-11-19 03:13:19.60288	2023-11-19 03:13:19.60288	123 Test Dr	Test City	12345	1111 1111 1111 1111	12/12	123	maryann@gmail.com	123-456-1335		f	\N
2	1	\N	\N	2023-11-19 03:18:56.562659	2023-11-19 03:18:56.562659	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	maryann@gmail.com	123-456-1335		f	\N
3	1	\N	\N	2023-11-19 03:20:29.260339	2023-11-19 03:20:29.260339	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	maryann@gmail.com	123-456-1335		f	\N
4	1	\N	\N	2023-11-19 03:24:56.526124	2023-11-19 03:24:56.526124	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	maryann@gmail.com	123-456-1335		f	\N
5	1	\N	\N	2023-11-19 18:55:09.422837	2023-11-19 18:55:09.422837	123 Test Dr	Test City	12345	1111 1111 1111 1111	12/12	123	maryann@gmail.com	123-456-1335		f	\N
6	1	\N	\N	2023-11-19 19:32:25.651082	2023-11-19 19:32:25.651082	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	maryann@gmail.com	123-456-1335		f	\N
7	1	\N	\N	2023-11-19 19:37:34.697338	2023-11-19 19:37:34.697338	123 Test Dr	Test City	12345	1111 1111 1111 1111	12/12	123	johndoe@gmail.com	123-456-1335		f	\N
8	1	\N	\N	2023-11-24 21:32:12.773052	2023-11-24 21:32:12.773052	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	testemail@gmail.com	123-456-1335		f	\N
9	1	\N	\N	2023-11-24 21:57:01.083809	2023-11-24 21:57:01.083809	123 Test Dr	Test City	12345	1111 1111 1111 1111	11/11	123	testemail@gmail.com	123-456-1335		f	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.products (id, title, user_id, condition, location, price, description, created_at, updated_at, sales_count, featured, average_rating, category, category_id, buy_now_price) FROM stdin;
2	Sample Product	2	New	\N	100.0	This is a sample product description.	2023-11-17 18:44:47.301681	2023-11-18 02:58:17.522993	0	f	5	\N	1	\N
3	Toy Car	1	New	\N	20.0	A fun toy car for kids.	2023-11-17 18:46:46.011495	2023-11-18 03:46:11.021531	0	f	0	\N	4	\N
4	Artificial Plant	1	Like New	Iowa City	50.0	5 ft tall artificial plant	2023-11-24 21:05:38.670323	2023-11-24 21:05:38.670323	0	f	0	Furniture	5	\N
5	L-shaped sofa	1	Good	Iowa	500.0	brown L-shaped sofa from Homemakers	2023-11-24 21:56:18.554058	2023-11-24 22:00:05.435654	0	f	5	Furniture	5	\N
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.reviews (id, product_id, rating, created_at, updated_at, comment, reviewer_id, reviewee_id) FROM stdin;
3	2	5	2023-11-18 02:58:17.520368	2023-11-18 02:58:17.520368	awesome product!	1	2
5	5	5	2023-11-24 22:00:05.416455	2023-11-24 22:00:05.416455	Great sofa!	1	1
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.sales (id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.schema_migrations (version) FROM stdin;
20231117152450
20231117063244
20231117062433
20231117025030
20231117015629
20231116203622
20231116195544
20231116190518
20231116045727
20231116044646
20231116043006
20231115042028
20231114074443
20231114065259
20231114064452
20231114060648
20231114025118
20231114023844
20231114012259
20231112050031
20231112045855
20231112045628
20231112045134
20231112044831
20231112044526
20231111045931
20231111032914
20231111005704
20231110003358
20231110003353
20231110002625
20231109235230
20231109234541
20231109233939
20231109172141
20231109052523
20231109050010
20231117154642
20231118031625
20231122050811
20231122052337
20231122184355
20231122210251
20231122224616
20231119030618
20231119031040
20231119033706
20231119040837
20231119190721
20231124221612
\.


--
-- Data for Name: trackings; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.trackings (id, created_at, updated_at, order_id, status, tracking_number, shipping_carrier) FROM stdin;
1	2023-11-19 03:24:56.559744	2023-11-19 03:24:56.559744	4	0	\N	\N
2	2023-11-19 04:00:54.068126	2023-11-19 04:00:54.068126	4	0	\N	\N
3	2023-11-19 04:10:57.444941	2023-11-19 04:10:57.444941	4	0	\N	\N
5	2023-11-19 04:14:40.721046	2023-11-19 04:14:40.721046	4	0	\N	\N
6	2023-11-19 04:18:33.973731	2023-11-19 04:18:33.973731	4	0	\N	\N
7	2023-11-19 04:19:03.172871	2023-11-19 04:19:03.172871	4	0	\N	\N
8	2023-11-19 04:25:33.599147	2023-11-19 04:25:33.599147	4	0	1e4bfc54-d830-476b-8343-14ff2de9b1bf	\N
9	2023-11-19 04:35:23.025974	2023-11-19 04:35:23.025974	4	0	2bdfa825-16b4-4db9-b96c-d2840f5921b5	\N
4	2023-11-19 04:14:08.238517	2023-11-19 04:47:26.815379	4	0	b27944ea-af6c-4a21-ad61-fd7a475739f8	\N
10	2023-11-19 18:55:09.445084	2023-11-19 18:55:09.445084	5	0	9bf7b1d4-5196-4626-8ab5-0c671e6e08f1	\N
11	2023-11-19 19:32:25.660676	2023-11-19 19:36:22.331796	6	0	df1e5e6d-7915-4607-887b-8b47bb65c8b2	\N
13	2023-11-19 19:37:34.718089	2023-11-19 19:37:34.718089	7	0	834dee14-c0fe-45d1-92bb-c9d6289c5944	UPS
15	2023-11-24 21:57:01.116895	2023-11-24 21:57:01.116895	9	0	cc32b4d9-039f-44a9-85a1-0e216a0cf266	UPS
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: knguyen
--

COPY public.users (id, name, username, email, password_digest, bio, created_at, updated_at, reset_token, reset_digest, reset_sent_at, verified, admin) FROM stdin;
1	Mary Ann	MaryAnn	maryann@gmail.com	$2a$12$qmGJA6u7Wrjecn/6.twhnOtLRcamAA7GZx5H8UFF.w8//4Hxo3bQW	Hi, im Mary	2023-11-17 18:15:56.818823	2023-11-17 18:15:56.818823	\N	\N	\N	\N	f
2	John Doe	johndoe	john@example.com	$2a$12$Vkyl7OWvl3qzkDwUaFrOSORbxT4lD7KV47ZguUePrrCVsFI7u3EQu	\N	2023-11-17 18:43:42.12301	2023-11-17 18:43:42.12301	\N	\N	\N	\N	f
3	Bob	testbob	bob@test.com	$2a$12$Hk4EZYxJbeBh0XzC9/lB4OpHOI6YoBDJgZ17NV72BhOe6oAqa7XWS	Hi, im Bob	2023-11-19 23:33:12.386999	2023-11-19 23:33:12.386999	\N	\N	\N	\N	f
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 7, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 7, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 11, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.carts_id_seq', 10, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.conversations_id_seq', 8, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.favorites_id_seq', 5, true);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 1, true);


--
-- Name: listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.listings_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.messages_id_seq', 28, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.notifications_id_seq', 3, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.order_items_id_seq', 9, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.orders_id_seq', 9, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.products_id_seq', 5, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.reviews_id_seq', 5, true);


--
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.sales_id_seq', 1, false);


--
-- Name: trackings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.trackings_id_seq', 15, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: knguyen
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: trackings trackings_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.trackings
    ADD CONSTRAINT trackings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_cart_items_on_cart_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_cart_items_on_cart_id ON public.cart_items USING btree (cart_id);


--
-- Name: index_cart_items_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_cart_items_on_product_id ON public.cart_items USING btree (product_id);


--
-- Name: index_carts_on_user_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_carts_on_user_id ON public.carts USING btree (user_id);


--
-- Name: index_conversations_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_conversations_on_product_id ON public.conversations USING btree (product_id);


--
-- Name: index_conversations_on_recipient_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_conversations_on_recipient_id ON public.conversations USING btree (recipient_id);


--
-- Name: index_conversations_on_sender_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_conversations_on_sender_id ON public.conversations USING btree (sender_id);


--
-- Name: index_favorites_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_favorites_on_product_id ON public.favorites USING btree (product_id);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_feedbacks_on_order_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_feedbacks_on_order_id ON public.feedbacks USING btree (order_id);


--
-- Name: index_messages_on_conversation_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_messages_on_conversation_id ON public.messages USING btree (conversation_id);


--
-- Name: index_messages_on_receiver_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_messages_on_receiver_id ON public.messages USING btree (receiver_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- Name: index_notifications_on_actor_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_notifications_on_actor_id ON public.notifications USING btree (actor_id);


--
-- Name: index_notifications_on_notifiable_type_and_notifiable_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_notifications_on_notifiable_type_and_notifiable_id ON public.notifications USING btree (notifiable_type, notifiable_id);


--
-- Name: index_notifications_on_recipient_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_notifications_on_recipient_id ON public.notifications USING btree (recipient_id);


--
-- Name: index_order_items_on_order_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_order_items_on_order_id ON public.order_items USING btree (order_id);


--
-- Name: index_order_items_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_order_items_on_product_id ON public.order_items USING btree (product_id);


--
-- Name: index_orders_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_orders_on_product_id ON public.orders USING btree (product_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_orders_on_user_id ON public.orders USING btree (user_id);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_products_on_category_id ON public.products USING btree (category_id);


--
-- Name: index_products_on_user_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_products_on_user_id ON public.products USING btree (user_id);


--
-- Name: index_reviews_on_product_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_reviews_on_product_id ON public.reviews USING btree (product_id);


--
-- Name: index_reviews_on_reviewee_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_reviews_on_reviewee_id ON public.reviews USING btree (reviewee_id);


--
-- Name: index_reviews_on_reviewer_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_reviews_on_reviewer_id ON public.reviews USING btree (reviewer_id);


--
-- Name: index_trackings_on_order_id; Type: INDEX; Schema: public; Owner: knguyen
--

CREATE INDEX index_trackings_on_order_id ON public.trackings USING btree (order_id);


--
-- Name: reviews fk_rails_007031d9cb; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_007031d9cb FOREIGN KEY (reviewer_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_06a39bb8cc; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_06a39bb8cc FOREIGN KEY (actor_id) REFERENCES public.users(id);


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_2855ab3029; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_2855ab3029 FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: trackings fk_rails_379f7c5c9c; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.trackings
    ADD CONSTRAINT fk_rails_379f7c5c9c FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: notifications fk_rails_4aea6afa11; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_4aea6afa11 FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: favorites fk_rails_54567c0f67; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_54567c0f67 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: messages fk_rails_67c67d2963; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_67c67d2963 FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: cart_items fk_rails_681a180e84; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_681a180e84 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: reviews fk_rails_6c8f877405; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_6c8f877405 FOREIGN KEY (reviewee_id) REFERENCES public.users(id);


--
-- Name: cart_items fk_rails_6cdb1f0139; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_6cdb1f0139 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: feedbacks fk_rails_7f47de8c47; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT fk_rails_7f47de8c47 FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: messages fk_rails_7f927086d2; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_7f927086d2 FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: conversations fk_rails_a83c011e5e; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_a83c011e5e FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: reviews fk_rails_bedd9094d4; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_bedd9094d4 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: favorites fk_rails_d15744e438; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_d15744e438 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: products fk_rails_dee2631783; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_dee2631783 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: orders fk_rails_dfb33b2de0; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_dfb33b2de0 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: order_items fk_rails_e3cb28f071; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_rails_e3cb28f071 FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: carts fk_rails_ea59a35211; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_rails_ea59a35211 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_f0edaae389; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_f0edaae389 FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: order_items fk_rails_f1a29ddd47; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_rails_f1a29ddd47 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders fk_rails_f868b47f6a; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_f868b47f6a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: products fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: knguyen
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

