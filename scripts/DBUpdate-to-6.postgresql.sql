-- ----------------------------------------------------------
--  driver: postgresql
-- ----------------------------------------------------------
SET standard_conforming_strings TO ON;
-- ----------------------------------------------------------
--  create table dynamic_field_obj_id_name
-- ----------------------------------------------------------
CREATE TABLE dynamic_field_obj_id_name (
    object_id serial NOT NULL,
    object_name VARCHAR (200) NOT NULL,
    object_type VARCHAR (200) NOT NULL,
    PRIMARY KEY(object_id),
    CONSTRAINT dynamic_field_object_name UNIQUE (object_name, object_type)
);
-- ----------------------------------------------------------
--  create table sysconfig_default
-- ----------------------------------------------------------
CREATE TABLE sysconfig_default (
    id serial NOT NULL,
    name VARCHAR (250) NOT NULL,
    description TEXT NOT NULL,
    navigation VARCHAR (200) NOT NULL,
    is_invisible SMALLINT NOT NULL,
    is_readonly SMALLINT NOT NULL,
    is_required SMALLINT NOT NULL,
    is_valid SMALLINT NOT NULL,
    has_configlevel SMALLINT NOT NULL,
    user_modification_possible SMALLINT NOT NULL,
    user_modification_active SMALLINT NOT NULL,
    user_preferences_group VARCHAR (250) NULL,
    xml_content_raw TEXT NOT NULL,
    xml_content_parsed TEXT NOT NULL,
    xml_filename VARCHAR (250) NOT NULL,
    effective_value TEXT NOT NULL,
    is_dirty SMALLINT NOT NULL,
    exclusive_lock_guid VARCHAR (32) NOT NULL,
    exclusive_lock_user_id INTEGER NULL,
    exclusive_lock_expiry_time timestamp(0) NULL,
    create_time timestamp(0) NOT NULL,
    create_by INTEGER NOT NULL,
    change_time timestamp(0) NOT NULL,
    change_by INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT sysconfig_default_name UNIQUE (name)
);
-- ----------------------------------------------------------
--  create table sysconfig_default_version
-- ----------------------------------------------------------
CREATE TABLE sysconfig_default_version (
    id serial NOT NULL,
    sysconfig_default_id INTEGER NULL,
    name VARCHAR (250) NOT NULL,
    description TEXT NOT NULL,
    navigation VARCHAR (200) NOT NULL,
    is_invisible SMALLINT NOT NULL,
    is_readonly SMALLINT NOT NULL,
    is_required SMALLINT NOT NULL,
    is_valid SMALLINT NOT NULL,
    has_configlevel SMALLINT NOT NULL,
    user_modification_possible SMALLINT NOT NULL,
    user_modification_active SMALLINT NOT NULL,
    user_preferences_group VARCHAR (250) NULL,
    xml_content_raw TEXT NOT NULL,
    xml_content_parsed TEXT NOT NULL,
    xml_filename VARCHAR (250) NOT NULL,
    effective_value TEXT NOT NULL,
    create_time timestamp(0) NOT NULL,
    create_by INTEGER NOT NULL,
    change_time timestamp(0) NOT NULL,
    change_by INTEGER NOT NULL,
    PRIMARY KEY(id)
);
-- ----------------------------------------------------------
--  create table sysconfig_modified
-- ----------------------------------------------------------
CREATE TABLE sysconfig_modified (
    id serial NOT NULL,
    sysconfig_default_id INTEGER NOT NULL,
    name VARCHAR (250) NOT NULL,
    user_id INTEGER NULL,
    is_valid SMALLINT NOT NULL,
    user_modification_active SMALLINT NOT NULL,
    effective_value TEXT NOT NULL,
    reset_to_default SMALLINT NOT NULL,
    is_dirty SMALLINT NOT NULL,
    create_time timestamp(0) NOT NULL,
    create_by INTEGER NOT NULL,
    change_time timestamp(0) NOT NULL,
    change_by INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT sysconfig_modified_per_user UNIQUE (sysconfig_default_id, user_id)
);
-- ----------------------------------------------------------
--  create table sysconfig_modified_version
-- ----------------------------------------------------------
CREATE TABLE sysconfig_modified_version (
    id serial NOT NULL,
    sysconfig_default_version_id INTEGER NOT NULL,
    name VARCHAR (250) NOT NULL,
    user_id INTEGER NULL,
    is_valid SMALLINT NOT NULL,
    user_modification_active SMALLINT NOT NULL,
    effective_value TEXT NOT NULL,
    reset_to_default SMALLINT NOT NULL,
    create_time timestamp(0) NOT NULL,
    create_by INTEGER NOT NULL,
    change_time timestamp(0) NOT NULL,
    change_by INTEGER NOT NULL,
    PRIMARY KEY(id)
);
-- ----------------------------------------------------------
--  create table sysconfig_deployment_lock
-- ----------------------------------------------------------
CREATE TABLE sysconfig_deployment_lock (
    id serial NOT NULL,
    exclusive_lock_guid VARCHAR (32) NULL,
    exclusive_lock_user_id INTEGER NULL,
    exclusive_lock_expiry_time timestamp(0) NULL,
    PRIMARY KEY(id)
);
-- ----------------------------------------------------------
--  create table sysconfig_deployment
-- ----------------------------------------------------------
CREATE TABLE sysconfig_deployment (
    id serial NOT NULL,
    comments VARCHAR (250) NULL,
    user_id INTEGER NULL,
    effective_value TEXT NOT NULL,
    create_time timestamp(0) NOT NULL,
    create_by INTEGER NOT NULL,
    PRIMARY KEY(id)
);
CREATE INDEX dynamic_field_value_search_text ON dynamic_field_value (field_id, value_text);
ALTER TABLE gi_webservice_config DROP CONSTRAINT gi_webservice_config_config_md5;
-- ----------------------------------------------------------
--  alter table gi_webservice_config
-- ----------------------------------------------------------
ALTER TABLE gi_webservice_config DROP config_md5;
ALTER TABLE cloud_service_config DROP CONSTRAINT cloud_service_config_config_md5;
-- ----------------------------------------------------------
--  alter table cloud_service_config
-- ----------------------------------------------------------
ALTER TABLE cloud_service_config DROP config_md5;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_from TYPE VARCHAR;
ALTER TABLE article ALTER a_from DROP DEFAULT;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_reply_to TYPE VARCHAR;
ALTER TABLE article ALTER a_reply_to DROP DEFAULT;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_to TYPE VARCHAR;
ALTER TABLE article ALTER a_to DROP DEFAULT;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_cc TYPE VARCHAR;
ALTER TABLE article ALTER a_cc DROP DEFAULT;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_references TYPE VARCHAR;
ALTER TABLE article ALTER a_references DROP DEFAULT;
-- ----------------------------------------------------------
--  alter table article
-- ----------------------------------------------------------
ALTER TABLE article ALTER a_in_reply_to TYPE VARCHAR;
ALTER TABLE article ALTER a_in_reply_to DROP DEFAULT;
CREATE INDEX ticket_history_article_id ON ticket_history (article_id);
SET standard_conforming_strings TO ON;
ALTER TABLE sysconfig_default ADD CONSTRAINT FK_sysconfig_default_create_by_id FOREIGN KEY (create_by) REFERENCES users (id);
ALTER TABLE sysconfig_default ADD CONSTRAINT FK_sysconfig_default_change_by_id FOREIGN KEY (change_by) REFERENCES users (id);
ALTER TABLE sysconfig_default ADD CONSTRAINT FK_sysconfig_default_exclusive_lock_user_id_id FOREIGN KEY (exclusive_lock_user_id) REFERENCES users (id);
ALTER TABLE sysconfig_default_version ADD CONSTRAINT FK_sysconfig_default_version_sysconfig_default_id_id FOREIGN KEY (sysconfig_default_id) REFERENCES sysconfig_default (id);
ALTER TABLE sysconfig_default_version ADD CONSTRAINT FK_sysconfig_default_version_create_by_id FOREIGN KEY (create_by) REFERENCES users (id);
ALTER TABLE sysconfig_default_version ADD CONSTRAINT FK_sysconfig_default_version_change_by_id FOREIGN KEY (change_by) REFERENCES users (id);
ALTER TABLE sysconfig_modified ADD CONSTRAINT FK_sysconfig_modified_sysconfig_default_id_id FOREIGN KEY (sysconfig_default_id) REFERENCES sysconfig_default (id);
ALTER TABLE sysconfig_modified ADD CONSTRAINT FK_sysconfig_modified_user_id_id FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE sysconfig_modified ADD CONSTRAINT FK_sysconfig_modified_create_by_id FOREIGN KEY (create_by) REFERENCES users (id);
ALTER TABLE sysconfig_modified ADD CONSTRAINT FK_sysconfig_modified_change_by_id FOREIGN KEY (change_by) REFERENCES users (id);
ALTER TABLE sysconfig_modified_version ADD CONSTRAINT FK_sysconfig_modified_version_sysconfig_default_version_idaf FOREIGN KEY (sysconfig_default_version_id) REFERENCES sysconfig_default_version (id);
ALTER TABLE sysconfig_modified_version ADD CONSTRAINT FK_sysconfig_modified_version_user_id_id FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE sysconfig_modified_version ADD CONSTRAINT FK_sysconfig_modified_version_create_by_id FOREIGN KEY (create_by) REFERENCES users (id);
ALTER TABLE sysconfig_modified_version ADD CONSTRAINT FK_sysconfig_modified_version_change_by_id FOREIGN KEY (change_by) REFERENCES users (id);
ALTER TABLE sysconfig_deployment_lock ADD CONSTRAINT FK_sysconfig_deployment_lock_exclusive_lock_user_id_id FOREIGN KEY (exclusive_lock_user_id) REFERENCES users (id);
ALTER TABLE sysconfig_deployment ADD CONSTRAINT FK_sysconfig_deployment_user_id_id FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE sysconfig_deployment ADD CONSTRAINT FK_sysconfig_deployment_create_by_id FOREIGN KEY (create_by) REFERENCES users (id);
