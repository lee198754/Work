drop table #customid
go
select c.F_iID,c.F_sCpbh,c.F_nYl,b.F_iProductTypeID into #customid from BI_CustomOrderDetails a,Set_PostageType b ,DO_OrderApart c
  where CHARINDEX(b.F_sYztmc,c.F_sYztmc)=1 and a.F_iID=c.F_iOrderID and c.F_tiOrderType=0 and  a.F_iTgzt=0 
  and exists(Select 1 from BI_CustomOrder where a.F_iCustomID=F_iID )and F_dJsrq >= '20111001' and F_dJsrq <= '20111030')

select F_iID from #customid where F_iProductTypeID=4

select * from DO_OrderApart where F_iID in (select F_iID from #customid where F_iProductTypeID=4)

select * 
--update DO_OrderApart set F_sYztmc = 'ÎÞÓÊ×ÊÍ¼'
from DO_OrderApart where F_sCPBH in (select F_sCPBH from DO_OrderApart where F_iID in (112,157,456,457)) and F_tiNJBZ=1
select * from BI_Customorder where F_iID in (select F_iCustomID from BI_CustomOrderDetails where F_iID in (112,157,456,457))

insert into DO_OrderApart
select F_tiOrderType,F_iOrderID,F_sCPBH,F_nYl,F_sYztmc,F_iCZR,F_dCZRQ,F_tiNJBZ=1
from DO_OrderApart where F_sCPBH in (select F_sCPBH from DO_OrderApart where F_iID in (112,157,456,457))


 if not exists(Select 1 from DO_ProductDate_Log where F_iWorkID = 6) 
Insert into DO_ProductDate_Log (F_iWorkID) VALUES (6) 
if not exists(Select 1 from DO_ProductDate_Log where F_iWorkID = 5) Insert into (F_iWorkID) VALUES (6) 

'Update DO_ProductDate_Log set F_dYYSRQ='2011/10/30 2:34:11',F_iYYSCZRID=7 where F_iWorkID in (5,6)'

 