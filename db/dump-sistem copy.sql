-- Create a new database called 'stream'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'stream'
)
CREATE DATABASE stream
GO


CREATE TABLE [stream.user] (
    user_id integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
    username varchar(40) not null,
    password varchar(255) not null,
    created_at datetime not null,
    update_at datetime not null default CURRENT_TIMESTAMP
)

create table [stream.user_account] (
    account_id integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id integer not null,
    first_name varchar(45) not null,
    last_name varchar(255) not null,
    email varchar(255) not null,
    created_at datetime not null,
    update_at datetime not null default CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) references [stream.user](user_id) on delete cascade on update no action
);

create table [stream.stream] (
    stream_id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name varchar(50) not null,
    brand_image varchar(255) null,
    url varchar(255) null,
    created_at datetime not null default CURRENT_TIMESTAMP,
    updated_at datetime not null default CURRENT_TIMESTAMP
)

CREATE TABLE [stream.stream_account] (
    stream_account_id INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
    stream_id integer not null,
    CONSTRAINT fk_stream_id FOREIGN KEY (stream_id) references [stream.stream](stream_id) on delete cascade on update no action
)
