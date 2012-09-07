<cfinclude template="/includes/alwaysInclude.cfm">
<cfset fn="arctos_#randRange(1,1000)#">
<cfset variables.localXmlFile="#Application.webDirectory#/bnhmMaps/tabfiles/#fn#.xml">
<cfset variables.localTabFile="#Application.webDirectory#/bnhmMaps/tabfiles/#fn#.txt">
<cfset variables.remoteXmlFile="#Application.serverRootUrl#/bnhmMaps/tabfiles/#fn#.xml">
<cfset variables.remoteTabFile="#Application.serverRootUrl#/bnhmMaps/tabfiles/#fn#.txt">
<cfset variables.encoding="UTF-8">
<div align="center" id="status">
	<span style="background-color:green;color:white; font-size:36px; font-weight:bold;">
		Fetching map data...
	</span>
</div>
<cfflush>
<cfif isdefined("session.roles") and listfindnocase(session.roles,"coldfusion_user")>
	<cfset flatTableName = "flat">
<cfelse>
	<cfset flatTableName = "filtered_flat">
</cfif>
<cfset mediaFlatTableName = "media_flat">
<!----------------------------------------------------------------->
<cfif isdefined("action") and action IS "mapPoint">
	<cfthrow detail="block not found" errorcode="9945" message="A block of code (action,mapPoint) was not found in the bnhmMapData template">
<cfelseif isdefined("search") and search IS "MediaSearch">
	<cfthrow detail="block not found" errorcode="9945" message="A block of code (search,MediaSearch) was not found in the bnhmMapData template">
<cfelse>
	<!--- regular mapping routine ---->
	<cfif isdefined("collection_object_id") and len(collection_object_id) gt 0>
		<cfset ShowObservations = "true">
	</cfif>
	<cfset basSelect = "SELECT DISTINCT 
		#flatTableName#.collection,
			#flatTableName#.guid,
		#flatTableName#.collection_id,
		#flatTableName#.cat_num,
		#flatTableName#.scientific_name,
		collecting_event.verbatim_date,
		specimen_event.specimen_event_type,
		locality.spec_locality,
		locality.dec_lat,
		locality.dec_long,
		to_meters(locality.max_error_distance,locality.max_error_units) COORDINATEUNCERTAINTYINMETERS,
		locality.datum,
		#flatTableName#.collection_object_id,
		#flatTableName#.collectors">
	<cfset basFrom = "	FROM #flatTableName#">
	<!----
	<cfset basJoin = " INNER JOIN cataloged_item ON (#flatTableName#.collection_object_id =cataloged_item.collection_object_id)
		INNER JOIN collecting_event flatCollEvent ON (#flatTableName#.collecting_event_id = flatCollEvent.collecting_event_id)">	
	<cfset basWhere = " WHERE 
		dec_lat is not null AND
		dec_long is not null AND
		flatCollEvent.collecting_source = 'wild caught' ">
	---->	
	<cfset basJoin = " INNER JOIN specimen_event ON (#flatTableName#.collection_object_id =specimen_event.collection_object_id)
			INNER JOIN collecting_event ON (specimen_event.collecting_event_id =collecting_event.collecting_event_id)
			INNER JOIN locality ON (collecting_event.locality_id =locality.locality_id)
				">
	<cfset basWhere = " WHERE 
		locality.dec_lat is not null ">		
	<cfset basQual = "">
	<cfif not isdefined("basJoin")>
		<cfset basJoin = "">
	</cfif>
	<cfinclude template="/includes/SearchSql.cfm">
	<cfset SqlString = "#basSelect# #basFrom# #basJoin# #basWhere# #basQual#">	
	<cfquery name="getMapData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		#preserveSingleQuotes(SqlString)#
	</cfquery>
</cfif><!--- end point map option --->
<cfif getMapData.recordcount is 0>
	<div class="error">
		Oops! We didn't find anything mappable.
		File a <a href='/info/bugs.cfm'>bug report</a> if you think this message is in error.
	</div>
	<cfabort>
</cfif>
<!---- write an XML config file specific to the critters they're mapping --->
<cfoutput>
	<cfquery name="collID" dbtype="query">
		select collection_id from getMapData group by collection_id
	</cfquery>
	<cfset thisAddress = #Application.DataProblemReportEmail#>
	<cfif len(valuelist(collID.collection_id)) gt 0>
		<cfquery name="whatEmails" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select address from
				electronic_address,
				collection_contacts
			WHERE
				electronic_address.agent_id = collection_contacts.contact_agent_id AND
				collection_contacts.collection_id IN (#valuelist(collID.collection_id)#) AND
				address_type='e-mail' AND
				contact_role='data quality'
			GROUP BY address
		</cfquery>
		<cfloop query="whatEmails">
			<cfset thisAddress = listappend(thisAddress,address)>
		</cfloop>
	</cfif>	
	
	
	
	
    <logos>
        <logo img="http://arctos.database.museum/images/genericHeaderIcon.gif" url="http://arctos.database.museum/"/>
        <logo img="http://amphibiaweb.org/images/redlist_logo.jpg" url="http://www.iucnredlist.org/initiatives/mammals"/>
    </logos>
</berkeleymapper>
	<cfscript>
		variables.joFileWriter = createObject('Component', '/component.FileWriter').init(variables.localXmlFile, variables.encoding, 32768);
		a='<berkeleymapper>' & chr(10) & 
			chr(9) & '<colors method="dynamicfield" fieldname="darwin:collectioncode" label="Collection"></colors>' & chr(10) & 
			chr(9) & '<concepts>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="darwin:relatedinformation" alias="Related Information"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="darwin:scientificname" alias="Scientific Name"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept order="3" viewlist="1" datatype="char120:2" alias="Event Type"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="char120:3" alias="Verbatim Date"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="darwin:locality" alias="Specific Locality"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="0" datatype="darwin:decimallatitude" alias="Decimal Latitude"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="0" datatype="darwin:decimallongitude" alias="Decimal Longitude"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="darwin:coordinateuncertaintyinmeters" alias="Error (m)"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="1" datatype="darwin:horizontaldatum" alias="Datum"/>' & chr(10) & 
			chr(9) & chr(9) & '<concept viewlist="0" datatype="darwin:collectioncode" alias="Collection Code"/>' & chr(10) & 
			chr(9) & '</concepts>' & chr(10); 
		variables.joFileWriter.writeLine(a);
	</cfscript>


	<cfif isdefined("showRangeMaps") and showRangeMaps is true>
		<cfquery name="species" dbtype="query">
			select distinct(scientific_name) scientific_name from getMapData
		</cfquery>
		<cfquery name="getClass" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
			select phylclass,genus,species,genus || ' ' || species scientific_name from taxonomy where scientific_name in
			 (#ListQualify(valuelist(species.scientific_name), "'")#)
			 group by 
			 phylclass,genus || ' ' || species,genus,species
		</cfquery>
		<cfif getClass.recordcount is not 1 or (
				getClass.phylclass is not 'Amphibia' and getClass.phylclass is not 'Mammalia' and getClass.phylclass is not 'Aves'
			)>
			<div class="error">
				Rangemaps are only available for queries which return one species in Classes
				Amphibia, Aves or Mammalia.
				<br>Subspecies are ignored for rangemapping.
				<br>You may use the BerkeleyMapper or Google Maps options for any query.
				<br>Please use your browser's back button or close this window.
			</div>
			<script>
				document.getElementById('status').style.display='none';
			</script>
			<cfabort>
		</cfif>
		
		<cfscript>
			a=chr(9) & '<gisdata>' & chr(10) & 
			chr(9) & chr(9) & '<layer title="#getClass.genus# #getClass.species#" name="mamm" location="#getClass.genus# #getClass.species#" legend="1" active="1" url="">' & chr(10);
			variables.joFileWriter.writeLine(a);
		</cfscript>
		<cfset i=1>
		<cfif getClass.phylclass is 'Amphibia'>
			<cfscript>
				a=chr(9) & chr(9) & chr(9) & '<![CDATA[http://berkeleymapper.berkeley.edu/v2/speciesrange/#getClass.genus#+#getClass.species#/binomial/gaa_2011]]>' & chr(10);
				variables.joFileWriter.writeLine(a);
			</cfscript>
		<cfelseif getClass.phylclass is 'Mammalia'>
			<cfscript>
				a=chr(9) & chr(9) & chr(9) & '<![CDATA[http://berkeleymapper.berkeley.edu/v2/speciesrange/#getClass.genus#+#getClass.species#/sci_name/mamm_2009]]>' & chr(10);
				variables.joFileWriter.writeLine(a);
			</cfscript>
		<cfelseif getClass.phylclass is 'Aves'>
			<cfscript>
				a=chr(9) & chr(9) & chr(9) & '<![CDATA[http://berkeleymapper.berkeley.edu/v2/speciesrange/#getClass.genus#+#getClass.species#/sci_name/birds_2009]]>' & chr(10);
				variables.joFileWriter.writeLine(a);
			</cfscript>
		</cfif>
		<cfscript>
			a = chr(9) & chr(9) & '</layer>' & chr(10) & 
			chr(9) & '</gisdata>' & chr(10);
			variables.joFileWriter.writeLine(a);
		</cfscript>
	</cfif>
	<cfscript>
		a = chr(9) & '<logos>' & chr(10) & 
			chr(9) & chr(9) & '<logo img="http://arctos.database.museum/images/genericHeaderIcon.gif" url="http://arctos.database.museum/"/>' & chr(10) & 
			chr(9) & '</logos>' & chr(10) &
			'</berkeleymapper>';
		variables.joFileWriter.writeLine(a);
		variables.joFileWriter.close();
		variables.joFileWriter = createObject('Component', '/component.FileWriter').init(variables.localTabFile, variables.encoding, 32768);
	</cfscript>	
	<cfloop query="getMapData">
		<cfscript>
			a='<a href="#Application.serverRootUrl#/guid/#guid#" target="_blank">' & guid & '</a>' & 
				chr(9) & scientific_name &
				chr(9) & specimen_event_type &
				chr(9) & verbatim_date & 
				chr(9) & spec_locality & 
				chr(9) & dec_lat & 
				chr(9) & dec_long &
				chr(9) & COORDINATEUNCERTAINTYINMETERS &
				chr(9) & datum &
				chr(9) & collection;
			variables.joFileWriter.writeLine(a);
		</cfscript>
	</cfloop>
	<cfscript>		
		variables.joFileWriter.close();
	</cfscript>
	<cfquery name="distColl" dbtype="query">
		select collection from getMapData group by collection
		order by collection
	</cfquery>
	<cfset collList=''>
	<cfloop query="distColl">
		<cfif len(collList) is 0>
			<cfset collList="#collection#">
		<cfelse>
			<cfset CollList="#collList#, #collection#">
		</cfif>
	</cfloop>
	<cfset listColl=reverse(CollList)>
	<cfset listColl=replace(listColl,",","dna ,","first")>
	<cfset CollList=reverse(listColl)>
	<cfset CollList="#CollList# data.">
	<cfset bnhmUrl="http://berkeleymapper.berkeley.edu/?ViewResults=tab&tabfile=#variables.remoteTabFile#&configfile=#variables.remoteXmlFile#&sourcename=#collList#&queryerrorcircles=1&maxerrorinmeters=1">
	#bnhmUrl#
	<!----
	<script type="text/javascript" language="javascript">
		document.location='#bnhmUrl#';
	</script>
	---->
	 <noscript>BerkeleyMapper reqiures JavaScript.</noscript> 
</cfoutput>
