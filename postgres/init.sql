drop table if exists manifestations cascade;
create table manifestations (
    id uuid primary key,
    fingerprint text
);

drop type if exists languages cascade;
create type languages as enum (
-- this is MvdP's list of languages used in Translatin, taken from Confluence page
    'Croatian',
    'Czech',
    'Danish',
    'Dutch',
    'English',
    'French',
    'German',
    'Greek',
    'Hungarian',
    'Italian',
    'Latin',
    'Norwegian',
    'Polish',
    'Russian',
    'Spanish',
    'Swedish'
);

drop type if exists certainty cascade;
create type certainty as enum ('Certain', 'Uncertain');

drop table if exists manifestation_languages cascade;
create table manifestation_languages (
    manifestation_id uuid not null,
    language languages not null,
    certainty certainty not null,
    unique (manifestation_id, language, certainty),
    foreign key (manifestation_id) references manifestations (id)
);
create index on manifestation_languages (manifestation_id);

drop table if exists manifestation_ceneton cascade;
create table manifestation_ceneton (
    manifestation_id uuid not null,
    ceneton_id text not null,
    primary key (manifestation_id, ceneton_id),
    foreign key (manifestation_id) references manifestations (id)
);

drop table if exists manifestation_titles cascade;
create table manifestation_titles (
    manifestation_id uuid not null,
    title text not null,
    primary key (manifestation_id, title),
    foreign key (manifestation_id) references manifestations (id)
);

drop type if exists author_types cascade;
create type author_types as enum ('person', 'organisation');

drop table if exists authors cascade;
create table authors (
    id uuid primary key,
    name text not null,
    type author_types not null
);

drop table if exists authors_manifestations cascade;
create table authors_manifestations (
    author_id uuid not null,
    manifestation_id uuid not null,
    primary key (author_id, manifestation_id),
    foreign key (manifestation_id) references manifestations (id),
    foreign key (author_id) references authors (id)
);
create unique index on authors_manifestations (manifestation_id, author_id);
