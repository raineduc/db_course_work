create table tradition
(
    tradition_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250)
);

create table synagogue
(
  synagogue_id SERIAL PRIMARY KEY,
  size REAL NOT NULL CHECK ( size >= 0 AND size <= 100000),
  architecture_style VARCHAR(50),
  tradition INTEGER REFERENCES tradition ON DELETE SET NULL
);

create table premise
(
  premise_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  synagogue INTEGER REFERENCES synagogue ON DELETE CASCADE NOT NULL
);

create table library
(
  library_id SERIAL PRIMARY KEY,
  premise INTEGER REFERENCES premise ON DELETE CASCADE NOT NULL
);

create table member
(
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    synagogue INTEGER REFERENCES synagogue ON DELETE SET NULL
);

create table book
(
    book_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250) NOT NULL,
    library INTEGER REFERENCES library ON DELETE CASCADE NOT NULL,
    borrower INTEGER REFERENCES member ON DELETE SET NULL
);

create table event
(
    event_id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description VARCHAR(250) NOT NULL,
    date TIMESTAMP WITH TIME ZONE NOT NULL,
    synagogue INTEGER REFERENCES synagogue ON DELETE CASCADE NOT NULL
);

create table meeting
(
    meeting_id SERIAL PRIMARY KEY,
    event INTEGER REFERENCES event ON DELETE CASCADE NOT NULL,
    premise INTEGER REFERENCES premise ON DELETE SET NULL,
    max_visitors INTEGER NOT NULL,
    food REAL
);

create table attribute
(
    attribute_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250) NOT NULL
);

create table synagogue_attribute
(
    synagogue_attribute_id SERIAL PRIMARY KEY,
    attribute INTEGER REFERENCES attribute ON DELETE CASCADE NOT NULL ,
    synagogue INTEGER REFERENCES synagogue ON DELETE CASCADE NOT NULL ,
    premise INTEGER REFERENCES premise ON DELETE SET NULL ,
    name VARCHAR(50) NOT NULL ,
    description VARCHAR(250) NOT NULL
);

create table tradition_attribute
(
    attribute_id SERIAL REFERENCES attribute ON DELETE CASCADE,
    tradition_id SERIAL REFERENCES tradition ON DELETE CASCADE,
    primary key (attribute_id, tradition_id)
);

create table event_member
(
    event_id SERIAL REFERENCES event ON DELETE CASCADE,
    member_id SERIAL REFERENCES member ON DELETE CASCADE,
    primary key (event_id, member_id)
);