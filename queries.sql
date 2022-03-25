/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * from animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals
WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Setting the species column to unspecified, then roll-back the change.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Setting the species column to 'digimon' for all animals that have a name ending in 'mon'.
-- Setting the species column to 'pokemon' for all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pekomon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Delete all records in the animals table, then roll-back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint.
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
*/

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT del;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO del;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.*
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name
FROM owners o
LEFT JOIN animals a ON a.owner_id = o.id; 

-- How many animals are there per species?
SELECT s.name, COUNT(*) 
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name
FROM owners o
JOIN animals a ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY COUNT(a.owner_id) DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON vets.id = v.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY v.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(a.name) FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON vets.id = v.vets_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name as specialties FROM vets v
LEFT JOIN specializations s ON v.id = s.vets_id
LEFT JOIN species sp ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON vets.id = v.vets_id
WHERE vets.name = 'Stephanie Mendez' AND (v.visit_date BETWEEN '2020-04-01' AND '2020-08-30');

-- What animal has the most visits to vets?
SELECT a.name FROM animals a
JOIN visits v ON a.id = v.animals_id
GROUP BY a.name
ORDER BY COUNT(a.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets ON vets.id = v.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY v.visit_date ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM animals a
JOIN visits v ON a.id = v.animals_id 
JOIN vets ON vets.id = v.vets_id
ORDER BY v.visit_date DESC;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(v.id) AS visits FROM vets
JOIN visits v ON vets.id = v.animals_id
LEFT JOIN specializations spec ON spec.species_id = vets.id
LEFT JOIN species ON species.id = spec.species_id
WHERE spec.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS species_name, COUNT(s.*) AS species_count FROM vets
JOIN visits v ON vets.id = v.vets_id
JOIN animals a ON a.id = v.animals_id
JOIN species s ON s.id = a.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(s.name) DESC LIMIT 1;
