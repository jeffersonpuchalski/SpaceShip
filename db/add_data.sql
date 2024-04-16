USE stream;

INSERT INTO [stream.user](username, password, created_at) VALUES ("admin", "jf12j124jkh124hjgghjk12", (SELECT GETDATE()))