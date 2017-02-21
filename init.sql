CREATE TYPE shirt_size_enum AS ENUM ('s', 'm', 'l', 'xl', 'xxl');
CREATE TYPE pizza_choice_enum AS ENUM ('cheese', 'pepperoni', 'bacon', 'chicken');
CREATE TYPE prog_lang_enum AS ENUM ('cpp', 'python', 'csharp', 'javascript', 'java', 'lua');
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');

CREATE TABLE "user" (
    id serial NOT NULL PRIMARY KEY,
    gitlab_id integer NOT NULL, 

    is_eligible boolean NOT NULL DEFAULT true,

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
    gitlab_id integer NOT NULL,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

CREATE TABLE "user_team" (
    user_id integer NOT NULL REFERENCES "user",
    team_id integer NOT NULL REFERENCES "team",
    PRIMARY KEY(user_id, team_id)
);

CREATE TABLE "invite" (
    id serial NOT NULL PRIMARY KEY,
    team integer NOT NULL REFERENCES "team",
    member integer NOT NULL REFERENCES "user",
    message varchar(140) NOT NULL DEFAULT ' ',

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

-- An individual game between teams
CREATE TABLE "game" (
    id serial NOT NULL PRIMARY KEY,
    status game_status_enum NOT NULL DEFAULT 'scheduled',

    win_reason varchar(64),
    lose_reason varchar(64),

    gamelog bytea,

    -- if this game has been visualized before
    visualized boolean NOT NULL DEFAULT false,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

-- Teams participating in a game
CREATE TABLE "team_game" (
    winner boolean,
    team_id integer NOT NULL REFERENCES "team",
    game_id integer NOT NULL REFERENCES "game",
    PRIMARY KEY(team_id, game_id)
);
