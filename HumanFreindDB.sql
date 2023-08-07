## 8.  Создать таблицы с иерархией из диаграммы в БД.
## 9.  Заполнить низкоуровневые таблицы именами(животных), 
##     командами, которые они выполняют и датами рождения.
## 10. Удалив из таблицы верблюдов, т.к. верблюдов решили 
##     перевезти в другой питомник на зимовку. 
##     Объединить таблицы лошади, и ослы в одну таблицу.
## 11. Создать новую таблицу “молодые животные”, в которую 
##     попадут все животные старше 1 года, но младше 3 лет 
##     и в отдельном столбце с точностью до месяца подсчитать 
##     возраст животных в новой таблице.
## 12. Объединить все таблицы в одну, при этом сохраняя поля, 
##     указывающие на прошлую принадлежность к старым таблицам.
## 13. Создать класс с Инкапсуляцией методов и наследованием по диаграмме.

## Создадим базу данных
CREATE DATABASE HumanFriendDB;
## Назначаем ее к использованию
USE HumanFriendDB;

## Сперва создадим низкоуровневые таблицы 
CREATE TABLE cat (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday DATE
);
CREATE TABLE dog (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday DATE
);
CREATE TABLE hamster (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday DATE
);
CREATE TABLE horse (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	liftWeight INT,
    Name VARCHAR(45),
    Command VARCHAR(45),
	Birthday DATE
);
CREATE TABLE camel (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	liftWeight INT,
    Name VARCHAR(45),
    Command VARCHAR(45),
	Birthday DATE
);
CREATE TABLE donkey (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	liftWeight INT,
    Name VARCHAR(45),
    Command VARCHAR(45),
	Birthday DATE
);

## Далее создаем таблицы более высокого уровня
CREATE TABLE pet (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday DATE
);
CREATE TABLE packAnimal (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    liftWeight INT,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday DATE
);

## Создаем общую таблицу
CREATE TABLE humanFriend(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    Command VARCHAR(45),
    Birthday Date
    ); 

## Заполняем данными низкоуровневые таблицы
INSERT INTO cat (Name, Command, Birthday) VALUES
    ('Пушок1', 'Спать', '2020-01-01'),
    ('Пушок2', 'Спать', '2020-01-02'),
	('Пушок3', 'Спать', '2020-01-03'),
    ('Пушок4', 'Спать', '2020-01-04');

    ## проверяем
    SELECT * FROM cat;

INSERT INTO dog (Name, Command, Birthday) VALUES
    ('Полкан1', 'Лежать', '2020-01-05'),
    ('Полкан2', 'Лежать', '2020-01-06'),
	('Полкан3', 'Лежать', '2020-01-07'),
    ('Полкан4', 'Лежать', '2020-01-08');
	
    ## проверяем
    SELECT * FROM dog;

INSERT INTO hamster (Name, Command, Birthday) VALUES
    ('Хомяк1', 'Бежать', '2020-01-09'),
    ('Хомяк2', 'Бежать', '2020-01-10'),
	('Хомяк3', 'Бежать', '2020-01-11'),
    ('Хомяк4', 'Бежать', '2020-01-12');
	
    ## проверяем
    SELECT * FROM hamster;

INSERT INTO camel (liftWeight, Name, Command, Birthday) VALUES
    (100, 'Верблюд1', 'Поднять', '2020-01-13'),
    (200, 'Верблюд2', 'Поднять', '2020-01-14'),
	(300, 'Верблюд3', 'Поднять', '2020-01-15'),
    (400, 'Верблюд4', 'Поднять', '2020-01-16');
	
    ## проверяем
    SELECT * FROM camel;

INSERT INTO horse (liftWeight, Name, Command,  Birthday) VALUES
    (50, 'Конь1', 'Галоп', '2020-01-17'),
    (60, 'Конь2', 'Галоп', '2021-01-18'),
	(70, 'Конь3', 'Галоп', '2022-01-19'),
    (80, 'Конь4', 'Галоп', '2023-01-20');
	
    ## проверяем
    SELECT * FROM horse; 

INSERT INTO donkey (liftWeight, Name, Command, Birthday) VALUES
    (100, 'Осел1', 'Тащить', '2020-01-22'),
    (200, 'Осел2', 'Тащить', '2021-01-23'),
	(300, 'Осел3', 'Тащить', '2022-01-24'),
    (400, 'Осел4', 'Тащить', '2023-01-25');
	
    ## проверяем
    SELECT * FROM donkey; 

## Удаление таблицы верблюдов
 DELETE FROM camel;

    ## проверяем
    SELECT * FROM camel;

## Объединение таблицы лошадей и ослов в одну таблицу.
CREATE TABLE HorseDonkey (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name, 
        Command, 
        Birthday
FROM horse UNION 
SELECT  Name, 
        Command, 
        Birthday
FROM donkey;

    ## проверяем
    SELECT * FROM HorseDonkey;

## Создание таблицы молодых животных, в которой все животные в возрасте от 1 до 3 лет.
## В отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице.

CREATE TABLE youngAnimals (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name, 
        Command, 
        Birthday,
        Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 1) AS age
FROM HorseDonkey
WHERE   Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 1) BETWEEN 1 AND 3;
    
    ## проверяем 
SELECT * FROM youngAnimals;

## Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

CREATE TABLE finalTable (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name, 
        Command,
        Birthday,
        'cat' AS oldTable
FROM cat UNION 
SELECT  Name, 
        Command, 
        Birthday,
        'dog' AS oldTable
FROM dog UNION
SELECT  Name, 
        Command, 
        Birthday,
        'hamster' AS oldTable
FROM hamster UNION 
SELECT  Name, 
        Command, 
        Birthday,
        'horse' AS oldTable
FROM horse UNION 
SELECT  Name, 
        Command, 
        Birthday,
        'donkey' AS oldTable
FROM donkey;

    ## проверяем
    SELECT * FROM finalTable;

