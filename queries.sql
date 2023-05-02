/*QUERY THAT FINDS Find all animals whose name ends in "mon".*/

SELECT * FROM animals WHERE name LIKE '%mon';
/*Query that List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/*Query that List the name of all animals that are neutered and have less than 3 escape attempts..*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/*Query that List the date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth 
FROM animals 
WHERE name = 'Agumon' OR name = 'Pikachu';

/*....... OR USE THESE CODES........*/
SELECT date_of_birth 
FROM animals 
WHERE name IN ('Agumon', 'Pikachu');


/*Query that List name and escape attempts of animals that weigh more than 10.5kg.*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Query that FindS all animals that are neutered.*/
SELECT * FROM animals WHERE neutered = true;

/*Query that FindS all animals not named Gabumon..*/
SELECT * FROM animals
WHERE name != 'Gabumon';

/*Query that Finds all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*Query for Rolling Back the species column changes*/
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;




/*Update the animals table by setting the species column to "digimon" for all animals that have a name ending in "mon":*/
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;
/*UUpdate the animals table by setting the species column to "pokemon" for all animals that don't have species already set::*/
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


/*Removing and bringing back all the records with help of transaction::*/
BEGIN;
TRUNCATE TABLE animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
/*Using save point to undo changes done after it have been created*/

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*Returning number of animals which are there   [THEY ARE 10 ANIMALS IN THE TABLE(10)]*/
SELECT COUNT(*) FROM animals;

/*Returning number of animals which haven't tried to escape   [THEY ARE 2 ANIMALS WHICH HAVE NOT ESCAPED(2)]*/
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/*showing avarage weight of animals*/
SELECT AVG(weight_kg) FROM animals;

/*showing avarage weight of animals*/
SELECT AVG(weight_kg) FROM animals;

/* Query to determine who escapes the most between neutered and non neutered animals in the table of animals*/
SELECT neutered, SUM(escape_attempts) AS total_escapes
FROM animals
GROUP BY neutered;

/* showing max and min numbers of weights between two species of animals*/
SELECT species, max(weight_kg), min(weight_kg) from animals GROUP BY species;


/* showing average of escape_attempts of type of animals which born  between 1900 and 200*/
SELECT species, AVG(escape_attempts)  from animals WHERE date_of_birth BETWEEN BETWEEN '1990-01-01' AND '2000-12-31;









