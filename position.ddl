/* We want to define a data type for a 3D vector first */
/* Language: SQL */
/* Dialect: PostgreSQL */

/* We need a DDL for a 3D point */
drop database if exists "particle_state";
create database "particle_state";
drop schema if exists "point_schema" cascade;
create schema "point_schema" authorization user_name;



create table point3D();

alter table point3D add column id serial;
alter table point3D add constraint pk_point3D primary key (id);
alter table point3D add column kernel_id serial;
alter table point3D add column data real[3];



/* Assign the owner of the table to the current user */
alter table point3D owner to current_user;

/* Create roles */
create role head_kernel;
create role compute_kernel;
create role operators;

/* Assign privileges */
grant select on point3D to head_kernel;
grant select, insert, update, delete on point3D to compute_kernel;
grant select, insert, update, delete on point3D to operators;

alter table point3D enable row level security;
-- grant select on point3D to head_kernel;
-- grant select, insert, update, delete on point3D to compute_kernel;
-- grant select, insert, update, delete on point3D to operators;
create policy head_kernel_policy on point3D to head_kernel using (true) with check (true);
create policy compute_kernel_policy on point3D to compute_kernel using (true) with check (true);
create policy operators_policy on point3D to operators using (true) with check (true);

/* After we are done with the DDL, we can define the data type */
revoke all on point3D from public;