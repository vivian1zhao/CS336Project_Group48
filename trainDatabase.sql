create database if not exists `TrainDatabase`;
use `TrainDatabase`;

drop table if exists `train`;
create table `train` (
`tid` varchar(4) primary key);

drop table if exists `station`;
create table `station` (
`sid` int primary key,
`name` varchar(30),
`city` varchar(30),
`state` varchar(30));

drop table if exists `transitLine`;
create table `transitLine` (
`tlid` int primary key,
`tlname` varchar(30));

drop table if exists `trainSchedule`;
create table `trainSchedule` (
`schid` int primary key, 
`tlid` int, 
`tid` varchar(4), 
`origin` varchar(30),
`destination` varchar(30),
`numStop` int,
`departure` time, 
`arrival` time,
`traveltime` varchar(30),
`fare` varchar(30),
foreign key(`tlid`) references `transitLine`(`tlid`) on delete cascade on update cascade,
foreign key(`tid`) references `train`(`tid`) on delete cascade on update cascade);

drop table if exists `customer`;
create table `customer` (
`cid` int primary key,
`firstname` varchar(30),
`lastname` varchar(30),
`email` varchar(30),
`username` varchar(30),
`password` varchar(30));

drop table if exists `reservationData`;
create table `reservationData` (
`resnum` int auto_increment primary key,
`date` date, 
`cid` int,
`schid` int, 
`totalfare` varchar(30),
`originStation` int,
`destinationStation` int,
`tid` varchar(4),
`cancelled` int,
foreign key(`schid`) references `trainSchedule`(`schid`) on delete cascade on update cascade,
foreign key(`cid`) references `customer`(`cid`) on delete cascade on update cascade,
foreign key(`originStation`) references `station`(`sid`) on delete cascade on update cascade,
foreign key(`destinationStation`) references `station`(`sid`) on delete cascade on update cascade,
foreign key(`tid`) references `train`(`tid`) on delete cascade on update cascade);

drop table if exists `employeeAdmin`;
create table `employeeAdmin` (
`ssn` int,
`firstname` varchar(30),
`lastname` varchar(30),
`username` varchar(30),
`password` varchar(30));

drop table if exists `employeeCustomerRep`;
create table `employeeCustomerRep` (
`ssn` int,
`firstname` varchar(30),
`lastname` varchar(30),
`username` varchar(30),
`password` varchar(30));

insert into `train` 
values
(3868), (3869), (3870), (3871), (3872), (3873), (3874), (3875), (3876), (3877), (3878), (3879);

insert into `station`
values
(1, 'Trenton Transit Center', 'Trenton', 'New Jersey'),
(2, 'New Brunswick', 'New Brunswick', 'New Jersey'),
(3, 'Elizabeth', 'Elizabeth', 'New Jersey'),
(4, 'Newark Penn Station', 'Newark', 'New Jersey'),
(5, 'Penn Station New York', 'New York', 'New York'),
(6, 'Raritan', 'Raritan', 'New Jersey'),
(7, 'Bridgewater', 'Bridgewater', 'New Jersey'),
(8, 'Dunellen', 'Dunellen', 'New Jersey'),
(9, 'Garwood', 'Garwood', 'New Jersey'),
(10, 'Newark Penn Station', 'Newark', 'New Jersey'),
(11, 'Bay Head', 'Bay Head', 'New Jersey'),
(12, 'Asbury Park', 'Asbury Park', 'New Jersey'),
(13, 'Long Branch', 'Long Branch', 'New Jersey'),
(14, 'Woodbridge', 'Woodbridge', 'New Jersey'),
(15, 'Newark Penn Station', 'Newark','New Jersey'),
(16, 'Penn Station New York', 'New York', 'New York'),
(17, 'Hackettstown', 'Hackettstown', 'New Jersey'),
(18, 'Summit', 'Summit', 'New Jersey'),
(19, 'Millburn', 'Millburn', 'New Jersey'),
(20, 'Newark Broad Street', 'Newark', 'New Jersey'),
(21, 'Hoboken', 'Hoboken', 'New York'),
(22, 'Hackettstown', 'Hackettstown', 'New Jersey'),
(23, 'Dover', 'Dover', 'New Jersey'),
(24, 'Boonton', 'Boonton', 'New Jersey'),
(25, 'Newark Broad Street', 'Newark', 'New Jersey'),
(26, 'Hoboken', 'Hoboken', 'New Jersey'),
(27, 'Suffern', 'Suffern', 'New York'), 
(28, 'Allendale', 'Allendale', 'New Jersey'),
(29, 'Ridgewood', 'Ridgewood', 'New Jersey'),
(30, 'Secaucus Junction', 'Secaucus', 'New Jersey'),
(31, 'Hoboken', 'Hoboken', 'New Jersey');

insert into `transitLine`
values
(1, 'Northeast Corridor'),
(2, 'Raritan Valley'),
(3, 'North Jersey Coast'),
(4, 'Morris & Essex'),
(5, 'Montaclair-Boonton'),
(6, 'Main-Bergen County');

insert into `trainSchedule` 
values
(1, 1, 3868, 'Trenton Transit Center', 'Penn Station New York', 5, '23:23:00', '00:25:00', '92 minutes', '$19.25'),
(2, 1, 3869, 'Penn Station New York', 'Trenton Transit Center', 5, '23:06:00', '00:55:00', '100 minutes', '$19.25'),
(3, 2, 3870, 'Raritan', 'Penn Station New York', 5, '23:36:00', '00:38:00', '62 minutes', '$12.65'),
(4, 2, 3871, 'Penn Station New York', 'Raritan', 5, '23:08:00', '00:03:00', '55 minutes', '$12.65'),
(5, 3, 3872, 'Bay Head', 'Penn Station New York', 6, '23:32:00', '01:55:00', '138 minutes', '$19.25'),
(6, 3, 3873, 'Penn Station New York', 'Bay Head', 6, '23:18:00', '01:38:00', '137 minutes', '$19.25'),
(7, 4, 3874, 'Hackettstown', 'Hoboken', 5, '06:42:00', '08:34:00', '112 minutes', '$13.80'),
(8, 4, 3875, 'Hackettstown', 'Hoboken', 5, '06:45:00', '08:34:00', '109 minutes', '$13.80'),
(9, 5, 3876, 'Hackettstown', 'Hoboken', 5, '05:04:00', '07:00:00', '114 minutes', '$13.80'),
(10, 5, 3877, 'Hoboken', 'Hackettstown', 5, '05:05:00', '07:01:00', '114 minutes', '$13.80'),
(11, 6, 3878, 'Suffern', 'Hoboken', 5, '05:13:00', '06:11:00', '58 minutes', '$11.00'),
(12, 6, 3879, 'Hoboken', 'Suffern', 5, '05:48:00', '06:56:00', '68 minutes', '$11.00');

insert into `employeeAdmin` 
values
(123456789, 'Vivian', 'Zhao', 'vzhao', 'vzhao');
