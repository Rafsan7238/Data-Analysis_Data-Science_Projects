CREATE Database murder;
USE murder;

-- Table structure for table crime_scene_report
--

DROP TABLE IF EXISTS crime_scene_report;

CREATE TABLE crime_scene_report (
  date int DEFAULT NULL,
  type varchar(9) DEFAULT NULL,
  description text,
  city varchar(17) DEFAULT NULL
);

--
-- Table structure for table drivers_license
--

DROP TABLE IF EXISTS drivers_license;

CREATE TABLE drivers_license (
  id int DEFAULT NULL,
  age tinyint DEFAULT NULL,
  height tinyint DEFAULT NULL,
  eye_color varchar(5) DEFAULT NULL,
  hair_color varchar(6) DEFAULT NULL,
  gender varchar(6) DEFAULT NULL,
  plate_number varchar(6) DEFAULT NULL,
  car_make varchar(13) DEFAULT NULL,
  car_model varchar(23) DEFAULT NULL
);

--
-- Table structure for table facebook_event_checkin
--

DROP TABLE IF EXISTS facebook_event_checkin;

CREATE TABLE facebook_event_checkin (
  person_id int DEFAULT NULL,
  event_id smallint DEFAULT NULL,
  event_name varchar(80) DEFAULT NULL,
  date int DEFAULT NULL
);

--
-- Table structure for table get_fit_now_check_in
--

DROP TABLE IF EXISTS get_fit_now_check_in;

CREATE TABLE get_fit_now_check_in (
  membership_id varchar(5) DEFAULT NULL,
  check_in_date int DEFAULT NULL,
  check_in_time smallint DEFAULT NULL,
  check_out_time smallint DEFAULT NULL
);

--
-- Table structure for table get_fit_now_member
--

DROP TABLE IF EXISTS get_fit_now_member;

CREATE TABLE get_fit_now_member (
  id varchar(5) DEFAULT NULL,
  person_id int DEFAULT NULL,
  name varchar(20) DEFAULT NULL,
  membership_start_date int DEFAULT NULL,
  membership_status varchar(7) DEFAULT NULL
);

--
-- Table structure for table income
--

DROP TABLE IF EXISTS income;

CREATE TABLE income (
  ssn int DEFAULT NULL,
  annual_income int DEFAULT NULL
);

--
-- Table structure for table interview
--

DROP TABLE IF EXISTS interview;

CREATE TABLE interview (
  person_id int DEFAULT NULL,
  transcript varchar(241) DEFAULT NULL
);

--
-- Table structure for table person
--

DROP TABLE IF EXISTS person;

CREATE TABLE person (
  id int DEFAULT NULL,
  name varchar(23) DEFAULT NULL,
  license_id int DEFAULT NULL,
  address_number smallint DEFAULT NULL,
  address_street_name varchar(28) DEFAULT NULL,
  ssn int DEFAULT NULL
);

DROP TABLE IF EXISTS solution;

CREATE TABLE solution (
  usr varchar(1) DEFAULT NULL,
  value varchar(1) DEFAULT NULL
);

-- Insert data from temporary tables using SQL Import Wizard --

INSERT INTO crime_scene_report
SELECT * FROM crime_temp;
DROP TABLE crime_temp;

INSERT INTO drivers_license
SELECT * FROM license;
DROP TABLE license;

INSERT INTO facebook_event_checkin
SELECT * FROM fb;
DROP TABLE fb;

INSERT INTO get_fit_now_check_in
SELECT * FROM gf;
DROP TABLE gf;

INSERT INTO get_fit_now_member
SELECT * FROM gf;
DROP TABLE gf;

INSERT INTO income
SELECT * FROM inc;
DROP TABLE inc;

INSERT INTO interview
SELECT * FROM inter;
DROP TABLE inter;

INSERT INTO person
SELECT * FROM per;
DROP TABLE per;

-- SCHEMA COMPLETED -- 