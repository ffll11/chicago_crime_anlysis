CREATE TABLE chicago_crime (
    id BIGINT PRIMARY KEY,
    case_number VARCHAR(20),
    date_occurrence TIMESTAMP,
    block VARCHAR(100),
    iucr VARCHAR(10),
    primary_type VARCHAR(100),
    description VARCHAR(255),
    location_description VARCHAR(255),
    arrest BOOLEAN,
    domestic BOOLEAN,
    beat VARCHAR(10),
    district VARCHAR(10),
    ward INTEGER,
    community_area INTEGER,
    fbi_code VARCHAR(10),
    x_coordinate DOUBLE PRECISION,
    y_coordinate DOUBLE PRECISION,
    year INTEGER,
    updated_on TIMESTAMP,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    location VARCHAR(100)
);

SET datestyle TO 'ISO, MDY';

COPY chicago_crime
FROM '/chicago_crime.csv' 
DELIMITER ',' 
CSV HEADER;