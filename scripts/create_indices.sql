create index if not exists event_date on event (date);

create index if not exists meeting_event_id on meeting using hash (event);

create index if not exists book_name on book (name);