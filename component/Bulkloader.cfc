<cfcomponent>
<!----------------------------------------------------------------------------------------->
<cffunction name="getPage" access="remote">
	<cfargument name="page" required="yes">
    <cfargument name="pageSize" required="yes">
	<cfargument name="gridsortcolumn" required="yes">
    <cfargument name="gridsortdirection" required="yes">
	<cfargument name="accn" required="yes">
	<cfargument name="enteredby" required="yes">
	
	<cfset startrow=page * pageSize>
	<cfset stoprow=startrow + pageSize>
	
	<!---
	
		
		

{"page":1,"pageSize":10,"gridsortcolumn":"CAT_NUM","gridsortdirection":"DESC"}
	--->
<cfoutput>
	<cfset sql="Select * from ( Select a.*, rownum rnum From (">
	<cfset sql=sql & "select * from bulkloader where 1=1">
	<cfif len(accn) gt 0>
		<cfset sql=sql & " and accn IN (#accn#)">
	</cfif>
	<cfif len(enteredby) gt 0>
		<cfset sql=sql & " and enteredby IN (#enteredby#)">
	</cfif>
	<cfset sql=sql & " order by #gridsortcolumn# #gridsortdirection#">
	<cfset sql=sql & " ) a where rownum <= #stoprow#) where rnum >= #startrow#">

	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		#preservesinglequotes(sql)#
	</cfquery>
</cfoutput>
	  <cfreturn data />
</cffunction>
</cfcomponent>