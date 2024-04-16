USE [master]

ALTER SERVER ROLE [sysadmin] ADD MEMBER [puchalski];
GRANT ALL ON DATABASE::Nasa TO [puchalski]
GO