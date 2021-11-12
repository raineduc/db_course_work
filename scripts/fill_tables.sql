INSERT INTO tradition (name, description)
VALUES
       ('Ашкеназская', 'Названа по имени ашкеназов - субэтнической группы евреев, сформировавшихся в Центральной Европе, представители говорят на идише'),
       ('Сефардская', 'Названа по имени ашкеназов - субэтнической группы евреев, сформировавшихся на Пиренейском полуострове из потоков миграции иудеев внутри Римской империи, а затем внутри Халифата');

INSERT INTO synagogue (size, architecture_style, tradition)
VALUES
       (750, 'неомавританский', 1);

INSERT INTO premise (name, synagogue)
VALUES
       ('зал', 1), ('библиотека', 1), ('эзрат нашим', 1), ('вестибюль', 1);

INSERT INTO library (premise)
VALUES (2);

INSERT INTO member (name, surname, role, synagogue)
VALUES
       ('Лев', 'Ландау', 'раввин', 1),
       ('Бенедикт', 'Спиноза', 'хазан', 1),
       ('Леонид', 'Канторович', 'шамаш', 1),
       ('Эрих', 'Фромм', 'габай', 1),
       ('Егор', 'Остряков', 'прихожанин', 1);

INSERT INTO book (name, description, library, borrower)
VALUES
    ('Пятикнижие', 'пять первых книг Танаха и Ветхого Завета: Бытие, Исход, Левит, Числа и Второзаконие. Составляет первую часть Танаха, именуемую также Торой', 1, NULL),
    ('Талмуд', 'свод правовых и религиозно-этических положений иудаизма, охватывающий Мишну и Гемару в их единстве', 1, NULL),
    ('Шулхан арух', 'кодекс практических положений устного закона, составленный в XVI веке раввином Йосефом Каро', 1, 5);

INSERT INTO event (type, description, date, synagogue)
VALUES
       ('Ханука', 'Праздничная молитва', TIMESTAMP WITH TIME ZONE '2021-11-28 17:00:00+03', 1),
       ('Иврит Торы', 'учимся читать и понимать тексты на святом языке в оригинале', TIMESTAMP WITH TIME ZONE '2021-11-02 19:00:00+03', 1),
       ('Пурим с подробностями', 'Обсуждение истории праздника', TIMESTAMP WITH TIME ZONE '2022-02-22 19:00:00+03', 1);

INSERT INTO meeting (event, premise, max_visitors, food)
VALUES (3, 1, 100, 50);

INSERT INTO attribute (name, description)
VALUES
       ('Арон акодеш', 'Шкаф или ниша, где хранятся свитки Торы'),
       ('Бима', 'Возвышение в центре, с которого читается Тора, на нем установлен стол для свитка'),
       ('Амуд', 'Пюпитр между бимой и арон кодеш');

INSERT INTO synagogue_attribute (attribute, synagogue, premise, name, description)
VALUES (2, 1, 1, 'Бима', 'Возвышение в центре');

INSERT INTO tradition_attribute (attribute_id, tradition_id)
VALUES (3, 1);

INSERT INTO event_member (event_id, member_id)
VALUES
       (1, 1), (1, 2), (1, 5),
       (2, 2), (2, 5),
       (3, 1), (3, 2), (3, 3), (3, 4), (3, 5);



