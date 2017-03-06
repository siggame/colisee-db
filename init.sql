CREATE TYPE shirt_size_enum AS ENUM ('s', 'm', 'l', 'xl', 'xxl');
CREATE TYPE pizza_choice_enum AS ENUM ('cheese', 'pepperoni', 'bacon', 'chicken');
CREATE TYPE prog_lang_enum AS ENUM ('cpp', 'python', 'csharp', 'javascript', 'java', 'lua');
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');

-- extra data for GitLab User representing an individual competitor
CREATE TABLE "user" (
    id integer NOT NULL PRIMARY KEY,

    is_eligible boolean NOT NULL DEFAULT true,

    shirt_size shirt_size_enum,
    pizza_choice pizza_choice_enum
);

-- extra data for GitLab Group representing a competition
CREATE TABLE "competition" (
    id integer NOT NULL PRIMARY KEY,

    start_time timestamp,
    end_time timestamp,

    is_open boolean NOT NULL DEFAULT false,
    is_running boolean NOT NULL DEFAULT false,

    min_team_size integer NOT NULL DEFAULT 2,
    max_team_size integer NOT NULL DEFAULT 2
);

-- extra data for GitLab Project representing a team
CREATE TABLE "team" (
    id integer NOT NULL PRIMARY KEY
);

CREATE TABLE "invite" (
    id serial NOT NULL PRIMARY KEY,
    team integer NOT NULL REFERENCES "team",
    member integer NOT NULL REFERENCES "user",
    message varchar(140) NOT NULL DEFAULT ' '
);

-- An individual game between teams
CREATE TABLE "game" (
    id serial NOT NULL PRIMARY KEY,
    status game_status_enum NOT NULL DEFAULT 'scheduled',

    winner integer,
    win_reason varchar(64),
    lose_reason varchar(64),

    gamelog bytea,

    -- if this game has been visualized before
    visualized boolean NOT NULL DEFAULT false,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);
