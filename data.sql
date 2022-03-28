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

-- Insert data into the vets table.
INSERT INTO vets(name, age, date_of_graduation)
VALUES 
	('William Tatcher', 45, '2000-04-23'),
	('Maisy Smith', 26, '2019-01-17'),
	('Stephanie Mendez', 64, '1981-05-04'),
	('Jack Harkness', 38, '2008-06-08');

-- Insert data into the specializations table.
INSERT INTO specializations(vets_id, species_id) 
VALUES (1,1),(3,1),(3,2),(4,2);

-- Insert data into the visits table.
INSERT INTO visits (visit_date, animals_id, vets_id)
VALUES
	('2020-05-24', 1, 1), ('2020-07-22', 1, 3),
	('2021-02-02', 2, 4), ('2020-01-05', 3, 2),
	('2020-03-08', 3, 2), ('2020-05-14', 3, 2),
	('2021-05-04', 4, 3), ('2021-02-24', 5, 4),
	('2019-12-21', 6, 2), ('2020-08-10', 6, 1),
	('2021-04-07', 6, 2), ('2019-09-29', 7, 3),
	('2020-10-03', 8, 4), ('2020-11-04', 8, 4),
	('2019-01-24', 9, 2), ('2019-05-15', 9, 2),
	('2020-02-27', 9, 2), ('2020-08-03', 9, 2),
	('2020-05-24', 10, 3),('2021-01-11', 10, 1);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- Execution Time: 1186.029 ms
explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;