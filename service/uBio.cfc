<cfcomponent>
	<cfinclude template="/includes/alwaysInclude.cfm">
	<cfoutput>
		<cffunction name="testUbio" access="remote" returntype="string" output="no">
	    	<!--- Creatr a variable for the URL --->
<cfset theURL = "http://www.ubio.org/webservices/service_internal.php">

<!--- Make the Post Request --->	
<cfhttp url="#theURL#" charset="utf-8" method="get">
	<cfhttpparam type="url" name="keyCode" value="0dcb58874a48e95725f591152981365d45833b56">
	<cfhttpparam type="url" name="function" value="classificationbank_object">
	<cfhttpparam type="url" name="classificationBankID" value="2038379">
	<cfhttpparam type="url" name="childrenFlag" value="1">
	<cfhttpparam type="url" name="ancestryFlag" value="1">
	<cfhttpparam type="url" name="citationsFlag" value="1">
	<cfhttpparam type="url" name="synonymsFlag" value="1">
	<cfhttpparam type="url" name="version" value="2.0">
</cfhttp>

<cfswitch expression="#cfhttp.responseHeader.status_code#">
	
	<cfcase value="503">
		<cfthrow message="Your call to Yahoo Web Services failed and  returned an HTTP status of 503. That means: Service unavailable. An internal problem prevented us from returning data to you.">
	</cfcase>
	
	<cfcase value="403">
		<cfthrow message="Your call to Yahoo  Web Services failed and returned an HTTP status  of 403. That means: Forbidden. You do not have permission to  access this resource, or are over your rate limit.">
	</cfcase>

	<cfcase value="400">
		<cfthrow message="Your call to Yahoo Web Services failed  and returned an HTTP status of 400.  That means: Bad request. The parameters passed to the service did not match as expected. The exact error is returned in the  XML response.">
	</cfcase>
	
	<cfcase value="200">
		<!--- Good response, do nothing. --->
	</cfcase>
	
	<cfdefaultcase>
		<cfthrow message="Your call to Yahoo Web Services returned an unexpected  HTTP status of: #cfhttp.responseHeader.status_code#">
	</cfdefaultcase>
	
</cfswitch>

			<cfreturn cfhttp.fileContent>             
	  	</cffunction>
	</cfoutput>
</cfcomponent>