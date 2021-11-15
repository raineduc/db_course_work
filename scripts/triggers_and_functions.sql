create trigger check_max_visitors
    before INSERT on event_member
    for each row execute procedure check_max_visitors_function();

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

