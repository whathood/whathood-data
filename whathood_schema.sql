--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: neighborhood; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE neighborhood (
    id integer NOT NULL,
    region_id integer NOT NULL,
    name character varying(255) NOT NULL,
    no_build_border boolean,
    date_time_added character varying(255) NOT NULL
);


--
-- Name: neighborhood_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE neighborhood_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: neighborhood_polygon; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE neighborhood_polygon (
    id integer NOT NULL,
    neighborhood_id integer NOT NULL,
    polygon geometry NOT NULL,
    created_at timestamp(0) with time zone NOT NULL
);


--
-- Name: COLUMN neighborhood_polygon.polygon; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN neighborhood_polygon.polygon IS '(DC2Type:geometry)';


--
-- Name: neighborhood_polygon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE neighborhood_polygon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: region; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE region (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    parent_id integer,
    roleid character varying(255) DEFAULT NULL::character varying
);


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_np; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE up_np (
    up_id integer NOT NULL,
    np_id integer NOT NULL
);


--
-- Name: user_polygon; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_polygon (
    id integer NOT NULL,
    neighborhood_id integer NOT NULL,
    region_id integer NOT NULL,
    whathood_user_id integer NOT NULL,
    date_time_added character varying(255) NOT NULL,
    polygon geometry(Polygon) NOT NULL,
    is_deleted boolean
);


--
-- Name: COLUMN user_polygon.polygon; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN user_polygon.polygon IS '(DC2Type:polygon)';


--
-- Name: user_polygon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_polygon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255) DEFAULT NULL::character varying,
    email character varying(255) NOT NULL,
    displayname character varying(50) DEFAULT NULL::character varying,
    password character varying(128) NOT NULL,
    state integer NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


--
-- Name: whathood_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE whathood_user (
    id integer NOT NULL,
    ip_address character varying(255) NOT NULL
);


--
-- Name: whathood_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE whathood_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: neighborhood_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY neighborhood
    ADD CONSTRAINT neighborhood_pkey PRIMARY KEY (id);


--
-- Name: neighborhood_polygon_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY neighborhood_polygon
    ADD CONSTRAINT neighborhood_polygon_pkey PRIMARY KEY (id);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: up_np_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY up_np
    ADD CONSTRAINT up_np_pkey PRIMARY KEY (up_id, np_id);


--
-- Name: user_polygon_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_polygon
    ADD CONSTRAINT user_polygon_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: whathood_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY whathood_user
    ADD CONSTRAINT whathood_user_pkey PRIMARY KEY (id);


--
-- Name: idx_50b466a6121f828f; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_50b466a6121f828f ON up_np USING btree (np_id);


--
-- Name: idx_50b466a652f241c; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_50b466a652f241c ON up_np USING btree (up_id);


--
-- Name: idx_51498a8ea76ed395; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_51498a8ea76ed395 ON users_roles USING btree (user_id);


--
-- Name: idx_51498a8ed60322ac; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_51498a8ed60322ac ON users_roles USING btree (role_id);


--
-- Name: idx_57698a6a727aca70; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_57698a6a727aca70 ON role USING btree (parent_id);


--
-- Name: idx_9a443078803bb24b; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_9a443078803bb24b ON neighborhood_polygon USING btree (neighborhood_id);


--
-- Name: idx_9fa93f185219ebcc; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_9fa93f185219ebcc ON user_polygon USING btree (whathood_user_id);


--
-- Name: idx_9fa93f18803bb24b; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_9fa93f18803bb24b ON user_polygon USING btree (neighborhood_id);


--
-- Name: idx_9fa93f1898260155; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_9fa93f1898260155 ON user_polygon USING btree (region_id);


--
-- Name: idx_fef1e9ee98260155; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_fef1e9ee98260155 ON neighborhood USING btree (region_id);


--
-- Name: idx_neighborhood_polygon_polygon; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_neighborhood_polygon_polygon ON neighborhood_polygon USING gist (polygon);


--
-- Name: idx_up_np_pair; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX idx_up_np_pair ON up_np USING btree (np_id, up_id);


--
-- Name: idx_user_polygon_polygon; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_user_polygon_polygon ON user_polygon USING gist (polygon);


--
-- Name: name_region_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX name_region_idx ON neighborhood USING btree (name, region_id);


--
-- Name: region_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX region_name_idx ON region USING btree (name);


--
-- Name: uniq_1483a5e9e7927c74; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX uniq_1483a5e9e7927c74 ON users USING btree (email);


--
-- Name: uniq_1483a5e9f85e0677; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX uniq_1483a5e9f85e0677 ON users USING btree (username);


--
-- Name: uniq_57698a6ab8c2fd88; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX uniq_57698a6ab8c2fd88 ON role USING btree (roleid);


--
-- Name: uniq_9e2afb1622ffd58c; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX uniq_9e2afb1622ffd58c ON whathood_user USING btree (ip_address);


--
-- Name: fk_50b466a6121f828f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY up_np
    ADD CONSTRAINT fk_50b466a6121f828f FOREIGN KEY (np_id) REFERENCES neighborhood_polygon(id);


--
-- Name: fk_50b466a652f241c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY up_np
    ADD CONSTRAINT fk_50b466a652f241c FOREIGN KEY (up_id) REFERENCES user_polygon(id);


--
-- Name: fk_51498a8ea76ed395; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_roles
    ADD CONSTRAINT fk_51498a8ea76ed395 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_51498a8ed60322ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users_roles
    ADD CONSTRAINT fk_51498a8ed60322ac FOREIGN KEY (role_id) REFERENCES role(id);


--
-- Name: fk_57698a6a727aca70; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role
    ADD CONSTRAINT fk_57698a6a727aca70 FOREIGN KEY (parent_id) REFERENCES role(id);


--
-- Name: fk_9a443078803bb24b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY neighborhood_polygon
    ADD CONSTRAINT fk_9a443078803bb24b FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id);


--
-- Name: fk_9fa93f185219ebcc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_polygon
    ADD CONSTRAINT fk_9fa93f185219ebcc FOREIGN KEY (whathood_user_id) REFERENCES whathood_user(id);


--
-- Name: fk_9fa93f18803bb24b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_polygon
    ADD CONSTRAINT fk_9fa93f18803bb24b FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id);


--
-- Name: fk_9fa93f1898260155; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_polygon
    ADD CONSTRAINT fk_9fa93f1898260155 FOREIGN KEY (region_id) REFERENCES region(id);


--
-- Name: fk_fef1e9ee98260155; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY neighborhood
    ADD CONSTRAINT fk_fef1e9ee98260155 FOREIGN KEY (region_id) REFERENCES region(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

