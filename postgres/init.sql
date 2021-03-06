drop type if exists form cascade;
create type form as enum (
    'First Printing',
    'Fragment',
    'Manuscript',
    'Mention',
    'Reprint',
    'Synopsis',
    'Synopsis (manuscript)',
    'Synopsis (printed)'
);

drop type if exists form_type cascade;
create type form_type as enum (
    'Fragment',
    'Full edition',
    'Synopsis'
);

drop type if exists genre cascade;
create type genre as enum (
    'Comedy',
    'Comical tragedy',
    'Interlude',
    'Opera',
    'Pastoral play',
    'Tragedy',
    'Tragicomedy'
);

drop type if exists subgenre cascade;
create type subgenre as enum (
    'Comedy in Greek fashion',
    'Farce',
    'Martyr tragedy',
    'Sacred comedy'
);

drop table if exists manifestations cascade;
create table manifestations (
    id uuid primary key,
    origin text not null, -- 'M1 .. M2249 in TransLatin_Manifestations.xlsx'
    earliest date not null,
    latest date not null,
    form form,
    form_type form_type not null,
    is_anonymous boolean not null,
    genre genre,
    subgenre subgenre,
    has_dramaweb_scan boolean,                  -- internal: somewhere in project there is a scan (column Y)
    has_dramaweb_transcription boolean,         -- internal: transcription was made in this project (column Y)
    ceneton_scan text,                          -- optional url, taken from column 'BD'
    ceneton_transcription text,                 -- optional url, taken from column 'BE'
    external_scan text,                         -- optional url, taken from column 'AM'
    external_transcription boolean not null,    -- not in excel, always false to start, can manually set to true
    fingerprint text,
    literature text,
    remarks text,
    link_ub_antwerp text,
    link_kbb text,
    link_ub_gent text,
    link_bnf text,
    link_kb text,
    link_google text,
    link_bll text
);
create unique index on manifestations(origin);

-- called 'personages' instead of 'character(s)' to avoid conflict with Postgres type 'character'
drop table if exists manifestation_personages;
create table manifestation_personages (
    manifestation_id uuid not null,
    name text not null,
    primary key (manifestation_id,name),
    foreign key (manifestation_id) references manifestations (id)
);
create index on manifestation_personages (name);

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

drop table if exists manifestation_titles cascade;
create table manifestation_titles (
    manifestation_id uuid not null,
    title text not null,
    language languages not null,
    certainty certainty not null,
    primary key (manifestation_id, title, language),
    foreign key (manifestation_id) references manifestations (id)
);
create index on manifestation_titles (language, certainty);

drop table if exists manifestation_ceneton cascade;
create table manifestation_ceneton (
    manifestation_id uuid not null,
    ceneton_id text not null,
    primary key (manifestation_id, ceneton_id),
    foreign key (manifestation_id) references manifestations (id)
);

drop type if exists author_types cascade;
create type author_types as enum ('Person', 'Organization');

drop table if exists authors cascade;
create table authors (
    id uuid primary key,
    name text not null,
    origin smallint not null, -- '1 .. 147 in TransLatin_Authors.xlsx'
    type author_types not null,
    first_name text,
    prefix text,
    surname text,
    birth_earliest date,
    birth_latest date,
    birth_place smallint,
    death_earliest date,
    death_latest date,
    death_place smallint,
    occupation text,
    religion text,
    image text,
    wikidata text
);
create unique index on authors (name);
create unique index on authors (origin);

drop table if exists places cascade;
create table places (
    id smallserial primary key,
    name text
);
create unique index on places (name);

drop table if exists author_names cascade;
create table author_names (
    author_id uuid not null,
    name text not null,
    primary key (author_id, name),
    foreign key (author_id) references authors (id)
);
create index on author_names (name);

drop table if exists author_viaf_links cascade;
create table author_viaf_links (
    author_id uuid not null,
    viaf text not null,
    primary key (author_id, viaf),
    foreign key (author_id) references authors (id)
);

drop table if exists author_nta_links cascade;
create table author_nta_links (
    author_id uuid not null,
    nta text not null,
    primary key (author_id, nta),
    foreign key (author_id) references authors (id)
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

drop type if exists widow_heirs cascade;
create type widow_heirs as enum (
    'Heirs',
    'Widow',
    'Widow and Heirs',
    'Widow and son'
);

drop table if exists publishers cascade;
create table publishers (
    id uuid primary key,
    name text not null,
    widow_heirs widow_heirs,
    first_name text,        -- empty for publishers
    patronym text,          -- e.g., 'jansz.'
    prefix text,            -- e.g., 'de', 'vander'
    addition text,          -- e.g., (i) (ii)
    surname text not null,  -- equal to 'name' for publishers (e.g., Elzevier)
    cerl_link text          -- CERL Thesaurus URL
);
create unique index on publishers (name);

drop table if exists publisher_names cascade;
create table publisher_names (
    publisher_id uuid not null,
    name text not null,
    primary key (publisher_id, name),
    foreign key (publisher_id) references publishers (id)
);
create unique index on publisher_names (name, publisher_id);

drop table if exists manifestations_publishers cascade;
create table manifestations_publishers (
    manifestation_id uuid not null,
    publisher_id uuid not null,
    place_id smallint,
    primary key (manifestation_id, publisher_id),
    foreign key (manifestation_id) references manifestations (id),
    foreign key (publisher_id) references publishers (id),
    foreign key (place_id) references places (id)
);
create unique index on manifestations_publishers (publisher_id, manifestation_id);
