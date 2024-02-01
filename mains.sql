CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    location VARCHAR(50)
);

INSERT INTO students (first_name, middle_name, last_name, age, location) VALUES
('Juan', 'Blank', 'Cruz', 18, 'Manila'),
('Anne', 'Blank', 'Wall', 20, 'Quezon City'),
('Theresa', 'Blank', 'Joseph', 21, 'Pasay'),
('Isaac', 'Blank', 'Gray', 19, 'Laguna'),
('Zack', 'Blank', 'Matthews', 22, 'Cavite'),
('Finn', 'Blank', 'LAm', 25, 'Batangas');

UPDATE students
SET first_name = 'Ivan', middle_name = 'Ingram', last_name = 'Howard', age = 25, location = 'Bulacan'
WHERE id = 1;

DELETE FROM students
WHERE id = 6;

--so dito yung - Alternative, if the ID of the last record is unknown
--pag katapos -- DELETE FROM students
--after that -- WHERE id = (SELECT max(id) FROM students);

--para ma display yung count of all students
SELECT COUNT(*) FROM students;

--mapili lahat lahat students located in Manila
SELECT * FROM students WHERE location = 'Manila';

--ilabas yung average age of all students
SELECT AVG(age) FROM students;

--ilabas ang mga students by age, descending order
SELECT * FROM students ORDER by age DESC;

DROP TABLE students

CREATE TABLE research_papers (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id),
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'E', 'F') OR grade IS NULL)
);

-- pag katapos ay ito naman - Already deleted the 6th student (line 22). Student IDs in students table are 1, 2, 3, 4, 5.
INSERT INTO research_papers (student_id, grade) VALUES
(1, 'A'),
(1, NULL), -- 1 of 2 students with an ungraded research paper
(2, 'C'),
(2, 'D'), -- 1 of 2 students with more than 1 research paper
(3, 'F'), -- One research paper only
(4, 'B'), -- One research paper only
(4, NULL), -- 2 of 2 students with an ungraded research paper
(5, 'B'),
(5, 'C'); -- 2 of 2 students with more than 1 research paper

SELECT s.first_name, s.last_name, COUNT(rp.id) AS number_of_research_papers
FROM students s
JOIN research_papers rp ON s.id = rp.student_id
GROUP BY s.id
HAVING COUNT(rp.id) > 1;

SELECT s.first_name, s.last_name, rp.id AS research_paper_id, rp.grade
FROM students s
JOIN research_papers rp ON s.id = rp.student_id
WHERE rp.grade IS NULL;

DROP TABLE research_papers