prompt PL/SQL Developer Export Tables for user C##ELIAOU_HAIM@XE
prompt Created by eliao on dimanche 14 juillet 2024
set feedback off
set define off

prompt Creating NURSE...
create table NURSE
(
  nurse_name       VARCHAR2(30) not null,
  telephone_number INTEGER not null,
  nurse_id         INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table NURSE
  add primary key (NURSE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating PATIENT...
create table PATIENT
(
  patient_id   INTEGER not null,
  patient_name VARCHAR2(30) not null,
  sexe         VARCHAR2(30) not null,
  illness      VARCHAR2(100) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PATIENT
  add primary key (PATIENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating OPERATING_ROOM...
create table OPERATING_ROOM
(
  room_id           INTEGER not null,
  availability      VARCHAR2(12) default 'available' not null,
  max_number_people INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OPERATING_ROOM
  add primary key (ROOM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating OPERATION...
create table OPERATION
(
  operation_date     DATE not null,
  duration_operation INTEGER not null,
  operation_id       INTEGER not null,
  patient_id         INTEGER not null,
  room_id            INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OPERATION
  add primary key (OPERATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OPERATION
  add foreign key (PATIENT_ID)
  references PATIENT (PATIENT_ID);
alter table OPERATION
  add foreign key (ROOM_ID)
  references OPERATING_ROOM (ROOM_ID);

prompt Creating ASSIST_BY...
create table ASSIST_BY
(
  nurse_id     INTEGER not null,
  operation_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ASSIST_BY
  add primary key (NURSE_ID, OPERATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ASSIST_BY
  add foreign key (NURSE_ID)
  references NURSE (NURSE_ID);
alter table ASSIST_BY
  add foreign key (OPERATION_ID)
  references OPERATION (OPERATION_ID);

prompt Creating DOCTOR...
create table DOCTOR
(
  doctor_name VARCHAR2(30) not null,
  specialty   VARCHAR2(50) not null,
  doctor_id   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DOCTOR
  add primary key (DOCTOR_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DOCTOR
  add constraint UNIQ_DOCTOR_NAME unique (DOCTOR_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating EQUIPEMENT...
create table EQUIPEMENT
(
  equipement_id           INTEGER not null,
  equipment_purchase_date DATE not null,
  equipment_name          VARCHAR2(30) not null,
  equipment_status        VARCHAR2(30) not null,
  room_id                 INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPEMENT
  add primary key (EQUIPEMENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPEMENT
  add foreign key (ROOM_ID)
  references OPERATING_ROOM (ROOM_ID);

prompt Creating OPERATE_BY...
create table OPERATE_BY
(
  doctor_id    INTEGER not null,
  operation_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OPERATE_BY
  add primary key (DOCTOR_ID, OPERATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OPERATE_BY
  add foreign key (DOCTOR_ID)
  references DOCTOR (DOCTOR_ID);
alter table OPERATE_BY
  add foreign key (OPERATION_ID)
  references OPERATION (OPERATION_ID);

prompt Disabling triggers for NURSE...
alter table NURSE disable all triggers;
prompt Disabling triggers for PATIENT...
alter table PATIENT disable all triggers;
prompt Disabling triggers for OPERATING_ROOM...
alter table OPERATING_ROOM disable all triggers;
prompt Disabling triggers for OPERATION...
alter table OPERATION disable all triggers;
prompt Disabling triggers for ASSIST_BY...
alter table ASSIST_BY disable all triggers;
prompt Disabling triggers for DOCTOR...
alter table DOCTOR disable all triggers;
prompt Disabling triggers for EQUIPEMENT...
alter table EQUIPEMENT disable all triggers;
prompt Disabling triggers for OPERATE_BY...
alter table OPERATE_BY disable all triggers;
prompt Disabling foreign key constraints for OPERATION...
alter table OPERATION disable constraint SYS_C008496;
alter table OPERATION disable constraint SYS_C008497;
prompt Disabling foreign key constraints for ASSIST_BY...
alter table ASSIST_BY disable constraint SYS_C008508;
alter table ASSIST_BY disable constraint SYS_C008509;
prompt Disabling foreign key constraints for EQUIPEMENT...
alter table EQUIPEMENT disable constraint SYS_C008481;
prompt Disabling foreign key constraints for OPERATE_BY...
alter table OPERATE_BY disable constraint SYS_C008502;
alter table OPERATE_BY disable constraint SYS_C008503;
prompt Deleting OPERATE_BY...
delete from OPERATE_BY;
commit;
prompt Deleting EQUIPEMENT...
delete from EQUIPEMENT;
commit;
prompt Deleting DOCTOR...
delete from DOCTOR;
commit;
prompt Deleting ASSIST_BY...
delete from ASSIST_BY;
commit;
prompt Deleting OPERATION...
delete from OPERATION;
commit;
prompt Deleting OPERATING_ROOM...
delete from OPERATING_ROOM;
commit;
prompt Deleting PATIENT...
delete from PATIENT;
commit;
prompt Deleting NURSE...
delete from NURSE;
commit;
prompt Loading NURSE...
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Zevon  Eric', 533438067, 3600);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Brooke  Moe', 526247728, 3601);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mahoney  Mary-Louise', 531480785, 3602);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Briscoe  Ed', 536089594, 3603);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Northam  Rachael', 531038589, 3604);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Azaria  Joan', 529149505, 3605);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lizzy  Sigourney', 520778920, 3606);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ronstadt  Merle', 529822770, 3607);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Puckett  Edwin', 525320641, 3608);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Slater  Philip', 535607196, 3609);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mazar  Victoria', 521060217, 3610);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gleeson  Mena', 521884551, 3611);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Spader  Bo', 533545787, 3612);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Richardson  Azucar', 520539639, 3613);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Farrell  Doug', 529093133, 3614);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McIntyre  Peter', 528359152, 3615);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gallagher  Millie', 538923687, 3616);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kennedy  Terry', 537810436, 3617);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rawls  Minnie', 533426157, 3618);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sweet  Holly', 531428850, 3619);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ward  First', 522486321, 3620);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lipnicki  Rosario', 521259541, 3621);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Arden  Sydney', 527746372, 3622);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crimson  Juliet', 520778920, 3623);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wilson  Tamala', 525782982, 3624);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Davies  Giovanni', 531453475, 3625);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Malkovich  Michael', 533426157, 3626);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Harrelson  Anita', 522498119, 3627);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McKellen  Jonny Lee', 533426157, 3628);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Jenkins  George', 520182755, 3629);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mahood  Elle', 531428850, 3630);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sharp  Marie', 520778920, 3631);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gleeson  Davey', 524295145, 3632);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Isaak  Franco', 524910170, 3633);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Williamson  Gary', 528724031, 3634);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Tucci  Deborah', 529822770, 3635);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Biel  John', 523621296, 3636);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hector  Julianne', 535607196, 3637);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Theron  Todd', 530245800, 3638);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cassidy  Steve', 531038589, 3639);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Grant  Tobey', 521259541, 3640);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Harry  Burton', 529964027, 3641);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Downie  Ahmad', 521884551, 3642);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McIntosh  Randy', 522486321, 3643);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McPherson  Tcheky', 528076478, 3644);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Begley  Ronnie', 533426157, 3645);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Danes  Meryl', 526353601, 3646);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Garza  Stephen', 531453475, 3647);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Woodard  John', 521259541, 3648);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Baldwin  Hookah', 529149505, 3649);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Page  Geraldine', 531428850, 3650);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ratzenberger  Mandy', 521884551, 3651);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chung  Parker', 522498119, 3652);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Beals  Chi', 523621296, 3653);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pressly  Molly', 531961937, 3654);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stuart  Laura', 530245800, 3655);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hampton  Sigourney', 537810436, 3656);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Black  Miriam', 528724031, 3657);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ali  Sal', 524295145, 3658);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Miles  Julio', 525075779, 3659);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Harrison  Domingo', 525771007, 3660);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cocker  Miko', 533766598, 3661);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Frakes  Ali', 527983188, 3662);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rickman  Latin', 533545787, 3663);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dourif  Viggo', 537810436, 3664);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ruffalo  Eileen', 520539639, 3665);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stallone  Jeroen', 525782982, 3666);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ratzenberger  Lari', 533426157, 3667);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Yankovic  Rhea', 523679466, 3668);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McDowell  Beth', 520778920, 3669);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Beckham  Richard', 521932206, 3670);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gough  Jude', 531829125, 3671);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Parker  Aidan', 522749390, 3672);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Connelly  Judge', 531428850, 3673);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rourke  Ceili', 539040640, 3674);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rossellini  Leonardo', 529964027, 3675);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hall  Tommy', 520778920, 3676);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dickinson  Guy', 533438067, 3677);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hurt  Meg', 539040640, 3678);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sawa  Suzi', 527746372, 3679);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Brandt  Tracy', 520539639, 3680);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Avalon  CeCe', 531961937, 3681);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Curtis-Hall  Moe', 521932206, 3682);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('von Sydow  Debra', 527746372, 3683);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Manning  Eugene', 528076478, 3684);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chinlund  Mary', 528359152, 3685);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kurtz  Crispin', 538923687, 3686);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wine  Art', 521884551, 3687);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Neville  Daniel', 525771007, 3688);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Botti  Henry', 529822770, 3689);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('DeLuise  Gates', 539040640, 3690);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Zane  Anjelica', 525320641, 3691);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('LaMond  Rosanne', 522749390, 3692);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Uggams  Gavin', 528359152, 3693);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ponce  Mike', 520182755, 3694);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Assante  Marina', 531961937, 3695);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Van Helden  Brendan', 526353601, 3696);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Duchovny  Sheena', 525782982, 3697);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Carr  Neneh', 534236952, 3698);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Shandling  Casey', 531453475, 3699);
commit;
prompt 100 records committed...
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Meniketti  Patty', 535607196, 3700);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dale  Shelby', 526353601, 3701);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rhames  Hal', 529093133, 3702);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hutch  Andy', 521884551, 3703);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Trevino  Noah', 520778920, 3704);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Webb  Chrissie', 529149505, 3705);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Romijn-Stamos  Marley', 528076478, 3706);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Liu  Rosco', 520778920, 3707);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Piven  Whoopi', 534347608, 3708);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Geldof  Jake', 531480785, 3709);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Whitaker  Joseph', 531428850, 3710);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pearce  Rupert', 533545787, 3711);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Eckhart  Jerry', 522498119, 3712);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Henstridge  Leo', 538923687, 3713);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Schiff  Brenda', 529093133, 3714);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Carr  Belinda', 533426157, 3715);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crimson  Dick', 528076478, 3716);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Tah  Buffy', 520539639, 3717);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rea  Murray', 526247728, 3718);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('LaSalle  Miles', 529964027, 3719);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wincott  Aida', 535607196, 3720);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Berkoff  Carol', 529822770, 3721);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Neill  Franz', 520539639, 3722);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Saxon  Mickey', 531829125, 3723);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mazar  Kyle', 531038589, 3724);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hunter  King', 527746372, 3725);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Penders  Alex', 529964027, 3726);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mahood  Clay', 527746372, 3727);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Diaz  Bradley', 527983188, 3728);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chao  Bryan', 522749390, 3729);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('English  Nickel', 531961937, 3730);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Paxton  Devon', 528724031, 3731);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Evett  Gordie', 534347608, 3732);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Durning  Josh', 522498119, 3733);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McDowell  Nicky', 523679466, 3734);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stone  Nora', 535607196, 3735);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pullman  Latin', 520739321, 3736);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Broderick  Merillee', 529149505, 3737);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Waite  Brenda', 531480785, 3738);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dillon  Daniel', 528724031, 3739);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sledge  Jackson', 531829125, 3740);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dorn  Celia', 531428850, 3741);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Colon  Balthazar', 520778920, 3742);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Perry  Rutger', 523679466, 3743);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cassel  Bobbi', 525771007, 3744);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Domino  Ramsey', 520902098, 3745);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('LaSalle  Tara', 529093133, 3746);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dale  Fisher', 531480785, 3747);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Farrell  Spike', 522749390, 3748);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pesci  Joaquim', 521060217, 3749);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quatro  Kay', 536089594, 3750);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Weller  Lloyd', 521259541, 3751);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Arthur  Melba', 528359152, 3752);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kapanka  Peabo', 524295145, 3753);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quinones  Henry', 538923687, 3754);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Blades  Ceili', 525320641, 3755);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Williamson  Derrick', 531453475, 3756);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Fender  Suzanne', 529093133, 3757);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Levine  Liam', 527746372, 3758);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Forster  Mena', 523621296, 3759);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Almond  Curt', 524295145, 3760);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Spine  Nik', 526353601, 3761);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hauser  Vertical', 525771007, 3762);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cara  Jena', 528359152, 3763);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Moorer  Murray', 520778920, 3764);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cartlidge  Jonny Lee', 539040640, 3765);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Whitley  Willie', 534236952, 3766);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Piven  Ernest', 534236952, 3767);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Donovan  Diane', 522486321, 3768);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Miles  Max', 527983188, 3769);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Birch  Madeline', 526247728, 3770);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bullock  Christmas', 526353601, 3771);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quinones  Bill', 521884551, 3772);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rudd  Chanté', 522498119, 3773);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rain  Tracy', 520739321, 3774);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('LuPone  Burton', 527746372, 3775);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Del Toro  Petula', 521884551, 3776);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Schwarzenegger  Lonnie', 526353601, 3777);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Tisdale  Fiona', 531480785, 3778);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Grier  Ivan', 527746372, 3779);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('English  Kathleen', 533426157, 3780);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Holliday  Jimmy', 520739321, 3781);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lloyd  Colin', 529149505, 3782);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hayes  Madeline', 526353601, 3783);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sweeney  Percy', 538923687, 3784);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gore  Fats', 531480785, 3785);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bogguss  Kitty', 535607196, 3786);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McLachlan  Carlene', 531038589, 3787);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ranger  Forest', 522486321, 3788);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Alexander  King', 537810436, 3789);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rush  Isabella', 536089594, 3790);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Edmunds  Kiefer', 520182755, 3791);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Arnold  Jared', 520739321, 3792);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Weaving  Bob', 531453475, 3793);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Burns  Seann', 528359152, 3794);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cozier  Matthew', 528359152, 3795);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Heche  Raymond', 535607196, 3796);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McKennitt  Harry', 526353601, 3797);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Carrere  Liam', 531961937, 3798);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kershaw  Betty', 525771007, 3799);
commit;
prompt 200 records committed...
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Belushi  Rosco', 520182755, 3800);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Clinton  Andy', 522498119, 3801);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Almond  Lindsay', 524910170, 3802);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Balin  Aimee', 536089594, 3803);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Astin  Gran', 522749390, 3804);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Monk  Kay', 522486321, 3805);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('O''Keefe  Emma', 527983188, 3806);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Weir  Vern', 522498119, 3807);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bening  Betty', 528076478, 3808);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Keen  Kid', 530245800, 3809);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Danger  Halle', 521884551, 3810);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Arden  Daryle', 536089594, 3811);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Schiff  Jean', 533766598, 3812);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dutton  Samuel', 520539639, 3813);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Baranski  Guy', 523621296, 3814);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Glover  Bruce', 533545787, 3815);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Caan  Debby', 531038589, 3816);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kingsley  Ani', 521259541, 3817);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Furay  Campbell', 533438067, 3818);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Weiland  Bebe', 528076478, 3819);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Moffat  Marina', 529093133, 3820);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Webb  Ving', 531829125, 3821);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Howard  Fionnula', 520778920, 3822);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Howard  Hilton', 521060217, 3823);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Aglukark  Lee', 521060217, 3824);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cervine  Gord', 521259541, 3825);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Osment  Nanci', 531480785, 3826);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Culkin  Anna', 533426157, 3827);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mellencamp  Nina', 529093133, 3828);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Shorter  Miguel', 533545787, 3829);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chesnutt  Suzi', 535607196, 3830);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('de Lancie  Adam', 528076478, 3831);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cooper  Lionel', 531428850, 3832);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Baker  Val', 531961937, 3833);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Plowright  Ron', 528359152, 3834);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Reeve  Sandra', 531428850, 3835);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Blossoms  Charlton', 539040640, 3836);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Giannini  Phil', 536089594, 3837);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Feliciano  Teri', 535607196, 3838);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Peniston  Pamela', 521884551, 3839);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Borgnine  Judge', 531961937, 3840);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quinlan  Rik', 525320641, 3841);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crouse  Bobby', 524910170, 3842);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Suvari  Samuel', 526353601, 3843);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Plowright  Aaron', 521932206, 3844);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Steagall  Geraldine', 527746372, 3845);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Allan  Sally', 536089594, 3846);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Tanon  Ani', 525075779, 3847);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Preston  Delroy', 525771007, 3848);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cotton  Jay', 533545787, 3849);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crosby  Ted', 522498119, 3850);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kingsley  Edie', 526247728, 3851);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Blackmore  Liv', 521060217, 3852);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Holbrook  Debra', 531428850, 3853);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Paxton  Maura', 526353601, 3854);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rossellini  Taryn', 531829125, 3855);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Navarro  Carlos', 523679466, 3856);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dolenz  Gilberto', 529822770, 3857);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sutherland  Mandy', 522498119, 3858);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rhodes  Derrick', 531038589, 3859);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hynde  Luis', 522749390, 3860);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hawn  Patty', 520182755, 3861);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Uggams  Luis', 526247728, 3862);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lynne  Larry', 522749390, 3863);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Burke  Angie', 529149505, 3864);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Connick  Nicholas', 522486321, 3865);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Coolidge  Laura', 520539639, 3866);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Penn  Merrill', 531038589, 3867);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Voight  Sean', 531480785, 3868);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hong  Sara', 525771007, 3869);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Feuerstein  Famke', 529822770, 3870);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lennix  Stockard', 536089594, 3871);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Place  Cevin', 530245800, 3872);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Easton  Gin', 522486321, 3873);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cummings  Geena', 520539639, 3874);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Vai  Rhona', 526247728, 3875);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Baez  Leo', 523289275, 3876);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Danger  Lloyd', 525771007, 3877);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wood  Laura', 523621296, 3878);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McLean  Timothy', 520778920, 3879);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Collette  Crystal', 531829125, 3880);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lange  Casey', 530245800, 3881);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Leachman  Belinda', 528359152, 3882);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dorn  Rosie', 534236952, 3883);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Douglas  Bridgette', 528359152, 3884);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lynskey  Pelvic', 520902098, 3885);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chilton  Javon', 535607196, 3886);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Goldwyn  Robbie', 533766598, 3887);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Margulies  Jessica', 531428850, 3888);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Duke  Lindsay', 529964027, 3889);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cash  Neve', 525782982, 3890);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pepper  Brendan', 530245800, 3891);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Evanswood  Kevin', 520539639, 3892);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dean  Al', 531961937, 3893);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Colman  Jaime', 520182755, 3894);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Leoni  Rawlins', 537810436, 3895);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rockwell  Andrae', 535607196, 3896);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cockburn  Ricardo', 523289275, 3897);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lillard  Grace', 522486321, 3898);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Burton  Cole', 525320641, 3899);
commit;
prompt 300 records committed...
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hanks  Ice', 521259541, 3900);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dalton  Derrick', 524910170, 3901);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Osmond  Kimberly', 534347608, 3902);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crewson  Val', 524910170, 3903);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ferry  Winona', 527983188, 3904);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Suchet  Remy', 528724031, 3905);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cockburn  Sandra', 524910170, 3906);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Harrelson  Ryan', 525771007, 3907);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Aykroyd  Jonny', 527983188, 3908);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ponty  Cledus', 527983188, 3909);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Guest  Leelee', 526353601, 3910);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Maxwell  Spike', 531480785, 3911);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Guilfoyle  Rosco', 525075779, 3912);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Belle  Al', 528724031, 3913);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cattrall  Casey', 531038589, 3914);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chilton  Nickel', 520902098, 3915);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Austin  Mary', 531038589, 3916);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hewitt  Jeffrey', 525075779, 3917);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quatro  Hal', 529093133, 3918);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Costello  Sylvester', 537810436, 3919);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Guilfoyle  Lydia', 531829125, 3920);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Feuerstein  Eliza', 525782982, 3921);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hayek  Taye', 531038589, 3922);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Caviezel  Rutger', 525320641, 3923);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rhys-Davies  Marc', 538923687, 3924);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Parker  Richard', 531961937, 3925);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Johnson  Doug', 525782982, 3926);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rapaport  Geraldine', 520539639, 3927);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mars  Matt', 531038589, 3928);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dale  Tracy', 531428850, 3929);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Thurman  Don', 534236952, 3930);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Zahn  Austin', 533766598, 3931);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Soul  Denny', 533438067, 3932);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Willis  Richard', 526353601, 3933);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Quinones  Gin', 531453475, 3934);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Loring  Kim', 525320641, 3935);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Collie  Penelope', 533438067, 3936);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lavigne  Jessica', 521884551, 3937);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McAnally  Fionnula', 520778920, 3938);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Remar  Carlene', 524910170, 3939);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cheadle  Carole', 531961937, 3940);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chestnut  Nastassja', 531480785, 3941);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Griggs  Bette', 533426157, 3942);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Howard  Lonnie', 533438067, 3943);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Paxton  Benjamin', 528076478, 3944);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chesnutt  Carrie-Anne', 528724031, 3945);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bassett  Andy', 529822770, 3946);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sayer  Miko', 529149505, 3947);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wells  Bradley', 526353601, 3948);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Warburton  Miki', 525075779, 3949);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('O''Donnell  Praga', 527983188, 3950);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Garner  Billy', 539040640, 3951);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McGregor  Jackson', 536089594, 3952);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Moorer  Harry', 521932206, 3953);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Crowe  Betty', 522498119, 3954);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kershaw  Yolanda', 520902098, 3955);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Northam  Albertina', 525075779, 3956);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kravitz  Hazel', 529093133, 3957);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cherry  Charles', 526247728, 3958);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gershon  Joe', 521259541, 3959);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gary  Clint', 529822770, 3960);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Conroy  Belinda', 523621296, 3961);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Matarazzo  Lucy', 520182755, 3962);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Burmester  Nora', 522498119, 3963);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Liu  Faye', 526247728, 3964);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sobieski  Scarlett', 533766598, 3965);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cattrall  Ceili', 533426157, 3966);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gleeson  Emilio', 531829125, 3967);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('McGregor  Sissy', 520778920, 3968);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Day-Lewis  Gwyneth', 520902098, 3969);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Loeb  Debby', 523289275, 3970);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Savage  Brenda', 522749390, 3971);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bancroft  Ted', 538923687, 3972);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Phifer  Marty', 522498119, 3973);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Avalon  Jose', 522749390, 3974);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Emmett  Fairuza', 525771007, 3975);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Walsh  Chuck', 535607196, 3976);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Plowright  Ralph', 534347608, 3977);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('England  Brothers', 529964027, 3978);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mellencamp  Forest', 531480785, 3979);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Franklin  Ving', 521060217, 3980);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Affleck  Delbert', 520539639, 3981);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Lauper  Leelee', 531829125, 3982);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stallone  Garry', 530245800, 3983);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rea  Katrin', 520739321, 3984);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Myles  Kenny', 535607196, 3985);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Paquin  Udo', 521884551, 3986);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gertner  Jill', 520739321, 3987);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wilson  Stanley', 521932206, 3988);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Ripley  Adina', 527983188, 3989);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Kenoly  Edward', 538923687, 3990);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Warwick  Treat', 525075779, 3991);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hackman  Ernest', 522749390, 3992);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Martin  First', 523289275, 3993);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Statham  Christian', 522498119, 3994);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wine  Janeane', 526247728, 3995);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Elliott  Benjamin', 525782982, 3996);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stanton  Daryl', 529093133, 3997);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Starr  Tilda', 533545787, 3998);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Jonze  Wesley', 531428850, 3999);
commit;
prompt 400 records committed...
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sandoval  Marisa', 529964027, 4000);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dukakis  Embeth', 520778920, 4001);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Parish  Anna', 533545787, 4002);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Marin  Laura', 531038589, 4003);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Martin  Dionne', 531480785, 4004);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Vance  Jimmy', 528724031, 4005);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dern  Desmond', 529822770, 4006);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rourke  Seth', 531829125, 4007);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hong  Mae', 520902098, 4008);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Flack  Horace', 526353601, 4009);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Watley  Ashton', 523679466, 4010);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pollack  Austin', 520902098, 4011);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Blackmore  Denny', 529822770, 4012);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Fiorentino  Humberto', 529149505, 4013);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Clarkson  Gina', 531038589, 4014);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Spader  Mira', 538923687, 4015);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dukakis  Dionne', 538923687, 4016);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Stuermer  Andre', 520902098, 4017);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Loggins  Charlize', 531961937, 4018);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Olyphant  Hookah', 526247728, 4019);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Voight  Herbie', 531428850, 4020);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Avalon  Sean', 521884551, 4021);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Johansson  Timothy', 526247728, 4022);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Price  Christina', 531829125, 4023);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Hurley  Russell', 521884551, 4024);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Levine  Vienna', 531829125, 4025);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Cornell  Carla', 530245800, 4026);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Thorton  Eddie', 520182755, 4027);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Osbourne  Larnelle', 525075779, 4028);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Waits  Brittany', 521259541, 4029);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Davidtz  Harvey', 533438067, 4030);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Pitney  Jose', 526247728, 4031);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Warburton  Wang', 533438067, 4032);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Wills  Mary Beth', 533766598, 4033);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Eckhart  Boz', 520739321, 4034);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gaynor  Lonnie', 531829125, 4035);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Rydell  Lenny', 529093133, 4036);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Sarsgaard  Louise', 526247728, 4037);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Parish  Al', 521259541, 4038);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bragg  Neil', 521060217, 4039);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Silverman  Chad', 530245800, 4040);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Chaykin  Natascha', 528076478, 4041);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Dunaway  Ahmad', 524910170, 4042);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Belle  Collective', 538923687, 4043);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Tarantino  Hazel', 537810436, 4044);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Keaton  Tanya', 521932206, 4045);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Slater  Harriet', 537810436, 4046);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Holeman  Donal', 535607196, 4047);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('MacDonald  Ralph', 531829125, 4048);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Balaban  Vienna', 529149505, 4049);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Bacon  Corey', 528724031, 4050);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Mohr  Goldie', 521932206, 4051);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Watson  Night', 535607196, 4052);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Costello  Bobbi', 523289275, 4053);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Weston  Luis', 523289275, 4054);
insert into NURSE (nurse_name, telephone_number, nurse_id)
values ('Gallagher  Blair', 531829125, 4055);
commit;
prompt 456 records loaded
prompt Loading PATIENT...
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (428, 'Place  Beth', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (429, 'Birch  Freddie', 'Woman', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (430, 'LaSalle  Clea', 'Woman', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (431, 'Popper  Terrence', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (432, 'Dalley  Mindy', 'Man', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (433, 'Rosas  Tori', 'Woman', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (434, 'Bragg  Kazem', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (435, 'Sizemore  Billy', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (436, 'Crouch  Helen', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (437, 'LaMond  Mekhi', 'Woman', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (438, 'Isaacs  Mac', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (439, 'Goldblum  Kristin', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (440, 'Berkoff  Roy', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (441, 'Meyer  David', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (442, 'Ruffalo  Mel', 'Man', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (443, 'Crouse  Grace', 'Man', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (444, 'Joli  Rupert', 'Woman', 'hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (445, 'Kramer  Gordon', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (446, 'Fehr  Matt', 'Woman', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (447, 'Liu  Merillee', 'Man', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (448, 'Paymer  Mark', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (449, 'Tippe  Rosie', 'Man', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (450, 'Lynne  Lila', 'Man', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (451, 'Busey  Maura', 'Man', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (452, 'Curtis  Adina', 'Woman', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (453, 'Latifah  Meryl', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (454, 'Watson  Max', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (455, 'Sawa  Thelma', 'Woman', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (456, 'Andrews  Liv', 'Woman', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (457, 'Crosby  Fiona', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (458, 'Curtis  Hilary', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (459, 'Webb  Miki', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (460, 'Brock  Tcheky', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (461, 'Nelson  Stockard', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (462, 'Pollack  Tramaine', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (463, 'Streep  Omar', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (464, 'Stills  Nikka', 'Man', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (465, 'Nugent  Graham', 'Woman', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (466, 'Anderson  Chet', 'Woman', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (467, 'Donelly  Ted', 'Woman', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (468, 'Murdock  Andy', 'Man', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (469, 'Nivola  Miko', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (470, 'Dorff  Rosie', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (471, 'McCready  Caroline', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (472, 'Williams  Johnny', 'Man', 'lumpectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (473, 'Bratt  Treat', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (474, 'McDiarmid  Solomon', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (475, 'Nivola  Leonardo', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (476, 'Dempsey  Franco', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (477, 'Todd  Peabo', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (478, 'Neill  King', 'Man', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (479, 'Torn  Suzi', 'Woman', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (480, 'Van Damme  Praga', 'Woman', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (481, 'Wayans  Clive', 'Man', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (482, 'von Sydow  Kasey', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (483, 'Weller  Josh', 'Man', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (484, 'Crimson  Buffy', 'Woman', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (485, 'Hyde  Carolyn', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (486, 'Gibson  Davey', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (487, 'Wilder  Kay', 'Man', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (488, 'DeGraw  Trace', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (489, 'Gertner  Ivan', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (490, 'Krabbe  Trini', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (491, 'Cale  Derrick', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (492, 'Polley  Emilio', 'Woman', 'pneumonectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (493, 'Tennison  Aaron', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (494, 'Dafoe  Angela', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (495, 'Atlas  Chaka', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (496, 'Dutton  Roscoe', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (497, 'Winwood  Clint', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (498, 'Archer  Benjamin', 'Man', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (499, 'Cummings  Carlos', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (500, 'Stills  Brothers', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (501, 'McGinley  Phoebe', 'Woman', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (502, 'Kretschmann  Betty', 'Man', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (503, 'Kotto  Mos', 'Man', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (504, 'Franks  Mykelti', 'Woman', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (505, 'Douglas  Delbert', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (506, 'Prowse  Neneh', 'Woman', 'pneumonectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (507, 'James  Cameron', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (508, 'Nelligan  Gena', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (509, 'Kidman  Whoopi', 'Man', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (510, 'Scaggs  Hex', 'Woman', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (511, 'Stuart  Nicole', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (512, 'Maguire  Denise', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (513, 'Colin Young  Kasey', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (514, 'Coyote  Lucy', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (515, 'Cross  Talvin', 'Man', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (516, 'Taha  Charlton', 'Woman', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (517, 'Caine  Junior', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (518, 'Coverdale  Val', 'Woman', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (519, 'Teng  Katrin', 'Woman', 'pneumonectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (520, 'Bacharach  Melanie', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (521, 'Harris  Cherry', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (522, 'Harary  Joshua', 'Man', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (523, 'Whitaker  Sigourney', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (524, 'Guest  Daryle', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (525, 'Reynolds  Ernest', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (526, 'Beckham  Pam', 'Man', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (527, 'Gore  Benicio', 'Woman', 'lung cancer');
commit;
prompt 100 records committed...
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (528, 'Pierce  Kyra', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (529, 'Cozier  Larenz', 'Man', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (530, 'Nolte  Andrae', 'Woman', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (531, 'Hawthorne  Burt', 'Woman', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (532, 'Potter  Marley', 'Man', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (533, 'D''Onofrio  Liam', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (534, 'Cruz  Marty', 'Man', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (535, 'de Lancie  Brendan', 'Woman', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (536, 'Hewitt  Aaron', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (537, 'Lofgren  David', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (538, 'Richter  Spike', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (539, 'Dunst  Jared', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (540, 'Kristofferson  Tim', 'Woman', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (541, 'Burstyn  Parker', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (542, 'Sinise  Judi', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (543, 'Michael  Walter', 'Woman', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (544, 'Strathairn  Leonardo', 'Woman', 'lumpectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (545, 'Wine  Trace', 'Woman', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (546, 'Sobieski  Marc', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (547, 'Lattimore  France', 'Man', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (548, 'Brock  Chaka', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (549, 'Kline  Isaiah', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (550, 'Lunch  Carol', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (551, 'Reiner  Roger', 'Man', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (552, 'Quatro  Dan', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (553, 'Remar  Molly', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (554, 'Jackman  Powers', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (555, 'Coltrane  Vendetta', 'Man', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (556, 'Springfield  Owen', 'Woman', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (557, 'Chilton  Irene', 'Man', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (558, 'Farris  Fisher', 'Man', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (559, 'Bailey  Isaiah', 'Woman', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (560, 'Krabbe  Gwyneth', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (561, 'Plimpton  Luis', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (562, 'Khan  Robbie', 'Man', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (563, 'Krabbe  Emerson', 'Woman', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (564, 'Womack  Lynn', 'Woman', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (266, 'Idle  Clay', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (267, 'Dooley  Alfred', 'Man', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (268, 'Bailey  Chely', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (269, 'Singletary  Orlando', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (270, 'Skarsgard  Nelly', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (271, 'MacIsaac  Marley', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (272, 'Ferrer  Daniel', 'Man', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (273, 'Byrne  Laura', 'Woman', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (274, 'Cocker  Demi', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (275, 'Davison  Neil', 'Man', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (276, 'Wariner  Lindsey', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (277, 'Wells  Shirley', 'Woman', 'lumpectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (278, 'Stoltz  Dar', 'Man', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (279, 'Speaks  Larenz', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (280, 'Hopkins  Whoopi', 'Woman', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (281, 'Holeman  Patrick', 'Man', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (282, 'Johnson  Corey', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (283, 'Fender  Patty', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (284, 'Stormare  Stanley', 'Woman', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (285, 'Wong  Lois', 'Woman', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (286, 'Squier  April', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (287, 'Botti  Gwyneth', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (288, 'Oakenfold  Madeline', 'Woman', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (289, 'Burke  Illeana', 'Man', 'hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (290, 'Wagner  Charlize', 'Man', 'pneumonectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (291, 'Thewlis  Cherry', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (292, 'Rains  Lorraine', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (293, 'Malkovich  Wally', 'Woman', 'mastectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (294, 'Sylvian  Kylie', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (295, 'Winslet  Nicholas', 'Woman', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (296, 'Carlyle  Larry', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (297, 'Torn  Alana', 'Man', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (298, 'O''Keefe  Cate', 'Man', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (299, 'McFerrin  Mel', 'Woman', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (300, 'Glover  Mia', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (301, 'Wheel  Gwyneth', 'Woman', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (302, 'Idle  Thomas', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (303, 'Hurt  Salma', 'Man', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (304, 'Smurfit  Patty', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (305, 'Cornell  Debby', 'Man', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (306, 'Baez  Cathy', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (307, 'Branagh  Lynn', 'Man', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (308, 'Hubbard  Judy', 'Woman', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (309, 'Cash  Elijah', 'Man', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (310, 'Hackman  Jean', 'Man', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (311, 'Kattan  Ritchie', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (312, 'Polito  Lorraine', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (313, 'urban  Taye', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (314, 'Studi  Breckin', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (315, 'Dean  Chad', 'Man', 'aortic aneurysm');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (316, 'Marie  Victor', 'Man', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (317, 'Nash  Ivan', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (318, 'Wayans  Deborah', 'Man', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (319, 'Dickinson  Eric', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (320, 'Lineback  Tim', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (321, 'Rodriguez  Cesar', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (322, 'Hayes  Tcheky', 'Woman', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (323, 'Addy  Bette', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (324, 'Dooley  Howie', 'Woman', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (325, 'Parsons  Nikka', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (326, 'Shocked  Jarvis', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (327, 'Blige  Nik', 'Man', 'aortic aneurysm');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (328, 'Wen  Ashton', 'Woman', 'deep vein thrombosis');
commit;
prompt 200 records committed...
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (329, 'Allan  Courtney', 'Man', 'aortic aneurysm');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (330, 'Conlee  Jared', 'Man', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (331, 'Love  Thin', 'Woman', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (332, 'Stevenson  Lili', 'Woman', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (333, 'Camp  Fats', 'Woman', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (334, 'Baranski  Burt', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (335, 'Hingle  Collective', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (336, 'Meniketti  Pablo', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (337, 'Magnuson  Lea', 'Man', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (338, 'Curry  Jeroen', 'Woman', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (339, 'Brown  Stockard', 'Woman', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (340, 'Patillo  Nicholas', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (341, 'Jackson  Kasey', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (342, 'Arquette  Franco', 'Man', 'mastectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (343, 'Singletary  Kyle', 'Woman', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (344, 'Turner  Charlize', 'Man', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (345, 'Whitmore  Stockard', 'Man', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (346, 'Stigers  Norm', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (347, 'Buckingham  Taryn', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (348, 'Stanley  Jonny', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (349, 'Rucker  Scott', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (350, 'McDowell  Yaphet', 'Man', 'hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (351, 'Bradford  Ellen', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (352, 'Dourif  Vince', 'Woman', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (353, 'Jonze  Brian', 'Man', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (354, 'Utada  Vertical', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (355, 'Broderick  Lou', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (356, 'Johansen  Alfred', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (357, 'Torino  Brendan', 'Man', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (358, 'Weaver  Bryan', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (359, 'Arquette  Mekhi', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (360, 'Steagall  Fats', 'Woman', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (361, 'Spiner  Edward', 'Woman', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (362, 'Loggins  Rosanne', 'Woman', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (363, 'Rippy  Edwin', 'Man', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (364, 'Heatherly  Timothy', 'Man', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (365, 'DeVito  Christmas', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (366, 'Potter  Kyle', 'Woman', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (367, 'O''Neal  Lauren', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (368, 'Swayze  Nick', 'Man', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (369, 'Oakenfold  Mos', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (370, 'DeVita  Tia', 'Man', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (371, 'Wakeling  Vivica', 'Woman', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (372, 'Loeb  Derrick', 'Man', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (373, 'Shand  Danni', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (374, 'Sutherland  Burton', 'Woman', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (375, 'Clark  Max', 'Man', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (376, 'Giamatti  Crispin', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (377, 'Wincott  Ryan', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (378, 'Winter  Rupert', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (379, 'Meniketti  Jean', 'Man', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (380, 'Mathis  Jennifer', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (381, 'Gooding  Leslie', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (382, 'Shandling  Mekhi', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (383, 'Sanchez  Denzel', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (384, 'Clark  Dom', 'Man', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (385, 'McDiarmid  Jeffery', 'Woman', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (386, 'Breslin  Bebe', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (387, 'Squier  Bob', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (388, 'Chandler  Juan', 'Woman', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (389, 'Colin Young  Remy', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (390, 'Forster  Scarlett', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (391, 'Ali  Henry', 'Woman', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (392, 'Caviezel  Reese', 'Man', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (393, 'Sweeney  Harry', 'Woman', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (394, 'Everett  Bret', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (395, 'Weisberg  Benjamin', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (396, 'Rawls  Praga', 'Man', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (397, 'Diffie  Martin', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (398, 'Lindley  John', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (399, 'Hagerty  Rosco', 'Woman', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (400, 'Wolf  Clarence', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (401, 'Uggams  Quentin', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (402, 'Paltrow  Gord', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (403, 'Feuerstein  Denzel', 'Woman', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (404, 'Rispoli  Carole', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (405, 'Crewson  Andy', 'Man', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (406, 'Affleck  Carl', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (407, 'McLean  Adam', 'Woman', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (408, 'Fariq  Dom', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (409, 'Harrelson  Swoosie', 'Man', 'heart valve disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (410, 'Robards  Davis', 'Man', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (411, 'Hirsch  Campbell', 'Woman', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (412, 'Lattimore  Stephen', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (413, 'El-Saher  Clive', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (414, 'Pitney  Jann', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (415, 'Macht  Arturo', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (416, 'Logue  Ernie', 'Woman', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (417, 'McGill  Famke', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (418, 'Jane  Albert', 'Man', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (419, 'Wilder  Vince', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (420, 'Carlton  Rik', 'Woman', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (421, 'Hauser  James', 'Man', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (422, 'Weller  Trace', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (423, 'Curry  Samantha', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (424, 'Bragg  Andrew', 'Man', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (425, 'Lillard  Mint', 'Man', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (426, 'Yulin  Andrae', 'Woman', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (427, 'Sandler  Patricia', 'Woman', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (151, 'Koyana  David', 'Woman', 'coronary artery disease');
commit;
prompt 300 records committed...
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (152, 'Field  Noah', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (153, 'Carr  Derrick', 'Man', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (154, 'Frakes  Franco', 'Woman', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (155, 'Holiday  Ricky', 'Woman', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (156, 'Bruce  Jake', 'Man', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (157, 'Randal  Jena', 'Man', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (158, 'Satriani  Sharon', 'Man', 'mastectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (159, 'Polley  Illeana', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (160, 'Reeve  Ahmad', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (161, 'Armstrong  Ramsey', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (162, 'Shue  Kevin', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (163, 'Root  Hank', 'Woman', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (164, 'Holmes  Aimee', 'Woman', 'pneumonectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (165, 'Kravitz  Loreena', 'Woman', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (166, 'Sewell  Jack', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (167, 'Marshall  Sonny', 'Woman', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (168, 'Goodman  Dennis', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (169, 'Holy  Curt', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (170, 'Waite  LeVar', 'Woman', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (171, 'Bentley  Chrissie', 'Man', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (172, 'Evett  Tzi', 'Woman', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (173, 'Gellar  Avenged', 'Woman', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (174, 'McGregor  Anne', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (175, 'Pantoliano  Nancy', 'Woman', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (176, 'Summer  Bobbi', 'Woman', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (177, 'Hughes  Ty', 'Woman', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (178, 'Sevigny  Cole', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (179, 'Prowse  Geena', 'Woman', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (180, 'Cole  Isabella', 'Woman', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (181, 'Wilder  Chad', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (182, 'Red  Owen', 'Man', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (183, 'Shearer  Loreena', 'Woman', 'testicular cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (184, 'Winwood  Nikka', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (185, 'Sandoval  Maury', 'Man', 'heart valve disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (186, 'Askew  Barbara', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (187, 'Guest  Pablo', 'Woman', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (188, 'Hewett  Adina', 'Woman', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (189, 'Piven  Fairuza', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (190, 'Ellis  Hector', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (191, 'Valentin  Andrew', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (192, 'Crowe  Nelly', 'Woman', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (193, 'Tucci  Betty', 'Woman', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (194, 'Lerner  Seth', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (195, 'Postlethwaite  Tilda', 'Man', 'heart valve disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (196, 'Diffie  Rip', 'Man', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (197, 'Lapointe  Crystal', 'Man', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (198, 'McElhone  Sissy', 'Woman', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (199, 'Baez  Cuba', 'Woman', 'deep vein thrombosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (200, 'Wilder  Bradley', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (201, 'Sellers  Frankie', 'Man', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (202, 'Mueller-Stahl  Christian', 'Woman', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (203, 'Orbit  Clive', 'Man', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (204, 'Schwarzenegger  Gary', 'Woman', 'mastectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (205, 'Wayans  Oliver', 'Man', 'lumpectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (206, 'Kinnear  Andrae', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (207, 'Goodall  Trace', 'Man', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (208, 'Molina  Humberto', 'Woman', 'laminectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (209, 'Cohn  Lenny', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (210, 'Buscemi  King', 'Man', 'endometrial cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (211, 'Davis  Jody', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (212, 'Cara  Leon', 'Man', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (213, 'Folds  Uma', 'Man', 'heart valve disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (214, 'Butler  Matthew', 'Man', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (215, 'Daniels  Rowan', 'Man', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (216, 'Green  Linda', 'Woman', 'pyloric stenosis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (217, 'England  Don', 'Man', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (218, 'Borden  Jim', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (219, 'Lynne  Jeanne', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (220, 'Brosnan  Tia', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (221, 'Jessee  Clarence', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (222, 'Bloch  Ian', 'Man', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (223, 'Bugnon  Celia', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (224, 'Fiennes  Alannah', 'Man', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (225, 'Burns  Alicia', 'Man', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (226, 'Belle  Howie', 'Man', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (227, 'Vicious  Joshua', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (228, 'Loring  Fred', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (229, 'Theron  Shelby', 'Woman', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (230, 'Furay  Andrea', 'Man', 'hip replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (231, 'Neill  Sally', 'Man', 'melanoma');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (232, 'Idol  Loreena', 'Woman', 'gastrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (233, 'Diesel  Nora', 'Woman', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (234, 'Waits  Raymond', 'Man', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (235, 'Singh  Mindy', 'Woman', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (236, 'Cara  Armin', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (237, 'Schwarzenegger  Ossie', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (238, 'Cumming  Chet', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (239, 'McConaughey  Mark', 'Woman', 'kidney cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (240, 'Nunn  Lynn', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (241, 'Twilley  Harris', 'Man', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (242, 'Bancroft  Tzi', 'Man', 'lumpectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (243, 'Shawn  Regina', 'Man', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (244, 'Jeter  Toshiro', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (245, 'Zellweger  Merle', 'Woman', 'congenital heart defects');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (246, 'Kidman  Guy', 'Woman', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (247, 'Short  Sander', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (248, 'Ranger  Rosanne', 'Woman', 'cervical cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (249, 'Allan  Denzel', 'Man', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (250, 'Bale  Derek', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (251, 'Morse  Forest', 'Woman', 'pancreatic cancer');
commit;
prompt 400 records committed...
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (252, 'Wood  Daryl', 'Woman', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (253, 'Thurman  Norm', 'Man', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (254, 'Dooley  Cyndi', 'Man', 'bladder cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (255, 'Hurt  Marina', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (256, 'Goldberg  Jonny Lee', 'Woman', 'hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (257, 'Atlas  Peter', 'Man', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (258, 'Amos  Tamala', 'Woman', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (259, 'Brown  Jane', 'Man', 'gallstones');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (260, 'Brolin  Lila', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (261, 'Meniketti  Dick', 'Man', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (262, 'Black  Chrissie', 'Woman', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (263, 'Margolyes  Nikka', 'Man', 'cholecystectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (264, 'Beckinsale  Delbert', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (265, 'Carrey  Lili', 'Woman', 'prostate cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (100, 'Penn  Queen', 'Man', 'heart valve disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (101, 'Tarantino  Tori', 'Woman', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (102, 'Wakeling  Juice', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (103, 'Furtado  Marley', 'Woman', 'colon cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (104, 'Jackman  Fiona', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (105, 'Aaron  Edward', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (106, 'Davison  Frances', 'Woman', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (107, 'Sherman  Tori', 'Woman', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (108, 'Hector  Chely', 'Woman', 'adrenalectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (109, 'Buscemi  Cole', 'Woman', 'inguinal hernia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (110, 'Coe  Ice', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (111, 'Estevez  Sean', 'Woman', 'pulmonary embolism');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (112, 'Bosco  Alfie', 'Woman', 'colectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (113, 'Eastwood  Powers', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (114, 'Vanian  Merillee', 'Man', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (115, 'Gold  Arturo', 'Woman', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (116, 'Cattrall  Nik', 'Woman', 'biliary atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (117, 'Monk  Lindsay', 'Woman', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (118, 'Reubens  Geoffrey', 'Woman', 'lung cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (119, 'Allen  Rosario', 'Man', 'knee replacement');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (120, 'Alda  Barbara', 'Woman', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (121, 'Sobieski  Terence', 'Man', 'ovarian cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (122, 'Hedaya  Humberto', 'Man', 'spinal fusion');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (123, 'Allen  Derek', 'Man', 'pancreatic cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (124, 'Harry  Charles', 'Man', 'liver cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (125, 'Milsap  Vendetta', 'Woman', 'thyroidectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (126, 'McGinley  Lisa', 'Woman', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (127, 'Fariq  Goldie', 'Man', 'appendicitis');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (128, 'Nakai  Isaiah', 'Man', 'nephrectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (129, 'Zellweger  Tracy', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (130, 'Judd  Lupe', 'Woman', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (131, 'Horton  Isaac', 'Man', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (132, 'Douglas  Tea', 'Woman', 'peripheral artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (133, 'Van Damme  Heather', 'Woman', 'lobectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (134, 'Weber  Harrison', 'Woman', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (135, 'Belle  Wes', 'Woman', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (136, 'Emmett  Jose', 'Woman', 'hysterectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (137, 'Morales  Denny', 'Man', 'esophageal cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (138, 'Galecki  Dabney', 'Man', 'brain tumor');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (139, 'Giannini  Dave', 'Man', 'intestinal atresia');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (140, 'Remar  Tal', 'Man', 'splenectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (141, 'Bacon  Brent', 'Woman', 'thyroid cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (142, 'Leigh  Tilda', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (143, 'Harry  Vern', 'Man', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (144, 'Cattrall  Catherine', 'Woman', 'craniotomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (145, 'Eckhart  Howard', 'Man', 'breast cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (146, 'Midler  Charles', 'Woman', 'cleft lip and palate');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (147, 'Olin  Yaphet', 'Man', 'gastric cancer');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (148, 'Rodgers  Johnnie', 'Woman', 'prostatectomy');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (149, 'Beck  Liam', 'Man', 'coronary artery disease');
insert into PATIENT (patient_id, patient_name, sexe, illness)
values (150, 'Folds  Hilary', 'Man', 'deep vein thrombosis');
commit;
prompt 465 records loaded
prompt Loading OPERATING_ROOM...
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1200, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1201, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1202, 'Maintenance', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1203, 'Maintenance', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1204, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1205, 'Maintenance', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1206, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1207, 'Maintenance', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1208, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1209, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1210, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1211, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1212, 'Maintenance', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1213, 'Maintenance', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1214, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1215, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1216, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1217, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1218, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1219, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1220, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1221, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1222, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1223, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1224, 'Maintenance', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1225, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1226, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1227, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1228, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1229, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1230, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1231, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1232, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1233, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1234, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1235, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1236, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1237, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1238, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1239, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1240, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1241, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1242, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1243, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1244, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1245, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1246, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1247, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1248, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1249, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1250, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1251, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1252, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1253, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1254, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1255, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1256, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1257, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1258, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1259, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1260, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1261, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1262, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1263, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1264, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1265, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1266, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1267, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1268, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1269, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1270, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1271, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1272, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1273, 'Yes', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1274, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1275, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1276, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1277, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1278, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1279, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1280, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1281, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1282, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1283, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1284, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1285, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1286, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1287, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1288, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1289, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1290, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1291, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1292, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1293, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1294, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1295, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1296, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1297, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1298, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1299, 'Yes', 4);
commit;
prompt 100 records committed...
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1300, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1301, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1302, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1303, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1304, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1305, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1306, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1307, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1308, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1309, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1310, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1311, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1312, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1313, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1314, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1315, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1316, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1317, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1318, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1319, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1320, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1321, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1322, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1323, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1324, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1325, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1326, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1327, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1328, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1329, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1330, 'Yes', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1331, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1332, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1333, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1334, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1335, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1336, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1337, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1338, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1339, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1340, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1341, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1342, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1343, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1344, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1345, 'BOOKED', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1346, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1347, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1348, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1349, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1350, 'BOOKED', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1351, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1352, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1353, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1354, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1355, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1356, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1357, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1358, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1359, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1360, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1361, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1362, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1363, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1364, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1365, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1366, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1367, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1368, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1369, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1370, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1371, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1372, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1373, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1374, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1375, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1376, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1377, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1378, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1379, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1380, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1381, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1382, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1383, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1384, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1385, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1386, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1387, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1388, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1389, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1390, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1391, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1392, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1393, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1394, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1395, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1396, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1397, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1398, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1399, 'No', 19);
commit;
prompt 200 records committed...
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1400, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1401, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1402, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1403, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1404, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1405, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1406, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1407, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1408, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1409, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1410, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1411, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1412, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1413, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1414, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1415, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1416, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1417, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1418, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1419, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1420, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1421, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1422, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1423, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1424, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1425, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1426, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1427, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1428, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1429, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1430, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1431, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1432, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1433, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1434, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1435, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1436, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1437, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1438, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1439, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1440, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1441, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1442, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1443, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1444, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1445, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1446, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1447, 'Yes', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1448, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1449, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1450, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1451, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1452, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1453, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1454, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1455, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1456, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1457, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1458, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1459, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1460, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1461, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1462, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1463, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1464, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1465, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1466, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1467, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1468, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1469, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1470, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1471, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1472, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1473, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1474, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1475, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1476, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1477, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1478, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1479, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1480, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1481, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1482, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1483, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1484, 'Yes', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1485, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1486, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1487, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1488, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1489, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1490, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1491, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1492, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1493, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1494, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1495, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1496, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1497, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1498, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1499, 'No', 1);
commit;
prompt 300 records committed...
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1500, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1501, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1502, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1503, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1504, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1505, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1506, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1507, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1508, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1509, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1510, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1511, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1512, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1513, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1514, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1515, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1516, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1517, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1518, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1519, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1520, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1521, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1522, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1523, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1524, 'Yes', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1525, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1526, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1527, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1528, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1529, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1530, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1531, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1532, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1533, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1534, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1535, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1536, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1537, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1538, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1539, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1540, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1541, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1542, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1543, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1544, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1545, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1546, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1547, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1548, 'Yes', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1549, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1550, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1551, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1552, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1553, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1554, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1555, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1556, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1557, 'Yes', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1558, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1559, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1560, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1561, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1562, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1563, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1564, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1565, 'No', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1566, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1567, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1568, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1569, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1570, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1571, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1572, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1573, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1574, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1575, 'No', 6);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1576, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1577, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1578, 'Yes', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1579, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1580, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1581, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1582, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1583, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1584, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1585, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1586, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1587, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1588, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1589, 'No', 15);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1590, 'Yes', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1591, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1592, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1593, 'Yes', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1594, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1595, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1596, 'Yes', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1597, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1598, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1599, 'No', 4);
commit;
prompt 400 records committed...
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1600, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1601, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1602, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1603, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1604, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1605, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1606, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1607, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1608, 'No', 9);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1609, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1610, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1611, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1612, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1613, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1614, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1615, 'Yes', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1616, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1617, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1618, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1619, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1620, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1621, 'Yes', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1622, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1623, 'No', 5);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1624, 'No', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1625, 'Yes', 18);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1626, 'No', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1627, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1628, 'No', 19);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1629, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1630, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1631, 'No', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1632, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1633, 'No', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1634, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1635, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1636, 'Yes', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1637, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1638, 'No', 12);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1639, 'No', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1640, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1641, 'Yes', 13);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1642, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1643, 'Yes', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1644, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1645, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1646, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1647, 'No', 17);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1648, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1649, 'No', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1650, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1651, 'Yes', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1652, 'No', 4);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1653, 'No', 7);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1654, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1655, 'Yes', 16);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1656, 'Yes', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1657, 'Yes', 3);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1658, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1659, 'No', 11);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1660, 'Yes', 2);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1661, 'No', 8);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1662, 'No', 1);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1663, 'Yes', 20);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1664, 'No', 14);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1665, 'Yes', 10);
insert into OPERATING_ROOM (room_id, availability, max_number_people)
values (1666, 'No', 4);
commit;
prompt 467 records loaded
prompt Loading OPERATION...
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-03-2024', 'dd-mm-yyyy'), 13, 6000, 100, 1216);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-01-2024', 'dd-mm-yyyy'), 10, 6001, 101, 1217);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-01-2025', 'dd-mm-yyyy'), 24, 6002, 102, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 15, 6003, 103, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-12-2023', 'dd-mm-yyyy'), 13, 6004, 104, 1204);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-05-2024', 'dd-mm-yyyy'), 2, 6005, 105, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-11-2024', 'dd-mm-yyyy'), 24, 6006, 106, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-08-2024', 'dd-mm-yyyy'), 23, 6007, 107, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-09-2023', 'dd-mm-yyyy'), 20, 6008, 108, 1208);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-10-2023', 'dd-mm-yyyy'), 21, 6009, 109, 1209);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-01-2024', 'dd-mm-yyyy'), 23, 6010, 110, 1210);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-01-2025', 'dd-mm-yyyy'), 15, 6011, 111, 1211);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-01-2025', 'dd-mm-yyyy'), 11, 6012, 112, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-11-2024', 'dd-mm-yyyy'), 23, 6013, 113, 1208);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-08-2024', 'dd-mm-yyyy'), 2, 6014, 114, 1214);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-01-2025', 'dd-mm-yyyy'), 19, 6015, 115, 1215);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-12-2024', 'dd-mm-yyyy'), 1, 6016, 116, 1216);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-10-2023', 'dd-mm-yyyy'), 16, 6017, 117, 1217);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-04-2024', 'dd-mm-yyyy'), 21, 6018, 118, 1218);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-11-2024', 'dd-mm-yyyy'), 23, 6019, 119, 1219);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-06-2023', 'dd-mm-yyyy'), 19, 6020, 120, 1220);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-08-2023', 'dd-mm-yyyy'), 7, 6021, 121, 1221);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-10-2024', 'dd-mm-yyyy'), 5, 6022, 122, 1222);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-04-2024', 'dd-mm-yyyy'), 14, 6023, 123, 1223);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-01-2024', 'dd-mm-yyyy'), 7, 6024, 124, 1206);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-11-2023', 'dd-mm-yyyy'), 16, 6025, 125, 1225);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-11-2023', 'dd-mm-yyyy'), 10, 6026, 126, 1226);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-07-2023', 'dd-mm-yyyy'), 17, 6027, 127, 1227);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-07-2024', 'dd-mm-yyyy'), 5, 6028, 128, 1228);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-05-2024', 'dd-mm-yyyy'), 12, 6029, 129, 1229);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-07-2023', 'dd-mm-yyyy'), 22, 6030, 130, 1230);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-03-2024', 'dd-mm-yyyy'), 12, 6031, 131, 1231);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-11-2023', 'dd-mm-yyyy'), 20, 6032, 132, 1232);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-12-2023', 'dd-mm-yyyy'), 1, 6033, 133, 1233);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-02-2024', 'dd-mm-yyyy'), 17, 6034, 134, 1234);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-11-2023', 'dd-mm-yyyy'), 14, 6035, 135, 1235);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-08-2024', 'dd-mm-yyyy'), 23, 6036, 136, 1236);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-01-2025', 'dd-mm-yyyy'), 1, 6037, 137, 1237);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-09-2024', 'dd-mm-yyyy'), 14, 6038, 138, 1238);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-12-2024', 'dd-mm-yyyy'), 14, 6039, 139, 1239);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-10-2023', 'dd-mm-yyyy'), 2, 6040, 140, 1240);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-09-2023', 'dd-mm-yyyy'), 15, 6041, 141, 1241);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-10-2024', 'dd-mm-yyyy'), 12, 6042, 142, 1242);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-09-2024', 'dd-mm-yyyy'), 4, 6043, 143, 1243);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-04-2024', 'dd-mm-yyyy'), 14, 6044, 144, 1244);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-07-2023', 'dd-mm-yyyy'), 23, 6045, 145, 1245);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-04-2024', 'dd-mm-yyyy'), 20, 6046, 146, 1246);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-06-2023', 'dd-mm-yyyy'), 24, 6047, 147, 1247);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-01-2025', 'dd-mm-yyyy'), 8, 6048, 148, 1248);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-01-2025', 'dd-mm-yyyy'), 3, 6049, 149, 1249);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-05-2024', 'dd-mm-yyyy'), 21, 6050, 150, 1250);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-01-2025', 'dd-mm-yyyy'), 22, 6051, 151, 1251);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-05-2024', 'dd-mm-yyyy'), 14, 6052, 152, 1252);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-12-2023', 'dd-mm-yyyy'), 10, 6053, 153, 1253);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-08-2024', 'dd-mm-yyyy'), 12, 6054, 154, 1254);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-02-2025', 'dd-mm-yyyy'), 14, 6055, 155, 1255);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-04-2024', 'dd-mm-yyyy'), 17, 6056, 156, 1256);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-07-2023', 'dd-mm-yyyy'), 19, 6057, 157, 1257);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-02-2024', 'dd-mm-yyyy'), 21, 6058, 158, 1258);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-05-2024', 'dd-mm-yyyy'), 9, 6059, 159, 1259);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-10-2023', 'dd-mm-yyyy'), 1, 6060, 160, 1260);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-10-2024', 'dd-mm-yyyy'), 16, 6061, 161, 1261);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-12-2024', 'dd-mm-yyyy'), 15, 6062, 162, 1262);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-12-2023', 'dd-mm-yyyy'), 15, 6063, 163, 1263);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-11-2023', 'dd-mm-yyyy'), 1, 6064, 164, 1264);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-12-2023', 'dd-mm-yyyy'), 15, 6065, 165, 1265);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-08-2023', 'dd-mm-yyyy'), 19, 6066, 166, 1266);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-08-2023', 'dd-mm-yyyy'), 10, 6067, 167, 1267);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-10-2024', 'dd-mm-yyyy'), 19, 6068, 168, 1268);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-01-2025', 'dd-mm-yyyy'), 12, 6069, 169, 1269);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-02-2025', 'dd-mm-yyyy'), 16, 6070, 170, 1270);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-11-2024', 'dd-mm-yyyy'), 15, 6071, 171, 1271);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-06-2023', 'dd-mm-yyyy'), 9, 6072, 172, 1272);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-12-2023', 'dd-mm-yyyy'), 2, 6073, 173, 1273);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-07-2023', 'dd-mm-yyyy'), 23, 6074, 174, 1274);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-12-2024', 'dd-mm-yyyy'), 14, 6075, 175, 1275);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-05-2024', 'dd-mm-yyyy'), 10, 6076, 176, 1276);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-01-2025', 'dd-mm-yyyy'), 18, 6077, 177, 1277);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-06-2024', 'dd-mm-yyyy'), 23, 6078, 178, 1278);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-07-2024', 'dd-mm-yyyy'), 4, 6079, 179, 1279);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-08-2023', 'dd-mm-yyyy'), 23, 6080, 180, 1280);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-03-2024', 'dd-mm-yyyy'), 1, 6081, 181, 1281);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-09-2024', 'dd-mm-yyyy'), 2, 6082, 182, 1282);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-07-2023', 'dd-mm-yyyy'), 17, 6083, 183, 1283);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-02-2024', 'dd-mm-yyyy'), 9, 6084, 184, 1284);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-07-2023', 'dd-mm-yyyy'), 14, 6085, 185, 1285);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-01-2024', 'dd-mm-yyyy'), 9, 6086, 186, 1286);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-01-2025', 'dd-mm-yyyy'), 5, 6087, 187, 1287);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-10-2023', 'dd-mm-yyyy'), 12, 6088, 188, 1288);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-12-2024', 'dd-mm-yyyy'), 20, 6089, 189, 1289);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-09-2024', 'dd-mm-yyyy'), 19, 6090, 190, 1290);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-12-2024', 'dd-mm-yyyy'), 10, 6091, 191, 1291);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-05-2024', 'dd-mm-yyyy'), 9, 6092, 192, 1292);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-01-2025', 'dd-mm-yyyy'), 21, 6093, 193, 1293);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 1, 6094, 194, 1294);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-11-2024', 'dd-mm-yyyy'), 2, 6095, 195, 1295);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-03-2024', 'dd-mm-yyyy'), 2, 6096, 196, 1296);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-05-2024', 'dd-mm-yyyy'), 23, 6097, 197, 1297);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-02-2024', 'dd-mm-yyyy'), 15, 6098, 198, 1298);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-07-2024', 'dd-mm-yyyy'), 7, 6099, 199, 1299);
commit;
prompt 100 records committed...
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-07-2023', 'dd-mm-yyyy'), 3, 6100, 200, 1300);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-01-2024', 'dd-mm-yyyy'), 6, 6101, 201, 1301);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-09-2024', 'dd-mm-yyyy'), 2, 6102, 202, 1302);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-02-2024', 'dd-mm-yyyy'), 11, 6103, 203, 1303);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-02-2024', 'dd-mm-yyyy'), 9, 6104, 204, 1304);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-03-2024', 'dd-mm-yyyy'), 24, 6105, 205, 1305);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-08-2024', 'dd-mm-yyyy'), 13, 6106, 206, 1306);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-04-2024', 'dd-mm-yyyy'), 6, 6107, 207, 1307);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-07-2023', 'dd-mm-yyyy'), 5, 6108, 208, 1308);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-09-2023', 'dd-mm-yyyy'), 8, 6109, 209, 1309);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-12-2023', 'dd-mm-yyyy'), 5, 6110, 210, 1310);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-09-2023', 'dd-mm-yyyy'), 12, 6111, 211, 1311);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-07-2024', 'dd-mm-yyyy'), 1, 6112, 212, 1312);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-12-2024', 'dd-mm-yyyy'), 22, 6113, 213, 1313);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-05-2024', 'dd-mm-yyyy'), 1, 6114, 214, 1314);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-06-2023', 'dd-mm-yyyy'), 7, 6115, 215, 1315);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-01-2024', 'dd-mm-yyyy'), 6, 6116, 216, 1316);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-06-2023', 'dd-mm-yyyy'), 10, 6117, 217, 1317);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-07-2024', 'dd-mm-yyyy'), 22, 6118, 218, 1318);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-11-2023', 'dd-mm-yyyy'), 12, 6119, 219, 1319);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-07-2023', 'dd-mm-yyyy'), 8, 6120, 220, 1320);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-04-2024', 'dd-mm-yyyy'), 6, 6121, 221, 1321);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-12-2023', 'dd-mm-yyyy'), 23, 6122, 222, 1322);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-11-2024', 'dd-mm-yyyy'), 1, 6123, 223, 1323);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-04-2024', 'dd-mm-yyyy'), 15, 6124, 224, 1324);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-05-2024', 'dd-mm-yyyy'), 2, 6125, 225, 1325);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-07-2024', 'dd-mm-yyyy'), 2, 6126, 226, 1326);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-09-2023', 'dd-mm-yyyy'), 3, 6127, 227, 1327);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-02-2025', 'dd-mm-yyyy'), 7, 6128, 228, 1328);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-07-2024', 'dd-mm-yyyy'), 19, 6129, 229, 1329);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-11-2024', 'dd-mm-yyyy'), 5, 6130, 230, 1330);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-07-2024', 'dd-mm-yyyy'), 20, 6131, 231, 1331);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-03-2024', 'dd-mm-yyyy'), 11, 6132, 232, 1332);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-04-2024', 'dd-mm-yyyy'), 10, 6133, 233, 1333);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-07-2023', 'dd-mm-yyyy'), 22, 6134, 234, 1334);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-09-2023', 'dd-mm-yyyy'), 7, 6135, 235, 1335);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-06-2024', 'dd-mm-yyyy'), 20, 6136, 236, 1336);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-08-2024', 'dd-mm-yyyy'), 24, 6137, 237, 1337);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-07-2023', 'dd-mm-yyyy'), 4, 6138, 238, 1338);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-07-2024', 'dd-mm-yyyy'), 13, 6139, 239, 1339);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-12-2023', 'dd-mm-yyyy'), 13, 6140, 240, 1340);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-07-2024', 'dd-mm-yyyy'), 5, 6141, 241, 1341);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-07-2023', 'dd-mm-yyyy'), 11, 6142, 242, 1342);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-06-2024', 'dd-mm-yyyy'), 13, 6143, 243, 1343);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-10-2024', 'dd-mm-yyyy'), 7, 6144, 244, 1344);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-09-2024', 'dd-mm-yyyy'), 19, 6145, 245, 1345);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-07-2024', 'dd-mm-yyyy'), 18, 6146, 246, 1346);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-05-2024', 'dd-mm-yyyy'), 11, 6147, 247, 1347);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-09-2024', 'dd-mm-yyyy'), 16, 6148, 248, 1348);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-12-2023', 'dd-mm-yyyy'), 16, 6149, 249, 1349);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-02-2024', 'dd-mm-yyyy'), 20, 6150, 250, 1350);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-09-2023', 'dd-mm-yyyy'), 24, 6151, 251, 1351);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-09-2024', 'dd-mm-yyyy'), 7, 6152, 252, 1352);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-07-2024', 'dd-mm-yyyy'), 7, 6153, 253, 1353);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-06-2023', 'dd-mm-yyyy'), 12, 6154, 254, 1354);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-10-2023', 'dd-mm-yyyy'), 24, 6155, 255, 1355);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 21, 6156, 256, 1356);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-01-2024', 'dd-mm-yyyy'), 16, 6157, 257, 1357);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-10-2023', 'dd-mm-yyyy'), 20, 6158, 258, 1358);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-02-2024', 'dd-mm-yyyy'), 19, 6159, 259, 1359);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-08-2024', 'dd-mm-yyyy'), 6, 6160, 260, 1360);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-10-2023', 'dd-mm-yyyy'), 19, 6161, 261, 1361);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-06-2024', 'dd-mm-yyyy'), 9, 6162, 262, 1362);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-12-2024', 'dd-mm-yyyy'), 4, 6163, 263, 1363);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-11-2024', 'dd-mm-yyyy'), 6, 6164, 264, 1364);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-07-2024', 'dd-mm-yyyy'), 10, 6165, 265, 1365);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-08-2024', 'dd-mm-yyyy'), 23, 6166, 266, 1366);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-12-2023', 'dd-mm-yyyy'), 6, 6167, 267, 1367);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-12-2023', 'dd-mm-yyyy'), 19, 6168, 268, 1368);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-12-2023', 'dd-mm-yyyy'), 11, 6169, 269, 1369);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-07-2023', 'dd-mm-yyyy'), 19, 6170, 270, 1370);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-02-2024', 'dd-mm-yyyy'), 8, 6171, 271, 1371);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-09-2024', 'dd-mm-yyyy'), 23, 6172, 272, 1372);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-08-2023', 'dd-mm-yyyy'), 8, 6173, 273, 1373);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-01-2025', 'dd-mm-yyyy'), 20, 6174, 274, 1374);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-01-2025', 'dd-mm-yyyy'), 10, 6175, 275, 1375);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-07-2024', 'dd-mm-yyyy'), 5, 6176, 276, 1376);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-01-2025', 'dd-mm-yyyy'), 17, 6177, 277, 1377);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-07-2023', 'dd-mm-yyyy'), 11, 6178, 278, 1378);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-12-2023', 'dd-mm-yyyy'), 15, 6179, 279, 1379);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-11-2023', 'dd-mm-yyyy'), 4, 6180, 280, 1380);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-10-2023', 'dd-mm-yyyy'), 23, 6181, 281, 1381);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-04-2024', 'dd-mm-yyyy'), 6, 6182, 282, 1382);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-01-2025', 'dd-mm-yyyy'), 9, 6183, 283, 1383);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-08-2023', 'dd-mm-yyyy'), 9, 6184, 284, 1384);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-10-2023', 'dd-mm-yyyy'), 6, 6185, 285, 1385);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-03-2024', 'dd-mm-yyyy'), 19, 6186, 286, 1386);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-12-2024', 'dd-mm-yyyy'), 5, 6187, 287, 1387);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-09-2023', 'dd-mm-yyyy'), 3, 6188, 288, 1388);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-02-2025', 'dd-mm-yyyy'), 18, 6189, 289, 1389);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-08-2023', 'dd-mm-yyyy'), 8, 6190, 290, 1390);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-07-2023', 'dd-mm-yyyy'), 20, 6191, 291, 1391);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-11-2023', 'dd-mm-yyyy'), 3, 6192, 292, 1392);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-07-2023', 'dd-mm-yyyy'), 2, 6193, 293, 1393);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-10-2024', 'dd-mm-yyyy'), 13, 6194, 294, 1394);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-07-2024', 'dd-mm-yyyy'), 4, 6195, 295, 1395);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-01-2024', 'dd-mm-yyyy'), 21, 6196, 296, 1396);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-02-2024', 'dd-mm-yyyy'), 24, 6197, 297, 1397);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-11-2024', 'dd-mm-yyyy'), 17, 6198, 298, 1398);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-07-2023', 'dd-mm-yyyy'), 18, 6199, 299, 1399);
commit;
prompt 200 records committed...
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-12-2023', 'dd-mm-yyyy'), 22, 6200, 300, 1400);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-12-2024', 'dd-mm-yyyy'), 12, 6201, 301, 1401);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-10-2023', 'dd-mm-yyyy'), 14, 6202, 302, 1402);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-01-2025', 'dd-mm-yyyy'), 14, 6203, 303, 1403);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-05-2024', 'dd-mm-yyyy'), 21, 6204, 304, 1404);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 6, 6205, 305, 1405);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-10-2023', 'dd-mm-yyyy'), 15, 6206, 306, 1406);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-10-2024', 'dd-mm-yyyy'), 21, 6207, 307, 1407);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 1, 6208, 308, 1408);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-02-2024', 'dd-mm-yyyy'), 18, 6209, 309, 1409);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 9, 6210, 310, 1410);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-09-2023', 'dd-mm-yyyy'), 21, 6211, 311, 1411);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-12-2024', 'dd-mm-yyyy'), 16, 6212, 312, 1412);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-12-2024', 'dd-mm-yyyy'), 20, 6213, 313, 1413);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-01-2025', 'dd-mm-yyyy'), 16, 6214, 314, 1414);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-06-2024', 'dd-mm-yyyy'), 23, 6215, 315, 1415);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-03-2024', 'dd-mm-yyyy'), 2, 6216, 316, 1416);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-02-2024', 'dd-mm-yyyy'), 3, 6217, 317, 1417);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 7, 6218, 318, 1418);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-06-2024', 'dd-mm-yyyy'), 13, 6219, 319, 1419);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-09-2023', 'dd-mm-yyyy'), 2, 6220, 320, 1420);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-02-2025', 'dd-mm-yyyy'), 14, 6221, 321, 1421);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-06-2024', 'dd-mm-yyyy'), 8, 6222, 322, 1422);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 7, 6223, 323, 1423);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-08-2023', 'dd-mm-yyyy'), 7, 6224, 324, 1424);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-05-2024', 'dd-mm-yyyy'), 6, 6225, 325, 1425);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-01-2024', 'dd-mm-yyyy'), 21, 6226, 326, 1426);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-08-2023', 'dd-mm-yyyy'), 2, 6227, 327, 1427);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-09-2024', 'dd-mm-yyyy'), 14, 6228, 328, 1428);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-04-2024', 'dd-mm-yyyy'), 13, 6229, 329, 1429);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-06-2023', 'dd-mm-yyyy'), 10, 6230, 330, 1430);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-09-2024', 'dd-mm-yyyy'), 23, 6231, 331, 1431);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-02-2025', 'dd-mm-yyyy'), 9, 6232, 332, 1432);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-07-2024', 'dd-mm-yyyy'), 15, 6233, 333, 1433);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-11-2023', 'dd-mm-yyyy'), 24, 6234, 334, 1434);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-10-2024', 'dd-mm-yyyy'), 20, 6235, 335, 1435);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-01-2024', 'dd-mm-yyyy'), 22, 6236, 336, 1436);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-09-2023', 'dd-mm-yyyy'), 5, 6237, 337, 1437);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-11-2023', 'dd-mm-yyyy'), 23, 6238, 338, 1438);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-01-2025', 'dd-mm-yyyy'), 17, 6239, 339, 1439);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-02-2024', 'dd-mm-yyyy'), 24, 6240, 340, 1440);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-10-2024', 'dd-mm-yyyy'), 24, 6241, 341, 1441);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-12-2024', 'dd-mm-yyyy'), 11, 6242, 342, 1442);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-09-2024', 'dd-mm-yyyy'), 24, 6243, 343, 1443);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-09-2024', 'dd-mm-yyyy'), 5, 6244, 344, 1444);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-01-2024', 'dd-mm-yyyy'), 8, 6245, 345, 1445);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-07-2023', 'dd-mm-yyyy'), 23, 6246, 346, 1446);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-09-2024', 'dd-mm-yyyy'), 13, 6247, 347, 1447);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-02-2024', 'dd-mm-yyyy'), 21, 6248, 348, 1448);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-11-2024', 'dd-mm-yyyy'), 15, 6249, 349, 1449);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-10-2023', 'dd-mm-yyyy'), 22, 6250, 350, 1450);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-03-2024', 'dd-mm-yyyy'), 9, 6251, 351, 1451);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-11-2023', 'dd-mm-yyyy'), 17, 6252, 352, 1452);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-11-2023', 'dd-mm-yyyy'), 3, 6253, 353, 1453);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-07-2023', 'dd-mm-yyyy'), 11, 6254, 354, 1454);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-11-2023', 'dd-mm-yyyy'), 4, 6255, 355, 1455);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-10-2023', 'dd-mm-yyyy'), 18, 6256, 356, 1456);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-01-2025', 'dd-mm-yyyy'), 6, 6257, 357, 1457);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-02-2025', 'dd-mm-yyyy'), 10, 6258, 358, 1458);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-07-2024', 'dd-mm-yyyy'), 14, 6259, 359, 1459);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-04-2024', 'dd-mm-yyyy'), 18, 6260, 360, 1460);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-11-2024', 'dd-mm-yyyy'), 6, 6261, 361, 1461);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-09-2024', 'dd-mm-yyyy'), 13, 6262, 362, 1462);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-11-2023', 'dd-mm-yyyy'), 21, 6263, 363, 1463);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-12-2023', 'dd-mm-yyyy'), 5, 6264, 364, 1464);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-12-2023', 'dd-mm-yyyy'), 19, 6265, 365, 1465);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-07-2023', 'dd-mm-yyyy'), 16, 6266, 366, 1466);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-11-2024', 'dd-mm-yyyy'), 2, 6267, 367, 1467);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-10-2024', 'dd-mm-yyyy'), 18, 6268, 368, 1468);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-03-2024', 'dd-mm-yyyy'), 5, 6269, 369, 1469);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-02-2024', 'dd-mm-yyyy'), 15, 6270, 370, 1470);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-07-2023', 'dd-mm-yyyy'), 18, 6271, 371, 1471);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-08-2024', 'dd-mm-yyyy'), 19, 6272, 372, 1472);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-11-2023', 'dd-mm-yyyy'), 6, 6273, 373, 1473);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-07-2024', 'dd-mm-yyyy'), 3, 6274, 374, 1474);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-10-2023', 'dd-mm-yyyy'), 13, 6275, 375, 1475);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-09-2023', 'dd-mm-yyyy'), 4, 6276, 376, 1476);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-11-2023', 'dd-mm-yyyy'), 21, 6277, 377, 1477);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-11-2024', 'dd-mm-yyyy'), 1, 6278, 378, 1478);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-10-2023', 'dd-mm-yyyy'), 8, 6279, 379, 1479);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-09-2023', 'dd-mm-yyyy'), 13, 6280, 380, 1480);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-08-2024', 'dd-mm-yyyy'), 16, 6281, 381, 1481);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-02-2024', 'dd-mm-yyyy'), 1, 6282, 382, 1482);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-08-2024', 'dd-mm-yyyy'), 20, 6283, 383, 1483);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-10-2024', 'dd-mm-yyyy'), 3, 6284, 384, 1484);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-03-2024', 'dd-mm-yyyy'), 4, 6285, 385, 1485);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-08-2023', 'dd-mm-yyyy'), 3, 6286, 386, 1486);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-06-2024', 'dd-mm-yyyy'), 6, 6287, 387, 1487);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-12-2023', 'dd-mm-yyyy'), 4, 6288, 388, 1488);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-02-2024', 'dd-mm-yyyy'), 9, 6289, 389, 1489);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-02-2024', 'dd-mm-yyyy'), 12, 6290, 390, 1490);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-07-2024', 'dd-mm-yyyy'), 24, 6291, 391, 1491);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-04-2024', 'dd-mm-yyyy'), 20, 6292, 392, 1492);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-09-2024', 'dd-mm-yyyy'), 9, 6293, 393, 1493);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-10-2023', 'dd-mm-yyyy'), 8, 6294, 394, 1494);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-04-2024', 'dd-mm-yyyy'), 9, 6295, 395, 1495);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-01-2025', 'dd-mm-yyyy'), 13, 6296, 396, 1496);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-04-2024', 'dd-mm-yyyy'), 13, 6297, 397, 1497);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-08-2023', 'dd-mm-yyyy'), 24, 6298, 398, 1498);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-08-2024', 'dd-mm-yyyy'), 18, 6299, 399, 1499);
commit;
prompt 300 records committed...
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-02-2025', 'dd-mm-yyyy'), 8, 6300, 400, 1500);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-02-2024', 'dd-mm-yyyy'), 2, 6301, 401, 1501);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-07-2024', 'dd-mm-yyyy'), 6, 6302, 402, 1502);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-06-2023', 'dd-mm-yyyy'), 3, 6303, 403, 1503);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-02-2024', 'dd-mm-yyyy'), 13, 6304, 404, 1504);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-07-2023', 'dd-mm-yyyy'), 21, 6305, 405, 1505);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-07-2023', 'dd-mm-yyyy'), 9, 6306, 406, 1506);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-11-2024', 'dd-mm-yyyy'), 19, 6307, 407, 1507);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-01-2025', 'dd-mm-yyyy'), 22, 6308, 408, 1508);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-11-2023', 'dd-mm-yyyy'), 8, 6309, 409, 1509);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-11-2024', 'dd-mm-yyyy'), 15, 6310, 410, 1510);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-12-2024', 'dd-mm-yyyy'), 20, 6311, 411, 1511);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-08-2023', 'dd-mm-yyyy'), 5, 6312, 412, 1512);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-02-2024', 'dd-mm-yyyy'), 24, 6313, 413, 1513);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-08-2023', 'dd-mm-yyyy'), 21, 6314, 414, 1514);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-01-2025', 'dd-mm-yyyy'), 17, 6315, 415, 1515);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-09-2023', 'dd-mm-yyyy'), 17, 6316, 416, 1516);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 9, 6317, 417, 1517);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-06-2024', 'dd-mm-yyyy'), 17, 6318, 418, 1518);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-05-2024', 'dd-mm-yyyy'), 8, 6319, 419, 1519);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-12-2023', 'dd-mm-yyyy'), 13, 6320, 420, 1520);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-10-2023', 'dd-mm-yyyy'), 20, 6321, 421, 1521);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-10-2023', 'dd-mm-yyyy'), 4, 6322, 422, 1522);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-06-2023', 'dd-mm-yyyy'), 7, 6323, 423, 1523);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-06-2024', 'dd-mm-yyyy'), 5, 6324, 424, 1524);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-07-2023', 'dd-mm-yyyy'), 12, 6325, 425, 1525);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-11-2023', 'dd-mm-yyyy'), 8, 6326, 426, 1526);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-08-2023', 'dd-mm-yyyy'), 24, 6327, 427, 1527);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-07-2023', 'dd-mm-yyyy'), 10, 6328, 428, 1528);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-05-2024', 'dd-mm-yyyy'), 2, 6329, 429, 1529);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-10-2023', 'dd-mm-yyyy'), 22, 6330, 430, 1530);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('30-06-2023', 'dd-mm-yyyy'), 20, 6331, 431, 1531);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-06-2023', 'dd-mm-yyyy'), 17, 6332, 432, 1532);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-02-2024', 'dd-mm-yyyy'), 5, 6333, 433, 1533);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-01-2024', 'dd-mm-yyyy'), 3, 6334, 434, 1534);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-08-2024', 'dd-mm-yyyy'), 4, 6335, 435, 1535);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-07-2023', 'dd-mm-yyyy'), 16, 6336, 436, 1536);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-12-2023', 'dd-mm-yyyy'), 11, 6337, 437, 1537);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-01-2024', 'dd-mm-yyyy'), 8, 6338, 438, 1538);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-01-2024', 'dd-mm-yyyy'), 6, 6339, 439, 1539);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-12-2024', 'dd-mm-yyyy'), 18, 6340, 440, 1540);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-06-2024', 'dd-mm-yyyy'), 9, 6341, 441, 1541);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-10-2023', 'dd-mm-yyyy'), 12, 6342, 442, 1542);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-02-2025', 'dd-mm-yyyy'), 19, 6343, 443, 1543);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-10-2024', 'dd-mm-yyyy'), 18, 6344, 444, 1544);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-11-2024', 'dd-mm-yyyy'), 12, 6345, 445, 1545);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-11-2023', 'dd-mm-yyyy'), 3, 6346, 446, 1546);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 16, 6347, 447, 1547);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-07-2024', 'dd-mm-yyyy'), 23, 6348, 448, 1548);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-10-2023', 'dd-mm-yyyy'), 12, 6349, 449, 1549);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-05-2024', 'dd-mm-yyyy'), 19, 6350, 450, 1550);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-02-2024', 'dd-mm-yyyy'), 1, 6351, 451, 1551);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-08-2024', 'dd-mm-yyyy'), 14, 6352, 452, 1552);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-06-2024', 'dd-mm-yyyy'), 13, 6353, 453, 1553);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-06-2024', 'dd-mm-yyyy'), 21, 6354, 454, 1554);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-09-2023', 'dd-mm-yyyy'), 13, 6355, 455, 1555);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-07-2024', 'dd-mm-yyyy'), 11, 6356, 456, 1556);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-11-2023', 'dd-mm-yyyy'), 11, 6357, 457, 1557);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-07-2023', 'dd-mm-yyyy'), 20, 6358, 458, 1558);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-06-2023', 'dd-mm-yyyy'), 16, 6359, 459, 1559);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-05-2024', 'dd-mm-yyyy'), 18, 6360, 460, 1560);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-08-2024', 'dd-mm-yyyy'), 22, 6361, 461, 1561);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-01-2024', 'dd-mm-yyyy'), 14, 6362, 462, 1562);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-11-2024', 'dd-mm-yyyy'), 9, 6363, 463, 1563);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-01-2025', 'dd-mm-yyyy'), 24, 6364, 464, 1564);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-07-2023', 'dd-mm-yyyy'), 22, 6365, 465, 1565);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-09-2023', 'dd-mm-yyyy'), 18, 6366, 466, 1566);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-03-2024', 'dd-mm-yyyy'), 9, 6367, 467, 1567);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-02-2024', 'dd-mm-yyyy'), 9, 6368, 468, 1568);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-11-2024', 'dd-mm-yyyy'), 6, 6369, 469, 1569);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-06-2024', 'dd-mm-yyyy'), 3, 6370, 470, 1570);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-12-2024', 'dd-mm-yyyy'), 3, 6371, 471, 1571);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-06-2024', 'dd-mm-yyyy'), 6, 6372, 472, 1572);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-10-2024', 'dd-mm-yyyy'), 22, 6373, 473, 1573);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-04-2024', 'dd-mm-yyyy'), 19, 6374, 474, 1574);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-11-2024', 'dd-mm-yyyy'), 17, 6375, 475, 1575);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-07-2023', 'dd-mm-yyyy'), 2, 6376, 476, 1576);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-10-2023', 'dd-mm-yyyy'), 7, 6377, 477, 1577);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-01-2024', 'dd-mm-yyyy'), 8, 6378, 478, 1578);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-10-2024', 'dd-mm-yyyy'), 6, 6379, 479, 1579);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-10-2023', 'dd-mm-yyyy'), 19, 6380, 480, 1580);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-02-2024', 'dd-mm-yyyy'), 11, 6381, 481, 1581);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-09-2023', 'dd-mm-yyyy'), 20, 6382, 482, 1582);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-01-2024', 'dd-mm-yyyy'), 7, 6383, 483, 1583);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('21-09-2023', 'dd-mm-yyyy'), 24, 6384, 484, 1584);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-11-2023', 'dd-mm-yyyy'), 24, 6385, 485, 1585);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-07-2023', 'dd-mm-yyyy'), 3, 6386, 486, 1586);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-01-2025', 'dd-mm-yyyy'), 15, 6387, 487, 1587);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('22-06-2024', 'dd-mm-yyyy'), 21, 6388, 488, 1588);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-03-2024', 'dd-mm-yyyy'), 14, 6389, 489, 1589);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-09-2024', 'dd-mm-yyyy'), 20, 6390, 490, 1590);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-07-2023', 'dd-mm-yyyy'), 1, 6391, 491, 1591);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-07-2024', 'dd-mm-yyyy'), 23, 6392, 492, 1592);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-08-2024', 'dd-mm-yyyy'), 1, 6393, 493, 1593);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-07-2024', 'dd-mm-yyyy'), 19, 6394, 494, 1594);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-10-2023', 'dd-mm-yyyy'), 6, 6395, 495, 1595);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-02-2024', 'dd-mm-yyyy'), 8, 6396, 496, 1596);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-02-2024', 'dd-mm-yyyy'), 6, 6397, 497, 1597);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-11-2023', 'dd-mm-yyyy'), 14, 6398, 498, 1598);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-07-2024', 'dd-mm-yyyy'), 6, 6399, 499, 1599);
commit;
prompt 400 records committed...
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-11-2024', 'dd-mm-yyyy'), 17, 6400, 500, 1600);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-02-2024', 'dd-mm-yyyy'), 7, 6401, 501, 1601);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-02-2024', 'dd-mm-yyyy'), 23, 6402, 502, 1602);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-02-2024', 'dd-mm-yyyy'), 11, 6403, 503, 1603);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 14, 6404, 504, 1604);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-04-2024', 'dd-mm-yyyy'), 16, 6405, 505, 1605);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-01-2025', 'dd-mm-yyyy'), 8, 6406, 506, 1606);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-11-2024', 'dd-mm-yyyy'), 8, 6407, 507, 1607);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-08-2024', 'dd-mm-yyyy'), 11, 6408, 508, 1608);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('02-03-2024', 'dd-mm-yyyy'), 24, 6409, 509, 1609);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-09-2023', 'dd-mm-yyyy'), 13, 6410, 510, 1610);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-10-2024', 'dd-mm-yyyy'), 24, 6411, 511, 1611);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-12-2023', 'dd-mm-yyyy'), 7, 6412, 512, 1612);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-08-2023', 'dd-mm-yyyy'), 4, 6413, 513, 1613);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-01-2024', 'dd-mm-yyyy'), 6, 6414, 514, 1614);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-08-2024', 'dd-mm-yyyy'), 22, 6415, 515, 1615);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-10-2024', 'dd-mm-yyyy'), 8, 6416, 516, 1616);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-08-2024', 'dd-mm-yyyy'), 13, 6417, 517, 1617);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-01-2025', 'dd-mm-yyyy'), 14, 6418, 518, 1618);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('19-06-2024', 'dd-mm-yyyy'), 10, 6419, 519, 1619);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-01-2024', 'dd-mm-yyyy'), 10, 6420, 520, 1620);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('13-02-2024', 'dd-mm-yyyy'), 15, 6421, 521, 1621);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-08-2024', 'dd-mm-yyyy'), 11, 6422, 522, 1622);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-12-2023', 'dd-mm-yyyy'), 23, 6423, 523, 1623);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('27-07-2024', 'dd-mm-yyyy'), 1, 6424, 524, 1624);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('17-07-2024', 'dd-mm-yyyy'), 17, 6425, 525, 1625);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-04-2024', 'dd-mm-yyyy'), 2, 6426, 526, 1626);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-12-2024', 'dd-mm-yyyy'), 15, 6427, 527, 1627);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-01-2024', 'dd-mm-yyyy'), 13, 6428, 528, 1628);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('08-10-2024', 'dd-mm-yyyy'), 14, 6429, 529, 1629);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-11-2023', 'dd-mm-yyyy'), 20, 6430, 530, 1630);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-10-2023', 'dd-mm-yyyy'), 6, 6431, 531, 1631);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-06-2023', 'dd-mm-yyyy'), 1, 6432, 532, 1632);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-04-2024', 'dd-mm-yyyy'), 11, 6433, 533, 1633);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('28-03-2024', 'dd-mm-yyyy'), 10, 6434, 534, 1634);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('14-11-2024', 'dd-mm-yyyy'), 12, 6435, 535, 1635);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('03-09-2024', 'dd-mm-yyyy'), 6, 6436, 536, 1636);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('16-07-2024', 'dd-mm-yyyy'), 3, 6437, 537, 1637);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-04-2024', 'dd-mm-yyyy'), 13, 6438, 538, 1638);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-06-2024', 'dd-mm-yyyy'), 5, 6439, 539, 1639);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('18-08-2023', 'dd-mm-yyyy'), 6, 6440, 540, 1640);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 19, 6441, 541, 1641);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('20-07-2023', 'dd-mm-yyyy'), 10, 6442, 542, 1642);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-06-2024', 'dd-mm-yyyy'), 7, 6443, 543, 1643);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('15-12-2023', 'dd-mm-yyyy'), 15, 6444, 544, 1644);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-09-2024', 'dd-mm-yyyy'), 21, 6445, 545, 1645);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-04-2024', 'dd-mm-yyyy'), 9, 6446, 546, 1646);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('11-11-2023', 'dd-mm-yyyy'), 3, 6447, 547, 1647);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('24-03-2024', 'dd-mm-yyyy'), 23, 6448, 548, 1648);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-12-2024', 'dd-mm-yyyy'), 13, 6449, 549, 1649);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('23-02-2024', 'dd-mm-yyyy'), 4, 6450, 550, 1650);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-11-2024', 'dd-mm-yyyy'), 8, 6451, 551, 1651);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-04-2024', 'dd-mm-yyyy'), 14, 6452, 552, 1652);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('05-10-2024', 'dd-mm-yyyy'), 21, 6453, 553, 1653);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('12-12-2023', 'dd-mm-yyyy'), 1, 6454, 554, 1654);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('04-01-2025', 'dd-mm-yyyy'), 4, 6455, 555, 1655);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('07-11-2024', 'dd-mm-yyyy'), 20, 6456, 556, 1656);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('10-12-2024', 'dd-mm-yyyy'), 12, 6457, 557, 1657);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('06-10-2024', 'dd-mm-yyyy'), 6, 6458, 558, 1658);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-10-2023', 'dd-mm-yyyy'), 18, 6459, 559, 1659);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('31-08-2024', 'dd-mm-yyyy'), 1, 6460, 560, 1660);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('26-07-2023', 'dd-mm-yyyy'), 10, 6461, 561, 1661);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-01-2025', 'dd-mm-yyyy'), 9, 6462, 562, 1662);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('25-01-2024', 'dd-mm-yyyy'), 19, 6463, 563, 1663);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('29-05-2024', 'dd-mm-yyyy'), 4, 6464, 564, 1664);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-07-2024', 'dd-mm-yyyy'), 3, 6465, 245, 1345);
insert into OPERATION (operation_date, duration_operation, operation_id, patient_id, room_id)
values (to_date('01-08-2025', 'dd-mm-yyyy'), 3, 6466, 305, 1350);
commit;
prompt 467 records loaded
prompt Loading ASSIST_BY...
insert into ASSIST_BY (nurse_id, operation_id)
values (3600, 6000);
insert into ASSIST_BY (nurse_id, operation_id)
values (3601, 6001);
insert into ASSIST_BY (nurse_id, operation_id)
values (3602, 6002);
insert into ASSIST_BY (nurse_id, operation_id)
values (3603, 6003);
insert into ASSIST_BY (nurse_id, operation_id)
values (3604, 6004);
insert into ASSIST_BY (nurse_id, operation_id)
values (3605, 6005);
insert into ASSIST_BY (nurse_id, operation_id)
values (3606, 6006);
insert into ASSIST_BY (nurse_id, operation_id)
values (3607, 6007);
insert into ASSIST_BY (nurse_id, operation_id)
values (3608, 6008);
insert into ASSIST_BY (nurse_id, operation_id)
values (3609, 6009);
insert into ASSIST_BY (nurse_id, operation_id)
values (3610, 6010);
insert into ASSIST_BY (nurse_id, operation_id)
values (3611, 6011);
insert into ASSIST_BY (nurse_id, operation_id)
values (3612, 6012);
insert into ASSIST_BY (nurse_id, operation_id)
values (3613, 6013);
insert into ASSIST_BY (nurse_id, operation_id)
values (3614, 6014);
insert into ASSIST_BY (nurse_id, operation_id)
values (3615, 6015);
insert into ASSIST_BY (nurse_id, operation_id)
values (3616, 6016);
insert into ASSIST_BY (nurse_id, operation_id)
values (3617, 6017);
insert into ASSIST_BY (nurse_id, operation_id)
values (3618, 6018);
insert into ASSIST_BY (nurse_id, operation_id)
values (3619, 6019);
insert into ASSIST_BY (nurse_id, operation_id)
values (3620, 6020);
insert into ASSIST_BY (nurse_id, operation_id)
values (3621, 6021);
insert into ASSIST_BY (nurse_id, operation_id)
values (3622, 6022);
insert into ASSIST_BY (nurse_id, operation_id)
values (3623, 6023);
insert into ASSIST_BY (nurse_id, operation_id)
values (3624, 6024);
insert into ASSIST_BY (nurse_id, operation_id)
values (3625, 6025);
insert into ASSIST_BY (nurse_id, operation_id)
values (3626, 6026);
insert into ASSIST_BY (nurse_id, operation_id)
values (3627, 6027);
insert into ASSIST_BY (nurse_id, operation_id)
values (3628, 6028);
insert into ASSIST_BY (nurse_id, operation_id)
values (3629, 6029);
insert into ASSIST_BY (nurse_id, operation_id)
values (3630, 6030);
insert into ASSIST_BY (nurse_id, operation_id)
values (3631, 6031);
insert into ASSIST_BY (nurse_id, operation_id)
values (3632, 6032);
insert into ASSIST_BY (nurse_id, operation_id)
values (3633, 6033);
insert into ASSIST_BY (nurse_id, operation_id)
values (3634, 6034);
insert into ASSIST_BY (nurse_id, operation_id)
values (3635, 6035);
insert into ASSIST_BY (nurse_id, operation_id)
values (3636, 6036);
insert into ASSIST_BY (nurse_id, operation_id)
values (3637, 6037);
insert into ASSIST_BY (nurse_id, operation_id)
values (3638, 6038);
insert into ASSIST_BY (nurse_id, operation_id)
values (3639, 6039);
insert into ASSIST_BY (nurse_id, operation_id)
values (3640, 6040);
insert into ASSIST_BY (nurse_id, operation_id)
values (3641, 6041);
insert into ASSIST_BY (nurse_id, operation_id)
values (3642, 6042);
insert into ASSIST_BY (nurse_id, operation_id)
values (3643, 6043);
insert into ASSIST_BY (nurse_id, operation_id)
values (3644, 6044);
insert into ASSIST_BY (nurse_id, operation_id)
values (3645, 6045);
insert into ASSIST_BY (nurse_id, operation_id)
values (3646, 6046);
insert into ASSIST_BY (nurse_id, operation_id)
values (3647, 6047);
insert into ASSIST_BY (nurse_id, operation_id)
values (3648, 6048);
insert into ASSIST_BY (nurse_id, operation_id)
values (3649, 6049);
insert into ASSIST_BY (nurse_id, operation_id)
values (3650, 6050);
insert into ASSIST_BY (nurse_id, operation_id)
values (3651, 6051);
insert into ASSIST_BY (nurse_id, operation_id)
values (3652, 6052);
insert into ASSIST_BY (nurse_id, operation_id)
values (3653, 6053);
insert into ASSIST_BY (nurse_id, operation_id)
values (3654, 6054);
insert into ASSIST_BY (nurse_id, operation_id)
values (3655, 6055);
insert into ASSIST_BY (nurse_id, operation_id)
values (3656, 6056);
insert into ASSIST_BY (nurse_id, operation_id)
values (3657, 6057);
insert into ASSIST_BY (nurse_id, operation_id)
values (3658, 6058);
insert into ASSIST_BY (nurse_id, operation_id)
values (3659, 6059);
insert into ASSIST_BY (nurse_id, operation_id)
values (3660, 6060);
insert into ASSIST_BY (nurse_id, operation_id)
values (3661, 6061);
insert into ASSIST_BY (nurse_id, operation_id)
values (3662, 6062);
insert into ASSIST_BY (nurse_id, operation_id)
values (3663, 6063);
insert into ASSIST_BY (nurse_id, operation_id)
values (3664, 6064);
insert into ASSIST_BY (nurse_id, operation_id)
values (3665, 6065);
insert into ASSIST_BY (nurse_id, operation_id)
values (3666, 6066);
insert into ASSIST_BY (nurse_id, operation_id)
values (3667, 6067);
insert into ASSIST_BY (nurse_id, operation_id)
values (3668, 6068);
insert into ASSIST_BY (nurse_id, operation_id)
values (3669, 6069);
insert into ASSIST_BY (nurse_id, operation_id)
values (3670, 6070);
insert into ASSIST_BY (nurse_id, operation_id)
values (3671, 6071);
insert into ASSIST_BY (nurse_id, operation_id)
values (3672, 6072);
insert into ASSIST_BY (nurse_id, operation_id)
values (3673, 6073);
insert into ASSIST_BY (nurse_id, operation_id)
values (3674, 6074);
insert into ASSIST_BY (nurse_id, operation_id)
values (3675, 6075);
insert into ASSIST_BY (nurse_id, operation_id)
values (3676, 6076);
insert into ASSIST_BY (nurse_id, operation_id)
values (3677, 6077);
insert into ASSIST_BY (nurse_id, operation_id)
values (3678, 6078);
insert into ASSIST_BY (nurse_id, operation_id)
values (3679, 6079);
insert into ASSIST_BY (nurse_id, operation_id)
values (3680, 6080);
insert into ASSIST_BY (nurse_id, operation_id)
values (3681, 6081);
insert into ASSIST_BY (nurse_id, operation_id)
values (3682, 6082);
insert into ASSIST_BY (nurse_id, operation_id)
values (3683, 6083);
insert into ASSIST_BY (nurse_id, operation_id)
values (3684, 6084);
insert into ASSIST_BY (nurse_id, operation_id)
values (3685, 6085);
insert into ASSIST_BY (nurse_id, operation_id)
values (3686, 6086);
insert into ASSIST_BY (nurse_id, operation_id)
values (3687, 6087);
insert into ASSIST_BY (nurse_id, operation_id)
values (3688, 6088);
insert into ASSIST_BY (nurse_id, operation_id)
values (3689, 6089);
insert into ASSIST_BY (nurse_id, operation_id)
values (3690, 6090);
insert into ASSIST_BY (nurse_id, operation_id)
values (3691, 6091);
insert into ASSIST_BY (nurse_id, operation_id)
values (3692, 6092);
insert into ASSIST_BY (nurse_id, operation_id)
values (3693, 6093);
insert into ASSIST_BY (nurse_id, operation_id)
values (3694, 6094);
insert into ASSIST_BY (nurse_id, operation_id)
values (3695, 6095);
insert into ASSIST_BY (nurse_id, operation_id)
values (3696, 6096);
insert into ASSIST_BY (nurse_id, operation_id)
values (3697, 6097);
insert into ASSIST_BY (nurse_id, operation_id)
values (3698, 6098);
insert into ASSIST_BY (nurse_id, operation_id)
values (3699, 6099);
commit;
prompt 100 records committed...
insert into ASSIST_BY (nurse_id, operation_id)
values (3700, 6100);
insert into ASSIST_BY (nurse_id, operation_id)
values (3701, 6101);
insert into ASSIST_BY (nurse_id, operation_id)
values (3702, 6102);
insert into ASSIST_BY (nurse_id, operation_id)
values (3703, 6103);
insert into ASSIST_BY (nurse_id, operation_id)
values (3704, 6104);
insert into ASSIST_BY (nurse_id, operation_id)
values (3705, 6105);
insert into ASSIST_BY (nurse_id, operation_id)
values (3706, 6106);
insert into ASSIST_BY (nurse_id, operation_id)
values (3707, 6107);
insert into ASSIST_BY (nurse_id, operation_id)
values (3708, 6108);
insert into ASSIST_BY (nurse_id, operation_id)
values (3709, 6109);
insert into ASSIST_BY (nurse_id, operation_id)
values (3710, 6110);
insert into ASSIST_BY (nurse_id, operation_id)
values (3711, 6111);
insert into ASSIST_BY (nurse_id, operation_id)
values (3712, 6112);
insert into ASSIST_BY (nurse_id, operation_id)
values (3713, 6113);
insert into ASSIST_BY (nurse_id, operation_id)
values (3714, 6114);
insert into ASSIST_BY (nurse_id, operation_id)
values (3715, 6115);
insert into ASSIST_BY (nurse_id, operation_id)
values (3716, 6116);
insert into ASSIST_BY (nurse_id, operation_id)
values (3717, 6117);
insert into ASSIST_BY (nurse_id, operation_id)
values (3718, 6118);
insert into ASSIST_BY (nurse_id, operation_id)
values (3719, 6119);
insert into ASSIST_BY (nurse_id, operation_id)
values (3720, 6120);
insert into ASSIST_BY (nurse_id, operation_id)
values (3721, 6121);
insert into ASSIST_BY (nurse_id, operation_id)
values (3722, 6122);
insert into ASSIST_BY (nurse_id, operation_id)
values (3723, 6123);
insert into ASSIST_BY (nurse_id, operation_id)
values (3724, 6124);
insert into ASSIST_BY (nurse_id, operation_id)
values (3725, 6125);
insert into ASSIST_BY (nurse_id, operation_id)
values (3726, 6126);
insert into ASSIST_BY (nurse_id, operation_id)
values (3727, 6127);
insert into ASSIST_BY (nurse_id, operation_id)
values (3728, 6128);
insert into ASSIST_BY (nurse_id, operation_id)
values (3729, 6129);
insert into ASSIST_BY (nurse_id, operation_id)
values (3730, 6130);
insert into ASSIST_BY (nurse_id, operation_id)
values (3731, 6131);
insert into ASSIST_BY (nurse_id, operation_id)
values (3732, 6132);
insert into ASSIST_BY (nurse_id, operation_id)
values (3733, 6133);
insert into ASSIST_BY (nurse_id, operation_id)
values (3734, 6134);
insert into ASSIST_BY (nurse_id, operation_id)
values (3735, 6135);
insert into ASSIST_BY (nurse_id, operation_id)
values (3736, 6136);
insert into ASSIST_BY (nurse_id, operation_id)
values (3737, 6137);
insert into ASSIST_BY (nurse_id, operation_id)
values (3738, 6138);
insert into ASSIST_BY (nurse_id, operation_id)
values (3739, 6139);
insert into ASSIST_BY (nurse_id, operation_id)
values (3740, 6140);
insert into ASSIST_BY (nurse_id, operation_id)
values (3741, 6141);
insert into ASSIST_BY (nurse_id, operation_id)
values (3742, 6142);
insert into ASSIST_BY (nurse_id, operation_id)
values (3743, 6143);
insert into ASSIST_BY (nurse_id, operation_id)
values (3744, 6144);
insert into ASSIST_BY (nurse_id, operation_id)
values (3745, 6145);
insert into ASSIST_BY (nurse_id, operation_id)
values (3746, 6146);
insert into ASSIST_BY (nurse_id, operation_id)
values (3747, 6147);
insert into ASSIST_BY (nurse_id, operation_id)
values (3748, 6148);
insert into ASSIST_BY (nurse_id, operation_id)
values (3749, 6149);
insert into ASSIST_BY (nurse_id, operation_id)
values (3750, 6150);
insert into ASSIST_BY (nurse_id, operation_id)
values (3751, 6151);
insert into ASSIST_BY (nurse_id, operation_id)
values (3752, 6152);
insert into ASSIST_BY (nurse_id, operation_id)
values (3753, 6153);
insert into ASSIST_BY (nurse_id, operation_id)
values (3754, 6154);
insert into ASSIST_BY (nurse_id, operation_id)
values (3755, 6155);
insert into ASSIST_BY (nurse_id, operation_id)
values (3756, 6156);
insert into ASSIST_BY (nurse_id, operation_id)
values (3757, 6157);
insert into ASSIST_BY (nurse_id, operation_id)
values (3758, 6158);
insert into ASSIST_BY (nurse_id, operation_id)
values (3759, 6159);
insert into ASSIST_BY (nurse_id, operation_id)
values (3760, 6160);
insert into ASSIST_BY (nurse_id, operation_id)
values (3761, 6161);
insert into ASSIST_BY (nurse_id, operation_id)
values (3762, 6162);
insert into ASSIST_BY (nurse_id, operation_id)
values (3763, 6163);
insert into ASSIST_BY (nurse_id, operation_id)
values (3764, 6164);
insert into ASSIST_BY (nurse_id, operation_id)
values (3765, 6165);
insert into ASSIST_BY (nurse_id, operation_id)
values (3766, 6166);
insert into ASSIST_BY (nurse_id, operation_id)
values (3767, 6167);
insert into ASSIST_BY (nurse_id, operation_id)
values (3768, 6168);
insert into ASSIST_BY (nurse_id, operation_id)
values (3769, 6169);
insert into ASSIST_BY (nurse_id, operation_id)
values (3770, 6170);
insert into ASSIST_BY (nurse_id, operation_id)
values (3771, 6171);
insert into ASSIST_BY (nurse_id, operation_id)
values (3772, 6172);
insert into ASSIST_BY (nurse_id, operation_id)
values (3773, 6173);
insert into ASSIST_BY (nurse_id, operation_id)
values (3774, 6174);
insert into ASSIST_BY (nurse_id, operation_id)
values (3775, 6175);
insert into ASSIST_BY (nurse_id, operation_id)
values (3776, 6176);
insert into ASSIST_BY (nurse_id, operation_id)
values (3777, 6177);
insert into ASSIST_BY (nurse_id, operation_id)
values (3778, 6178);
insert into ASSIST_BY (nurse_id, operation_id)
values (3779, 6179);
insert into ASSIST_BY (nurse_id, operation_id)
values (3780, 6180);
insert into ASSIST_BY (nurse_id, operation_id)
values (3781, 6181);
insert into ASSIST_BY (nurse_id, operation_id)
values (3782, 6182);
insert into ASSIST_BY (nurse_id, operation_id)
values (3783, 6183);
insert into ASSIST_BY (nurse_id, operation_id)
values (3784, 6184);
insert into ASSIST_BY (nurse_id, operation_id)
values (3785, 6185);
insert into ASSIST_BY (nurse_id, operation_id)
values (3786, 6186);
insert into ASSIST_BY (nurse_id, operation_id)
values (3787, 6187);
insert into ASSIST_BY (nurse_id, operation_id)
values (3788, 6188);
insert into ASSIST_BY (nurse_id, operation_id)
values (3789, 6189);
insert into ASSIST_BY (nurse_id, operation_id)
values (3790, 6190);
insert into ASSIST_BY (nurse_id, operation_id)
values (3791, 6191);
insert into ASSIST_BY (nurse_id, operation_id)
values (3792, 6192);
insert into ASSIST_BY (nurse_id, operation_id)
values (3793, 6193);
insert into ASSIST_BY (nurse_id, operation_id)
values (3794, 6194);
insert into ASSIST_BY (nurse_id, operation_id)
values (3795, 6195);
insert into ASSIST_BY (nurse_id, operation_id)
values (3796, 6196);
insert into ASSIST_BY (nurse_id, operation_id)
values (3797, 6197);
insert into ASSIST_BY (nurse_id, operation_id)
values (3798, 6198);
insert into ASSIST_BY (nurse_id, operation_id)
values (3799, 6199);
commit;
prompt 200 records committed...
insert into ASSIST_BY (nurse_id, operation_id)
values (3800, 6200);
insert into ASSIST_BY (nurse_id, operation_id)
values (3801, 6201);
insert into ASSIST_BY (nurse_id, operation_id)
values (3802, 6202);
insert into ASSIST_BY (nurse_id, operation_id)
values (3803, 6203);
insert into ASSIST_BY (nurse_id, operation_id)
values (3804, 6204);
insert into ASSIST_BY (nurse_id, operation_id)
values (3805, 6205);
insert into ASSIST_BY (nurse_id, operation_id)
values (3806, 6206);
insert into ASSIST_BY (nurse_id, operation_id)
values (3807, 6207);
insert into ASSIST_BY (nurse_id, operation_id)
values (3808, 6208);
insert into ASSIST_BY (nurse_id, operation_id)
values (3809, 6209);
insert into ASSIST_BY (nurse_id, operation_id)
values (3810, 6210);
insert into ASSIST_BY (nurse_id, operation_id)
values (3811, 6211);
insert into ASSIST_BY (nurse_id, operation_id)
values (3812, 6212);
insert into ASSIST_BY (nurse_id, operation_id)
values (3813, 6213);
insert into ASSIST_BY (nurse_id, operation_id)
values (3814, 6214);
insert into ASSIST_BY (nurse_id, operation_id)
values (3815, 6215);
insert into ASSIST_BY (nurse_id, operation_id)
values (3816, 6216);
insert into ASSIST_BY (nurse_id, operation_id)
values (3817, 6217);
insert into ASSIST_BY (nurse_id, operation_id)
values (3818, 6218);
insert into ASSIST_BY (nurse_id, operation_id)
values (3819, 6219);
insert into ASSIST_BY (nurse_id, operation_id)
values (3820, 6220);
insert into ASSIST_BY (nurse_id, operation_id)
values (3821, 6221);
insert into ASSIST_BY (nurse_id, operation_id)
values (3822, 6222);
insert into ASSIST_BY (nurse_id, operation_id)
values (3823, 6223);
insert into ASSIST_BY (nurse_id, operation_id)
values (3824, 6224);
insert into ASSIST_BY (nurse_id, operation_id)
values (3825, 6225);
insert into ASSIST_BY (nurse_id, operation_id)
values (3826, 6226);
insert into ASSIST_BY (nurse_id, operation_id)
values (3827, 6227);
insert into ASSIST_BY (nurse_id, operation_id)
values (3828, 6228);
insert into ASSIST_BY (nurse_id, operation_id)
values (3829, 6229);
insert into ASSIST_BY (nurse_id, operation_id)
values (3830, 6230);
insert into ASSIST_BY (nurse_id, operation_id)
values (3831, 6231);
insert into ASSIST_BY (nurse_id, operation_id)
values (3832, 6232);
insert into ASSIST_BY (nurse_id, operation_id)
values (3833, 6233);
insert into ASSIST_BY (nurse_id, operation_id)
values (3834, 6234);
insert into ASSIST_BY (nurse_id, operation_id)
values (3835, 6235);
insert into ASSIST_BY (nurse_id, operation_id)
values (3836, 6236);
insert into ASSIST_BY (nurse_id, operation_id)
values (3837, 6237);
insert into ASSIST_BY (nurse_id, operation_id)
values (3838, 6238);
insert into ASSIST_BY (nurse_id, operation_id)
values (3839, 6239);
insert into ASSIST_BY (nurse_id, operation_id)
values (3840, 6240);
insert into ASSIST_BY (nurse_id, operation_id)
values (3841, 6241);
insert into ASSIST_BY (nurse_id, operation_id)
values (3842, 6242);
insert into ASSIST_BY (nurse_id, operation_id)
values (3843, 6243);
insert into ASSIST_BY (nurse_id, operation_id)
values (3844, 6244);
insert into ASSIST_BY (nurse_id, operation_id)
values (3845, 6245);
insert into ASSIST_BY (nurse_id, operation_id)
values (3846, 6246);
insert into ASSIST_BY (nurse_id, operation_id)
values (3847, 6247);
insert into ASSIST_BY (nurse_id, operation_id)
values (3848, 6248);
insert into ASSIST_BY (nurse_id, operation_id)
values (3849, 6249);
insert into ASSIST_BY (nurse_id, operation_id)
values (3850, 6250);
insert into ASSIST_BY (nurse_id, operation_id)
values (3851, 6251);
insert into ASSIST_BY (nurse_id, operation_id)
values (3852, 6252);
insert into ASSIST_BY (nurse_id, operation_id)
values (3853, 6253);
insert into ASSIST_BY (nurse_id, operation_id)
values (3854, 6254);
insert into ASSIST_BY (nurse_id, operation_id)
values (3855, 6255);
insert into ASSIST_BY (nurse_id, operation_id)
values (3856, 6256);
insert into ASSIST_BY (nurse_id, operation_id)
values (3857, 6257);
insert into ASSIST_BY (nurse_id, operation_id)
values (3858, 6258);
insert into ASSIST_BY (nurse_id, operation_id)
values (3859, 6259);
insert into ASSIST_BY (nurse_id, operation_id)
values (3860, 6260);
insert into ASSIST_BY (nurse_id, operation_id)
values (3861, 6261);
insert into ASSIST_BY (nurse_id, operation_id)
values (3862, 6262);
insert into ASSIST_BY (nurse_id, operation_id)
values (3863, 6263);
insert into ASSIST_BY (nurse_id, operation_id)
values (3864, 6264);
insert into ASSIST_BY (nurse_id, operation_id)
values (3865, 6265);
insert into ASSIST_BY (nurse_id, operation_id)
values (3866, 6266);
insert into ASSIST_BY (nurse_id, operation_id)
values (3867, 6267);
insert into ASSIST_BY (nurse_id, operation_id)
values (3868, 6268);
insert into ASSIST_BY (nurse_id, operation_id)
values (3869, 6269);
insert into ASSIST_BY (nurse_id, operation_id)
values (3870, 6270);
insert into ASSIST_BY (nurse_id, operation_id)
values (3871, 6271);
insert into ASSIST_BY (nurse_id, operation_id)
values (3872, 6272);
insert into ASSIST_BY (nurse_id, operation_id)
values (3873, 6273);
insert into ASSIST_BY (nurse_id, operation_id)
values (3874, 6274);
insert into ASSIST_BY (nurse_id, operation_id)
values (3875, 6275);
insert into ASSIST_BY (nurse_id, operation_id)
values (3876, 6276);
insert into ASSIST_BY (nurse_id, operation_id)
values (3877, 6277);
insert into ASSIST_BY (nurse_id, operation_id)
values (3878, 6278);
insert into ASSIST_BY (nurse_id, operation_id)
values (3879, 6279);
insert into ASSIST_BY (nurse_id, operation_id)
values (3880, 6280);
insert into ASSIST_BY (nurse_id, operation_id)
values (3881, 6281);
insert into ASSIST_BY (nurse_id, operation_id)
values (3882, 6282);
insert into ASSIST_BY (nurse_id, operation_id)
values (3883, 6283);
insert into ASSIST_BY (nurse_id, operation_id)
values (3884, 6284);
insert into ASSIST_BY (nurse_id, operation_id)
values (3885, 6285);
insert into ASSIST_BY (nurse_id, operation_id)
values (3886, 6286);
insert into ASSIST_BY (nurse_id, operation_id)
values (3887, 6287);
insert into ASSIST_BY (nurse_id, operation_id)
values (3888, 6288);
insert into ASSIST_BY (nurse_id, operation_id)
values (3889, 6289);
insert into ASSIST_BY (nurse_id, operation_id)
values (3890, 6290);
insert into ASSIST_BY (nurse_id, operation_id)
values (3891, 6291);
insert into ASSIST_BY (nurse_id, operation_id)
values (3892, 6292);
insert into ASSIST_BY (nurse_id, operation_id)
values (3893, 6293);
insert into ASSIST_BY (nurse_id, operation_id)
values (3894, 6294);
insert into ASSIST_BY (nurse_id, operation_id)
values (3895, 6295);
insert into ASSIST_BY (nurse_id, operation_id)
values (3896, 6296);
insert into ASSIST_BY (nurse_id, operation_id)
values (3897, 6297);
insert into ASSIST_BY (nurse_id, operation_id)
values (3898, 6298);
insert into ASSIST_BY (nurse_id, operation_id)
values (3899, 6299);
commit;
prompt 300 records committed...
insert into ASSIST_BY (nurse_id, operation_id)
values (3900, 6300);
insert into ASSIST_BY (nurse_id, operation_id)
values (3901, 6301);
insert into ASSIST_BY (nurse_id, operation_id)
values (3902, 6302);
insert into ASSIST_BY (nurse_id, operation_id)
values (3903, 6303);
insert into ASSIST_BY (nurse_id, operation_id)
values (3904, 6304);
insert into ASSIST_BY (nurse_id, operation_id)
values (3905, 6305);
insert into ASSIST_BY (nurse_id, operation_id)
values (3906, 6306);
insert into ASSIST_BY (nurse_id, operation_id)
values (3907, 6307);
insert into ASSIST_BY (nurse_id, operation_id)
values (3908, 6308);
insert into ASSIST_BY (nurse_id, operation_id)
values (3909, 6309);
insert into ASSIST_BY (nurse_id, operation_id)
values (3910, 6310);
insert into ASSIST_BY (nurse_id, operation_id)
values (3911, 6311);
insert into ASSIST_BY (nurse_id, operation_id)
values (3912, 6312);
insert into ASSIST_BY (nurse_id, operation_id)
values (3913, 6313);
insert into ASSIST_BY (nurse_id, operation_id)
values (3914, 6314);
insert into ASSIST_BY (nurse_id, operation_id)
values (3915, 6315);
insert into ASSIST_BY (nurse_id, operation_id)
values (3916, 6316);
insert into ASSIST_BY (nurse_id, operation_id)
values (3917, 6317);
insert into ASSIST_BY (nurse_id, operation_id)
values (3918, 6318);
insert into ASSIST_BY (nurse_id, operation_id)
values (3919, 6319);
insert into ASSIST_BY (nurse_id, operation_id)
values (3920, 6320);
insert into ASSIST_BY (nurse_id, operation_id)
values (3921, 6321);
insert into ASSIST_BY (nurse_id, operation_id)
values (3922, 6322);
insert into ASSIST_BY (nurse_id, operation_id)
values (3923, 6323);
insert into ASSIST_BY (nurse_id, operation_id)
values (3924, 6324);
insert into ASSIST_BY (nurse_id, operation_id)
values (3925, 6325);
insert into ASSIST_BY (nurse_id, operation_id)
values (3926, 6326);
insert into ASSIST_BY (nurse_id, operation_id)
values (3927, 6327);
insert into ASSIST_BY (nurse_id, operation_id)
values (3928, 6328);
insert into ASSIST_BY (nurse_id, operation_id)
values (3929, 6329);
insert into ASSIST_BY (nurse_id, operation_id)
values (3930, 6330);
insert into ASSIST_BY (nurse_id, operation_id)
values (3931, 6331);
insert into ASSIST_BY (nurse_id, operation_id)
values (3932, 6332);
insert into ASSIST_BY (nurse_id, operation_id)
values (3933, 6333);
insert into ASSIST_BY (nurse_id, operation_id)
values (3934, 6334);
insert into ASSIST_BY (nurse_id, operation_id)
values (3935, 6335);
insert into ASSIST_BY (nurse_id, operation_id)
values (3936, 6336);
insert into ASSIST_BY (nurse_id, operation_id)
values (3937, 6337);
insert into ASSIST_BY (nurse_id, operation_id)
values (3938, 6338);
insert into ASSIST_BY (nurse_id, operation_id)
values (3939, 6339);
insert into ASSIST_BY (nurse_id, operation_id)
values (3940, 6340);
insert into ASSIST_BY (nurse_id, operation_id)
values (3941, 6341);
insert into ASSIST_BY (nurse_id, operation_id)
values (3942, 6342);
insert into ASSIST_BY (nurse_id, operation_id)
values (3943, 6343);
insert into ASSIST_BY (nurse_id, operation_id)
values (3944, 6344);
insert into ASSIST_BY (nurse_id, operation_id)
values (3945, 6345);
insert into ASSIST_BY (nurse_id, operation_id)
values (3946, 6346);
insert into ASSIST_BY (nurse_id, operation_id)
values (3947, 6347);
insert into ASSIST_BY (nurse_id, operation_id)
values (3948, 6348);
insert into ASSIST_BY (nurse_id, operation_id)
values (3949, 6349);
insert into ASSIST_BY (nurse_id, operation_id)
values (3950, 6350);
insert into ASSIST_BY (nurse_id, operation_id)
values (3951, 6351);
insert into ASSIST_BY (nurse_id, operation_id)
values (3952, 6352);
insert into ASSIST_BY (nurse_id, operation_id)
values (3953, 6353);
insert into ASSIST_BY (nurse_id, operation_id)
values (3954, 6354);
insert into ASSIST_BY (nurse_id, operation_id)
values (3955, 6355);
insert into ASSIST_BY (nurse_id, operation_id)
values (3956, 6356);
insert into ASSIST_BY (nurse_id, operation_id)
values (3957, 6357);
insert into ASSIST_BY (nurse_id, operation_id)
values (3958, 6358);
insert into ASSIST_BY (nurse_id, operation_id)
values (3959, 6359);
insert into ASSIST_BY (nurse_id, operation_id)
values (3960, 6360);
insert into ASSIST_BY (nurse_id, operation_id)
values (3961, 6361);
insert into ASSIST_BY (nurse_id, operation_id)
values (3962, 6362);
insert into ASSIST_BY (nurse_id, operation_id)
values (3963, 6363);
insert into ASSIST_BY (nurse_id, operation_id)
values (3964, 6364);
insert into ASSIST_BY (nurse_id, operation_id)
values (3965, 6365);
insert into ASSIST_BY (nurse_id, operation_id)
values (3966, 6366);
insert into ASSIST_BY (nurse_id, operation_id)
values (3967, 6367);
insert into ASSIST_BY (nurse_id, operation_id)
values (3968, 6368);
insert into ASSIST_BY (nurse_id, operation_id)
values (3969, 6369);
insert into ASSIST_BY (nurse_id, operation_id)
values (3970, 6370);
insert into ASSIST_BY (nurse_id, operation_id)
values (3971, 6371);
insert into ASSIST_BY (nurse_id, operation_id)
values (3972, 6372);
insert into ASSIST_BY (nurse_id, operation_id)
values (3973, 6373);
insert into ASSIST_BY (nurse_id, operation_id)
values (3974, 6374);
insert into ASSIST_BY (nurse_id, operation_id)
values (3975, 6375);
insert into ASSIST_BY (nurse_id, operation_id)
values (3976, 6376);
insert into ASSIST_BY (nurse_id, operation_id)
values (3977, 6377);
insert into ASSIST_BY (nurse_id, operation_id)
values (3978, 6378);
insert into ASSIST_BY (nurse_id, operation_id)
values (3979, 6379);
insert into ASSIST_BY (nurse_id, operation_id)
values (3980, 6380);
insert into ASSIST_BY (nurse_id, operation_id)
values (3981, 6381);
insert into ASSIST_BY (nurse_id, operation_id)
values (3982, 6382);
insert into ASSIST_BY (nurse_id, operation_id)
values (3983, 6383);
insert into ASSIST_BY (nurse_id, operation_id)
values (3984, 6384);
insert into ASSIST_BY (nurse_id, operation_id)
values (3985, 6385);
insert into ASSIST_BY (nurse_id, operation_id)
values (3986, 6386);
insert into ASSIST_BY (nurse_id, operation_id)
values (3987, 6387);
insert into ASSIST_BY (nurse_id, operation_id)
values (3988, 6388);
insert into ASSIST_BY (nurse_id, operation_id)
values (3989, 6389);
insert into ASSIST_BY (nurse_id, operation_id)
values (3990, 6390);
insert into ASSIST_BY (nurse_id, operation_id)
values (3991, 6391);
insert into ASSIST_BY (nurse_id, operation_id)
values (3992, 6392);
insert into ASSIST_BY (nurse_id, operation_id)
values (3993, 6393);
insert into ASSIST_BY (nurse_id, operation_id)
values (3994, 6394);
insert into ASSIST_BY (nurse_id, operation_id)
values (3995, 6395);
insert into ASSIST_BY (nurse_id, operation_id)
values (3996, 6396);
insert into ASSIST_BY (nurse_id, operation_id)
values (3997, 6397);
insert into ASSIST_BY (nurse_id, operation_id)
values (3998, 6398);
insert into ASSIST_BY (nurse_id, operation_id)
values (3999, 6399);
commit;
prompt 400 records loaded
prompt Loading DOCTOR...
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hingle  Amy', 'Reconstructive Surgery', 2402);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Margolyes  Alan', 'Reproductive Surgery', 2403);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rickles  Demi', 'Pediatric Plastic Surgery', 2404);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('DiFranco  Jesse', 'Vascular Surgery', 2405);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Newton  Regina', 'Trauma Surgery', 2406);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Silverman  Marina', 'Neurointerventional Surgery', 2407);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Roundtree  Debi', 'Minimally Invasive Surgery', 2408);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dourif  Bette', 'Joint Replacement Surgery', 2409);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hauer  Anna', 'Neurosurgery', 2410);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Quinlan  Tia', 'Cardiac Surgery', 2411);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Paxton  Natacha', 'Hernia Surgery', 2412);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Day-Lewis  Jimmy', 'Pediatric Plastic Surgery', 2413);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Zahn  Willie', 'Foot and Ankle Surgery', 2414);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Plummer  Debby', 'Robotic Surgery', 2415);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Downie  Alicia', 'Spine Surgery', 2416);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Paymer  Anne', 'Hepatobiliary Surgery', 2417);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Walken  Isaac', 'Pediatric Transplant Surgery', 2418);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Newton  Glenn', 'Foot and Ankle Surgery', 2419);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rea  Billy', 'Joint Replacement Surgery', 2420);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gore  Lou', 'Pediatric Gastrointestinal Surgery', 2421);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Swinton  Dermot', 'Endocrine Surgery', 2422);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cleary  Joely', 'Urologic Surgery', 2423);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Jonze  Ron', 'Pediatric Plastic Surgery', 2424);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Phifer  Maceo', 'Reproductive Surgery', 2425);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Wong  Michelle', 'Pediatric Transplant Surgery', 2426);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Coburn  Rebeka', 'Dermatologic Surgery', 2427);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fox  Terence', 'Pediatric Surgery', 2428);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Palminteri  Kitty', 'Pediatric Trauma Surgery', 2429);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mac  Jena', 'Surgical Critical Care', 2430);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ricci  Caroline', 'Neurointerventional Surgery', 2431);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Affleck  Gino', 'Pediatric Cardiothoracic Surgery', 2432);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Shelton  Rosanna', 'Gynecologic Surgery', 2433);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Blaine  Mike', 'Pediatric Trauma Surgery', 2434);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Stanton  Charles', 'Spine Surgery', 2435);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lewis  Todd', 'Pediatric Plastic Surgery', 2436);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ermey  Kirsten', 'Transplant Surgery', 2437);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Duvall  Terri', 'Minimally Invasive Surgery', 2438);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dalton  Isaiah', 'Pediatric Plastic Surgery', 2439);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Curtis-Hall  Gina', 'Pediatric Endocrine Surgery', 2440);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Iglesias  Denzel', 'Robotic Surgery', 2441);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Murray  Nikki', 'Head and Neck Surgery', 2442);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Olin  Suzanne', 'Surgical Oncology', 2443);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Morse  Connie', 'Breast Surgery', 2444);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Foxx  Jarvis', 'Pediatric Urology', 2445);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Numan  Mark', 'Pediatric Trauma Surgery', 2446);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Springfield  Junior', 'Plastic Surgery', 2447);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rizzo  Alex', 'General Surgery', 2448);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Street  Mae', 'Transplant Surgery', 2449);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Redgrave  Herbie', 'Pediatric Surgery', 2450);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rebhorn  Lois', 'Hernia Surgery', 2451);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Love  Joe', 'Neurointerventional Surgery', 2452);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Salt  Oro', 'Head and Neck Surgery', 2453);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hutton  Cate', 'Surgical Oncology', 2454);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Landau  Nikki', 'Surgical Oncology', 2455);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lee  Salma', 'Trauma Surgery', 2456);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Johansson  Rik', 'Foot and Ankle Surgery', 2457);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Keitel  Delbert', 'Urologic Surgery', 2458);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ruiz  Belinda', 'Breast Surgery', 2459);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Frakes  Timothy', 'Laparoscopic Surgery', 2460);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Day-Lewis  Olympia', 'Orthopedic Surgery', 2461);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Seagal  Lenny', 'Gynecologic Surgery', 2462);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lopez  Denise', 'Pediatric Urology', 2463);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Derringer  Nancy', 'Cardiothoracic Surgery', 2464);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dafoe  Nastassja', 'Neurosurgery', 2465);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ramis  Dylan', 'Minimally Invasive Surgery', 2466);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Leigh  Edward', 'Surgical Oncology', 2467);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Schwimmer  Darren', 'Hepatobiliary Surgery', 2468);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Benet  Nicolas', 'Pediatric Surgical Oncology', 2469);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Horizon  Cesar', 'Trauma and Critical Care Surgery', 2470);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Jeffreys  Grant', 'Pediatric Urology', 2471);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McGinley  Davey', 'Neurointerventional Surgery', 2472);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lorenz  Cary', 'Surgical Critical Care', 2473);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Skaggs  Fionnula', 'Vascular Surgery', 2474);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Madsen  Jean', 'Breast Surgery', 2475);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fiorentino  Naomi', 'Ophthalmic Surgery', 2476);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Vaughan  Daryl', 'Pediatric Cardiothoracic Surgery', 2477);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Scaggs  Rade', 'Reproductive Surgery', 2478);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lynne  Heather', 'Gynecologic Surgery', 2479);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Atkins  Meryl', 'Pediatric Surgery', 2480);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mac  Ali', 'Pediatric Plastic Surgery', 2481);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ifans  Bo', 'Robotic Surgery', 2482);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mortensen  Anna', 'Urologic Surgery', 2483);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('DiFranco  Cesar', 'Bariatric Surgery', 2484);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rain  Gloria', 'Bariatric Surgery', 2485);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kimball  Debi', 'Surgical Critical Care', 2486);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Baez  Tia', 'Pediatric Urology', 2487);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ryan  Rik', 'Gastrointestinal Surgery', 2488);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gatlin  Helen', 'Pediatric Otolaryngology', 2489);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Chan  Dabney', 'Neurosurgery', 2490);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Applegate  Dianne', 'Pediatric Orthopedic Surgery', 2491);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Basinger  Nora', 'Colorectal Surgery', 2492);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kinski  Dabney', 'Spine Surgery', 2493);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Loeb  Franz', 'Reconstructive Surgery', 2494);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Irons  Ving', 'Ophthalmic Surgery', 2495);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Albright  Jay', 'Neurointerventional Surgery', 2496);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Woodward  Lara', 'Pediatric Trauma Surgery', 2497);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Parker  Scott', 'Pediatric Gastrointestinal Surgery', 2498);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gyllenhaal  Rod', 'Surgical Critical Care', 2499);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Vince  Corey', 'Pediatric Transplant Surgery', 2500);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Abraham  Derrick', 'Surgical Critical Care', 2501);
commit;
prompt 100 records committed...
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Snipes  Pelvic', 'Foot and Ankle Surgery', 2502);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Faithfull  Geraldine', 'Pediatric Endocrine Surgery', 2503);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sharp  Toni', 'Bariatric Surgery', 2504);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Idol  Gilbert', 'Urologic Surgery', 2505);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McPherson  Jamie', 'Dermatologic Surgery', 2506);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Serbedzija  Pablo', 'Pediatric Cardiothoracic Surgery', 2507);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Starr  Lari', 'Trauma Surgery', 2508);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kadison  Sandra', 'Gynecologic Surgery', 2509);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Schock  Sissy', 'Dermatologic Surgery', 2510);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Carrere  Rob', 'Dermatologic Surgery', 2511);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McGill  Garland', 'General Surgery', 2512);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bullock  Joey', 'Breast Surgery', 2513);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Maguire  Rory', 'Dermatologic Surgery', 2514);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hatosy  Freddy', 'Endocrine Surgery', 2515);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kurtz  Sander', 'Pediatric Endocrine Surgery', 2516);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Neville  Thelma', 'Orthopedic Surgery', 2517);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Moreno  Dean', 'Pediatric Trauma Surgery', 2518);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Stuermer  Owen', 'Bariatric Surgery', 2519);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cassidy  Kevin', 'Gynecologic Surgery', 2520);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hersh  Peabo', 'Reproductive Surgery', 2521);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Caan  Oro', 'Pediatric Surgical Oncology', 2522);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Reiner  Spencer', 'Colorectal Surgery', 2523);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Deejay  Karon', 'Colorectal Surgery', 2524);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Burton  Joanna', 'Surgical Oncology', 2525);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crimson  Roddy', 'Minimally Invasive Surgery', 2526);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Isaak  Emm', 'Pediatric Orthopedic Surgery', 2527);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Blackwell  Vin', 'Ophthalmic Surgery', 2528);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Wolf  Mark', 'Gastrointestinal Surgery', 2529);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cruz  Laurence', 'Pediatric Urology', 2530);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Duke  Will', 'Plastic Surgery', 2531);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gaynor  Nicolas', 'Pediatric Endocrine Surgery', 2532);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Buscemi  Eliza', 'Pediatric Otolaryngology', 2533);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lucas  Gran', 'Hernia Surgery', 2534);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Parm  Debby', 'Orthopedic Surgery', 2535);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cox  Liev', 'Pediatric Neurosurgery', 2536);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Squier  Lonnie', 'Vascular Surgery', 2537);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bailey  Donal', 'Urologic Surgery', 2538);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gagnon  Dwight', 'Transplant Surgery', 2539);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Brody  Garth', 'Otolaryngology', 2540);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gosdin  Red', 'Pediatric Plastic Surgery', 2541);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sanchez  Debbie', 'Pediatric Transplant Surgery', 2542);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Pastore  Davey', 'Gynecologic Surgery', 2543);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tomlin  Sydney', 'Pediatric Surgery', 2544);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fender  Peabo', 'Foot and Ankle Surgery', 2545);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Norton  Wes', 'Surgical Oncology', 2546);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Biel  Pat', 'Pediatric Neurosurgery', 2547);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Badalucco  Alfie', 'Gastrointestinal Surgery', 2548);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mason  Rebeka', 'Breast Surgery', 2549);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Robinson  Christina', 'Urologic Surgery', 2550);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Garner  Praga', 'Breast Surgery', 2551);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rucker  Regina', 'Gynecologic Surgery', 2552);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lovitz  Jane', 'Pediatric Trauma Surgery', 2553);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Alda  Kimberly', 'Gynecologic Surgery', 2554);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gandolfini  Rosanne', 'Joint Replacement Surgery', 2555);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Danger  Neil', 'Neurosurgery', 2556);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Strathairn  Gran', 'Transplant Surgery', 2557);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Black  Yaphet', 'Surgical Oncology', 2558);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Culkin  Mary Beth', 'Neurosurgery', 2559);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Black  Carrie', 'Head and Neck Surgery', 2560);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Goldberg  Robert', 'Pediatric Gastrointestinal Surgery', 2561);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Milsap  Kevn', 'Endocrine Surgery', 2562);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ward  Randy', 'Bariatric Surgery', 2563);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McGoohan  Emm', 'Neurosurgery', 2564);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Wilson  Scarlett', 'Pediatric Surgery', 2565);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Robards  Ty', 'Neurointerventional Surgery', 2566);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rush  Taryn', 'Pediatric Orthopedic Surgery', 2567);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gugino  Candice', 'Pediatric Plastic Surgery', 2568);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Goldberg  Nigel', 'Laparoscopic Surgery', 2569);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rippy  Leo', 'Foot and Ankle Surgery', 2570);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hawkins  Patricia', 'Surgical Oncology', 2571);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Huston  Robert', 'Reproductive Surgery', 2572);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cocker  Rosco', 'Dermatologic Surgery', 2573);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('O''Connor  Tamala', 'Robotic Surgery', 2574);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Whitmore  Lisa', 'Thoracic Surgery', 2575);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Frakes  Natacha', 'Colorectal Surgery', 2576);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Conlee  Freddy', 'Gynecologic Surgery', 2577);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Finn  Anne', 'Breast Surgery', 2578);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Olin  Isaiah', 'Pediatric Urology', 2579);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Roundtree  Rene', 'Pediatric Trauma Surgery', 2580);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Carter  Chloe', 'Pediatric Trauma Surgery', 2581);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bening  Jay', 'Dermatologic Surgery', 2582);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Theron  Mint', 'Orthopedic Surgery', 2583);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gooding  Gena', 'Colorectal Surgery', 2584);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Jay  Bob', 'Vascular Surgery', 2585);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Watson  Suzy', 'Breast Surgery', 2586);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('MacDonald  Cloris', 'Pediatric Surgery', 2587);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Allen  Tim', 'Transplant Surgery', 2588);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McLean  Courtney', 'Oral and Maxillofacial Surgery', 2589);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cooper  Mary-Louise', 'Pediatric Gastrointestinal Surgery', 2590);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Brosnan  Vonda', 'Surgical Oncology', 2591);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Loring  Danni', 'Laparoscopic Surgery', 2592);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Marin  Matthew', 'Trauma Surgery', 2593);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('DiBiasio  Amanda', 'Pediatric Trauma Surgery', 2594);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Clark  Sydney', 'Transplant Surgery', 2595);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hunter  Christine', 'Laparoscopic Surgery', 2596);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rhodes  Tea', 'Dermatologic Surgery', 2597);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Berkley  Renee', 'Colorectal Surgery', 2598);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Weiland  France', 'Pediatric Urology', 2599);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Howard  Leo', 'Pediatric Gastrointestinal Surgery', 2600);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Esposito  Nikka', 'Robotic Surgery', 2601);
commit;
prompt 200 records committed...
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Vega  Murray', 'Cardiac Surgery', 2602);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sampson  Christian', 'Otolaryngology', 2603);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Voight  Viggo', 'General Surgery', 2604);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lauper  Dan', 'Gastrointestinal Surgery', 2605);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bentley  Sandra', 'Urologic Surgery', 2606);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Judd  Hank', 'Pediatric Otolaryngology', 2607);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ball  Jodie', 'General Surgery', 2608);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Channing  Eliza', 'Surgical Critical Care', 2609);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Boyle  Leelee', 'Otolaryngology', 2610);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Candy  Daryl', 'Oral and Maxillofacial Surgery', 2611);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rivers  Wes', 'Ophthalmic Surgery', 2612);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Logue  Corey', 'Surgical Critical Care', 2613);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tobolowsky  Nikki', 'Surgical Critical Care', 2614);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Epps  Catherine', 'Cardiac Surgery', 2615);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Squier  Selma', 'Gastrointestinal Surgery', 2616);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Pacino  Lenny', 'Ophthalmic Surgery', 2617);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McPherson  Olga', 'Pediatric Surgery', 2618);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Oates  Gena', 'Gastrointestinal Surgery', 2619);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dorff  Alicia', 'Pediatric Transplant Surgery', 2620);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crimson  Maria', 'Pediatric Plastic Surgery', 2621);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gallant  Fiona', 'Pediatric Surgical Oncology', 2622);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cronin  Robbie', 'Endocrine Surgery', 2623);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tarantino  Tramaine', 'Plastic Surgery', 2624);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Idle  Don', 'Breast Surgery', 2625);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Horton  Isabella', 'Pediatric Surgery', 2626);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Margolyes  Sissy', 'Hand Surgery', 2627);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Playboys  Eric', 'Orthopedic Surgery', 2628);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cox  Edie', 'Robotic Surgery', 2629);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('de Lancie  Julia', 'Otolaryngology', 2630);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rhodes  Glen', 'Ophthalmic Surgery', 2631);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sharp  Rita', 'Breast Surgery', 2632);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Stanley  Ozzy', 'Plastic Surgery', 2633);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crowell  Larnelle', 'Transplant Surgery', 2634);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rhys-Davies  Richard', 'Hand Surgery', 2635);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Garcia  Wade', 'Hand Surgery', 2636);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Biel  Kiefer', 'Laparoscopic Surgery', 2637);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hunter  Rosanna', 'Gastrointestinal Surgery', 2638);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Galecki  Lou', 'Pediatric Transplant Surgery', 2639);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crudup  Javon', 'Reproductive Surgery', 2640);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tyson  Glen', 'Urologic Surgery', 2641);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McLachlan  Casey', 'Trauma and Critical Care Surgery', 2642);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gold  Ray', 'Spine Surgery', 2643);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Conroy  Chloe', 'Urologic Surgery', 2644);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('MacDowell  Stockard', 'Endocrine Surgery', 2645);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Wright  Ani', 'Pediatric Gastrointestinal Surgery', 2646);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Herrmann  Ruth', 'Pediatric Gastrointestinal Surgery', 2647);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Pigott-Smith  Aimee', 'Trauma Surgery', 2648);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McCann  Rhona', 'Foot and Ankle Surgery', 2649);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cara  Jody', 'Gastrointestinal Surgery', 2650);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Griffith  Teri', 'Head and Neck Surgery', 2651);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dawson  Alan', 'Vascular Surgery', 2652);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Nelligan  Mira', 'Hepatobiliary Surgery', 2653);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Benoit  Jean-Luc', 'Pediatric Trauma Surgery', 2654);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Eckhart  Carrie', 'Pediatric Orthopedic Surgery', 2655);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Johnson  Kristin', 'Pediatric Transplant Surgery', 2656);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Brosnan  Jonatha', 'Hand Surgery', 2657);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lindley  Beverley', 'Dermatologic Surgery', 2658);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sampson  Vivica', 'Otolaryngology', 2659);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hurt  Ewan', 'Reproductive Surgery', 2660);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McGoohan  Maura', 'Surgical Oncology', 2661);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fox  Yolanda', 'Robotic Surgery', 2662);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Walsh  Wayne', 'Otolaryngology', 2663);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hidalgo  Oliver', 'Laparoscopic Surgery', 2664);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Byrne  Ann', 'Pediatric Endocrine Surgery', 2665);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Raybon  Maxine', 'Neurointerventional Surgery', 2666);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Westerberg  Chazz', 'Cardiac Surgery', 2667);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Wayans  David', 'Ophthalmic Surgery', 2668);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mulroney  Ray', 'Pediatric Surgical Oncology', 2669);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Weaving  Hugh', 'Bariatric Surgery', 2670);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Janney  Paul', 'Pediatric Surgical Oncology', 2671);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Schreiber  Eileen', 'Hand Surgery', 2672);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mahood  Terry', 'Minimally Invasive Surgery', 2673);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kelly  Juice', 'Gastrointestinal Surgery', 2674);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crow  Kathy', 'Pediatric Endocrine Surgery', 2675);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gibbons  Lena', 'Pediatric Cardiothoracic Surgery', 2676);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lorenz  Christmas', 'Neurosurgery', 2677);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dunaway  Radney', 'Reproductive Surgery', 2678);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Haggard  Judd', 'Pediatric Gastrointestinal Surgery', 2679);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Pastore  Harry', 'Head and Neck Surgery', 2680);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Griffin  Spencer', 'Breast Surgery', 2681);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crowe  Charles', 'Colorectal Surgery', 2682);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Shand  Saffron', 'Transplant Surgery', 2683);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Skerritt  Carlos', 'Urologic Surgery', 2684);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Albright  Rodney', 'Dermatologic Surgery', 2685);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Plowright  Elvis', 'Neurointerventional Surgery', 2686);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Saxon  Joely', 'Pediatric Transplant Surgery', 2687);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Houston  Martin', 'Hepatobiliary Surgery', 2688);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Arkenstone  Patricia', 'Pediatric Endocrine Surgery', 2689);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tomlin  Kurtwood', 'Thoracic Surgery', 2690);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hutton  Debby', 'Hernia Surgery', 2691);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rebhorn  Kurt', 'Robotic Surgery', 2692);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Steenburgen  Mandy', 'Ophthalmic Surgery', 2693);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('O''Keefe  Lloyd', 'Surgical Critical Care', 2694);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lane  Chris', 'Pediatric Transplant Surgery', 2695);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hornsby  Chaka', 'Pediatric Trauma Surgery', 2696);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Thurman  Barry', 'Breast Surgery', 2697);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Diggs  Angie', 'Pediatric Transplant Surgery', 2698);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lynn  Amanda', 'Plastic Surgery', 2699);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sayer  Elizabeth', 'Cardiothoracic Surgery', 2700);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Beals  Goran', 'Pediatric Otolaryngology', 2701);
commit;
prompt 300 records committed...
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McGregor  Zooey', 'Laparoscopic Surgery', 2702);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hersh  Sean', 'Pediatric Cardiothoracic Surgery', 2703);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rickles  Brooke', 'Urologic Surgery', 2704);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Humphrey  Aaron', 'Oral and Maxillofacial Surgery', 2705);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Frampton  Humberto', 'Pediatric Surgical Oncology', 2706);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Klugh  Lin', 'Hernia Surgery', 2707);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Postlethwaite  Cameron', 'Trauma Surgery', 2708);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Humphrey  Ron', 'Reproductive Surgery', 2709);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Valentin  Lindsey', 'Colorectal Surgery', 2710);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lennix  Remy', 'Plastic Surgery', 2711);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Winwood  Kelly', 'Otolaryngology', 2712);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bandy  Belinda', 'Foot and Ankle Surgery', 2713);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Atkinson  Howard', 'Pediatric Surgical Oncology', 2714);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Negbaur  Elle', 'Spine Surgery', 2715);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Pacino  Richie', 'Reconstructive Surgery', 2716);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Hunt  Shirley', 'Dermatologic Surgery', 2717);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gryner  Tea', 'Surgical Critical Care', 2718);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Willis  Ryan', 'Gastrointestinal Surgery', 2719);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Thurman  Gabriel', 'General Surgery', 2720);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Woods  CeCe', 'Transplant Surgery', 2721);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Willis  Gil', 'Head and Neck Surgery', 2722);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Apple  Javon', 'Pediatric Trauma Surgery', 2723);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Vannelli  Anthony', 'Trauma and Critical Care Surgery', 2724);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kirkwood  Neil', 'Gastrointestinal Surgery', 2725);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Squier  Rupert', 'Pediatric Otolaryngology', 2726);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Mathis  Shannyn', 'Colorectal Surgery', 2727);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('LaMond  Salma', 'General Surgery', 2728);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tobolowsky  Grace', 'Reconstructive Surgery', 2729);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Turner  Ice', 'Head and Neck Surgery', 2730);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bracco  Josh', 'General Surgery', 2731);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lennix  Toshiro', 'Plastic Surgery', 2732);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dorff  Angie', 'Reproductive Surgery', 2733);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Blige  Selma', 'Cardiothoracic Surgery', 2734);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kirshner  Joseph', 'Ophthalmic Surgery', 2735);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Soul  Kevin', 'Hand Surgery', 2736);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Diesel  Dianne', 'Hernia Surgery', 2737);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sanders  Pamela', 'Pediatric Endocrine Surgery', 2738);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Weber  Tara', 'Breast Surgery', 2739);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Turner  Juliet', 'Dermatologic Surgery', 2740);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Raybon  Kitty', 'Vascular Surgery', 2741);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Keen  Jonny Lee', 'Thoracic Surgery', 2742);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gertner  Joseph', 'Colorectal Surgery', 2743);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Connelly  Tia', 'Transplant Surgery', 2744);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kier  Pamela', 'Trauma and Critical Care Surgery', 2745);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Franks  Ian', 'Robotic Surgery', 2746);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Summer  Mili', 'Pediatric Surgical Oncology', 2747);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tyson  Millie', 'Pediatric Surgery', 2748);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Carradine  Barry', 'Reconstructive Surgery', 2749);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Swank  Dermot', 'Hepatobiliary Surgery', 2750);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Osmond  Robert', 'Pediatric Urology', 2751);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Stevenson  Clarence', 'Hepatobiliary Surgery', 2752);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Carmen  Hookah', 'Reconstructive Surgery', 2753);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cara  Cheech', 'Thoracic Surgery', 2754);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Azaria  Chloe', 'Thoracic Surgery', 2755);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Holmes  Lydia', 'Neurosurgery', 2756);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Koteas  Elizabeth', 'Trauma Surgery', 2757);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rizzo  Nanci', 'Pediatric Urology', 2758);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Macy  Bette', 'Colorectal Surgery', 2759);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Newton  Lee', 'Gynecologic Surgery', 2760);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Nicholson  Marley', 'Laparoscopic Surgery', 2761);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kleinenberg  Victor', 'Pediatric Surgical Oncology', 2762);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Moreno  Rosanna', 'Cardiac Surgery', 2763);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Goldwyn  Cuba', 'Surgical Critical Care', 2764);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dillon  Yolanda', 'Trauma Surgery', 2765);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Suchet  April', 'Breast Surgery', 2766);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('O''Donnell  Mickey', 'Gynecologic Surgery', 2767);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Ricci  Kyle', 'Minimally Invasive Surgery', 2768);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Baez  Ty', 'Neurointerventional Surgery', 2769);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Marin  Jann', 'Neurosurgery', 2770);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Getty  Darius', 'Cardiac Surgery', 2771);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Paquin  Ann', 'Gastrointestinal Surgery', 2772);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Marley  Stephanie', 'Pediatric Transplant Surgery', 2773);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Molina  Robbie', 'Hernia Surgery', 2774);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('McCormack  Frank', 'Trauma Surgery', 2775);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Dench  Belinda', 'Pediatric Transplant Surgery', 2776);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Garber  Hookah', 'Oral and Maxillofacial Surgery', 2777);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fisher  Toni', 'Neurointerventional Surgery', 2778);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Berenger  Nicky', 'Colorectal Surgery', 2779);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Houston  Liv', 'Gastrointestinal Surgery', 2780);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Himmelman  Alfred', 'Ophthalmic Surgery', 2781);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Sweeney  Willem', 'Pediatric Neurosurgery', 2782);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kinney  Jean-Luc', 'Surgical Critical Care', 2783);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Crudup  Cornell', 'Pediatric Endocrine Surgery', 2784);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Suvari  Sissy', 'Dermatologic Surgery', 2785);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rossellini  Ned', 'Pediatric Cardiothoracic Surgery', 2786);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Tyler  Penelope', 'Pediatric Transplant Surgery', 2787);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rockwell  Matthew', 'Ophthalmic Surgery', 2788);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lemmon  Marley', 'Trauma Surgery', 2789);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Lennox  Henry', 'Breast Surgery', 2790);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Allan  Rodney', 'Oral and Maxillofacial Surgery', 2791);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fariq  Uma', 'Gastrointestinal Surgery', 2792);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Keeslar  Nastassja', 'Reproductive Surgery', 2793);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Collette  Kim', 'Spine Surgery', 2794);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Oates  Merillee', 'Minimally Invasive Surgery', 2795);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Detmer  Dianne', 'Oral and Maxillofacial Surgery', 2796);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Camp  Rhys', 'Pediatric Trauma Surgery', 2797);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Duvall  Jonny Lee', 'Minimally Invasive Surgery', 2798);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Murray  Vin', 'Pediatric Otolaryngology', 2799);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Belle  Melba', 'Endocrine Surgery', 2800);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Cole  April', 'Pediatric Surgical Oncology', 2801);
commit;
prompt 400 records committed...
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Fishburne  Julia', 'Pediatric Surgical Oncology', 2802);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Finn  Ty', 'Dermatologic Surgery', 2803);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Teng  Rosanna', 'Colorectal Surgery', 2804);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Martinez  Goldie', 'Colorectal Surgery', 2805);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Heatherly  Derek', 'Hepatobiliary Surgery', 2806);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Coleman  Anne', 'Pediatric Trauma Surgery', 2807);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Leary  Goran', 'Minimally Invasive Surgery', 2808);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Callow  Nigel', 'Pediatric Surgery', 2809);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Quaid  Gil', 'Breast Surgery', 2810);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Chestnut  Halle', 'Cardiothoracic Surgery', 2811);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Oszajca  Lisa', 'Pediatric Endocrine Surgery', 2812);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Neil  Pamela', 'Surgical Critical Care', 2813);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Rhymes  Ozzy', 'Endocrine Surgery', 2814);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Paul  Fats', 'Urologic Surgery', 2815);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('O''Sullivan  Sal', 'Gynecologic Surgery', 2816);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bacharach  Lorraine', 'Hand Surgery', 2817);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Gyllenhaal  Rawlins', 'Pediatric Otolaryngology', 2818);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Bogguss  Ernest', 'Neurointerventional Surgery', 2819);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Perry  Frankie', 'Neurosurgery', 2820);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Robinson  Swoosie', 'Pediatric Trauma Surgery', 2821);
insert into DOCTOR (doctor_name, specialty, doctor_id)
values ('Kravitz  Kelli', 'Robotic Surgery', 2822);
commit;
prompt 421 records loaded
prompt Loading EQUIPEMENT...
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4800, to_date('10-08-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'Maintenance', 1431);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4801, to_date('07-09-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'Maintenance', 1658);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4802, to_date('05-05-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1307);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4803, to_date('24-02-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1402);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4804, to_date('21-09-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1283);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4805, to_date('20-04-2024', 'dd-mm-yyyy'), 'Bone saw', 'not available', 1456);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4806, to_date('09-03-2024', 'dd-mm-yyyy'), 'Retractor', 'not available', 1582);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4807, to_date('23-03-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'IN USE', 1652);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4808, to_date('30-06-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1390);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4809, to_date('04-05-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1468);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4810, to_date('27-07-2024', 'dd-mm-yyyy'), 'Foot pedal', 'not available', 1372);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4811, to_date('15-06-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1451);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4812, to_date('09-03-2024', 'dd-mm-yyyy'), 'Catheter', 'IN USE', 1427);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4813, to_date('28-07-2024', 'dd-mm-yyyy'), 'Surgical tray', 'available', 1274);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4814, to_date('22-09-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1624);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4815, to_date('06-10-2024', 'dd-mm-yyyy'), 'Retractor', 'not available', 1453);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4816, to_date('09-03-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1649);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4817, to_date('05-10-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1226);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4818, to_date('19-02-2024', 'dd-mm-yyyy'), 'Hemostat', 'ul', 1568);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4819, to_date('09-03-2024', 'dd-mm-yyyy'), 'Surgical mask', 'not available', 1496);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4820, to_date('28-01-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1569);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4821, to_date('30-06-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1601);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4822, to_date('21-09-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1609);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4823, to_date('05-02-2024', 'dd-mm-yyyy'), 'Suction canister', 'not available', 1618);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4824, to_date('29-06-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'not available', 1452);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4825, to_date('24-08-2024', 'dd-mm-yyyy'), 'Microscope', 'Maintenance', 1290);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4826, to_date('19-02-2024', 'dd-mm-yyyy'), 'Surgical drill', 'Maintenance', 1544);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4827, to_date('15-06-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'Maintenance', 1217);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4828, to_date('05-02-2024', 'dd-mm-yyyy'), 'Trocars', 'not available', 1467);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4829, to_date('08-09-2024', 'dd-mm-yyyy'), 'Surgical gown', 'Maintenance', 1617);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4830, to_date('15-06-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1583);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4831, to_date('22-09-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1467);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4832, to_date('10-08-2024', 'dd-mm-yyyy'), 'Syringe', 'available', 1306);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4833, to_date('14-07-2024', 'dd-mm-yyyy'), 'Surgical sponge', 'not available', 1294);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4834, to_date('28-07-2024', 'dd-mm-yyyy'), 'Sterile container', 'Maintenance', 1506);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4835, to_date('27-07-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1208);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4836, to_date('06-10-2024', 'dd-mm-yyyy'), 'Smoke evacuator', 'available', 1208);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4837, to_date('19-10-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1645);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4838, to_date('27-07-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1217);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4839, to_date('08-09-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1232);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4840, to_date('20-04-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1579);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4841, to_date('15-12-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1554);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4842, to_date('15-12-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'available', 1294);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4843, to_date('03-11-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'not available', 1572);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4844, to_date('24-02-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'not available', 1208);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4845, to_date('29-06-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'In Use', 1658);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4846, to_date('02-06-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1214);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4847, to_date('29-06-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1589);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4848, to_date('24-08-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'not available', 1565);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4849, to_date('08-09-2024', 'dd-mm-yyyy'), 'Smoke evacuator', 'available', 1659);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4850, to_date('20-04-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1305);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4851, to_date('16-06-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'not available', 1459);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4852, to_date('21-09-2024', 'dd-mm-yyyy'), 'Surgical mask', 'available', 1276);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4853, to_date('14-07-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'not available', 1297);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4854, to_date('11-08-2024', 'dd-mm-yyyy'), 'Sterile container', 'available', 1435);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4855, to_date('09-03-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1326);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4856, to_date('27-07-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1355);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4857, to_date('05-05-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1415);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4858, to_date('31-03-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1566);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4859, to_date('24-08-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1395);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4860, to_date('25-08-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1550);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4861, to_date('19-05-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1227);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4862, to_date('01-06-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'not available', 1372);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4863, to_date('15-06-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1543);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4864, to_date('20-04-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1367);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4865, to_date('10-08-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1301);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4866, to_date('25-08-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1264);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4867, to_date('05-02-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1418);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4868, to_date('06-04-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'not available', 1561);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4869, to_date('01-01-2024', 'dd-mm-yyyy'), 'Surgical tray', 'available', 1316);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4870, to_date('17-11-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1543);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4871, to_date('21-04-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1451);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4872, to_date('06-10-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1416);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4873, to_date('18-05-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1546);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4874, to_date('31-03-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1551);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4875, to_date('06-10-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'In Use', 1431);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4876, to_date('03-11-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1639);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4877, to_date('17-11-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1548);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4878, to_date('09-03-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1628);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4879, to_date('18-05-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1638);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4880, to_date('09-03-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1642);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4881, to_date('04-05-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1652);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4882, to_date('13-01-2024', 'dd-mm-yyyy'), 'IV pole', 'available', 1335);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4883, to_date('04-05-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1306);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4884, to_date('28-01-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1504);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4885, to_date('03-03-2024', 'dd-mm-yyyy'), 'Laparoscope', 'not available', 1647);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4886, to_date('20-04-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1403);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4887, to_date('17-11-2024', 'dd-mm-yyyy'), 'Infusion pump', 'not available', 1271);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4888, to_date('27-07-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'not available', 1582);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4889, to_date('19-05-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1335);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4890, to_date('19-10-2024', 'dd-mm-yyyy'), 'Suction canister', 'available', 1491);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4891, to_date('23-03-2024', 'dd-mm-yyyy'), 'IV pole', 'available', 1606);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4892, to_date('03-11-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1207);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4893, to_date('20-04-2024', 'dd-mm-yyyy'), 'Bone saw', 'available', 1553);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4894, to_date('08-09-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1204);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4895, to_date('11-08-2024', 'dd-mm-yyyy'), 'Surgical sponge', 'available', 1363);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4896, to_date('16-06-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'not available', 1566);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4897, to_date('17-03-2024', 'dd-mm-yyyy'), 'Surgical tray', 'available', 1457);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4898, to_date('05-10-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1584);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4899, to_date('19-10-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1460);
commit;
prompt 100 records committed...
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4900, to_date('10-02-2024', 'dd-mm-yyyy'), 'Syringe', 'available', 1594);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4901, to_date('29-06-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'available', 1415);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4902, to_date('09-03-2024', 'dd-mm-yyyy'), 'C-arm', 'available', 1462);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4903, to_date('28-07-2024', 'dd-mm-yyyy'), 'Endoscope', 'not available', 1503);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4904, to_date('29-06-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1321);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4905, to_date('07-09-2024', 'dd-mm-yyyy'), 'Needle holder', 'available', 1222);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4906, to_date('11-08-2024', 'dd-mm-yyyy'), 'Needle holder', 'not available', 1278);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4907, to_date('06-10-2024', 'dd-mm-yyyy'), 'Sterile container', 'available', 1267);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4908, to_date('05-02-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1503);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4909, to_date('14-07-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1594);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4910, to_date('04-05-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1303);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4911, to_date('03-11-2024', 'dd-mm-yyyy'), 'Catheter', 'available', 1259);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4912, to_date('14-07-2024', 'dd-mm-yyyy'), 'Endoscope', 'not available', 1367);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4913, to_date('01-12-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1448);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4914, to_date('30-06-2024', 'dd-mm-yyyy'), 'Laparoscope', 'not available', 1262);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4915, to_date('01-06-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1400);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4916, to_date('02-06-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1504);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4917, to_date('09-03-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1262);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4918, to_date('21-04-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'available', 1349);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4919, to_date('01-06-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1579);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4920, to_date('19-05-2024', 'dd-mm-yyyy'), 'Suction canister', 'available', 1620);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4921, to_date('08-09-2024', 'dd-mm-yyyy'), 'Surgical tray', 'not available', 1295);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4922, to_date('21-04-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1387);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4923, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'not available', 1277);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4924, to_date('16-06-2024', 'dd-mm-yyyy'), 'Bone saw', 'not available', 1559);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4925, to_date('27-07-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1205);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4926, to_date('04-05-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1381);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4927, to_date('30-06-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1519);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4928, to_date('27-07-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'available', 1389);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4929, to_date('29-12-2024', 'dd-mm-yyyy'), 'Retractor', 'available', 1538);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4930, to_date('06-04-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1602);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4931, to_date('25-08-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1229);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4932, to_date('28-01-2024', 'dd-mm-yyyy'), 'Operating table', 'not available', 1492);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4933, to_date('08-09-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1484);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4934, to_date('20-10-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1277);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4935, to_date('19-02-2024', 'dd-mm-yyyy'), 'IV pole', 'available', 1516);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4936, to_date('02-06-2024', 'dd-mm-yyyy'), 'Endoscope', 'available', 1247);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4937, to_date('17-11-2024', 'dd-mm-yyyy'), 'Syringe', 'available', 1294);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4938, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'available', 1478);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4939, to_date('05-05-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1563);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4940, to_date('16-06-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1455);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4941, to_date('02-06-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1439);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4942, to_date('10-02-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1475);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4943, to_date('05-05-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1516);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4944, to_date('05-05-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1626);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4945, to_date('05-05-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1292);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4946, to_date('03-11-2024', 'dd-mm-yyyy'), 'Surgical tray', 'not available', 1620);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4947, to_date('21-04-2024', 'dd-mm-yyyy'), 'Needle holder', 'available', 1633);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4948, to_date('08-09-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'not available', 1463);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4949, to_date('19-10-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1555);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4950, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1575);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4951, to_date('01-06-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'available', 1445);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4952, to_date('14-07-2024', 'dd-mm-yyyy'), 'Patient monitor', 'available', 1421);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4953, to_date('02-06-2024', 'dd-mm-yyyy'), 'Catheter', 'available', 1540);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4954, to_date('22-09-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1325);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4955, to_date('31-03-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'available', 1237);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4956, to_date('27-01-2024', 'dd-mm-yyyy'), 'Suction device', 'available', 1391);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4957, to_date('10-02-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'not available', 1595);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4958, to_date('21-09-2024', 'dd-mm-yyyy'), 'Catheter', 'not available', 1272);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4959, to_date('10-08-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1207);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4960, to_date('24-08-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1255);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4961, to_date('09-03-2024', 'dd-mm-yyyy'), 'Foot pedal', 'not available', 1323);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4962, to_date('19-05-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'not available', 1385);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4963, to_date('21-09-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'available', 1551);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4964, to_date('27-07-2024', 'dd-mm-yyyy'), 'IV pole', 'available', 1442);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4965, to_date('20-04-2024', 'dd-mm-yyyy'), 'Forceps', 'available', 1535);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4966, to_date('01-01-2024', 'dd-mm-yyyy'), 'Clip applier', 'available', 1290);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4967, to_date('24-02-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'not available', 1617);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4968, to_date('19-02-2024', 'dd-mm-yyyy'), 'Patient monitor', 'available', 1612);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4969, to_date('19-10-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1539);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4970, to_date('07-09-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1287);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4971, to_date('17-11-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1394);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4972, to_date('21-09-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1214);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4973, to_date('28-07-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1560);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4974, to_date('06-10-2024', 'dd-mm-yyyy'), 'Operating table', 'available', 1512);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4975, to_date('05-05-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1601);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4976, to_date('20-04-2024', 'dd-mm-yyyy'), 'Laparoscope', 'not available', 1437);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4977, to_date('28-07-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1429);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4978, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical gown', 'available', 1547);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4979, to_date('24-02-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1434);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4980, to_date('11-08-2024', 'dd-mm-yyyy'), 'Smoke evacuator', 'not available', 1567);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4981, to_date('05-02-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'available', 1601);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4982, to_date('29-06-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1451);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4983, to_date('20-04-2024', 'dd-mm-yyyy'), 'Suction canister', 'available', 1463);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4984, to_date('03-11-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'available', 1405);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4985, to_date('02-06-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1379);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4986, to_date('19-05-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1373);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4987, to_date('28-07-2024', 'dd-mm-yyyy'), 'Retractor', 'not available', 1380);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4988, to_date('28-07-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1356);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4989, to_date('14-01-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1334);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4990, to_date('03-03-2024', 'dd-mm-yyyy'), 'Operating table', 'available', 1647);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4991, to_date('11-08-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1488);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4992, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical gown', 'available', 1584);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4993, to_date('24-08-2024', 'dd-mm-yyyy'), 'Operating table', 'available', 1522);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4994, to_date('31-03-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1472);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4995, to_date('03-11-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1387);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4996, to_date('21-09-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1630);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4997, to_date('15-06-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1579);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4998, to_date('06-10-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1337);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (4999, to_date('16-06-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1467);
commit;
prompt 200 records committed...
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5000, to_date('23-03-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'not available', 1436);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5001, to_date('10-08-2024', 'dd-mm-yyyy'), 'Defibrillator', 'not available', 1267);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5002, to_date('15-12-2024', 'dd-mm-yyyy'), 'Sterile container', 'available', 1242);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5003, to_date('14-01-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1589);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5004, to_date('19-10-2024', 'dd-mm-yyyy'), 'Sterile container', 'available', 1432);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5005, to_date('15-12-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1502);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5006, to_date('02-06-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'not available', 1250);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5007, to_date('20-04-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'not available', 1642);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5008, to_date('19-05-2024', 'dd-mm-yyyy'), 'IV pole', 'available', 1221);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5009, to_date('28-07-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1635);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5010, to_date('20-04-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1578);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5011, to_date('07-09-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1630);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5012, to_date('01-01-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'available', 1535);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5013, to_date('24-08-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1412);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5014, to_date('02-06-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1278);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5015, to_date('27-07-2024', 'dd-mm-yyyy'), 'Trocars', 'not available', 1295);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5016, to_date('19-02-2024', 'dd-mm-yyyy'), 'Patient monitor', 'not available', 1524);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5017, to_date('07-09-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1525);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5018, to_date('30-06-2024', 'dd-mm-yyyy'), 'Endoscope', 'available', 1601);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5019, to_date('31-03-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1600);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5020, to_date('11-08-2024', 'dd-mm-yyyy'), 'Endoscope', 'not available', 1640);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5021, to_date('14-01-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1365);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5022, to_date('25-08-2024', 'dd-mm-yyyy'), 'Suction canister', 'available', 1408);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5023, to_date('21-09-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1555);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5024, to_date('04-05-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1394);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5025, to_date('15-06-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'available', 1447);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5026, to_date('05-02-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1464);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5027, to_date('06-04-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'available', 1566);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5028, to_date('17-03-2024', 'dd-mm-yyyy'), 'Defibrillator', 'not available', 1308);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5029, to_date('10-02-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1627);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5030, to_date('27-07-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1254);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5031, to_date('19-05-2024', 'dd-mm-yyyy'), 'Infusion pump', 'not available', 1662);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5032, to_date('08-09-2024', 'dd-mm-yyyy'), 'Defibrillator', 'not available', 1605);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5033, to_date('23-03-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1658);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5034, to_date('21-04-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1411);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5035, to_date('13-01-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1575);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5036, to_date('05-05-2024', 'dd-mm-yyyy'), 'Smoke evacuator', 'not available', 1362);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5037, to_date('27-07-2024', 'dd-mm-yyyy'), 'Microscope', 'available', 1275);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5038, to_date('19-05-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'not available', 1460);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5039, to_date('05-10-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1300);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5040, to_date('05-02-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1396);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5041, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1222);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5042, to_date('01-01-2024', 'dd-mm-yyyy'), 'Forceps', 'not available', 1315);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5043, to_date('01-06-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'not available', 1649);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5044, to_date('05-05-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1554);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5045, to_date('03-11-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1466);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5046, to_date('05-05-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1361);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5047, to_date('06-10-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1534);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5048, to_date('01-12-2024', 'dd-mm-yyyy'), 'Forceps', 'not available', 1264);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5049, to_date('20-04-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1287);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5050, to_date('21-04-2024', 'dd-mm-yyyy'), 'Suction canister', 'not available', 1612);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5051, to_date('11-08-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'available', 1324);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5052, to_date('01-12-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1496);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5053, to_date('09-03-2024', 'dd-mm-yyyy'), 'Syringe', 'available', 1233);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5054, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical mask', 'not available', 1325);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5055, to_date('24-08-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1536);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5056, to_date('16-06-2024', 'dd-mm-yyyy'), 'Surgical mask', 'not available', 1572);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5057, to_date('13-07-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1341);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5058, to_date('10-02-2024', 'dd-mm-yyyy'), 'Infusion pump', 'not available', 1430);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5059, to_date('11-08-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'available', 1515);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5060, to_date('14-07-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1596);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5061, to_date('21-04-2024', 'dd-mm-yyyy'), 'Surgical gown', 'available', 1223);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5062, to_date('22-09-2024', 'dd-mm-yyyy'), 'Smoke evacuator', 'not available', 1345);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5063, to_date('20-04-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1393);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5064, to_date('10-02-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1605);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5065, to_date('27-07-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1553);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5066, to_date('17-11-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1396);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5067, to_date('13-07-2024', 'dd-mm-yyyy'), 'Endoscope', 'available', 1245);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5068, to_date('01-12-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1656);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5069, to_date('30-06-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1358);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5070, to_date('03-11-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1509);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5071, to_date('05-05-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1637);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5072, to_date('24-02-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1448);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5073, to_date('28-01-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'available', 1368);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5074, to_date('19-05-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'In Use', 1431);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5075, to_date('07-09-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1384);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5076, to_date('29-06-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1341);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5077, to_date('18-05-2024', 'dd-mm-yyyy'), 'Endoscope', 'not available', 1307);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5078, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'not available', 1535);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5079, to_date('23-03-2024', 'dd-mm-yyyy'), 'Surgical drapes', 'available', 1374);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5080, to_date('17-03-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1512);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5081, to_date('07-04-2024', 'dd-mm-yyyy'), 'Retractor', 'not available', 1377);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5082, to_date('29-12-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1473);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5083, to_date('09-03-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1381);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5084, to_date('06-04-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1575);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5085, to_date('10-08-2024', 'dd-mm-yyyy'), 'Needle holder', 'not available', 1417);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5086, to_date('24-02-2024', 'dd-mm-yyyy'), 'Patient monitor', 'not available', 1233);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5087, to_date('17-11-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1559);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5088, to_date('20-04-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'available', 1603);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5089, to_date('01-12-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1450);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5090, to_date('22-09-2024', 'dd-mm-yyyy'), 'Suction device', 'available', 1441);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5091, to_date('07-04-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1594);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5092, to_date('11-08-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1279);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5093, to_date('03-11-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1311);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5094, to_date('07-04-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1444);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5095, to_date('14-01-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'available', 1258);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5096, to_date('20-04-2024', 'dd-mm-yyyy'), 'Catheter', 'available', 1388);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5097, to_date('07-09-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1666);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5098, to_date('05-02-2024', 'dd-mm-yyyy'), 'Retractor', 'not available', 1268);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5099, to_date('10-02-2024', 'dd-mm-yyyy'), 'Bone saw', 'available', 1428);
commit;
prompt 300 records committed...
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5100, to_date('01-06-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1568);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5101, to_date('29-06-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1294);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5102, to_date('03-03-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1235);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5103, to_date('23-03-2024', 'dd-mm-yyyy'), 'Autoclave', 'available', 1379);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5104, to_date('30-06-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1330);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5105, to_date('20-04-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1383);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5106, to_date('01-01-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1586);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5107, to_date('03-03-2024', 'dd-mm-yyyy'), 'Retractor', 'available', 1665);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5108, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'available', 1550);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5109, to_date('01-06-2024', 'dd-mm-yyyy'), 'Needle holder', 'not available', 1412);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5110, to_date('16-06-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1635);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5111, to_date('13-07-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1410);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5112, to_date('14-07-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1286);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5113, to_date('04-05-2024', 'dd-mm-yyyy'), 'Laparoscope', 'not available', 1573);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5114, to_date('01-01-2024', 'dd-mm-yyyy'), 'Patient monitor', 'not available', 1255);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5115, to_date('29-06-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1664);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5116, to_date('18-05-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1598);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5117, to_date('20-04-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1459);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5118, to_date('27-07-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1435);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5119, to_date('07-09-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1285);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5120, to_date('22-09-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1440);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5121, to_date('28-07-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1550);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5122, to_date('19-02-2024', 'dd-mm-yyyy'), 'Endoscope', 'not available', 1564);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5123, to_date('07-09-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1232);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5124, to_date('03-03-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1477);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5125, to_date('03-11-2024', 'dd-mm-yyyy'), 'C-arm', 'available', 1437);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5126, to_date('30-06-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1388);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5127, to_date('25-08-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1382);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5128, to_date('28-01-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1374);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5129, to_date('25-08-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1306);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5130, to_date('29-12-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'not available', 1562);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5131, to_date('27-01-2024', 'dd-mm-yyyy'), 'Suction canister', 'not available', 1552);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5132, to_date('27-07-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1282);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5133, to_date('20-10-2024', 'dd-mm-yyyy'), 'Autoclave', 'available', 1561);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5134, to_date('19-05-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'available', 1406);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5135, to_date('10-02-2024', 'dd-mm-yyyy'), 'Orthopedic implants', 'not available', 1588);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5136, to_date('08-09-2024', 'dd-mm-yyyy'), 'Patient monitor', 'available', 1461);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5137, to_date('16-06-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1512);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5138, to_date('05-10-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1325);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5139, to_date('19-02-2024', 'dd-mm-yyyy'), 'Patient monitor', 'not available', 1450);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5140, to_date('15-06-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1434);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5141, to_date('15-12-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1327);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5142, to_date('10-02-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1498);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5143, to_date('07-04-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1304);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5144, to_date('08-09-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1472);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5145, to_date('07-09-2024', 'dd-mm-yyyy'), 'Forceps', 'available', 1652);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5146, to_date('31-03-2024', 'dd-mm-yyyy'), 'Infusion pump', 'not available', 1495);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5147, to_date('13-01-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1602);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5148, to_date('29-12-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1284);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5149, to_date('17-03-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1370);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5150, to_date('09-03-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1301);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5151, to_date('20-10-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1309);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5152, to_date('18-05-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'available', 1503);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5153, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'available', 1419);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5154, to_date('19-05-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1403);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5155, to_date('14-07-2024', 'dd-mm-yyyy'), 'Microscope', 'available', 1256);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5156, to_date('20-10-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1443);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5157, to_date('21-04-2024', 'dd-mm-yyyy'), 'Surgical sponge', 'available', 1609);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5158, to_date('27-07-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1479);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5159, to_date('19-10-2024', 'dd-mm-yyyy'), 'Foot pedal', 'available', 1426);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5160, to_date('19-10-2024', 'dd-mm-yyyy'), 'Surgical lights', 'available', 1515);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5161, to_date('23-03-2024', 'dd-mm-yyyy'), 'Suction device', 'available', 1651);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5162, to_date('15-12-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1413);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5163, to_date('29-12-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1509);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5164, to_date('27-01-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1452);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5165, to_date('31-03-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1237);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5166, to_date('05-10-2024', 'dd-mm-yyyy'), 'Surgical sutures', 'available', 1391);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5167, to_date('30-06-2024', 'dd-mm-yyyy'), 'C-arm', 'available', 1457);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5168, to_date('28-07-2024', 'dd-mm-yyyy'), 'Surgical tray', 'available', 1327);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5169, to_date('21-04-2024', 'dd-mm-yyyy'), 'Surgical drill', 'available', 1533);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5170, to_date('06-04-2024', 'dd-mm-yyyy'), 'Sterile container', 'available', 1515);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5171, to_date('13-01-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1569);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5172, to_date('24-08-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1645);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5173, to_date('05-10-2024', 'dd-mm-yyyy'), 'Hemostat', 'not available', 1527);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5174, to_date('05-10-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1426);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5175, to_date('10-08-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'available', 1648);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5176, to_date('18-05-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'not available', 1556);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5177, to_date('19-05-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1392);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5178, to_date('10-02-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'not available', 1326);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5179, to_date('09-03-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1554);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5180, to_date('19-10-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'available', 1284);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5181, to_date('17-03-2024', 'dd-mm-yyyy'), 'Foot pedal', 'not available', 1630);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5182, to_date('31-03-2024', 'dd-mm-yyyy'), 'Operating table', 'available', 1599);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5183, to_date('14-07-2024', 'dd-mm-yyyy'), 'Hemostat', 'available', 1290);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5184, to_date('03-03-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'available', 1277);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5185, to_date('16-06-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1301);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5186, to_date('03-11-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1494);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5187, to_date('03-03-2024', 'dd-mm-yyyy'), 'Trocars', 'not available', 1560);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5188, to_date('02-06-2024', 'dd-mm-yyyy'), 'IV pole', 'not available', 1362);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5189, to_date('10-02-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1374);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5190, to_date('14-01-2024', 'dd-mm-yyyy'), 'Syringe', 'available', 1553);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5191, to_date('17-03-2024', 'dd-mm-yyyy'), 'Doppler', 'available', 1519);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5192, to_date('24-08-2024', 'dd-mm-yyyy'), 'Trocars', 'not available', 1297);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5193, to_date('11-08-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'not available', 1546);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5194, to_date('24-02-2024', 'dd-mm-yyyy'), 'Laparoscope', 'not available', 1359);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5195, to_date('19-05-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1663);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5196, to_date('24-08-2024', 'dd-mm-yyyy'), 'C-arm', 'not available', 1330);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5197, to_date('07-09-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1266);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5198, to_date('20-10-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'not available', 1494);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5199, to_date('07-09-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1582);
commit;
prompt 400 records committed...
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5200, to_date('06-10-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1348);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5201, to_date('05-10-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1222);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5202, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'available', 1291);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5203, to_date('11-08-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1449);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5204, to_date('10-08-2024', 'dd-mm-yyyy'), 'Suction device', 'not available', 1435);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5205, to_date('03-03-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'not available', 1559);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5206, to_date('20-10-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1255);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5207, to_date('02-06-2024', 'dd-mm-yyyy'), 'Surgical lights', 'not available', 1638);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5208, to_date('15-06-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1491);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5209, to_date('17-03-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'available', 1503);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5210, to_date('14-01-2024', 'dd-mm-yyyy'), 'Surgical tray', 'not available', 1287);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5211, to_date('13-07-2024', 'dd-mm-yyyy'), 'Surgical stapler', 'available', 1415);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5212, to_date('10-08-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'available', 1320);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5213, to_date('06-04-2024', 'dd-mm-yyyy'), 'Surgical mask', 'not available', 1314);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5214, to_date('08-09-2024', 'dd-mm-yyyy'), 'Clip applier', 'not available', 1232);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5215, to_date('18-05-2024', 'dd-mm-yyyy'), 'Sterile container', 'not available', 1357);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5216, to_date('13-07-2024', 'dd-mm-yyyy'), 'Microscope', 'not available', 1649);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5217, to_date('22-09-2024', 'dd-mm-yyyy'), 'Forceps', 'not available', 1441);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5218, to_date('22-09-2024', 'dd-mm-yyyy'), 'Clip applier', 'available', 1439);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5219, to_date('28-01-2024', 'dd-mm-yyyy'), 'Syringe', 'not available', 1572);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5220, to_date('25-08-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'available', 1420);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5221, to_date('20-04-2024', 'dd-mm-yyyy'), 'Forceps', 'not available', 1208);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5222, to_date('10-08-2024', 'dd-mm-yyyy'), 'Scalpel', 'not available', 1447);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5223, to_date('28-01-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1321);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5224, to_date('31-03-2024', 'dd-mm-yyyy'), 'Ultrasound machine', 'not available', 1607);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5225, to_date('27-07-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1234);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5226, to_date('17-11-2024', 'dd-mm-yyyy'), 'Infusion pump', 'available', 1468);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5227, to_date('11-08-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1439);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5228, to_date('10-02-2024', 'dd-mm-yyyy'), 'Cryosurgery unit', 'not available', 1569);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5229, to_date('01-06-2024', 'dd-mm-yyyy'), 'Trocars', 'not available', 1659);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5230, to_date('01-06-2024', 'dd-mm-yyyy'), 'Surgical sponge', 'not available', 1550);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5231, to_date('04-05-2024', 'dd-mm-yyyy'), 'Doppler', 'not available', 1623);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5232, to_date('03-03-2024', 'dd-mm-yyyy'), 'Microscope', 'not available', 1476);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5233, to_date('19-02-2024', 'dd-mm-yyyy'), 'Foot pedal', 'not available', 1291);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5234, to_date('01-01-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1656);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5235, to_date('31-03-2024', 'dd-mm-yyyy'), 'Retractor', 'available', 1450);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5236, to_date('10-02-2024', 'dd-mm-yyyy'), 'Laparoscope', 'available', 1458);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5237, to_date('21-09-2024', 'dd-mm-yyyy'), 'Forceps', 'available', 1431);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5238, to_date('05-05-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1289);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5239, to_date('01-12-2024', 'dd-mm-yyyy'), 'Autoclave', 'not available', 1401);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5240, to_date('13-07-2024', 'dd-mm-yyyy'), 'Forceps', 'available', 1229);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5241, to_date('17-03-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'available', 1296);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5242, to_date('19-10-2024', 'dd-mm-yyyy'), 'Catheter', 'not available', 1445);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5243, to_date('13-07-2024', 'dd-mm-yyyy'), 'Scalpel', 'available', 1547);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5244, to_date('17-03-2024', 'dd-mm-yyyy'), 'Sterilizer', 'not available', 1575);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5245, to_date('29-06-2024', 'dd-mm-yyyy'), 'Patient monitor', 'available', 1368);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5246, to_date('13-01-2024', 'dd-mm-yyyy'), 'Laser scalpel', 'available', 1436);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5247, to_date('14-01-2024', 'dd-mm-yyyy'), 'Surgical scissors', 'available', 1637);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5248, to_date('30-06-2024', 'dd-mm-yyyy'), 'Trocars', 'available', 1638);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5249, to_date('24-02-2024', 'dd-mm-yyyy'), 'Cautery pencil', 'available', 1617);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5250, to_date('06-04-2024', 'dd-mm-yyyy'), 'Endoscope', 'available', 1308);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5251, to_date('27-07-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1653);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5252, to_date('06-04-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1337);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5253, to_date('15-12-2024', 'dd-mm-yyyy'), 'Retractor', 'available', 1589);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5254, to_date('29-12-2024', 'dd-mm-yyyy'), 'Defibrillator', 'available', 1462);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5255, to_date('05-10-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'not available', 1427);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5256, to_date('19-02-2024', 'dd-mm-yyyy'), 'Surgical drill', 'not available', 1462);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5257, to_date('04-05-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1428);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5258, to_date('20-04-2024', 'dd-mm-yyyy'), 'Sterilizer', 'available', 1343);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5259, to_date('09-03-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1200);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5260, to_date('10-02-2024', 'dd-mm-yyyy'), 'Surgical instrument table', 'available', 1421);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5261, to_date('06-04-2024', 'dd-mm-yyyy'), 'Surgical gloves', 'available', 1493);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5262, to_date('05-02-2024', 'dd-mm-yyyy'), 'Sterile gauze', 'available', 1395);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5263, to_date('01-01-2024', 'dd-mm-yyyy'), 'Pulse oximeter', 'not available', 1241);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5264, to_date('06-04-2024', 'dd-mm-yyyy'), 'Operating table', 'not available', 1663);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5265, to_date('28-01-2024', 'dd-mm-yyyy'), 'Surgical microscope', 'not available', 1517);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5266, to_date('29-06-2024', 'dd-mm-yyyy'), 'Hemostat', 'not available', 1279);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5267, to_date('23-03-2024', 'dd-mm-yyyy'), 'Operating table', 'not available', 1467);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5268, to_date('05-10-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1432);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5269, to_date('03-11-2024', 'dd-mm-yyyy'), 'Surgical gown', 'not available', 1624);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5270, to_date('28-07-2024', 'dd-mm-yyyy'), 'Anesthesia machine', 'available', 1362);
insert into EQUIPEMENT (equipement_id, equipment_purchase_date, equipment_name, equipment_status, room_id)
values (5271, to_date('24-08-2024', 'dd-mm-yyyy'), 'Electrocautery unit', 'not available', 1531);
commit;
prompt 472 records loaded
prompt Loading OPERATE_BY...
insert into OPERATE_BY (doctor_id, operation_id)
values (2402, 6002);
insert into OPERATE_BY (doctor_id, operation_id)
values (2403, 6003);
insert into OPERATE_BY (doctor_id, operation_id)
values (2404, 6004);
insert into OPERATE_BY (doctor_id, operation_id)
values (2405, 6005);
insert into OPERATE_BY (doctor_id, operation_id)
values (2406, 6006);
insert into OPERATE_BY (doctor_id, operation_id)
values (2407, 6007);
insert into OPERATE_BY (doctor_id, operation_id)
values (2408, 6008);
insert into OPERATE_BY (doctor_id, operation_id)
values (2409, 6009);
insert into OPERATE_BY (doctor_id, operation_id)
values (2410, 6010);
insert into OPERATE_BY (doctor_id, operation_id)
values (2411, 6011);
insert into OPERATE_BY (doctor_id, operation_id)
values (2412, 6012);
insert into OPERATE_BY (doctor_id, operation_id)
values (2413, 6013);
insert into OPERATE_BY (doctor_id, operation_id)
values (2414, 6014);
insert into OPERATE_BY (doctor_id, operation_id)
values (2415, 6015);
insert into OPERATE_BY (doctor_id, operation_id)
values (2416, 6016);
insert into OPERATE_BY (doctor_id, operation_id)
values (2417, 6017);
insert into OPERATE_BY (doctor_id, operation_id)
values (2418, 6018);
insert into OPERATE_BY (doctor_id, operation_id)
values (2419, 6019);
insert into OPERATE_BY (doctor_id, operation_id)
values (2420, 6020);
insert into OPERATE_BY (doctor_id, operation_id)
values (2421, 6021);
insert into OPERATE_BY (doctor_id, operation_id)
values (2422, 6022);
insert into OPERATE_BY (doctor_id, operation_id)
values (2423, 6023);
insert into OPERATE_BY (doctor_id, operation_id)
values (2424, 6024);
insert into OPERATE_BY (doctor_id, operation_id)
values (2425, 6025);
insert into OPERATE_BY (doctor_id, operation_id)
values (2426, 6026);
insert into OPERATE_BY (doctor_id, operation_id)
values (2427, 6027);
insert into OPERATE_BY (doctor_id, operation_id)
values (2428, 6028);
insert into OPERATE_BY (doctor_id, operation_id)
values (2429, 6029);
insert into OPERATE_BY (doctor_id, operation_id)
values (2430, 6030);
insert into OPERATE_BY (doctor_id, operation_id)
values (2431, 6031);
insert into OPERATE_BY (doctor_id, operation_id)
values (2432, 6032);
insert into OPERATE_BY (doctor_id, operation_id)
values (2433, 6033);
insert into OPERATE_BY (doctor_id, operation_id)
values (2434, 6034);
insert into OPERATE_BY (doctor_id, operation_id)
values (2435, 6035);
insert into OPERATE_BY (doctor_id, operation_id)
values (2436, 6036);
insert into OPERATE_BY (doctor_id, operation_id)
values (2437, 6037);
insert into OPERATE_BY (doctor_id, operation_id)
values (2438, 6038);
insert into OPERATE_BY (doctor_id, operation_id)
values (2439, 6039);
insert into OPERATE_BY (doctor_id, operation_id)
values (2440, 6040);
insert into OPERATE_BY (doctor_id, operation_id)
values (2441, 6041);
insert into OPERATE_BY (doctor_id, operation_id)
values (2442, 6042);
insert into OPERATE_BY (doctor_id, operation_id)
values (2443, 6043);
insert into OPERATE_BY (doctor_id, operation_id)
values (2444, 6044);
insert into OPERATE_BY (doctor_id, operation_id)
values (2445, 6045);
insert into OPERATE_BY (doctor_id, operation_id)
values (2446, 6046);
insert into OPERATE_BY (doctor_id, operation_id)
values (2447, 6047);
insert into OPERATE_BY (doctor_id, operation_id)
values (2448, 6000);
insert into OPERATE_BY (doctor_id, operation_id)
values (2448, 6048);
insert into OPERATE_BY (doctor_id, operation_id)
values (2449, 6049);
insert into OPERATE_BY (doctor_id, operation_id)
values (2450, 6050);
insert into OPERATE_BY (doctor_id, operation_id)
values (2451, 6051);
insert into OPERATE_BY (doctor_id, operation_id)
values (2452, 6052);
insert into OPERATE_BY (doctor_id, operation_id)
values (2453, 6053);
insert into OPERATE_BY (doctor_id, operation_id)
values (2454, 6054);
insert into OPERATE_BY (doctor_id, operation_id)
values (2455, 6055);
insert into OPERATE_BY (doctor_id, operation_id)
values (2456, 6056);
insert into OPERATE_BY (doctor_id, operation_id)
values (2457, 6057);
insert into OPERATE_BY (doctor_id, operation_id)
values (2458, 6058);
insert into OPERATE_BY (doctor_id, operation_id)
values (2459, 6059);
insert into OPERATE_BY (doctor_id, operation_id)
values (2460, 6060);
insert into OPERATE_BY (doctor_id, operation_id)
values (2461, 6061);
insert into OPERATE_BY (doctor_id, operation_id)
values (2462, 6062);
insert into OPERATE_BY (doctor_id, operation_id)
values (2463, 6063);
insert into OPERATE_BY (doctor_id, operation_id)
values (2464, 6064);
insert into OPERATE_BY (doctor_id, operation_id)
values (2465, 6065);
insert into OPERATE_BY (doctor_id, operation_id)
values (2466, 6066);
insert into OPERATE_BY (doctor_id, operation_id)
values (2467, 6067);
insert into OPERATE_BY (doctor_id, operation_id)
values (2468, 6068);
insert into OPERATE_BY (doctor_id, operation_id)
values (2469, 6069);
insert into OPERATE_BY (doctor_id, operation_id)
values (2470, 6070);
insert into OPERATE_BY (doctor_id, operation_id)
values (2471, 6071);
insert into OPERATE_BY (doctor_id, operation_id)
values (2472, 6072);
insert into OPERATE_BY (doctor_id, operation_id)
values (2473, 6073);
insert into OPERATE_BY (doctor_id, operation_id)
values (2474, 6074);
insert into OPERATE_BY (doctor_id, operation_id)
values (2475, 6075);
insert into OPERATE_BY (doctor_id, operation_id)
values (2476, 6076);
insert into OPERATE_BY (doctor_id, operation_id)
values (2477, 6077);
insert into OPERATE_BY (doctor_id, operation_id)
values (2478, 6078);
insert into OPERATE_BY (doctor_id, operation_id)
values (2479, 6079);
insert into OPERATE_BY (doctor_id, operation_id)
values (2480, 6080);
insert into OPERATE_BY (doctor_id, operation_id)
values (2481, 6081);
insert into OPERATE_BY (doctor_id, operation_id)
values (2482, 6082);
insert into OPERATE_BY (doctor_id, operation_id)
values (2483, 6083);
insert into OPERATE_BY (doctor_id, operation_id)
values (2484, 6084);
insert into OPERATE_BY (doctor_id, operation_id)
values (2485, 6085);
insert into OPERATE_BY (doctor_id, operation_id)
values (2486, 6086);
insert into OPERATE_BY (doctor_id, operation_id)
values (2487, 6087);
insert into OPERATE_BY (doctor_id, operation_id)
values (2488, 6088);
insert into OPERATE_BY (doctor_id, operation_id)
values (2489, 6089);
insert into OPERATE_BY (doctor_id, operation_id)
values (2490, 6090);
insert into OPERATE_BY (doctor_id, operation_id)
values (2491, 6091);
insert into OPERATE_BY (doctor_id, operation_id)
values (2492, 6092);
insert into OPERATE_BY (doctor_id, operation_id)
values (2493, 6093);
insert into OPERATE_BY (doctor_id, operation_id)
values (2494, 6094);
insert into OPERATE_BY (doctor_id, operation_id)
values (2495, 6095);
insert into OPERATE_BY (doctor_id, operation_id)
values (2496, 6096);
insert into OPERATE_BY (doctor_id, operation_id)
values (2497, 6097);
insert into OPERATE_BY (doctor_id, operation_id)
values (2498, 6098);
insert into OPERATE_BY (doctor_id, operation_id)
values (2499, 6099);
insert into OPERATE_BY (doctor_id, operation_id)
values (2500, 6100);
commit;
prompt 100 records committed...
insert into OPERATE_BY (doctor_id, operation_id)
values (2501, 6101);
insert into OPERATE_BY (doctor_id, operation_id)
values (2502, 6102);
insert into OPERATE_BY (doctor_id, operation_id)
values (2503, 6103);
insert into OPERATE_BY (doctor_id, operation_id)
values (2504, 6104);
insert into OPERATE_BY (doctor_id, operation_id)
values (2505, 6105);
insert into OPERATE_BY (doctor_id, operation_id)
values (2506, 6106);
insert into OPERATE_BY (doctor_id, operation_id)
values (2507, 6107);
insert into OPERATE_BY (doctor_id, operation_id)
values (2508, 6108);
insert into OPERATE_BY (doctor_id, operation_id)
values (2509, 6109);
insert into OPERATE_BY (doctor_id, operation_id)
values (2510, 6110);
insert into OPERATE_BY (doctor_id, operation_id)
values (2511, 6111);
insert into OPERATE_BY (doctor_id, operation_id)
values (2512, 6112);
insert into OPERATE_BY (doctor_id, operation_id)
values (2513, 6113);
insert into OPERATE_BY (doctor_id, operation_id)
values (2514, 6114);
insert into OPERATE_BY (doctor_id, operation_id)
values (2515, 6115);
insert into OPERATE_BY (doctor_id, operation_id)
values (2516, 6116);
insert into OPERATE_BY (doctor_id, operation_id)
values (2517, 6117);
insert into OPERATE_BY (doctor_id, operation_id)
values (2518, 6118);
insert into OPERATE_BY (doctor_id, operation_id)
values (2519, 6119);
insert into OPERATE_BY (doctor_id, operation_id)
values (2520, 6120);
insert into OPERATE_BY (doctor_id, operation_id)
values (2521, 6121);
insert into OPERATE_BY (doctor_id, operation_id)
values (2522, 6122);
insert into OPERATE_BY (doctor_id, operation_id)
values (2523, 6123);
insert into OPERATE_BY (doctor_id, operation_id)
values (2524, 6124);
insert into OPERATE_BY (doctor_id, operation_id)
values (2525, 6125);
insert into OPERATE_BY (doctor_id, operation_id)
values (2526, 6126);
insert into OPERATE_BY (doctor_id, operation_id)
values (2527, 6127);
insert into OPERATE_BY (doctor_id, operation_id)
values (2528, 6128);
insert into OPERATE_BY (doctor_id, operation_id)
values (2529, 6129);
insert into OPERATE_BY (doctor_id, operation_id)
values (2530, 6130);
insert into OPERATE_BY (doctor_id, operation_id)
values (2531, 6131);
insert into OPERATE_BY (doctor_id, operation_id)
values (2532, 6132);
insert into OPERATE_BY (doctor_id, operation_id)
values (2533, 6133);
insert into OPERATE_BY (doctor_id, operation_id)
values (2534, 6134);
insert into OPERATE_BY (doctor_id, operation_id)
values (2535, 6135);
insert into OPERATE_BY (doctor_id, operation_id)
values (2536, 6136);
insert into OPERATE_BY (doctor_id, operation_id)
values (2537, 6137);
insert into OPERATE_BY (doctor_id, operation_id)
values (2538, 6138);
insert into OPERATE_BY (doctor_id, operation_id)
values (2539, 6139);
insert into OPERATE_BY (doctor_id, operation_id)
values (2540, 6140);
insert into OPERATE_BY (doctor_id, operation_id)
values (2541, 6141);
insert into OPERATE_BY (doctor_id, operation_id)
values (2542, 6142);
insert into OPERATE_BY (doctor_id, operation_id)
values (2543, 6143);
insert into OPERATE_BY (doctor_id, operation_id)
values (2544, 6144);
insert into OPERATE_BY (doctor_id, operation_id)
values (2545, 6145);
insert into OPERATE_BY (doctor_id, operation_id)
values (2546, 6146);
insert into OPERATE_BY (doctor_id, operation_id)
values (2547, 6147);
insert into OPERATE_BY (doctor_id, operation_id)
values (2548, 6148);
insert into OPERATE_BY (doctor_id, operation_id)
values (2549, 6149);
insert into OPERATE_BY (doctor_id, operation_id)
values (2550, 6150);
insert into OPERATE_BY (doctor_id, operation_id)
values (2551, 6151);
insert into OPERATE_BY (doctor_id, operation_id)
values (2552, 6152);
insert into OPERATE_BY (doctor_id, operation_id)
values (2553, 6153);
insert into OPERATE_BY (doctor_id, operation_id)
values (2554, 6154);
insert into OPERATE_BY (doctor_id, operation_id)
values (2555, 6155);
insert into OPERATE_BY (doctor_id, operation_id)
values (2556, 6156);
insert into OPERATE_BY (doctor_id, operation_id)
values (2557, 6157);
insert into OPERATE_BY (doctor_id, operation_id)
values (2558, 6158);
insert into OPERATE_BY (doctor_id, operation_id)
values (2559, 6159);
insert into OPERATE_BY (doctor_id, operation_id)
values (2560, 6160);
insert into OPERATE_BY (doctor_id, operation_id)
values (2561, 6161);
insert into OPERATE_BY (doctor_id, operation_id)
values (2562, 6162);
insert into OPERATE_BY (doctor_id, operation_id)
values (2563, 6163);
insert into OPERATE_BY (doctor_id, operation_id)
values (2564, 6164);
insert into OPERATE_BY (doctor_id, operation_id)
values (2565, 6165);
insert into OPERATE_BY (doctor_id, operation_id)
values (2566, 6166);
insert into OPERATE_BY (doctor_id, operation_id)
values (2567, 6167);
insert into OPERATE_BY (doctor_id, operation_id)
values (2568, 6168);
insert into OPERATE_BY (doctor_id, operation_id)
values (2569, 6169);
insert into OPERATE_BY (doctor_id, operation_id)
values (2570, 6170);
insert into OPERATE_BY (doctor_id, operation_id)
values (2571, 6171);
insert into OPERATE_BY (doctor_id, operation_id)
values (2572, 6172);
insert into OPERATE_BY (doctor_id, operation_id)
values (2573, 6173);
insert into OPERATE_BY (doctor_id, operation_id)
values (2574, 6174);
insert into OPERATE_BY (doctor_id, operation_id)
values (2575, 6175);
insert into OPERATE_BY (doctor_id, operation_id)
values (2576, 6176);
insert into OPERATE_BY (doctor_id, operation_id)
values (2577, 6177);
insert into OPERATE_BY (doctor_id, operation_id)
values (2578, 6178);
insert into OPERATE_BY (doctor_id, operation_id)
values (2579, 6179);
insert into OPERATE_BY (doctor_id, operation_id)
values (2580, 6180);
insert into OPERATE_BY (doctor_id, operation_id)
values (2581, 6181);
insert into OPERATE_BY (doctor_id, operation_id)
values (2582, 6182);
insert into OPERATE_BY (doctor_id, operation_id)
values (2583, 6183);
insert into OPERATE_BY (doctor_id, operation_id)
values (2584, 6184);
insert into OPERATE_BY (doctor_id, operation_id)
values (2585, 6185);
insert into OPERATE_BY (doctor_id, operation_id)
values (2586, 6186);
insert into OPERATE_BY (doctor_id, operation_id)
values (2587, 6187);
insert into OPERATE_BY (doctor_id, operation_id)
values (2588, 6188);
insert into OPERATE_BY (doctor_id, operation_id)
values (2589, 6189);
insert into OPERATE_BY (doctor_id, operation_id)
values (2590, 6190);
insert into OPERATE_BY (doctor_id, operation_id)
values (2591, 6191);
insert into OPERATE_BY (doctor_id, operation_id)
values (2592, 6192);
insert into OPERATE_BY (doctor_id, operation_id)
values (2593, 6193);
insert into OPERATE_BY (doctor_id, operation_id)
values (2594, 6194);
insert into OPERATE_BY (doctor_id, operation_id)
values (2595, 6195);
insert into OPERATE_BY (doctor_id, operation_id)
values (2596, 6196);
insert into OPERATE_BY (doctor_id, operation_id)
values (2597, 6197);
insert into OPERATE_BY (doctor_id, operation_id)
values (2598, 6198);
insert into OPERATE_BY (doctor_id, operation_id)
values (2599, 6199);
insert into OPERATE_BY (doctor_id, operation_id)
values (2600, 6200);
commit;
prompt 200 records committed...
insert into OPERATE_BY (doctor_id, operation_id)
values (2601, 6201);
insert into OPERATE_BY (doctor_id, operation_id)
values (2602, 6202);
insert into OPERATE_BY (doctor_id, operation_id)
values (2603, 6203);
insert into OPERATE_BY (doctor_id, operation_id)
values (2604, 6204);
insert into OPERATE_BY (doctor_id, operation_id)
values (2605, 6205);
insert into OPERATE_BY (doctor_id, operation_id)
values (2606, 6206);
insert into OPERATE_BY (doctor_id, operation_id)
values (2607, 6207);
insert into OPERATE_BY (doctor_id, operation_id)
values (2608, 6208);
insert into OPERATE_BY (doctor_id, operation_id)
values (2609, 6209);
insert into OPERATE_BY (doctor_id, operation_id)
values (2610, 6210);
insert into OPERATE_BY (doctor_id, operation_id)
values (2611, 6211);
insert into OPERATE_BY (doctor_id, operation_id)
values (2612, 6212);
insert into OPERATE_BY (doctor_id, operation_id)
values (2613, 6213);
insert into OPERATE_BY (doctor_id, operation_id)
values (2614, 6214);
insert into OPERATE_BY (doctor_id, operation_id)
values (2615, 6215);
insert into OPERATE_BY (doctor_id, operation_id)
values (2616, 6216);
insert into OPERATE_BY (doctor_id, operation_id)
values (2617, 6217);
insert into OPERATE_BY (doctor_id, operation_id)
values (2618, 6218);
insert into OPERATE_BY (doctor_id, operation_id)
values (2619, 6219);
insert into OPERATE_BY (doctor_id, operation_id)
values (2620, 6220);
insert into OPERATE_BY (doctor_id, operation_id)
values (2621, 6221);
insert into OPERATE_BY (doctor_id, operation_id)
values (2622, 6222);
insert into OPERATE_BY (doctor_id, operation_id)
values (2623, 6223);
insert into OPERATE_BY (doctor_id, operation_id)
values (2624, 6224);
insert into OPERATE_BY (doctor_id, operation_id)
values (2625, 6225);
insert into OPERATE_BY (doctor_id, operation_id)
values (2626, 6226);
insert into OPERATE_BY (doctor_id, operation_id)
values (2627, 6227);
insert into OPERATE_BY (doctor_id, operation_id)
values (2628, 6228);
insert into OPERATE_BY (doctor_id, operation_id)
values (2629, 6229);
insert into OPERATE_BY (doctor_id, operation_id)
values (2630, 6230);
insert into OPERATE_BY (doctor_id, operation_id)
values (2631, 6231);
insert into OPERATE_BY (doctor_id, operation_id)
values (2632, 6232);
insert into OPERATE_BY (doctor_id, operation_id)
values (2633, 6233);
insert into OPERATE_BY (doctor_id, operation_id)
values (2634, 6234);
insert into OPERATE_BY (doctor_id, operation_id)
values (2635, 6235);
insert into OPERATE_BY (doctor_id, operation_id)
values (2636, 6236);
insert into OPERATE_BY (doctor_id, operation_id)
values (2637, 6237);
insert into OPERATE_BY (doctor_id, operation_id)
values (2638, 6238);
insert into OPERATE_BY (doctor_id, operation_id)
values (2639, 6239);
insert into OPERATE_BY (doctor_id, operation_id)
values (2640, 6240);
insert into OPERATE_BY (doctor_id, operation_id)
values (2641, 6241);
insert into OPERATE_BY (doctor_id, operation_id)
values (2642, 6242);
insert into OPERATE_BY (doctor_id, operation_id)
values (2643, 6243);
insert into OPERATE_BY (doctor_id, operation_id)
values (2644, 6244);
insert into OPERATE_BY (doctor_id, operation_id)
values (2645, 6245);
insert into OPERATE_BY (doctor_id, operation_id)
values (2646, 6246);
insert into OPERATE_BY (doctor_id, operation_id)
values (2647, 6247);
insert into OPERATE_BY (doctor_id, operation_id)
values (2648, 6248);
insert into OPERATE_BY (doctor_id, operation_id)
values (2649, 6249);
insert into OPERATE_BY (doctor_id, operation_id)
values (2650, 6250);
insert into OPERATE_BY (doctor_id, operation_id)
values (2651, 6251);
insert into OPERATE_BY (doctor_id, operation_id)
values (2652, 6252);
insert into OPERATE_BY (doctor_id, operation_id)
values (2653, 6253);
insert into OPERATE_BY (doctor_id, operation_id)
values (2654, 6254);
insert into OPERATE_BY (doctor_id, operation_id)
values (2655, 6255);
insert into OPERATE_BY (doctor_id, operation_id)
values (2656, 6256);
insert into OPERATE_BY (doctor_id, operation_id)
values (2657, 6257);
insert into OPERATE_BY (doctor_id, operation_id)
values (2658, 6258);
insert into OPERATE_BY (doctor_id, operation_id)
values (2659, 6259);
insert into OPERATE_BY (doctor_id, operation_id)
values (2660, 6260);
insert into OPERATE_BY (doctor_id, operation_id)
values (2661, 6261);
insert into OPERATE_BY (doctor_id, operation_id)
values (2662, 6262);
insert into OPERATE_BY (doctor_id, operation_id)
values (2663, 6263);
insert into OPERATE_BY (doctor_id, operation_id)
values (2664, 6264);
insert into OPERATE_BY (doctor_id, operation_id)
values (2665, 6265);
insert into OPERATE_BY (doctor_id, operation_id)
values (2666, 6266);
insert into OPERATE_BY (doctor_id, operation_id)
values (2667, 6267);
insert into OPERATE_BY (doctor_id, operation_id)
values (2668, 6268);
insert into OPERATE_BY (doctor_id, operation_id)
values (2669, 6269);
insert into OPERATE_BY (doctor_id, operation_id)
values (2670, 6270);
insert into OPERATE_BY (doctor_id, operation_id)
values (2671, 6271);
insert into OPERATE_BY (doctor_id, operation_id)
values (2672, 6272);
insert into OPERATE_BY (doctor_id, operation_id)
values (2673, 6273);
insert into OPERATE_BY (doctor_id, operation_id)
values (2674, 6274);
insert into OPERATE_BY (doctor_id, operation_id)
values (2675, 6275);
insert into OPERATE_BY (doctor_id, operation_id)
values (2676, 6276);
insert into OPERATE_BY (doctor_id, operation_id)
values (2677, 6277);
insert into OPERATE_BY (doctor_id, operation_id)
values (2678, 6278);
insert into OPERATE_BY (doctor_id, operation_id)
values (2679, 6279);
insert into OPERATE_BY (doctor_id, operation_id)
values (2680, 6280);
insert into OPERATE_BY (doctor_id, operation_id)
values (2681, 6281);
insert into OPERATE_BY (doctor_id, operation_id)
values (2682, 6282);
insert into OPERATE_BY (doctor_id, operation_id)
values (2683, 6283);
insert into OPERATE_BY (doctor_id, operation_id)
values (2684, 6284);
insert into OPERATE_BY (doctor_id, operation_id)
values (2685, 6285);
insert into OPERATE_BY (doctor_id, operation_id)
values (2686, 6286);
insert into OPERATE_BY (doctor_id, operation_id)
values (2687, 6287);
insert into OPERATE_BY (doctor_id, operation_id)
values (2688, 6288);
insert into OPERATE_BY (doctor_id, operation_id)
values (2689, 6289);
insert into OPERATE_BY (doctor_id, operation_id)
values (2690, 6290);
insert into OPERATE_BY (doctor_id, operation_id)
values (2691, 6291);
insert into OPERATE_BY (doctor_id, operation_id)
values (2692, 6292);
insert into OPERATE_BY (doctor_id, operation_id)
values (2693, 6293);
insert into OPERATE_BY (doctor_id, operation_id)
values (2694, 6294);
insert into OPERATE_BY (doctor_id, operation_id)
values (2695, 6295);
insert into OPERATE_BY (doctor_id, operation_id)
values (2696, 6296);
insert into OPERATE_BY (doctor_id, operation_id)
values (2697, 6297);
insert into OPERATE_BY (doctor_id, operation_id)
values (2698, 6298);
insert into OPERATE_BY (doctor_id, operation_id)
values (2699, 6299);
insert into OPERATE_BY (doctor_id, operation_id)
values (2700, 6300);
commit;
prompt 300 records committed...
insert into OPERATE_BY (doctor_id, operation_id)
values (2701, 6301);
insert into OPERATE_BY (doctor_id, operation_id)
values (2702, 6302);
insert into OPERATE_BY (doctor_id, operation_id)
values (2703, 6303);
insert into OPERATE_BY (doctor_id, operation_id)
values (2704, 6304);
insert into OPERATE_BY (doctor_id, operation_id)
values (2705, 6305);
insert into OPERATE_BY (doctor_id, operation_id)
values (2706, 6306);
insert into OPERATE_BY (doctor_id, operation_id)
values (2707, 6307);
insert into OPERATE_BY (doctor_id, operation_id)
values (2708, 6308);
insert into OPERATE_BY (doctor_id, operation_id)
values (2709, 6309);
insert into OPERATE_BY (doctor_id, operation_id)
values (2710, 6310);
insert into OPERATE_BY (doctor_id, operation_id)
values (2711, 6311);
insert into OPERATE_BY (doctor_id, operation_id)
values (2712, 6312);
insert into OPERATE_BY (doctor_id, operation_id)
values (2713, 6313);
insert into OPERATE_BY (doctor_id, operation_id)
values (2714, 6314);
insert into OPERATE_BY (doctor_id, operation_id)
values (2715, 6315);
insert into OPERATE_BY (doctor_id, operation_id)
values (2716, 6316);
insert into OPERATE_BY (doctor_id, operation_id)
values (2717, 6317);
insert into OPERATE_BY (doctor_id, operation_id)
values (2718, 6318);
insert into OPERATE_BY (doctor_id, operation_id)
values (2719, 6319);
insert into OPERATE_BY (doctor_id, operation_id)
values (2720, 6320);
insert into OPERATE_BY (doctor_id, operation_id)
values (2721, 6321);
insert into OPERATE_BY (doctor_id, operation_id)
values (2722, 6322);
insert into OPERATE_BY (doctor_id, operation_id)
values (2723, 6323);
insert into OPERATE_BY (doctor_id, operation_id)
values (2724, 6324);
insert into OPERATE_BY (doctor_id, operation_id)
values (2725, 6325);
insert into OPERATE_BY (doctor_id, operation_id)
values (2726, 6326);
insert into OPERATE_BY (doctor_id, operation_id)
values (2727, 6327);
insert into OPERATE_BY (doctor_id, operation_id)
values (2728, 6328);
insert into OPERATE_BY (doctor_id, operation_id)
values (2729, 6329);
insert into OPERATE_BY (doctor_id, operation_id)
values (2730, 6330);
insert into OPERATE_BY (doctor_id, operation_id)
values (2731, 6331);
insert into OPERATE_BY (doctor_id, operation_id)
values (2732, 6332);
insert into OPERATE_BY (doctor_id, operation_id)
values (2733, 6333);
insert into OPERATE_BY (doctor_id, operation_id)
values (2734, 6001);
insert into OPERATE_BY (doctor_id, operation_id)
values (2734, 6334);
insert into OPERATE_BY (doctor_id, operation_id)
values (2735, 6335);
insert into OPERATE_BY (doctor_id, operation_id)
values (2736, 6336);
insert into OPERATE_BY (doctor_id, operation_id)
values (2737, 6337);
insert into OPERATE_BY (doctor_id, operation_id)
values (2738, 6338);
insert into OPERATE_BY (doctor_id, operation_id)
values (2739, 6339);
insert into OPERATE_BY (doctor_id, operation_id)
values (2740, 6340);
insert into OPERATE_BY (doctor_id, operation_id)
values (2741, 6341);
insert into OPERATE_BY (doctor_id, operation_id)
values (2742, 6342);
insert into OPERATE_BY (doctor_id, operation_id)
values (2743, 6343);
insert into OPERATE_BY (doctor_id, operation_id)
values (2744, 6344);
insert into OPERATE_BY (doctor_id, operation_id)
values (2745, 6345);
insert into OPERATE_BY (doctor_id, operation_id)
values (2746, 6346);
insert into OPERATE_BY (doctor_id, operation_id)
values (2747, 6347);
insert into OPERATE_BY (doctor_id, operation_id)
values (2748, 6348);
insert into OPERATE_BY (doctor_id, operation_id)
values (2749, 6349);
insert into OPERATE_BY (doctor_id, operation_id)
values (2750, 6350);
insert into OPERATE_BY (doctor_id, operation_id)
values (2751, 6351);
insert into OPERATE_BY (doctor_id, operation_id)
values (2752, 6352);
insert into OPERATE_BY (doctor_id, operation_id)
values (2753, 6353);
insert into OPERATE_BY (doctor_id, operation_id)
values (2754, 6354);
insert into OPERATE_BY (doctor_id, operation_id)
values (2755, 6355);
insert into OPERATE_BY (doctor_id, operation_id)
values (2756, 6356);
insert into OPERATE_BY (doctor_id, operation_id)
values (2757, 6357);
insert into OPERATE_BY (doctor_id, operation_id)
values (2758, 6358);
insert into OPERATE_BY (doctor_id, operation_id)
values (2759, 6359);
insert into OPERATE_BY (doctor_id, operation_id)
values (2760, 6360);
insert into OPERATE_BY (doctor_id, operation_id)
values (2761, 6361);
insert into OPERATE_BY (doctor_id, operation_id)
values (2762, 6362);
insert into OPERATE_BY (doctor_id, operation_id)
values (2763, 6363);
insert into OPERATE_BY (doctor_id, operation_id)
values (2764, 6364);
insert into OPERATE_BY (doctor_id, operation_id)
values (2765, 6365);
insert into OPERATE_BY (doctor_id, operation_id)
values (2766, 6366);
insert into OPERATE_BY (doctor_id, operation_id)
values (2767, 6367);
insert into OPERATE_BY (doctor_id, operation_id)
values (2768, 6368);
insert into OPERATE_BY (doctor_id, operation_id)
values (2769, 6369);
insert into OPERATE_BY (doctor_id, operation_id)
values (2770, 6370);
insert into OPERATE_BY (doctor_id, operation_id)
values (2771, 6371);
insert into OPERATE_BY (doctor_id, operation_id)
values (2772, 6372);
insert into OPERATE_BY (doctor_id, operation_id)
values (2773, 6373);
insert into OPERATE_BY (doctor_id, operation_id)
values (2774, 6374);
insert into OPERATE_BY (doctor_id, operation_id)
values (2775, 6375);
insert into OPERATE_BY (doctor_id, operation_id)
values (2776, 6376);
insert into OPERATE_BY (doctor_id, operation_id)
values (2777, 6377);
insert into OPERATE_BY (doctor_id, operation_id)
values (2778, 6378);
insert into OPERATE_BY (doctor_id, operation_id)
values (2779, 6379);
insert into OPERATE_BY (doctor_id, operation_id)
values (2780, 6380);
insert into OPERATE_BY (doctor_id, operation_id)
values (2781, 6381);
insert into OPERATE_BY (doctor_id, operation_id)
values (2782, 6382);
insert into OPERATE_BY (doctor_id, operation_id)
values (2783, 6383);
insert into OPERATE_BY (doctor_id, operation_id)
values (2784, 6384);
insert into OPERATE_BY (doctor_id, operation_id)
values (2785, 6385);
insert into OPERATE_BY (doctor_id, operation_id)
values (2786, 6386);
insert into OPERATE_BY (doctor_id, operation_id)
values (2787, 6387);
insert into OPERATE_BY (doctor_id, operation_id)
values (2788, 6388);
insert into OPERATE_BY (doctor_id, operation_id)
values (2789, 6389);
insert into OPERATE_BY (doctor_id, operation_id)
values (2790, 6390);
insert into OPERATE_BY (doctor_id, operation_id)
values (2791, 6391);
insert into OPERATE_BY (doctor_id, operation_id)
values (2792, 6392);
insert into OPERATE_BY (doctor_id, operation_id)
values (2793, 6393);
insert into OPERATE_BY (doctor_id, operation_id)
values (2794, 6394);
insert into OPERATE_BY (doctor_id, operation_id)
values (2795, 6395);
insert into OPERATE_BY (doctor_id, operation_id)
values (2796, 6396);
insert into OPERATE_BY (doctor_id, operation_id)
values (2797, 6397);
insert into OPERATE_BY (doctor_id, operation_id)
values (2798, 6398);
insert into OPERATE_BY (doctor_id, operation_id)
values (2799, 6399);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for OPERATION...
alter table OPERATION enable constraint SYS_C008496;
alter table OPERATION enable constraint SYS_C008497;
prompt Enabling foreign key constraints for ASSIST_BY...
alter table ASSIST_BY enable constraint SYS_C008508;
alter table ASSIST_BY enable constraint SYS_C008509;
prompt Enabling foreign key constraints for EQUIPEMENT...
alter table EQUIPEMENT enable constraint SYS_C008481;
prompt Enabling foreign key constraints for OPERATE_BY...
alter table OPERATE_BY enable constraint SYS_C008502;
alter table OPERATE_BY enable constraint SYS_C008503;
prompt Enabling triggers for NURSE...
alter table NURSE enable all triggers;
prompt Enabling triggers for PATIENT...
alter table PATIENT enable all triggers;
prompt Enabling triggers for OPERATING_ROOM...
alter table OPERATING_ROOM enable all triggers;
prompt Enabling triggers for OPERATION...
alter table OPERATION enable all triggers;
prompt Enabling triggers for ASSIST_BY...
alter table ASSIST_BY enable all triggers;
prompt Enabling triggers for DOCTOR...
alter table DOCTOR enable all triggers;
prompt Enabling triggers for EQUIPEMENT...
alter table EQUIPEMENT enable all triggers;
prompt Enabling triggers for OPERATE_BY...
alter table OPERATE_BY enable all triggers;

set feedback on
set define on
prompt Done
