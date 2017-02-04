CREATE TYPE shirt_size_enum AS ENUM ('s', 'm', 'l', 'xl', 'xxl');
CREATE TYPE pizza_choice_enum AS ENUM ('cheese', 'pepperoni', 'bacon', 'chicken');
CREATE TYPE prog_lang_enum AS ENUM ('cpp', 'python', 'csharp', 'javascript', 'java', 'lua');
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');
CREATE TYPE schedule_type_enum as ENUM ('random', 'single-elim', 'triple-elim', 'swiss');

CREATE TABLE "user" (
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL UNIQUE,
    full_name varchar(64),
    email varchar(64) NOT NULL UNIQUE,

    is_dev boolean NOT NULL DEFAULT false,
    is_student boolean NOT NULL DEFAULT true,
    is_sponsor boolean NOT NULL DEFAULT false,
    is_prev_competitor boolean NOT NULL DEFAULT false,

    shirt_size shirt_size_enum,
    pizza_choice pizza_choice_enum,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "competition" (
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) UNIQUE,
    description varchar(128) NOT NULL DEFAULT 'Competition description here.',

    slogan varchar(64) NOT NULL DEFAULT 'Competition slogan here.',
    logo bytea,

    start_time timestamp,
    end_time timestamp,

    is_open boolean NOT NULL DEFAULT false,
    is_running boolean NOT NULL DEFAULT false,

    min_team_size integer NOT NULL DEFAULT 2,
    max_team_size integer NOT NULL DEFAULT 2,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "team" (
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL UNIQUE,

    gitlab_id integer,

    members integer[],
    prog_lang prog_lang_enum,

    competition integer REFERENCES "competition",

    is_paid boolean NOT NULL DEFAULT false,
    paid_time timestamp,
    is_eligible boolean NOT NULL DEFAULT true,

    is_embargoed boolean NOT NULL DEFAULT true,
    embargo_reason varchar(128) DEFAULT 'Initial build not performed.',
    last_embargoed_time timestamp NOT NULL DEFAULT now(),

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "team_invitation" (
    id serial NOT NULL PRIMARY KEY,
    team integer NOT NULL REFERENCES "team",
    sender integer NOT NULL REFERENCES "user",
    receiver integer NOT NULL REFERENCES "user",

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "game" (
    id serial NOT NULL PRIMARY KEY,
    teams integer[] NOT NULL,
    competition integer NOT NULL REFERENCES "competition",

    status game_status_enum NOT NULL DEFAULT 'scheduled',

    winners integer[],
    win_reasons varchar(64)[],
    losers integer[],
    lose_reasons varchar(64)[],

    gamelog bytea,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "schedule" (
    id serial NOT NULL PRIMARY KEY,
    
    type schedule_type_enum NOT NULL,
    
    include_all boolean NOT NULL DEFAULT false,
    include_alum boolean NOT NULL DEFAULT false,
    include_dev boolean NOT NULL DEFAULT false,
    include_eligible boolean NOT NULL DEFAULT true,
    include_sponsor boolean NOT NULL DEFAULT false,
    
    data json,
    result json,
    
    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);
