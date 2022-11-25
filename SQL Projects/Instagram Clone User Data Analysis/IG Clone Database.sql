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

-- Value Insertion
INSERT INTO users (username, created_at) VALUES ('Kenton_Kirlin', '2017-02-16 18:22:10.846'), ('Andre_Purdy85', '2017-04-02 17:11:21.417'), ('Harley_Lind18', '2017-02-21 11:12:32.574'), ('Arely_Bogan63', '2016-08-13 01:28:43.085'), ('Aniya_Hackett', '2016-12-07 01:04:39.298'), ('Travon.Waters', '2017-04-30 13:26:14.496'), ('Kasandra_Homenick', '2016-12-12 06:50:07.996'), ('Tabitha_Schamberger11', '2016-08-20 02:19:45.512'), ('Gus93', '2016-06-24 19:36:30.978'), ('Presley_McClure', '2016-08-07 16:25:48.561'), ('Justina.Gaylord27', '2017-05-04 16:32:15.577'), ('Dereck65', '2017-01-19 01:34:14.296'), ('Alexandro35', '2017-03-29 17:09:02.344'), ('Jaclyn81', '2017-02-06 23:29:16.394'), ('Billy52', '2016-10-05 14:10:20.453'), ('Annalise.McKenzie16', '2016-08-02 21:32:45.646'), ('Norbert_Carroll35', '2017-02-06 22:05:43.425'), ('Odessa2', '2016-10-21 18:16:56.390'), ('Hailee26', '2017-04-29 18:53:39.650'), ('Delpha.Kihn', '2016-08-31 02:42:30.288'), ('Rocio33', '2017-01-23 11:51:15.467'), ('Kenneth64', '2016-12-27 09:48:17.380'), ('Eveline95', '2017-01-23 23:14:18.569'), ('Maxwell.Halvorson', '2017-04-18 02:32:43.597'), ('Tierra.Trantow', '2016-10-03 12:49:20.774'), ('Josianne.Friesen', '2016-06-07 12:47:00.703'), ('Darwin29', '2017-03-18 03:10:07.047'), ('Dario77', '2016-08-18 07:15:02.823'), ('Jaime53', '2016-09-11 18:51:56.965'), ('Kaley9', '2016-09-23 21:24:20.222'), ('Aiyana_Hoeger', '2016-09-29 20:28:12.457'), ('Irwin.Larson', '2016-08-26 19:36:22.199'), ('Yvette.Gottlieb91', '2016-11-14 12:32:01.405'), ('Pearl7', '2016-07-08 21:42:00.982'), ('Lennie_Hartmann40', '2017-03-30 03:25:21.937'), ('Ollie_Ledner37', '2016-08-04 15:42:20.322'), ('Yazmin_Mills95', '2016-07-27 00:56:44.310'), ('Jordyn.Jacobson2', '2016-05-14 07:56:25.835'), ('Kelsi26', '2016-06-08 17:48:08.478'), ('Rafael.Hickle2', '2016-05-19 09:51:25.779'), ('Mckenna17', '2016-07-17 17:25:44.855'), ('Maya.Farrell', '2016-12-11 18:04:45.344'), ('Janet.Armstrong', '2016-10-06 07:57:44.491'), ('Seth46', '2016-07-07 11:40:26.557'), ('David.Osinski47', '2017-02-05 21:23:37.392'), ('Malinda_Streich', '2016-07-09 21:37:07.610'), ('Harrison.Beatty50', '2016-09-02 03:48:38.340'), ('Granville_Kutch', '2016-06-26 03:10:22.202'), ('Morgan.Kassulke', '2016-10-30 12:42:31.387'), ('Gerard79', '2016-08-23 19:47:44.102'), ('Mariano_Koch3', '2017-04-17 14:14:45.662'), ('Zack_Kemmer93', '2017-01-01 05:58:22.276'), ('Linnea59', '2017-02-07 07:49:33.830'), ('Duane60', '2016-12-21 04:43:37.761'), ('Meggie_Doyle', '2017-04-04 12:17:33.931'), ('Peter.Stehr0', '2016-08-22 18:05:42.167'), ('Julien_Schmidt', '2017-02-02 23:12:48.451'), ('Aurelie71', '2016-05-31 06:20:56.909'), ('Cesar93', '2016-10-18 16:42:43.220'), ('Sam52', '2017-03-30 22:03:45.159'), ('Jayson65', '2016-10-14 19:10:52.564'), ('Ressie_Stanton46', '2016-12-20 15:09:08.721'), ('Elenor88', '2016-05-08 01:30:40.677'), ('Florence99', '2016-10-06 23:08:30.626'), ('Adelle96', '2016-10-01 00:37:57.429'), ('Mike.Auer39', '2016-07-01 17:36:14.714'), ('Emilio_Bernier52', '2016-05-06 13:04:29.960'), ('Franco_Keebler64', '2016-11-13 20:09:26.855'), ('Karley_Bosco', '2016-06-24 23:38:52.138'), ('Erick5', '2017-04-05 23:44:47.060'), ('Nia_Haag', '2016-05-14 15:38:50.230'), ('Kathryn80', '2016-10-11 09:01:56.764'), ('Jaylan.Lakin', '2016-06-10 23:58:52.210'), ('Hulda.Macejkovic', '2017-01-25 17:17:27.717'), ('Leslie67', '2016-09-21 05:14:01.207'), ('Janelle.Nikolaus81', '2016-07-21 09:26:09.466'), ('Donald.Fritsch', '2017-01-07 10:05:41.165'), ('Colten.Harris76', '2016-10-10 02:38:52.941'), ('Katarina.Dibbert', '2016-11-03 13:14:10.647'), ('Darby_Herzog', '2016-05-06 00:14:21.191'), ('Esther.Zulauf61', '2017-01-14 17:02:33.511'), ('Aracely.Johnston98', '2016-07-25 18:49:09.996'), ('Bartholome.Bernhard', '2016-11-06 02:31:23.463'), ('Alysa22', '2017-01-01 17:44:42.980'), ('Milford_Gleichner42', '2017-04-30 07:50:51.280'), ('Delfina_VonRueden68', '2017-03-21 12:02:14.358'), ('Rick29', '2017-02-24 11:25:08.160'), ('Clint27', '2016-06-02 21:40:09.555'), ('Jessyca_West', '2016-09-14 23:47:04.780'), ('Esmeralda.Mraz57', '2017-03-03 11:52:27.469'), ('Bethany20', '2016-06-03 23:31:53.322'), ('Frederik_Rice', '2016-07-06 21:56:28.654'), ('Willie_Leuschke', '2017-02-15 01:40:53.310'), ('Damon35', '2016-10-31 14:44:27.239'), ('Nicole71', '2016-05-09 17:30:22.371'), ('Keenan.Schamberger60', '2016-08-28 14:57:28.221'), ('Tomas.Beatty93', '2017-02-11 11:38:55.026'), ('Imani_Nicolas17', '2017-01-31 22:59:34.108'), ('Alek_Watsica', '2016-12-10 07:43:58.083'), ('Javonte83', '2017-03-27 22:06:37.433');