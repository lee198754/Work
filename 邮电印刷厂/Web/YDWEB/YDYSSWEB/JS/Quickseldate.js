// JScript 文件
function fillstring(str)
{
	if(str.length==1)
	{
		str = "0" + str; 
	}
	return(str);
}
function quickseldate(type)
{
	var begintime,endtime;
	var oneminute = 60*1000;
	var onehour   = 60*oneminute;
	var oneday    = 24*onehour;
	var oneweek   = 7*oneday;
	
	var todayDate = new Date();
	var date = todayDate.getDate();
	var month= todayDate.getMonth() +1;
	var year= todayDate.getFullYear();
	var day = todayDate.getDay();
	if(navigator.appName == "Netscape")
	{
		year = 1900 + year;
	}

	//-->
				
	if(type=="day")
	{
		begintime = year.toString() + "-" + fillstring(month.toString()) + "-" + fillstring(date.toString());
		endtime = begintime;
	}
	else if(type=="week")
	{
		var daytoMon = day-1;
		if(day==0) 
			daytoMon = 6;
		
		todayDate.setTime(todayDate.getTime()-daytoMon*oneday);
		date = todayDate.getDate();
		month= todayDate.getMonth() +1;
		year= todayDate.getFullYear();
		day = todayDate.getDay();
		
		begintime = year.toString() + "-" + fillstring(month.toString()) + "-" + fillstring(date.toString());
		
		todayDate.setTime(todayDate.getTime()+6*oneday);
		
		date = todayDate.getDate();
		month= todayDate.getMonth() +1;
		year= todayDate.getFullYear();
		
		endtime = year.toString() + "-" + fillstring(month.toString()) + "-" + fillstring(date.toString());
	}
	else if(type=="month")
	{
		var dateto1 = date-1;
		
		todayDate.setTime(todayDate.getTime()-dateto1*oneday);
		date = todayDate.getDate();
		month= todayDate.getMonth() +1;
		year= todayDate.getFullYear();
		day = todayDate.getDay();
		
		begintime = year.toString() + "-" + fillstring(month.toString()) + "-" + fillstring(date.toString());
		
		todayDate.setMonth(month);
		todayDate.setTime(todayDate.getTime()-oneday);
		
		date = todayDate.getDate();
		month= todayDate.getMonth() +1;
		year= todayDate.getFullYear();
		
		endtime = year.toString() + "-" + fillstring(month.toString()) + "-" + fillstring(date.toString());

	}

	document.getElementById("txt_BegionTime").value = begintime;
	document.getElementById("txt_endTime").value = endtime;

}
