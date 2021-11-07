CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE public.horoscopes(
    id UUID NOT NULL DEFAULT uuid_generate_v4(),
    content text NOT NULL
);
