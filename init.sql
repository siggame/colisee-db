CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished', 'failed');
create type submission_status_enum as enum ('queued', 'building', 'finished', 'failed');

-- info for our teams
CREATE TABLE "teams" (
    -- basic team info
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL UNIQUE,
    contact_name varchar(128) NOT NULL,
    contact_email varchar(128) NOT NULL,
    -- can be changed to match whatever encryption we want
    password varchar(256) NOT NULL,

    -- TODO: Add additional contact info

    is_eligible boolean NOT NULL DEFAULT true,
  
    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

create table "submissions" (
  id serial NOT NULL PRIMARY KEY,
  team_id integer NOT NULL REFERENCES teams(id),
  version integer NOT NULL,
  status submission_status_enum NOT NULL DEFAULT 'queued',
  submission_url varchar(64),
  log_url varchar(64),
  image_name varchar(64),
  
  created_time timestamp NOT NULL DEFAULT now(),
  modified_time timestamp NOT NULL DEFAULT now(),
  
  unique(team_id, version)
);
  

-- An individual game between teams
CREATE TABLE "games" (
    id serial NOT NULL PRIMARY KEY,
    status game_status_enum NOT NULL DEFAULT 'scheduled',

    win_reason varchar(64),
    lose_reason varchar(64),

    winner_id integer REFERENCES teams(id),

    log_url varchar(128),

    -- if this game has been visualized before
    visualized boolean NOT NULL DEFAULT false,

    created_time timestamp NOT NULL DEFAULT now(),
    modified_time timestamp NOT NULL DEFAULT now()
);

-- Links the Team and Game tables
CREATE TABLE "game_submissions" (
    id serial NOT NULL PRIMARY KEY,
    game_id integer NOT NULL REFERENCES games(id),
    submission_id integer NOT NULL REFERENCES submissions(id),
    output_url varchar(64)
);
