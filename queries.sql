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
SELECT species, AVG(escape_attempts)  from animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31';


-- SELECT ANIMALS NAME BELONGS TO Melody Pond
SELECT animals.name,owners.full_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id= species.id WHERE species.name='Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

--How many animals are there per species?
SELECT species.name, COUNT(animals.id) AS num_animals
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS Animal_name, species.name as Species_name, owners.full_name as Owner_name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
INNER JOIN owners
ON animals.owner_id = owners.id where owners.full_name='Jennifer Orwell' AND species.name= 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name,owners.full_name,escape_attempts FROM 
animals INNER JOIN owners ON animals.owner_id= owners.id INNER JOIN
 species ON animals.species_id=species.id WHERE
  escape_attempts=0 AND owners.full_name='Dean Winchester';

  --Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) as animal_count
FROM owners
INNER JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY animal_count DESC
LIMIT 1;

--Who was the last animal seen by William Tatcher?
SELECT animals.name,visit_date 
FROM visits 
JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY visit_date DESC 
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialIties, including vets with no specialties.
SELECT vets.name,species.name from specialization
 RIGHT JOIN vets ON specialization.vet_id = vets.id
 INNER JOIN species ON specialization.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.


SELECT animals.name FROM visits 
JOIN animals ON visits.animal_id=animals.id
JOIN vets ON visits.vet_id=vets.id WHERE
 visit_date BETWEEN '2020-04-01' AND
  '2020-08-30' AND vets.name='Stephanie Mendez';
--What animal has the most visits to vets?
SELECT animals.name, COUNT(*) as num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.id
ORDER BY num_visits DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date from visits
JOIN animals ON visits.animal_id = animals.id
ORDER BY visit_date ASC
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
LEFT JOIN specialization ON vets.id = specialization.vet_id 
AND animals.species_id = specialization.species_id 
WHERE specialization.vet_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS specialty, COUNT(*) AS visits_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN species s ON a.species_id = s.id
JOIN specialization sp ON sp.species_id = s.id
JOIN vets vt ON v.vet_id = vt.id
WHERE a.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visits_count DESC
LIMIT 1;










