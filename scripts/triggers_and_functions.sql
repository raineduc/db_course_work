create table Farm (
    farm_id serial primary key,
    location text,
    name varchar(32)
);

create table Client (

                        client_id serial primary key,

                        name varchar(32),

                        surname varchar(32),

                        email varchar(32),

                        phone_number varchar(32),

                        country varchar(32),

                        city varchar(32),

                        address text

);

create table Pick_Up_Point (

                               pick_up_point_id serial primary key,

                               location text,

                               number_of_cells integer,

                               number_of_free_cells integer

);

create type cell_status as ENUM ('available', 'occupied', 'broken');

create table Cell (

                      cell_id serial primary key,

                      status cell_status,

                      client_id int

                          references Client(client_id)

                              ON DELETE set null

                              ON UPDATE cascade,

                      pick_up_point_id int

                          references Pick_Up_Point(pick_up_point_id)

                              ON DELETE set null

                              ON UPDATE cascade

);

create table Product (

                         product_id serial primary key,

                         type text,

                         weight integer,

                         size integer ARRAY[3],

                         departure_date date,

                         arrival_date date,

                         production_date date,

                         expiration_date date,

                         client_id int

                             references Client(client_id)

                                 ON DELETE cascade

                                 ON UPDATE cascade,

                         pick_up_point_id int

                             references Pick_Up_Point(pick_up_point_id)

                                 ON DELETE set null

                                 ON UPDATE cascade,

                         farm_id int

                             references Farm(farm_id)

                                 ON DELETE cascade

                                 ON UPDATE cascade

);

create trigger cell_was_added
    after INSERT on cell
    for each row execute procedure cell_was_added_function();

create function cell_was_added_function() returns trigger as $cell_was_added_function$
    BEGIN
        UPDATE pick_up_point
        SET number_of_cells = number_of_cells + 1
        WHERE pick_up_point_id = NEW.pick_up_point_id;
        UPDATE pick_up_point
        SET number_of_free_cells = number_of_free_cells + 1
        WHERE pick_up_point_id = NEW.pick_up_point_id
        AND NEW.status = 'available';
        RETURN new;
    END;

$cell_was_added_function$ LANGUAGE plpgsql;