select uname as 'Technician'
, usection as 'Section'
, (select count(faultid) from Faults where Assignedtoint=unum and Status<>9 and dateoccured>@startdate and  
dateoccured<@enddate) 
as 'OpenTicketCount'
, (select count(faultid) from Faults where Assignedtoint=unum and status=9 and dateoccured>@startdate and  
dateoccured<@enddate) 
as 'ClosedTicketCount'
, (select count(faultid) from Faults where Assignedtoint=unum and dateoccured>@startdate and 
dateoccured<@enddate) 
as 'TotalTicketCount'
, isnull(round((select sum(timetaken) from actions where who=uname and whe_>@startdate and whe_<@enddate),2),0)
as 'WorkingTime'
, isnull(round((select sum(traveltime) from actions where who=uname and whe_>@startdate and whe_<@enddate),2),0)
as 'TravelTime'
, isnull(round((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and 
hdate<@enddate),2),0)
as 'HolidayTime'
, isnull(round((select sum(timetaken)+sum(traveltime) from actions where who=uname and whe_>@startdate and  
whe_<@enddate),2),0)
as 'WorkingTravelTime'
, isnull(round((select sum(timetaken)+sum(traveltime) from actions where who=uname and whe_>@startdate and 
whe_<@enddate),2),0) 
    + isnull(round((select sum(hduration) from holidays where HTechnicianID=Unum and hdate>@startdate and 
hdate<@enddate),2),0) 
as 'TotalTime'                        
from uname

