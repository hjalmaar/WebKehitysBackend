DROP DATABASE IF EXISTS HealthDiary;
CREATE DATABASE HealthDiary;
USE HealthDiary;

-- Create a table for users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_level VARCHAR(10) NOT NULL DEFAULT 'regular'
);

-- Create a table for diary entries
CREATE TABLE DiaryEntries (
    entry_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    entry_date DATE NOT NULL,
    mood VARCHAR(50),
    weight DECIMAL(5,2),
    sleep_hours INT,
    notes TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create a table for activities
CREATE TABLE Activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    activity_date DATE NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    duration_minutes INT NOT NULL,
    intensity VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create a table for meals
CREATE TABLE Meals (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    meal_date DATE NOT NULL,
    meal_type VARCHAR(50) NOT NULL,
    description TEXT,
    calories INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- INSERT User sample data
-- Iserting multiple user rows at once
INSERT INTO Users (username, password, email, user_level) VALUES
  ('johndoe', 'temp-pw-1', 'johndoe@example.com', 'regular'),
  ('janedoe', 'temp-pw-2', 'janedoe@example.com', 'admin'),
  ('mike_smith', 'temp-pw-3', 'mike@example.com', 'moderator');


-- Inserting multiple diary entries
INSERT INTO DiaryEntries (user_id, entry_date, mood, weight, sleep_hours, notes, created_at) VALUES
  (1, '2024-01-10', 'Happy', 70.5, 8, 'Had a great day, felt energetic', '2024-01-10 20:00:00'),
  (1, '2024-01-11', 'Tired', 70.2, 6, 'Long day at work, need rest', '2024-01-11 20:00:00'),
  (2, '2024-01-10', 'Stressed', 65.0, 7, 'Busy day, a bit stressed out', '2023-12-10 21:00:00');

INSERT INTO Activities (user_id, activity_date, activity_type, duration_minutes, intensity) VALUES
  (1, '2024-02-01', 'Running', 30, 'High'),
  (1, '2024-02-02', 'Cycling', 45, 'Medium'),
  (2, '2024-02-01', 'Yoga', 60, 'Low'),
  (3, '2024-02-03', 'Swimming', 30, 'High');

-- Inserting a single activity record
INSERT INTO Activities (user_id, activity_date, activity_type, duration_minutes, intensity) VALUES
  (2, '2024-02-04', 'Hiking', 120, 'Medium');


-- Example queries
SELECT Users.username, DiaryEntries.entry_date, DiaryEntries.mood, DiaryEntries.notes
  FROM Users, DiaryEntries
  WHERE DiaryEntries.user_id = Users.user_id;

-- Same with JOIN
SELECT Users.username, DiaryEntries.entry_date, DiaryEntries.mood, DiaryEntries.notes
  FROM Users JOIN DiaryEntries ON DiaryEntries.user_id = Users.user_id;

-- Entries for specific username
SELECT entry_date, mood, sleep_hours FROM DiaryEntries
  JOIN Users ON DiaryEntries.user_id = Users.user_id
  WHERE username = 'johndoe';

-- Update user's email
UPDATE Users SET email='newemail@example.com' WHERE username='johndoe';

-- Delete an entry from DiaryEntries
DELETE FROM DiaryEntries WHERE entry_id=1;

-- Query to get average sleep hours for a user
SELECT AVG(sleep_hours) AS average_sleep FROM DiaryEntries WHERE user_id=1;
