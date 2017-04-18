CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');

-- info for our teams
CREATE TABLE "team" (
    -- basic team info
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL UNIQUE,
    contact_name varchar(128) NOT NULL,
    contact_email varchar(128) NOT NULL,
    -- can be changed to match whatever encryption we want
    password varchar(256) NOT NULL,

    -- TODO: Add additional contact info

    is eligible boolean NOT NULL DEFAULT true,

    -- info used to store team builds
    latest_submission_tar_url varchar(64),
    latest_submission_build_output_url varchar(64),
    latest_submission_time timestamp,
    
    valid_submission_tar_url varchar(64),
    valid_submission_build_output_url varchar(64),
    valid_submission_time timestamp
);

-- An individual game between teams
CREATE TABLE "game" (
    id serial NOT NULL PRIMARY KEY,
    status game_status_enum NOT NULL DEFAULT 'scheduled',

    win_reason varchar(64),
    lose_reason varchar(64),

    gamelog_url varchar(64),

    -- if this game has been visualized before
    visualized boolean NOT NULL DEFAULT false,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);
