#!/bin/bash

SQLCMD=/opt/mssql-tools/bin/sqlcmd 

# Create the database from file
$SQLCMD -S sqlserver -U sa -P $SA_PASSWORD -d master -i /tmp/database.sql

# Create the user from file
$SQLCMD -S sqlserver -U sa -P $SA_PASSWORD -d master -i /tmp/user.sql

# Create schema from file
$SQLCMD -S sqlserver -U puchalski -P'password123' -d $DB_NAME -i /tmp/schema.sql

# Create tables from file
$SQLCMD -S sqlserver -U puchalski -P 'password123' -d $DB_NAME -i /tmp/table.sql
