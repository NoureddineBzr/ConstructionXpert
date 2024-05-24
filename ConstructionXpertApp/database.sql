CREATE DATABASE constructionxpert;



CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(id) on delete cascade
);


CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10, 2)
);

use constructionxpert;
CREATE TABLE resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    quantity INT,
    task_id INT,
    FOREIGN KEY (task_id) REFERENCES tasks(id) on delete cascade

);
