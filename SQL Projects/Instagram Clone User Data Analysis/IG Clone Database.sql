-- Create Database
CREATE DATABASE ig_clone;
USE ig_clone;

-- Users Table
CREATE TABLE users(
	id INT IDENTITY(1,1) PRIMARY KEY,
	username VARCHAR(255) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Photos Table
CREATE TABLE photos(
	id INT IDENTITY(1,1) PRIMARY KEY,
	image_url VARCHAR(355) NOT NULL,
	user_id INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_user_id_photos FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Comments Table
CREATE TABLE comments(
	id INT IDENTITY(1,1) PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_user_id_comments FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT fk_photo_id_comments FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- Likes Table
CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_user_id_likes FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT fk_photo_id_likes FOREIGN KEY(photo_id) REFERENCES photos(id),
	CONSTRAINT pk_user_id_photo_id_likes PRIMARY KEY(user_id,photo_id)
);

-- Follows Table
CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_follower_id_follows FOREIGN KEY (follower_id) REFERENCES users(id),
	CONSTRAINT fk_followee_id_follows FOREIGN KEY (followee_id) REFERENCES users(id),
	CONSTRAINT pk_follower_id_followee_id_follows PRIMARY KEY(follower_id,followee_id)
);

-- Tags Table
CREATE TABLE tags(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Junction Table: Photos - Tags
CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	CONSTRAINT fk_photo_id_photo_tags FOREIGN KEY(photo_id) REFERENCES photos(id),
	CONSTRAINT fk_tag_id_photo_tags FOREIGN KEY(tag_id) REFERENCES tags(id),
	CONSTRAINT pk_photo_id_tag_id_photo_tags PRIMARY KEY(photo_id,tag_id)
);