<<<<<<< HEAD
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');

-- info for our teams
CREATE TABLE "team" (
=======
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished', 'failed');
create type submission_status_enum as enum ('queued', 'building', 'finished', 'failed');

-- info for our teams
CREATE TABLE "teams" (
>>>>>>> 8f352cee12fcfbeca25383d066097df05036335d
    -- basic team info
    id serial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL UNIQUE,
    contact_name varchar(128) NOT NULL,
    contact_email varchar(128) NOT NULL,
    -- can be changed to match whatever encryption we want
    password varchar(256) NOT NULL,

    -- TODO: Add additional contact info

    is_eligible boolean NOT NULL DEFAULT true,
<<<<<<< HEAD

    -- info used to store team builds
    latest_submission_tar_url varchar(64),
    latest_submission_build_output_url varchar(64),
    latest_submission_time timestamp,
    
    valid_submission_tar_url varchar(64),
    valid_submission_build_output_url varchar(64),
    valid_submission_time timestamp
=======
  
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
>>>>>>> 8f352cee12fcfbeca25383d066097df05036335d
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
<<<<<<< HEAD
CREATE TABLE "team_games" (
    game_id integer NOT NULL PRIMARY KEY REFERENCES game(id),
    team1 varchar(64) NOT NULL REFERENCES team(name),
    team2 varchar(64) NOT NULL REFERENCES team(name),
    winner varchar(64) CHECK ( winner = team1 OR winner = team2 ) REFERENCES team(name)
);
=======
CREATE TABLE "game_submissions" (
    id serial NOT NULL PRIMARY KEY,
    game_id integer NOT NULL REFERENCES games(id),
    submission_id integer NOT NULL REFERENCES submissions(id),
    output_url varchar(64)
);
>>>>>>> 8f352cee12fcfbeca25383d066097df05036335d
