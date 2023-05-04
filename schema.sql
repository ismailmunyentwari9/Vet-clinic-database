/* Add new schema for database table */
CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL(10,2)
);
/* modify schema for database table by adding species column*/
ALTER TABLE animals
ADD COLUMN species VARCHAR(250);

-- create owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(250),
    age INTEGER
);

-- create species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(250)
);

-- Add species_id as foreign key to animals table
ALTER table animals ADD COLUMN species_id int, FOREIGN KEY (species_id) REFERENCES species(id);

-- Add owner_id as foreign key to animals table
ALTER table animals ADD COLUMN owner_id int, FOREIGN KEY (owner_id) REFERENCES owners(id);

--Create a table named vets
create table vets
(id SERIAL PRIMARY key,name VARCHAR (255)
,age int,date_of_graduation date);

--Create table specialization
CREATE TABLE specialization(id SERIAL PRIMARY key, vet_id int, FOREIGN key(vet_id) REFERENCES vets(id),species_id int, FOREIGN key(species_id) REFERENCES species(id));

--create visits table 
CREATE TABLE visits(id SERIAL PRIMARY KEY,animal_id int,FOREIGN KEY(animal_id) REFERENCES animals(id), vet_id int, FOREIGN KEY(vet_id) REFERENCES vets(id), visit_date date);

