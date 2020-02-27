-- Drop foreign keys referencing ACCOUNT
alter table PLAYER_CHARACTER
    drop foreign key CHAR_ACC_Email_fk;
alter table CHAR_WEAPON
    drop foreign key CHAR_WEAPON_ACC_Email_fk;
alter table CHAR_ARMOR
    drop foreign key CHAR_ARMOR_ACC_Email_fk;
alter table QUEST_COUNTER
    drop foreign key QUEST_COUNTER_ACC_Email_fk;
alter table KILL_COUNTER
    drop foreign key KILL_COUNTER_ACC_Email_fk;
drop table if exists ACCOUNT;
-- Drop foreign keys referencing LOCATION
alter table PLAYER_CHARACTER
    drop foreign key CHAR_LOC_LocID_fk;
drop table if exists LOCATION ;
-- Drop foreign keys referencing CHARACTER
alter table CHAR_WEAPON
    drop foreign key CHAR_WEAPON_CHAR_Name_fk;
alter table CHAR_ARMOR
    drop foreign key CHAR_ARMOR_CHAR_Name_fk;
alter table QUEST_COUNTER
    drop foreign key QUEST_COUNTER_CHAR_Name_fk;
alter table KILL_COUNTER
    drop foreign key KILL_COUNTER_CHAR_Name_fk;
drop table if exists PLAYER_CHARACTER;
-- Drop foreign keys referencing CONSUMABLE
alter table MOB
    drop foreign key MOB_CONSUME_Drop_fk;
alter table QUEST
    drop foreign key QUEST_CONSUME_Collect_fk;
drop table if exists CONSUMABLE;
-- Drop foreign keys referencing MOB
alter table QUEST
    drop foreign key QUEST_MOB_Kill_fk;
alter table KILL_COUNTER
    drop foreign key KILL_COUNTER_MOB_ID;
drop table if exists MOB;
-- Drop foreign keys referencing QUEST
alter table QUEST_COUNTER
    drop foreign key QUEST_COUNTER_QUEST_ID_fk;
drop table if exists QUEST;
drop table if exists NPC;
-- Drop foreign keys referencing ARMOR
alter table CHAR_ARMOR
    drop foreign key CHAR_ARMOR_ARMOR_ID_fk;
drop table if exists ARMOR;
-- Drop foreign keys referencing WEAPON
alter table CHAR_WEAPON
    drop foreign key CHAR_WEAPON_WEAPON_ID_fk;
drop table if exists WEAPON;
drop table if exists CHAR_WEAPON;
drop table if exists CHAR_ARMOR;
drop table if exists QUEST_COUNTER;
drop table if exists KILL_COUNTER;

create table ACCOUNT
(
	Email varchar(50) not null check (Email like '%_@__%.__%'),
	First_Name varchar(15) not null,
	Last_Name varchar(15) null,
	Time_Played time default '000:00:00' not null,
	Num_Character tinyint unsigned default 0 not null,
	constraint ACCOUNT_pk
		primary key (Email)
);

create table LOCATION
(
	Location_ID varchar(30) not null,
	Rec_Loc_Lvl tinyint unsigned default 1 not null,
	Location_Name varchar(30) not null,
	constraint LOCATION_pk
		primary key (Location_ID)
);

create table PLAYER_CHARACTER
(
	ACC_Email varchar(50) not null,
	Character_Name varchar(30) not null,
	Class varchar(7) not null
        check (Class in ('Warrior', 'Mage', 'Thief')),
	Experience int unsigned default 0 not null,
	Health int unsigned not null,
	Strength int unsigned not null,
	Magika int unsigned not null,
	Money int unsigned default 100 not null,
	Playtime time default '000:00:00' not null,
	LOC_Location_ID varchar(30) default 'StartingZone' not null,
	constraint CHARACTER_pk
		primary key (ACC_Email, Character_Name),
	index name (Character_Name),
	constraint CHAR_ACC_Email_fk
		foreign key (ACC_Email) references ACCOUNT (Email)
			on update cascade on delete cascade,
	constraint CHAR_LOC_LocID_fk
		foreign key (LOC_Location_ID) references LOCATION (Location_ID)
			on update cascade on delete cascade
);

create table CONSUMABLE
(
	Item_ID varchar(20) not null,
	Item_Desc text not null,
	Heal_Total int signed null,
	Str_Buff int signed null,
	Magic_Buff int signed null,
	Item_Duration time null,
	Item_Cost mediumint unsigned null,
	constraint CONSUMABLE_pk
		primary key (Item_ID)
);

create table MOB
(
	Mob_ID varchar(20) not null,
	Mob_Name varchar(30) not null,
	Mob_Health smallint unsigned not null,
	Money_Drop mediumint unsigned not null,
	Exp_Drop int unsigned not null,
	Drop_ID varchar(20) not null,
	constraint MOB_pk
		primary key (Mob_ID),
	constraint MOB_CONSUME_Drop_fk
		foreign key (Drop_ID) references CONSUMABLE (Item_ID)
			on update cascade on delete cascade
);

create table QUEST
(
	Quest_ID varchar(30) not null,
	Quest_Name tinytext not null,
	Money_Given mediumint unsigned not null,
	Rec_Quest_Lvl tinyint unsigned not null,
	Exp_Given int unsigned not null,
	Mobs_to_Kill varchar(20) not null,
	Items_to_Collect varchar(20) not null,
	Quest_Type varchar(7) not null
        check (Quest_Type in ('Slay', 'Collect')),
	constraint QUEST_pk
		primary key (Quest_ID),
	constraint QUEST_CONSUME_Collect_fk
		foreign key (Items_to_Collect) references CONSUMABLE (Item_ID)
			on update cascade on delete cascade,
	constraint QUEST_MOB_Kill_fk
		foreign key (Mobs_to_Kill) references MOB (Mob_ID)
			on update cascade on delete cascade
);

create table NPC
(
	NPC_ID varchar(20) not null,
	NPC_Name varchar(20) not null,
	NPC_Type varchar(10) not null,
	constraint NPC_pk
		primary key (NPC_ID)
);

create table ARMOR
(
	Armor_ID varchar(30) not null,
	A_Health_Given int signed not null,
	A_Magic_Given int signed null,
	A_Strength_Given int signed null,
	Armor_Cost mediumint unsigned not null,
	Armor_Name tinytext not null,
	constraint ARMOR_pk
		primary key (Armor_ID)
);

create table WEAPON
(
	Weapon_ID varchar(30) not null,
	W_Strength_Given int signed null,
	W_Magic_Given int signed null,
	Weapon_Type varchar(9) not null
	    check (Weapon_Type in ('Staff', 'Wand', 'Dagger', 'Sword', 'Longsword')),
	Weapon_Name tinytext not null,
	Weapon_Cost mediumint unsigned not null,
	constraint WEAPON_pk
		primary key (Weapon_ID)
);

create table CHAR_WEAPON
(
    ACC_Email varchar(50) not null,
    CHAR_Name varchar(30) not null,
    WEAPON_ID varchar(30) not null,
    constraint CHAR_WEAPON_pk
        primary key (ACC_Email, CHAR_Name, WEAPON_ID),
    constraint CHAR_WEAPON_ACC_Email_fk
        foreign key (ACC_Email) references ACCOUNT (Email)
            on update cascade on delete cascade,
    constraint CHAR_WEAPON_CHAR_Name_fk
        foreign key (CHAR_Name) references PLAYER_CHARACTER (Character_Name)
            on update cascade on delete cascade,
    constraint CHAR_WEAPON_WEAPON_ID_fk
        foreign key (WEAPON_ID) references WEAPON (Weapon_ID)
            on update cascade on delete cascade
);

create table CHAR_ARMOR
(
	ACC_Email varchar(50) not null,
	CHAR_Name varchar(30) not null,
	ARMOR_ID varchar(30) not null,
	constraint CHAR_ARMOR_pk
		primary key (ACC_Email, CHAR_Name, ARMOR_ID),
	constraint CHAR_ARMOR_ACC_Email_fk
		foreign key (ACC_Email) references ACCOUNT (Email)
			on update cascade on delete cascade,
	constraint CHAR_ARMOR_ARMOR_ID_fk
		foreign key (ARMOR_ID) references ARMOR (Armor_ID)
			on update cascade on delete cascade,
	constraint CHAR_ARMOR_CHAR_Name_fk
		foreign key (CHAR_Name) references PLAYER_CHARACTER (Character_Name)
			on update cascade on delete cascade
);

create table QUEST_COUNTER
(
    ACC_Email varchar(50) not null,
    CHAR_Name varchar(30) not null,
    QUEST_ID varchar(30) not null,
    Completed boolean not null default false,
    constraint QUEST_COUNTER_pk
        primary key (ACC_Email, CHAR_Name, QUEST_ID),
    constraint QUEST_COUNTER_ACC_Email_fk
        foreign key (ACC_Email) references ACCOUNT (Email)
            on update cascade on delete cascade,
    constraint QUEST_COUNTER_CHAR_Name_fk
        foreign key (CHAR_Name) references PLAYER_CHARACTER (Character_Name)
            on update cascade on delete cascade,
    constraint QUEST_COUNTER_QUEST_ID_fk
        foreign key (QUEST_ID) references QUEST(Quest_ID)
            on update cascade on delete cascade
);

create table KILL_COUNTER
(
    ACC_Email varchar(50) not null,
    CHAR_Name varchar(30) not null,
    MOB_ID varchar(20) not null,
    C_Kill_M_Counter mediumint unsigned default 0 not null,
    M_Kill_C_Counter mediumint unsigned default 0 not null,
    constraint KILL_COUNTER_pk
        primary key (ACC_Email, CHAR_Name, MOB_ID),
    constraint KILL_COUNTER_ACC_Email_fk
        foreign key (ACC_Email) references ACCOUNT (Email)
            on update cascade on delete cascade,
    constraint KILL_COUNTER_CHAR_Name_fk
        foreign key (CHAR_Name) references PLAYER_CHARACTER (Character_Name)
            on update cascade on delete cascade,
    constraint KILL_COUNTER_MOB_ID
        foreign key (MOB_ID) references MOB (Mob_ID)
            on update cascade on delete cascade
);