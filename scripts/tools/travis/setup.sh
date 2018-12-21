#!/bin/bash
# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

set -ev

if [ $DB = 'mysql' ]; then

    # Tweak some mysql settings for LIGERO.
    sudo su - <<MODIFY_MYSQL_CONFIG
cat - <<MYSQL_CONFIG >> /etc/mysql/my.cnf
[mysqld]
max_allowed_packet   = 24M
innodb_log_file_size = 256M
MYSQL_CONFIG
MODIFY_MYSQL_CONFIG
    sudo service mysql restart
    mysql -e "SHOW VARIABLES LIKE 'max_allowed_packet';"
    mysql -e "SHOW VARIABLES LIKE 'innodb_log_file_size';"

    # Now create LIGERO specific users and databases.
    cp -i $TRAVIS_BUILD_DIR/scripts/tools/travis/Config.mysql.pm $TRAVIS_BUILD_DIR/Kernel/Config.pm

    mysql -uroot -e "CREATE DATABASE ligero CHARACTER SET utf8";
    mysql -uroot -e "GRANT ALL PRIVILEGES ON ligero.* TO 'ligero'@'localhost' IDENTIFIED BY 'ligero'";
    mysql -uroot -e "CREATE DATABASE ligerotest CHARACTER SET utf8";
    mysql -uroot -e "GRANT ALL PRIVILEGES ON ligerotest.* TO 'ligerotest'@'localhost' IDENTIFIED BY 'ligerotest'";
    mysql -uroot -e "FLUSH PRIVILEGES";
    mysql -uroot ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-schema.mysql.sql
    mysql -uroot ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-initial_insert.mysql.sql
    mysql -uroot ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-schema-post.mysql.sql
fi

if [ $DB = 'postgresql' ]; then
    cp -i $TRAVIS_BUILD_DIR/scripts/tools/travis/Config.postgresql.pm $TRAVIS_BUILD_DIR/Kernel/Config.pm

    psql -U postgres -c "CREATE ROLE ligero LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE"
    psql -U postgres -c "CREATE DATABASE ligero OWNER ligero ENCODING 'UTF8'"
    psql -U postgres -c "CREATE ROLE ligerotest LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE"
    psql -U postgres -c "CREATE DATABASE ligerotest OWNER ligerotest ENCODING 'UTF8'"
    psql -U ligero ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-schema.postgresql.sql > /dev/null
    psql -U ligero ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-initial_insert.postgresql.sql > /dev/null
    psql -U ligero ligero < $TRAVIS_BUILD_DIR/scripts/database/ligero-schema-post.postgresql.sql > /dev/null
    psql -U postgres -c "ALTER ROLE ligero PASSWORD 'ligero'"
    psql -U postgres -c "ALTER ROLE ligerotest PASSWORD 'ligerotest'"
fi
