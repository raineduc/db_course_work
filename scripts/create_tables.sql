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
    borrower INTEGER REFERENCES member ON DELETE SET NULL,
    is_available BOOLEAN
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

create function update_role(in our_member_id integer, in new_role varchar(50)) returns text as $$
BEGIN
    update member
    set role = new_role
    where member_id = our_member_id;
    return 'New role successfully updated!';
END;

$$ LANGUAGE plpgsql;

create function book_was_borrowed_function() returns trigger as $book_was_borrowed_function$
BEGIN
    IF borrower is null THEN
        UPDATE book
        SET is_available = true
        WHERE book_id = NEW.book_id;
    ELSE
        UPDATE book
        SET is_available = false
        WHERE book_id = NEW.book_id;
    END IF;
    RETURN new;
END;

$book_was_borrowed_function$ LANGUAGE plpgsql;

create trigger cell_was_updated
    after UPDATE of borrower on book
    for each row execute procedure book_was_borrowed_function();
