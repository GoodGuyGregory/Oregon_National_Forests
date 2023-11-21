-- Create Schema for Graduate_Project
create schema graduate_project

-- create the permits table
create table graduate_project.permits (
    permit_id smallserial constraint permit_key primary key,
    pass_name varchar(50),
    state_coverage text,
    cost double precision
);

-- created the national_forest table
create table graduate_project.national_forest(
    forest_id serial constraint forest_key primary key,
    state varchar(2),
    acerage integer,
    phone_num integer,
    address varchar(150),
    website varchar(250),
    annual_visitors integer,
    permits_id smallserial references graduate_project.permits (permit_id)
);

create table graduate_project.forest_region(
    forest_region_id smallserial constraint forest_region_key primary key,
    direction varchar(10)
);

create table graduate_project.wilderness_areas (
    wilderness_id serial constraint wilderness_key primary key,
    forest_key serial references graduate_project.national_forest (forest_id),
    wilderness_name varchar(50),
    forest_region_key smallserial references graduate_project.forest_region (forest_region_id),
    acerage numeric(20,2)
);

create table graduate_project.lakes_reservoir(
    lake_id smallserial constraint lake_id primary key,
    lake_name varchar(50),
    man_made smallint CHECK (lakes_reservoir.man_made >= 0 AND lakes_reservoir.man_made <= 1),
    water_reservoir smallint CHECK (lakes_reservoir.water_reservoir >= 0 AND lakes_reservoir.water_reservoir <= 1),
    swimming_allowed smallint CHECK (lakes_reservoir.swimming_allowed >= 0 AND lakes_reservoir.swimming_allowed <= 1),
    boats_allowed smallint CHECK (lakes_reservoir.boats_allowed >= 0 AND lakes_reservoir.boats_allowed <= 1),
    fishing_allowed smallint CHECK (lakes_reservoir.fishing_allowed >= 0 AND lakes_reservoir.fishing_allowed <= 1),
    forest_key serial references graduate_project.national_forest (forest_id),
    forest_region_key smallserial references  graduate_project.forest_region (forest_region_id)
);

create table graduate_project.mountains(
    mountain_id smallserial constraint mountain_id primary key,
    forest_key serial references graduate_project.national_forest (forest_id),
    elevation integer,
    climbing_season text,
    climbing_permit smallint CHECK (mountains.climbing_permit >= 0 AND mountains.climbing_permit <= 1),
    wilderness_key serial references graduate_project.wilderness_areas (wilderness_id)
);

create table graduate_project.recreation_site(
    recreation_id smallint constraint recreation_id primary key,
    forest_key serial references graduate_project.national_forest (forest_id),
    amenities text,
    address text,
    state varchar(2),
    city varchar(25),
    phone_number integer,
    website text,
    wilderness_key serial references graduate_project.wilderness_areas (wilderness_id),
    closest_town text,
    parking_on_site smallint CHECK (recreation_site.parking_on_site >= 0 AND recreation_site.parking_on_site <= 1)

);


create table graduate_project.campgrounds(
    campground_id serial constraint campground_id primary key,
    forest_id serial references graduate_project.national_forest (forest_id),
    camp_name varchar(150),
    amenities text,
    rating real,
    cancellation_policy text,
    max_consecutive_stay interval,
    website text,
    tent_site double precision,
    holiday_premium double precision,
    cabin_site double precision,
    electric_options smallint,
    closest_wilderness_area serial references  graduate_project.wilderness_areas (wilderness_id),
    cabin_options smallint,
    state varchar(2),
    city varchar(25),
    address text,
    phone_number integer
);

create table graduate_project.trails (
    trail_id serial constraint trail_id primary key,
    trail_name varchar(50),
    distance_round_trip real,
    rating real,
    elevation_gain integer,
    difficulty integer,
    kid_friendly smallint CHECK (trails.kid_friendly >= 0 AND trails.kid_friendly <= 1),
    dog_friendly smallint check (trails.dog_friendly >= 0 AND trails.dog_friendly <= 1),
    season text,
    wild_flowers smallint check (trails.wild_flowers >= 0 and trails.wild_flowers <= 1),
    views smallint check (trails.views >= 0 and trails.views <= 1),
    waterfalls smallint check (trails.waterfalls >= 0 and trails.waterfalls <= 1),
    historical_interest smallint check (trails.historical_interest >= 0 and trails.historical_interest <= 1),
    good_on_cloudy_days smallint check (trails.good_on_cloudy_days  >= 0 and trails.good_on_cloudy_days <= 1),
    winter smallint check (trails.winter >= 0 and trails.winter <= 1),
    permit text,
    notes text,
    GPS text,
    forest_id  serial references graduate_project.national_forest (forest_id),
    wilderness_id integer references  graduate_project.wilderness_areas (wilderness_id)
);