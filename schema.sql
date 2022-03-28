/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(25),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY(id)
);

-- Add a column species of type string to animals table.
ALTER TABLE animals
ADD species VARCHAR(25);

-- Create a table named owners
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(50),
	age INT,
	PRIMARY KEY(id)
);

-- Create a table named species
CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(25),
	PRIMARY KEY (id)
);

-- Remove 'species' column from animals table.
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id);

-- Create a table named vets.
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(25),
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
);

-- Create a "join table" called specializations.
CREATE TABLE specializations (
	vets_id INT NOT NULL,
	species_id INT NOT NULL,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON UPDATE CASCADE,
	FOREIGN KEY (species_id) REFERENCES species (id) ON UPDATE CASCADE
);

-- Create a "join table" called visits to handle this relationship.
CREATE TABLE visits (
	id INT GENERATED ALWAYS AS IDENTITY,
	visit_date DATE NOT NULL,
	vets_id INT NOT NULL,
	animals_id INT NOT NULL,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON UPDATE CASCADE,
	FOREIGN KEY (animals_id) REFERENCES animals (id) ON UPDATE CASCADE,
	PRIMARY KEY (id)
);

-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons.
CREATE INDEX visits_animals_id_idx ON visits(animals_id);

-- Find a way to improve execution time of the other two queries.
CREATE INDEX visits_vets_id_idx ON visits(vets_id desc);

CREATE INDEX owners_email_idx ON owners(email);