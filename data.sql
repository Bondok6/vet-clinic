/* Populate database with sample data. */

INSERT INTO animals (name,  date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
	('Agumon', '2020-02-03', 10.23, TRUE, 0),
	('Gabumon', '2018-11-15', 8, TRUE, 2),
	('Pikachu', '2021-01-07', 15.4, FALSE, 1),
	('Devimon', '2017-05-12', 11, TRUE, 5);


INSERT INTO animals (name,  date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
	('Charmander', '2020-02-08', -11, FALSE, 0),
	('Plantmon', '2021-11-15', -5.7, TRUE, 2),
	('Squirtle', '1993-06-02', -12.13, FALSE, 3),
	('Angemon', '2005-06-12', -45, TRUE, 1),
	('Boarmon', '2005-06-07', 20.4, TRUE, 7),
	('Blossom', '1998-10-13', 17, TRUE, 3),
	('Ditto', '2022-05-14', 22, TRUE, 4);

-- Insert data into the owners table.
INSERT INTO owners (full_name, age)
VALUES 
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 54),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

-- Insert data into the species table.
INSERT INTO species(name) VALUES ('Pokemon'), ('Digimon');

/* 
Modify inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
*/
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Modify inserted animals to include owner information (owner_id).
UPDATE animals SET owner_id = 1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');