create or replace function check_max_visitors_function() returns trigger as $check_max_visitors_function$
declare
    max_visitors           integer;
    current_visitors_count integer;
BEGIN
    SELECT count(*)
    INTO current_visitors_count
    FROM event_member
    WHERE event_member.event_id = NEW.event_id;
    SELECT meeting.max_visitors INTO max_visitors FROM meeting
    WHERE event = NEW.event_id;
    IF (current_visitors_count = max_visitors) THEN
        RAISE EXCEPTION 'Visitors are limited, try next time!';
    END IF;

    return NEW;
END;

$check_max_visitors_function$ LANGUAGE plpgsql;


create trigger check_max_visitors
    before INSERT on event_member
    for each row execute procedure check_max_visitors_function();

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