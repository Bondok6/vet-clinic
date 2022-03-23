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