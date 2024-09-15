SELECT 
(Area.aareadesc)as 'Customer',   
isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(sum(timetaken))),100)      +':'                             + 
            RIGHT('00' + CONVERT(varchar(2),FLOOR((((sum(timetaken))-FLOOR((sum(timetaken))))*60))),2)      +':'      + 
            RIGHT('00' + CONVERT(varchar(2),FLOOR((((sum(timetaken))-FLOOR((sum(timetaken))))*60)-FLOOR((((sum(timetaken))-FLOOR((sum(timetaken))))*60)))*60),2)),'0:00:00')
            as 'Time Taken',                                                                                     


isnull((SELECT    RIGHT('' + CONVERT(varchar(100),FLOOR(sum(IIF(actionbillingplanid = -2, timetaken, 0)))),100)      +':'                             + 
            RIGHT('00' + CONVERT(varchar(2),FLOOR((((sum(IIF(actionbillingplanid = -2, timetaken, 0)))-FLOOR((sum(IIF(actionbillingplanid = -2, timetaken, 0)))))*60))),2)      +':'      + 
            RIGHT('00' + CONVERT(varchar(2),FLOOR((((sum(IIF(actionbillingplanid = -2, timetaken, 0)))-FLOOR((sum(IIF(actionbillingplanid = -2, timetaken, 0)))))*60)-FLOOR((((sum(IIF(actionbillingplanid = -2, timetaken, 0)))-FLOOR((sum(IIF(actionbillingplanid = -2, timetaken, 0)))))*60)))*60),2)),'0:00:00')
            as 'Billable Time',

isnull(
       round((Select sum(timetaken)),2)

      ,0) as 'Time Taken (System)',

isnull(
       round((sum(IIF(actionbillingplanid = -2, timetaken, 0))),2)

      ,0) as 'Billable Time (System)',

isnull(
       round((sum(IIF(actionbillingplanid <= -3, timetaken, 0))),2)

      ,0) as 'Contract Time (System)'   


FROM (ACTIONS INNER JOIN Faults ON ACTIONS.Faultid = Faults.Faultid) 
INNER JOIN Area ON Faults.Areaint = Area.Aarea

where whe_ > @startdate and whe_ < @enddate
AND FDeleted !='TRUE' /* Excludes deleted tickets */


group by aareadesc  
