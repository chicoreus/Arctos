<cfcomponent>
<!----------------------------------------------------------------------------------------->
<cffunction name="getPage" access="remote">
	<cfargument name="page" required="yes">
    <cfargument name="pageSize" required="yes">
	<cfargument name="gridsortcolumn" required="yes">
    <cfargument name="gridsortdirection" required="yes">
	<!---
	<cfargument name="accn" required="yes">
	<cfargument name="enteredby" required="yes">
		
		

{"page":1,"pageSize":10,"gridsortcolumn":"CAT_NUM","gridsortdirection":"DESC"}
	--->
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select * from bulkloader where rownum<20		
	</cfquery>

	  <cfreturn queryconvertforgrid(data,page,pagesize)/>
</cffunction>
</cfcomponent>