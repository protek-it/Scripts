select   uname as 'Technician',  usection as 'Section',  (select count(faultid) from Faults where Assignedtoint=unum and Status<>9 and dateoccured>@startdate and dateoccured<@enddate) as 'OpenTicketCount',  (select count(faultid) from Faults where Assignedtoint=unum and status=9 and dateoccured>@startdate and dateoccured<@enddate) as 'ClosedTicketCount',  (select count(faultid) from Faults where Assignedtoint=unum and dateoccured>@startdate and dateoccured<@enddate) as 'TotalTicketCount',    isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(sum(timetaken))),100)      +':'                             + RIGHT('00' + CONVERT(varchar(2),FLOOR((((SUM(timetaken))-FLOOR((SUM(timetaken))))*60))),2)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR((((SUM(timetaken))-FLOOR((SUM(timetaken))))*60)-FLOOR((((SUM(timetaken))-FLOOR((SUM(timetaken))))*60)))*60),2) from ACTIONS where who=uname and Whe_>@startdate and whe_<@enddate),'0:00:00')as 'WorkingTime',    isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(SUM(traveltime))),100)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(traveltime)-FLOOR(SUM(traveltime)))*60))),2)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(traveltime)-FLOOR(SUM(traveltime)))*60)-FLOOR(((SUM(traveltime)-FLOOR(SUM(traveltime)))*60)))*60),2) from ACTIONS where who=uname and Whe_>@startdate and whe_<@enddate),'0:00:00') as 'TravelTime',     isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate))),100)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR((((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)-FLOOR((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)))*60))),2)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR((((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)-FLOOR((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)))*60)-FLOOR((((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)-FLOOR((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate)))*60)))*60),2)),'0:00:00') as 'Non-RecoverableTime',    isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(SUM(timetaken)+SUM(traveltime))),100)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(timetaken)+SUM(traveltime)-FLOOR(SUM(timetaken)+SUM(traveltime)))*60))),2)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(timetaken)+SUM(traveltime)-FLOOR(SUM(timetaken)+SUM(traveltime)))*60)-FLOOR(((SUM(timetaken)+SUM(traveltime)-FLOOR(SUM(timetaken)+SUM(traveltime)))*60)))*60),2) from ACTIONS where who=uname and Whe_>@startdate and whe_<@enddate),'0:00:00') as 'RecoverableTime',    isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0))),100)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)-FLOOR(SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)))*60))),2)      +':'      + RIGHT('00' + CONVERT(varchar(2),FLOOR(((SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)-FLOOR(SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)))*60)-FLOOR(((SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)-FLOOR(SUM(timetaken)+SUM(traveltime)+isnull((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and hdate<@enddate),0)))*60)))*60),2)  from ACTIONS where who=uname and Whe_>@startdate and whe_<@enddate),'0:00:00') as 'BookedTime'         from uname   
