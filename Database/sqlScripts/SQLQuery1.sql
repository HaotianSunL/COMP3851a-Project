IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'COMP3851B')
  BEGIN
    CREATE DATABASE COMP3851B

    USE COMP3851B

	CREATE TABLE Staff(
		staffID					VARCHAR(8) PRIMARY KEY			NOT NULL,
		staffName				VARCHAR(50)						NOT NULL,
		staffPassword			VARCHAR(50)						NOT NULL,
		contentHistory			INT,
		staffAddress			VARCHAR(100),
		phone					INT								NOT NULL,
	)

	CREATE TABLE Content (
        contentCode				INT PRIMARY KEY IDENTITY (1, 1)	NOT NULL,
        staffID					VARCHAR(8)						NOT NULL,
		forumCode				INT								NOT NULL,
		contentType				VARCHAR(100)					NOT NULL,
		contentStatus			BIT	DEFAULT '0'					NOT NULL,	-- 0 is false = not on show, 1 = on showing
		scheduledStartDateTime	DateTime,
		scheduledEndDateTime	DateTime,
		postDateTime			DateTime,
		dropDateTime			DateTime,
		keywords				VARCHAR(100)					NOT NULL,
		contentDescription		TEXT,

		FOREIGN KEY (staffID) REFERENCES Staff (staffID)
			ON DELETE NO ACTION ON UPDATE NO ACTION
    )

	CREATE TABLE Content_text(
		contentCode				INT PRIMARY KEY					NOT NULL,
		textContent				TEXT							NOT NULL,

		FOREIGN KEY (contentCode) REFERENCES Content (contentCode)
			ON DELETE CASCADE ON UPDATE CASCADE 
	)

	CREATE TABLE Content_video(
		contentCode				INT PRIMARY KEY					NOT NULL,
		videoURL				TEXT							NOT NULL,

		FOREIGN KEY (contentCode) REFERENCES Content (contentCode)
			ON DELETE CASCADE ON UPDATE CASCADE 
	)

	CREATE TABLE Content_picture(
		contentCode				INT PRIMARY KEY					NOT NULL,
		pictureURL				TEXT							NOT NULL,

		FOREIGN KEY (contentCode) REFERENCES Content (contentCode)
			ON DELETE CASCADE ON UPDATE CASCADE 
	)

	CREATE TABLE Content_text(
		contentCode				INT PRIMARY KEY					NOT NULL,
		hyperlinkURL			TEXT							NOT NULL,

		FOREIGN KEY (contentCode) REFERENCES Content (contentCode)
			ON DELETE CASCADE ON UPDATE CASCADE 
	)

	/*
	CREATE TABLE StaffContent (
		staffID					VARCHAR(8)						NOT NULL,
		contentCode				INT								NOT NULL,

		FOREIGN KEY (staffID) REFERENCES Staff (staffID)
			ON DELETE NO ACTION ON UPDATE NO ACTION,
		FOREIGN KEY (contentCode) REFERENCES Content(contentCode)
			ON DELETE NO ACTION ON UPDATE NO ACTION,

		PRIMARY KEY (staffID, contentCode)
	)
	*/

	CREATE TABLE Forum(
		forumCode				VARCHAR(8)						NOT NULL,
		forumName				VARCHAR(50)						NOT NULL,
		currentContentID		INT,

		FOREIGN KEY (currentContentID) REFERENCES Content(contentCode)
			ON DELETE NO ACTION ON UPDATE NO ACTION
	)
  END