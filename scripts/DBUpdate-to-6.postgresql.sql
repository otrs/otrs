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
