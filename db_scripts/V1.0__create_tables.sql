CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE public.horoscope(
    id UUID NOT NULL,
    content text NOT NULL
);