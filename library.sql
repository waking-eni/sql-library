if exists(select 1 from sys.sysforeignkey where role='FK_IZNAJMLJ_KNJIGA_JE_KNJIGA') then
    alter table IZNAJMLJUJE
       delete foreign key FK_IZNAJMLJ_KNJIGA_JE_KNJIGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_IZNAJMLJ_KORISNIK__KORISNIK') then
    alter table IZNAJMLJUJE
       delete foreign key FK_IZNAJMLJ_KORISNIK__KORISNIK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KNJIGA_KNJIGA_PR_KATEGORI') then
    alter table KNJIGA
       delete foreign key FK_KNJIGA_KNJIGA_PR_KATEGORI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KNJIGA_KNJIGU_JE_IZDAVAC') then
    alter table KNJIGA
       delete foreign key FK_KNJIGA_KNJIGU_JE_IZDAVAC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KNJIGA_KNJIGU_JE_AUTOR') then
    alter table KNJIGA
       delete foreign key FK_KNJIGA_KNJIGU_JE_AUTOR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KORISNIK_KORISNIK__KATEGORI') then
    alter table KORISNIK
       delete foreign key FK_KORISNIK_KORISNIK__KATEGORI
end if;

if exists(
   select 1 from sys.systable 
   where table_name='AUTOR'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table AUTOR
end if;

if exists(
   select 1 from sys.systable 
   where table_name='IZDAVAC'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table IZDAVAC
end if;

if exists(
   select 1 from sys.systable 
   where table_name='IZNAJMLJUJE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table IZNAJMLJUJE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='KATEGORIJA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table KATEGORIJA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='KATEGORIJA_KORISNIKA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table KATEGORIJA_KORISNIKA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='KNJIGA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table KNJIGA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='KORISNIK'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table KORISNIK
end if;

/*==============================================================*/
/* Table: AUTOR                                                 */
/*==============================================================*/
create table AUTOR 
(
   IDAUTOR              char(3)                        not null,
   IMEAUTOR             varchar(10)                    null,
   PRZAUTOR             varchar(10)                    null,
   constraint PK_AUTOR primary key clustered (IDAUTOR)
);

/*==============================================================*/
/* Table: IZDAVAC                                               */
/*==============================================================*/
create table IZDAVAC 
(
   IDIZDAV              char(3)                        not null,
   IMEIZDAV             varchar(10)                    null,
   TELIZDAV             varchar(20)                    null,
   ADRIZDAV             varchar(30)                    null,
   EMAILIZDAV           varchar(30)                    null,
   constraint PK_IZDAVAC primary key clustered (IDIZDAV)
);

/*==============================================================*/
/* Table: IZNAJMLJUJE                                           */
/*==============================================================*/
create table IZNAJMLJUJE 
(
   IDKNJIG              char(3)                        null,
   IDKOR                char(3)                        null,
   DATIZD               date                           null,
   DATPOVR              date                           null
);

/*==============================================================*/
/* Table: KATEGORIJA                                            */
/*==============================================================*/
create table KATEGORIJA 
(
   IDKATEG              char(3)                        not null,
   constraint PK_KATEGORIJA primary key clustered (IDKATEG)
);

/*==============================================================*/
/* Table: KATEGORIJA_KORISNIKA                                  */
/*==============================================================*/
create table KATEGORIJA_KORISNIKA 
(
   IDKATKOR             char(3)                        not null,
   constraint PK_KATEGORIJA_KORISNIKA primary key clustered (IDKATKOR)
);

/*==============================================================*/
/* Table: KNJIGA                                                */
/*==============================================================*/
create table KNJIGA 
(
   IDKNJIG              char(3)                        not null,
   IDAUTOR              char(3)                        null,
   IDIZDAV              char(3)                        null,
   IDKATEG              char(3)                        null,
   NAZIV_KNJIGE         varchar(30)                    null,
   constraint PK_KNJIGA primary key clustered (IDKNJIG)
);

/*==============================================================*/
/* Table: KORISNIK                                              */
/*==============================================================*/
create table KORISNIK 
(
   IDKOR                char(3)                        not null,
   IDKATKOR             char(3)                        null,
   IMEKOR               varchar(10)                    null,
   PRZKOR               varchar(10)                    null,
   TELKOR               varchar(20)                    null,
   ADRKOR               varchar(30)                    null,
   EMAILKOR             varchar(30)                    null,
   constraint PK_KORISNIK primary key clustered (IDKOR)
);

alter table IZNAJMLJUJE
   add constraint FK_IZNAJMLJ_KNJIGA_JE_KNJIGA foreign key (IDKNJIG)
      references KNJIGA (IDKNJIG)
      on update restrict
      on delete restrict;

alter table IZNAJMLJUJE
   add constraint FK_IZNAJMLJ_KORISNIK__KORISNIK foreign key (IDKOR)
      references KORISNIK (IDKOR)
      on update restrict
      on delete restrict;

alter table KNJIGA
   add constraint FK_KNJIGA_KNJIGA_PR_KATEGORI foreign key (IDKATEG)
      references KATEGORIJA (IDKATEG)
      on update restrict
      on delete restrict;

alter table KNJIGA
   add constraint FK_KNJIGA_KNJIGU_JE_IZDAVAC foreign key (IDIZDAV)
      references IZDAVAC (IDIZDAV)
      on update restrict
      on delete restrict;

alter table KNJIGA
   add constraint FK_KNJIGA_KNJIGU_JE_AUTOR foreign key (IDAUTOR)
      references AUTOR (IDAUTOR)
      on update restrict
      on delete restrict;

alter table KORISNIK
   add constraint FK_KORISNIK_KORISNIK__KATEGORI foreign key (IDKATKOR)
      references KATEGORIJA_KORISNIKA (IDKATKOR)
      on update restrict
      on delete restrict;
