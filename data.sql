/* Add First Group Of Annimals */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03', 10.23, true, 0),
       ('Gabumon', '2018-11-15', 8, true, 2),
       ('Pikachu', '2021-01-07', 15.04, false, 1),
       ('Devimon', '2017-05-12', 11, true, 5);

/* Add Second Group Of Annimals */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
('Charmander', '2020-02-08', 0, false, -11, NULL),
('Plantmon', '2021-11-15', 2, true, -5.7, NULL),
('Squirtle', '1993-04-02', 3, false, -12.13, NULL),
('Angemon', '2005-06-12', 1, true, -45, NULL),
('Boarmon', '2005-06-07', 7, true, 20.4, NULL),
('Blossom', '1998-10-13', 3, true, 17, NULL),
('Ditto', '2022-05-14', 4, true, 22, NULL);

-- Add data to owners table
INSERT into owners(full_name,age) 
VALUES('Sam Smith', 34),
      ('Jennifer Orwell', 19),
      ('Bob', 45),
      ('Melody Pond', 77), 
      ('Dean Winchester',14),
      ('Jodie Whittaker', 39);

-- Add data to owners table
INSERT into species(name)
VALUES('Pokemon'),
      ('Digimon');

-- Add species_id
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END;

  -- update animals with owner_id based on owner name
UPDATE animals
SET owner_id = CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  END ;






                                   