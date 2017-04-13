CREATE TYPE shirt_size_enum AS ENUM ('s', 'm', 'l', 'xl', 'xxl');
CREATE TYPE pizza_choice_enum AS ENUM ('cheese', 'pepperoni', 'bacon', 'chicken');
CREATE TYPE game_status_enum as ENUM ('scheduled', 'playing', 'finished');

-- extra data for GitLab User representing an individual competitor
CREATE TABLE "user" (
    id serial NOT NULL PRIMARY KEY,
    name varchar(32) NOT NULL UNIQUE,
    full_name varchar(128),

    is_eligible boolean NOT NULL DEFAULT true,

    shirt_size shirt_size_enum,
    pizza_choice pizza_choice_enum
);

CREATE TABLE "team_member" (
       
);

-- extra data for GitLab Project representing a team
CREATE TABLE "team" (
    id serial NOT NULL PRIMARY KEY,
    
    latest_submission_tar_url varchar(64),
    latest_submission_build_output_url varchar(64),
    latest_submission_time timestamp,
    
    valid_submission_tar_url varchar(64),
    valid_submission_build_output_url varchar(64),
    valid_submission_time timestamp,
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
