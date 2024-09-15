SELECT

(select uname from uname where assignedtoint=unum)as [Technician],

(select count(faultid) from faults where Status<>9 and assignedtoint = O.assignedtoint and FexcludefromSLA=0 )as
[Total Tickets Currently Open],

(select COUNT(faultid) from Faults where assignedtoint = O.assignedtoint and dateoccured>@startdate and 
dateoccured<@enddate  
and FexcludefromSLA=0)as [Tickets Opened This Period],

(select COUNT(faultid) from faults where status=9 and assignedtoint = O.assignedtoint and datecleared>@startdate and 
datecleared<@enddate  and FexcludefromSLA=0)as [Tickets Closed This Period],

(select count(faultid) from faults where slastate='O' and assignedtoint = O.assignedtoint and datecleared>@startdate 
and 
datecleared<@enddate  and status=9  and FexcludefromSLA=0)as [SLA Missed],

(select count(faultid) from faults where slastate='I' and assignedtoint = O.assignedtoint and datecleared>@startdate 
and 
datecleared<@enddate  and status=9  and FexcludefromSLA=0)as [SLA Met],

cast((round(cast((select count(faultid) from faults where slastate='O' and assignedtoint = O.assignedtoint and 
datecleared>@startdate and datecleared<@enddate  and status=9  and FexcludefromSLA=0)as float)
/replace(cast(((select COUNT(faultid) from faults where status=9 and assignedtoint = O.assignedtoint and 
datecleared>@startdate 
and datecleared<@enddate   and FexcludefromSLA=0))as float),0,1),4)*100)as nvarchar(50)) + ' %' as 
[SLA Missed %],

cast((round(cast((select count(faultid) from faults where slastate='I' and assignedtoint = O.assignedtoint and 
datecleared>@startdate and datecleared<@enddate  and status=9  and FexcludefromSLA=0)as float)
/replace(cast(((select COUNT(faultid) from faults where status=9 and assignedtoint = O.assignedtoint and 
datecleared>@startdate 
and datecleared<@enddate   and FexcludefromSLA=0))as float),0,1),4)*100)as nvarchar(50)) + ' %' as 
'SLA Met %'

FROM faults O
where FexcludefromSLA=0 and assignedtoint in (select unum from uname where uisdisabled=0)
GROUP BY assignedtoint   
                                           

                                          




