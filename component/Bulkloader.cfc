<cfcomponent>



<!----------------------------------------------------------------------------------------->
<cffunction name="saveNewSpecimenEvent" access="remote" returnformat="json" queryformat="column">
	<cfargument name="q" required="yes">
	<cfoutput>
		
		
		<cfloop list="#q#" index="kv" delimiters="&">
			<cfset k=listfirst(kv,"=")>
			<cfset v=replace(kv,k & "=",'')>
			<cfset "#k#"=urldecode(v)>
		</cfloop>
		<cfset fatalerrstr="">


	<cfset required="UUID,assigned_by_agent_name,assigned_date,collecting_source">
	<cfif variables.letype is "pick_event">
		<cfset required=listappend(required,"collecting_event_id")>
	</cfif>
	
	<!--- 
		options:
			pick_event=require collecting event ID
			type_event=require event stuff + locality_id
			type_locality: require event stuff, locality stuff, geog_auth_rec_id
			pick_locality: require locality_id
			
		extension:
			under type_locality ONLY
				check orig_lat_long_units
					if not null then require
						datum n such
					if DD then require....	
	--->
	<cfif variables.letype is "pick_event">
		<cfset required=listappend(required,"collecting_event_id")>
	<cfelseif variables.letype is "type_event">
		<cfset temp="locality_id,verbatim_locality,verbatim_date,began_date,ended_date">
		<cfset required=listappend(required,temp)>
	<cfelseif variables.letype is "pick_locality">
		<cfset temp="locality_id,verbatim_locality,verbatim_date,began_date,ended_date">
		<cfset required=listappend(required,temp)>
	<cfelseif variables.letype is "type_locality">
		<cfset temp="HIGHER_GEOG,verbatim_locality,verbatim_date,began_date,ended_date,spec_locality">
		<cfset required=listappend(required,temp)>
		<cfif len(orig_elev_units) gt 0 or len(minimum_elevation) gt 0 or len(maximum_elevation) gt 0>
			<cfif len(orig_elev_units) is 0 or len(minimum_elevation) is 0 or len(maximum_elevation) is 0>
				<cfset fatalerrstr=listappend(fatalerrstr,'(orig_elev_units,minimum_elevation,maximum_elevation) must be all or none',';')>
			</cfif>
		</cfif>		
		<cfif len(orig_lat_long_units) gt 0>
			<cfif len(max_error_distance) gt 0 or len(max_error_units) gt 0>
				<cfif len(max_error_distance) is 0 or len(max_error_units) is 0>
					<cfset fatalerrstr=listappend(fatalerrstr,'(max_error_distance,max_error_units) must be all or none',';')>
				</cfif>
			</cfif>
			<cfset temp="datum,georeference_source,georeference_protocol">
			<cfset required=listappend(required,temp)>
			<cfif orig_lat_long_units is "decimal degrees">
				<cfset temp="dec_lat,dec_long">
				<cfset required=listappend(required,temp)>
			</cfif>
			<cfif orig_lat_long_units is "deg. min. sec.">
				<cfset temp="latdeg,latmin,latsec,latdir,longdeg,longmin,longsec,longdir">
				<cfset required=listappend(required,temp)>
			</cfif>
			<cfif orig_lat_long_units is "degrees dec. minutes">
				<cfset temp="decLAT_DEG,dec_lat_min,decLAT_DIR,decLONGDEG,DEC_LONG_MIN,decLONGDIR">
				<cfset required=listappend(required,temp)>
			</cfif>
			<cfif orig_lat_long_units is "UTM">
				<cfset temp="utm_zone,utm_ew,utm_ns">
				<cfset required=listappend(required,temp)>
			</cfif>
		</cfif>
	</cfif>
	
	
	
	<cfloop list="#required#" index="i">
		<cfset thisVal=evaluate("variables." & i)>
		<cfif len(thisVal) is 0>
			<cfset fatalerrstr=listappend(fatalerrstr,'#i# is required',';')>
		</cfif>
	</cfloop>
	
	
		<cfif len(fatalerrstr) is 0>
			<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				insert into cf_temp_specevent (
					status,
					UUID
					guid varchar2(60) not null,
					ASSIGNED_BY_AGENT varchar2(255),
					ASSIGNED_DATE varchar2(255),
					SPECIMEN_EVENT_REMARK varchar2(255),
					SPECIMEN_EVENT_TYPE varchar2(255),
					COLLECTING_METHOD varchar2(255),
					COLLECTING_SOURCE varchar2(255),
					VERIFICATIONSTATUS varchar2(255),
					HABITAT varchar2(255),
					COLLECTING_EVENT_ID NUMBER,
					VERBATIM_DATE varchar2(255),
					VERBATIM_LOCALITY varchar2(255),
					COLL_EVENT_REMARKS varchar2(255),
					BEGAN_DATE varchar2(255),
					ENDED_DATE varchar2(255),
					COLLECTING_EVENT_NAME varchar2(255),
					LAT_DEG NUMBER,
					DEC_LAT_MIN NUMBER,
					LAT_MIN NUMBER,
					LAT_SEC NUMBER,
					LAT_DIR NUMBER,
					LONG_DEG NUMBER,
					DEC_LONG_MIN NUMBER,
					LONG_MIN NUMBER,
					LONG_SEC NUMBER,
					LONG_DIR NUMBER,
					DEC_LAT NUMBER,
					DEC_LONG NUMBER,
					DATUM varchar2(255),
					UTM_ZONE varchar2(255),
					UTM_EW varchar2(255),
					UTM_NS varchar2(255),
					ORIG_LAT_LONG_UNITS varchar2(255),
					LOCALITY_ID NUMBER,
					SPEC_LOCALITY varchar2(255),
					MINIMUM_ELEVATION NUMBER,
					MAXIMUM_ELEVATION NUMBER,
					ORIG_ELEV_UNITS varchar2(255),
					MIN_DEPTH NUMBER,
					MAX_DEPTH NUMBER,
					DEPTH_UNITS varchar2(255),
					MAX_ERROR_DISTANCE NUMBER,
					MAX_ERROR_UNITS varchar2(255),
					LOCALITY_REMARKS varchar2(255),
					GEOREFERENCE_SOURCE varchar2(255),
					GEOREFERENCE_PROTOCOL varchar2(255),
					LOCALITY_NAME varchar2(255),
					GEOG_AUTH_REC_ID NUMBER,
					HIGHER_GEOG varchar2(255),
					l_collection_object_id number,
					l_collecting_event_id number,
					l_locality_id number,
					l_geog_auth_rec_id number,
					l_event_assigned_id number
			</cfquery>

		
		
	
);




			<cfreturn fatalerrstr>
		</cfif>
		<cfreturn 'component doing stuff'>
	</cfoutput>
</cffunction>





<cffunction name="my_last_record" access="remote">
	<cfquery name="result" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select max(collection_object_id) collection_object_id from bulkloader where enteredby='#session.username#'
	</cfquery>
	<cfreturn result.collection_object_id>
</cffunction>

<!----------------------------------------------------------------------------------------->

<cffunction name="loadRecord" access="remote">
	<cfargument name="collection_object_id" required="yes">
	<cfif collection_object_id gt 500><!--- don't check templates/new records--->
		<cfquery name="chk" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select nvl(bulk_check_one(collection_object_id),'waiting approval') ld from bulkloader where collection_object_id=#collection_object_id#
		</cfquery>
		<cfif len(chk.ld) gt 254>
			<cfset msg=left(chk.ld,200) & '... {snip}'>
		<cfelseif len(chk.ld) is 0>
			<cfset msg='passed checks'>
		<cfelse>
			<cfset msg=chk.ld>
		</cfif>
		<cfquery name="rchk" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			update bulkloader set loaded='#msg#' where collection_object_id=#collection_object_id#
		</cfquery>
	</cfif>
	<cfquery name="getCols" datasource="uam_god" cachedwithin="#createtimespan(0,0,60,0)#">
		select
			column_name
		from
			sys.user_tab_cols
		where
			table_name='BULKLOADER'
		and
			column_name not like '%$%'
		order by
			internal_column_id
	</cfquery>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select #valuelist(getCols.column_Name)# from bulkloader where collection_object_id=#collection_object_id#
	</cfquery>
	<cfreturn d>
</cffunction>


<!----------------------------------------------------------------------------------------->

<cffunction name="bulk_check_one" access="remote">
	<cfargument name="collection_object_id" required="yes">
	<cfif collection_object_id lt 500>
			<cfset result = querynew("result")>
			<cfset temp = queryaddrow(result,1)>
	<cfelse>
		<cfquery name="result" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select bulk_check_one(#collection_object_id#) result from dual
		</cfquery>
	</cfif>

	<cfreturn result>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="getExistingCatItemData" access="remote">
	<cfargument name="collection_object_id" required="yes">
	<cfquery name="g" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select
			collecting_event_id,
			collectors,
			guid
		from
			flat
		where
			collection_object_id=#collection_object_id#
	</cfquery>
	<cfreturn g>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="splitGeog" access="remote">
	<cfargument name="geog" required="yes">
	<cfargument name="specloc" required="yes">
	<cfquery name="g" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select
			country,
			county,
			state_prov
		from
			geog_auth_rec
		where
			higher_geog='#geog#'
	</cfquery>
	<cfset guri="http://www.museum.tulane.edu/geolocate/web/webgeoreflight.aspx?georef=run&locality=#specloc#">
	<cfif len(g.country) gt 0>
		<cfset guri=listappend(guri,"country=#g.country#","&")>
	</cfif>
	<cfif len(g.state_prov) gt 0>
		<cfset guri=listappend(guri,"state=#g.state_prov#","&")>
	</cfif>
	<cfif len(g.county) gt 0>
		<cfset cnty=replace(g.county," County","")>
		<cfset guri=listappend(guri,"county=#cnty#","&")>
	</cfif>
	<cfreturn guri>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="geolocate" access="remote">
	<cfargument name="geog" required="yes">
	<cfargument name="specloc" required="yes">
	<cfquery name="g" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select
			country,
			county,
			state_prov
		from
			geog_auth_rec
		where
			higher_geog='#geog#'
	</cfquery>
	<cfhttp method="post" url="http://www.museum.tulane.edu/webservices/geolocatesvcv2/geolocatesvc.asmx/Georef2" timeout="5">
	    <cfhttpparam name="Country" type="FormField" value="#g.country#">
	    <cfhttpparam name="County" type="FormField" value="#g.county#">
	    <cfhttpparam name="LocalityString" type="FormField" value="#specloc#">
	    <cfhttpparam name="State" type="FormField" value="#g.state_prov#">
	    <cfhttpparam name="HwyX" type="FormField" value="false">
	    <cfhttpparam name="FindWaterbody" type="FormField" value="false">
	    <cfhttpparam name="RestrictToLowestAdm" type="FormField" value="false">
	    <cfhttpparam name="doUncert" type="FormField" value="true">
	    <cfhttpparam name="doPoly" type="FormField" value="false">
	    <cfhttpparam name="displacePoly" type="FormField" value="false">
	    <cfhttpparam name="polyAsLinkID" type="FormField" value="false">
	    <cfhttpparam name="LanguageKey" type="FormField" value="0">
	</cfhttp>
	<cfset glat=''>
	<cfset glon=''>
	<cfset gerr=''>
	<cfif cfhttp.statuscode is "200 OK">
		<cfset gl=xmlparse(cfhttp.fileContent)>
		<cfif gl.Georef_Result_Set.NumResults.xmltext is 1>
			<cfset glat=gl.Georef_Result_Set.ResultSet.WGS84Coordinate.Latitude.XmlText>
			<cfset glon=gl.Georef_Result_Set.ResultSet.WGS84Coordinate.Longitude.XmlText>
			<cfset gerr=gl.Georef_Result_Set.ResultSet.UncertaintyRadiusMeters.XmlText>
		</cfif>
	</cfif>
	<cfset result = querynew("GLAT,GLON,GERR")>
	<cfset temp = queryaddrow(result,1)>
	<cfset temp = QuerySetCell(result, "GLAT", glat, 1)>
	<cfset temp = QuerySetCell(result, "GLON", glon, 1)>
	<cfset temp = QuerySetCell(result, "GERR", gerr, 1)>
	<cfreturn result>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="incrementCustomId" access="remote">
	<cfargument name="cidType" required="no">
	<cfargument name="cidVal" required="no">
	<cfif isdefined("cidType") and len(cidType) gt 0>
		<cfset cVal="">
		<cfif isdefined("session.rememberLastOtherId") and session.rememberLastOtherId is 1>
			<cftry>
				<cfif isnumeric(cidVal)>
					<cfset cVal = cidVal + 1>
				<cfelseif isnumeric(right(cidVal,len(cidVal)-1))>
					<cfset temp = (right(cidVal,len(cidVal)-1)) + 1>
					<cfset cVal = left(cidVal,1) & temp>
				</cfif>
			<cfcatch>
				<!--- whatever ---->
			</cfcatch>
			</cftry>
		</cfif>
		<cfreturn cVal>
	<cfelse>
		<cfreturn ''>
	</cfif>
</cffunction>


<!----------------------------------------------------------------------------------------->

<cffunction name="deleteRecord" access="remote">
	<cfargument name="collection_object_id" required="yes">
	<cftry>
		<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			delete from bulkloader where collection_object_id=#collection_object_id#
		</cfquery>
	<cfcatch>
		<cfreturn 'Failure deleting record: #cfcatch.message# #cfcatch.detail#'>
	</cfcatch>
	</cftry>
	<cfreturn />
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="checkshowcal" access="remote">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select show_calendars from cf_dataentry_settings where username='#session.username#'
	</cfquery>
	<cfreturn d>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="show_calendars" access="remote">
	<cfargument name="onoff" required="yes">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_dataentry_settings set show_calendars=#onoff# where username='#session.username#'
	</cfquery>
	<cfreturn />
</cffunction>

<!----------------------------------------------------------------------------------------->
<cffunction name="set_sort_order" access="remote">
	<cfargument name="sort_leftcolumn" required="yes">
	<cfargument name="sort_rightcolumn" required="yes">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_dataentry_settings set sort_leftcolumn='#sort_leftcolumn#',sort_rightcolumn='#sort_rightcolumn#'  where username='#session.username#'
	</cfquery>
	<cfreturn />
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="get_sort_order" access="remote">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select sort_leftcolumn,sort_rightcolumn from cf_dataentry_settings where username='#session.username#'
	</cfquery>
	<cfreturn d>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="updateMySettings" access="remote">
	<cfargument name="element" required="yes">
	<cfargument name="value" required="yes">
	<cfif value is true>
		<cfset thisValue=1>
	<cfelse>
		<cfset thisValue=0>
	</cfif>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		update cf_dataentry_settings set #element# = #thisValue# where username='#session.username#'
	</cfquery>
	<cfreturn 1>
</cffunction>


<!----------------------------------------------------------------------------------------->

<cffunction name="getPrefs" access="remote">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select * from cf_dataentry_settings where username='#session.username#'
	</cfquery>
	<cfreturn d>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="saveEdits" access="remote">
	<cfargument name="q" required="yes">
	<cfoutput>
		<cfquery name="getCols" datasource="uam_god" cachedwithin="#createtimespan(0,0,60,0)#">
			select column_name from sys.user_tab_cols
			where table_name='BULKLOADER'
			and column_name not like '%$%'
			order by internal_column_id
		</cfquery>
		<cfloop list="#q#" index="kv" delimiters="&">
			<cfset k=listfirst(kv,"=")>
			<cfset v=replace(kv,k & "=",'')>
			<cfset "variables.#k#"=urldecode(v)>
		</cfloop>
		<cfset sql = "UPDATE bulkloader SET ">
		<cfloop query="getCols">
			<cfif isDefined("variables.#column_name#")>
				<cfif column_name is not "collection_object_id">
					<cfset thisData = evaluate("variables." & column_name)>
					<cfset thisData = replace(thisData,"'","''","all")>
					<cfset sql = "#SQL#,#COLUMN_NAME# = '#thisData#'">
				</cfif>
			</cfif>
		</cfloop>
		<cfset sql = "#SQL# where collection_object_id = #collection_object_id#">
		<cfset sql = replace(sql,"UPDATE bulkloader SET ,","UPDATE bulkloader SET ")>
		<cftry>
			<cftransaction>
				<cfquery name="new" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					#preservesinglequotes(sql)#
				</cfquery>
				<cfquery name="result" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					select #collection_object_id# collection_object_id, bulk_check_one(#collection_object_id#) rslt from dual
				</cfquery>
			</cftransaction>
		<cfcatch>
			<cfset result = querynew("COLLECTION_OBJECT_ID,RSLT")>
			<cfset temp = queryaddrow(result,1)>
			<cfset temp = QuerySetCell(result, "collection_object_id", collection_object_id, 1)>
			<cfset temp = QuerySetCell(result, "rslt",  cfcatch.message & "; " &  cfcatch.detail, 1)>
		</cfcatch>
		</cftry>
		<cfset x=SerializeJSON(result, true)>
		<cfreturn x>
	</cfoutput>
</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="saveNewRecord" access="remote" returnformat="json" queryformat="column">
	<cfargument name="q" required="yes">
	<cfoutput>
		<cfquery name="getCols" datasource="uam_god">
			select column_name from sys.user_tab_cols
			where table_name='BULKLOADER'
			and column_name not like '%$%'
			order by internal_column_id
		</cfquery>
		<cfloop list="#q#" index="kv" delimiters="&">
			<cfset k=listfirst(kv,"=")>
			<cfset v=replace(kv,k & "=",'')>
			<cfset "variables.#k#"=urldecode(v)>
		</cfloop>
		<cfset sql = "INSERT INTO bulkloader (">
		<cfset flds = "">
		<cfset data = "">
		<cfloop query="getCols">
			<cfif isDefined("variables.#column_name#")>
				<cfif column_name is not "collection_object_id">
					<cfset flds = "#flds#,#column_name#">
					<cfset thisData = evaluate("variables." & column_name)>
					<cfset thisData = replace(thisData,"'","''","all")>
					<cfset data = "#data#,'#thisData#'">
				</cfif>
			</cfif>
		</cfloop>
		<cfset flds = trim(flds)>
		<cfset flds=right(flds,len(flds)-1)>
		<cfset data = trim(data)>
		<cfset data=right(data,len(data)-1)>
		<cfset flds = "collection_object_id,#flds#">
		<cfset data = "bulkloader_PKEY.nextval,#data#">
		<cfset sql = "insert into bulkloader (#flds#) values (#data#)">
		<cftry>
			<cftransaction>
				<cfquery name="new" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					#preservesinglequotes(sql)#
				</cfquery>
				<cfquery name="tVal" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					select bulkloader_PKEY.currval as currval from dual
				</cfquery>
				<cfquery name="result" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					select bulkloader_PKEY.currval collection_object_id, bulk_check_one(bulkloader_PKEY.currval) rslt from dual
				</cfquery>
			</cftransaction>
		<cfcatch>
			<cfset result = querynew("COLLECTION_OBJECT_ID,RSLT")>
			<cfset temp = queryaddrow(result,1)>
			<cfset temp = QuerySetCell(result, "COLLECTION_OBJECT_ID", collection_object_id, 1)>
			<cfset temp = QuerySetCell(result, "rslt",  cfcatch.message & "; " &  cfcatch.detail & "; " &  cfcatch.sql, 1)>
		</cfcatch>
		</cftry>
		<cfreturn result>
	</cfoutput>
</cffunction>

	<!----------------------------------------------------------------------------------------->
	<cffunction name="getStagePage" access="remote">
		<cfargument name="page" required="yes">
	    <cfargument name="pageSize" required="yes">
		<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
		<cfset startrow=page * pageSize>
		<cfset stoprow=startrow + pageSize>
		<cfif len(gridsortcolumn) is 0>
			<cfset gridsortcolumn="collection_object_id">
		</cfif>
	<cfoutput>
		<cfset sql="select * from bulkloader_stage where 1=1">
		<cfset sql=sql & " order by #gridsortcolumn# #gridsortdirection#">
		<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			#preservesinglequotes(sql)#
		</cfquery>
	</cfoutput>
		      <cfreturn queryconvertforgrid(data,page,pagesize)/>
	</cffunction>
<!----------------------------------------------------------------------------------------->
<cffunction name="getPage" access="remote">
	<cfargument name="page" required="yes">
    <cfargument name="pageSize" required="yes">
	<cfargument name="gridsortcolumn" required="yes">
    <cfargument name="gridsortdirection" required="yes">
	<cfargument name="accn" required="yes">
	<cfargument name="enteredby" required="yes">
	<cfargument name="colln" required="yes">
	<cfset startrow=page * pageSize>
	<cfset stoprow=startrow + pageSize>
	<cfif len(gridsortcolumn) is 0>
		<cfset gridsortcolumn="collection_object_id">
	</cfif>
<cfoutput>
	<cfset sql="select * from bulkloader where collection_object_id > 500 ">
	<cfif len(accn) gt 0>
		<cfset sql=sql & " and accn IN (#accn#)">
	</cfif>
	<cfif len(enteredby) gt 0>
		<cfset sql=sql & " and enteredby IN (#enteredby#)">
	</cfif>
	<cfif len(colln) gt 0>
		<cfset sql = "#sql# AND institution_acronym || ':' || collection_cde IN (#colln#)">
	</cfif>
	<cfset sql=sql & " order by #gridsortcolumn# #gridsortdirection#">

	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		#preservesinglequotes(sql)#
	</cfquery>
</cfoutput>
	      <cfreturn queryconvertforgrid(data,page,pagesize)/>
</cffunction>
<!--------------------------------------->
<cffunction name="editRecord" access="remote">
	<cfargument name="cfgridaction" required="yes">
    <cfargument name="cfgridrow" required="yes">
	<cfargument name="cfgridchanged" required="yes">
	<cfoutput>
		<cfset colname = StructKeyList(cfgridchanged)>
		<cfset value = cfgridchanged[colname]>
		<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			update bulkloader set  #colname# = '#value#'
			where collection_object_id=#cfgridrow.collection_object_id#
		</cfquery>
	</cfoutput>
</cffunction>

	<!--------------------------------------->
	<cffunction name="editStageRecord" access="remote">
		<cfargument name="cfgridaction" required="yes">
	    <cfargument name="cfgridrow" required="yes">
		<cfargument name="cfgridchanged" required="yes">
		<cfoutput>
			<cfset colname = StructKeyList(cfgridchanged)>
			<cfset value = cfgridchanged[colname]>
			<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				update bulkloader_stage set  #colname# = '#value#'
				where collection_object_id=#cfgridrow.collection_object_id#
			</cfquery>
		</cfoutput>
	</cffunction>
</cfcomponent>