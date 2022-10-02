-- CREATE USER ${db_admin}@'localhost' IDENTIFIED BY ${db_admin_pass};
-- CREATE USER ${db_user}@'localhost' IDENTIFIED BY ${db_pass};

-- CREATE DATABASE ${db_name};

-- GRANT ALL PRIVILEGES ON ${db_name}.* TO ${db_admin}@"localhost";


-- FLUSH PRIVILEGES;

-- exit

CREATE USER "admin"@'localhost' IDENTIFIED BY "admin_password";
CREATE USER "user"@'localhost' IDENTIFIED BY "password";

CREATE DATABASE wordpress;

GRANT ALL PRIVILEGES ON wordpress.* TO "admin"@"localhost";


FLUSH PRIVILEGES;

