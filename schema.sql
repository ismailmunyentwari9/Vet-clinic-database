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

