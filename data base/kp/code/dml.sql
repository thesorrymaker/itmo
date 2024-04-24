create or replace function fill_user() returns setof "user" as $$
DECLARE
    i int = 0;
    names varchar(64)[] = array ['Peter','Bob','John','Tomas','Alex','Anna'];
BEGIN
    while i < 10 loop
            insert into "user"(name,gender,password,age) values (names[i%6+1],'MAN',random()*1000,28);
            i = i + 1;
        end loop;
    return query select * from "user" limit 5;
end;
$$ language plpgsql;
select fill_user();

create or replace function fill_support() returns setof Support_man as $$
    DECLARE
        i int = 0;
        names varchar(64)[] = array ['Peter','Bob','John','Tomas','Alex','Anna'];
    BEGIN
        while i < 10 loop
            insert into Support_man(password, name) VALUES (floor(random()*1000000),names[i%6+1]);
            i = i + 1;
            end loop;
        return query select * from Support_man limit 5;
    end;
    $$ language plpgsql;
select fill_support();
select count(*) from support_man;

create or replace function fill_problem() returns setof problem as $$
DECLARE
    i int = 0;
BEGIN
    while i < 10 loop
            insert into problem(user_id, support_man_id, description,is_finished, type) values (i%1000000 + 1,i%1000 + 1,'test test','true','BUGS');
            i = i + 1;
        end loop;
    return query select * from problem limit 5;
end;
$$ language plpgsql;
select fill_problem();

create or replace function fill_address() returns setof address as $$
DECLARE
    i int = 0;
    countries country[] = array ['US','UK','RUSSIAN','CHINA','FRANCE'];
    cities city[] = array ['Shanghai', 'Beijing', 'Shenzhen', 'Guangzhou', 'Chengdu','Paris', 'Marseille', 'Lyon', 'Toulouse','Cambridge', 'Edinburgh',  'London', 'Liverpool','New York', 'Los Angeles', 'Chicago', 'Boston'];
BEGIN
    while i < 10 loop
            insert into address(country, city, street) VALUES (countries[i%5+1],cities[i%17+1],'xx streest');
            i = i + 1;
        end loop;
    return query select * from address limit 5;
end;
$$ language plpgsql;
select fill_address();

create or replace function fill_house() returns setof address as $$
DECLARE
    i int = 0;
    houses house_type[] = array ['APARTMENTS', 'VILLAS', 'HIGH-END','ORDINARY'];
BEGIN
    while i < 10 loop
            insert into house(address_id, type) VALUES (i+1,houses[i%4+1]);
            i = i + 1;
        end loop;
    return query select * from address limit 5;
end;
$$ language plpgsql;
select fill_house();

create or replace function fill_room() returns setof address as $$
DECLARE
    i int = 0;
    rooms room_type[] = array ['KITCHEN','BEDROOM','BATHROOM','LIVING'];
BEGIN
    while i < 10 loop
            insert into room(house_id, square, height,type) VALUES (i+1,19,3,rooms[i%4+1]),
                                                                   (i+1,22,3,rooms[i%4+1]),
                                                                   (i+1,22,3,rooms[i%4+1]);
            i = i + 1;
        end loop;
    return query select * from address limit 5;
end;
$$ language plpgsql;
select fill_room();

create or replace function fill_furniture() returns setof furniture as $$
DECLARE
    i int = 0;
    ft furniture_type[] = array ['AIR_CONDITION','LIGHT', 'HUMIDIFIER', 'BATHTUB', 'OUTLET','CURTAINS', 'FAN', 'CAMERA', 'WATER_HEATER'];
BEGIN
    while i < 10 loop
            insert into furniture(room_id, manufacture, type) values (i+1,'xiaomi',ft[i%9+1]),(i+1,'xiaomi',ft[i%9+1]);
            i = i + 1;
        end loop;
    return query select * from furniture limit 5;
end;
$$ language plpgsql;
select fill_furniture();

create or replace function fill_action() returns setof action as $$
DECLARE
    i int = 0;
    ft furniture_type[] = array ['AIR_CONDITION','LIGHT', 'HUMIDIFIER', 'BATHTUB', 'OUTLET','CURTAINS', 'FAN', 'CAMERA', 'WATER_HEATER'];
BEGIN
    while i < 9 loop
            insert into action(type_furniture, type, description) values (ft[i%9+1],'TURN_ON','Test'),  (ft[i%9+1],'TURN_OFF','Test')
                                                                       ,  (ft[i%9+1],'SWITCH_OFF','Test'),  (ft[i%9+1],'SWITCH_OFF','Test');
            i = i + 1;
        end loop;
    return query select * from action limit 5;
end;
$$ language plpgsql;
select fill_action();

create or replace function fill_contact() returns setof contact as $$
DECLARE
    i int = 0;
BEGIN
    while i < 1000000 loop
            insert into contact(user_id, email, phone)  VALUES (i+1,to_char(i,'9999999')||'@gmail.com',to_char(i,'99999999')) ;
            i = i + 1;
        end loop;
    return query select * from contact limit 5;
end;
$$ language plpgsql;
select fill_contact();

create or replace function fill_script() returns setof script as $$
DECLARE
    i int = 0;
    st script_type [] = array ['CONDITIONAL','SCHEDULE'];
BEGIN
    while i < 10 loop
            if i < 5 then
                insert into script(creator_name, type)  VALUES ('Tom',st[1]) ;
            elsif i < 10 then
                insert into script(creator_name, type)  VALUES ('Tom',st[2]) ;
            end if;
            i = i + 1;
        end loop;
    return query select * from script limit 5;
end;
$$ language plpgsql;
select fill_script();

create or replace function fill_condition_script() returns setof condition_script as $$
DECLARE
    i int = 0;
BEGIN
    while i < 5 loop
            insert into condition_script(script_id, condition)  VALUES (i+1,'click button') ;
            i = i + 1;
        end loop;
    return query select * from condition_script limit 5;
end;
$$ language plpgsql;
select fill_condition_script();

create or replace function fill_schedule_script() returns setof schedule_script as $$
DECLARE
    i int = 0;
BEGIN
    while i < 5 loop
            insert into schedule_script(script_id, start_time,end_time)  VALUES (i+5000001,'8:00','9:00') ;
            i = i + 1;
        end loop;
    return query select * from schedule_script limit 5;
end;
$$ language plpgsql;
select fill_schedule_script();

create or replace function fill_list_action_script() returns setof list_action_script as $$
DECLARE
    i int = 0;
BEGIN
    while i < 10 loop
            insert into list_action_script(script_id, action_id) values (i+1,1),(i+1,2),(i+1,3);
            i = i + 1;
        end loop;
    return query select * from list_action_script limit 5;
end;
$$ language plpgsql;
select  fill_list_action_script();

create or replace function fill_list_user_house() returns setof list_user_house as $$
DECLARE
    i int = 0;
BEGIN
    while i < 10 loop
            insert into list_user_house(user_id, house_id) values (i + 1,i+1);
            i = i + 1;
        end loop;
    return query select * from list_user_house limit 5;
end;
$$ language plpgsql;
select  fill_list_user_house();

create or replace function fill_list_script_user() returns setof list_script_user as $$
DECLARE
    i int = 0;
BEGIN
    while i < 10 loop
            insert into list_script_user(user_id, script_id) values (i + 1,i*10+1),(i + 1,i*10+2),(i + 1,i*10+3),(i + 1,i*10+4),(i + 1,i*10+5),(i + 1,i*10+6),(i + 1,i*10+7),(i + 1,i*10+8),(i + 1,i*10+9),(i + 1,i*10+10);
            i = i + 1;
        end loop;
    return query select * from list_script_user limit 5;
end;
$$ language plpgsql;
select  fill_list_script_user();