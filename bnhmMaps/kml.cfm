<cfset table_name=session.SpecSrchTab>
<cfset internalPath="#Application.webDirectory#/bnhmMaps/tabfiles/">
<cfset externalPath="#Application.ServerRootUrl#/bnhmMaps/tabfiles/">
<cfif not isdefined("method")>
	<cfset method="download">
</cfif>
<cfif not isdefined("showErrors")>
	<cfset showErrors=0>
</cfif>
<cfif not isdefined("mapByLocality")>
	<cfset mapByLocality=0>
</cfif>
<cfif not isdefined("showUnccepted")>
	<cfset showUnccepted=0>
</cfif>
<cfif not isdefined("userFileName")>
	<cfset userFileName="kmlfile#cfid##cftoken#">
</cfif>
<cfif not isdefined("action")>
	<cfset action="nothing">
</cfif>
<cfif isdefined("session.roles") and listfindnocase(session.roles,"coldfusion_user")>
	<cfset flatTableName = "flat">
<cfelse>
	<cfset flatTableName = "filtered_flat">
</cfif>
<!--- handle direct calls --->
<cfif isdefined("newReq")>
	<cfoutput>
		<cfset basSelect = " SELECT distinct #flatTableName#.collection_object_id">
		<cfquery name="reqd" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select * from cf_spec_res_cols where category='required'
		</cfquery>
		<cfset basSelect = listappend(basSelect,valuelist(reqd.SQL_ELEMENT))>
		<cfset basFrom = " FROM #flatTableName#">
		<cfset basJoin = "INNER JOIN cataloged_item ON (#flatTableName#.collection_object_id =cataloged_item.collection_object_id)">
		<cfset basWhere = " WHERE #flatTableName#.collection_object_id IS NOT NULL ">	
		<cfset basQual = "">
		<cfset mapurl="">
		<cfinclude template="/includes/SearchSql.cfm">
		<cfset SqlString = "#basSelect# #basFrom# #basJoin# #basWhere# #basQual#">
		<cfset sqlstring = replace(sqlstring,"flatTableName","#flatTableName#","all")>
		<cfset srchTerms="">
		<cfloop list="#mapurl#" delimiters="&" index="t">
			<cfset tt=listgetat(t,1,"=")>
			<cfset srchTerms=listappend(srchTerms,tt)>
		</cfloop>
		<cfif listcontains(srchTerms,"ShowObservations")>
			<cfset srchTerms=listdeleteat(srchTerms,listfindnocase(srchTerms,'ShowObservations'))>
		</cfif>
		<cfif listcontains(srchTerms,"collection_id")>
			<cfset srchTerms=listdeleteat(srchTerms,listfindnocase(srchTerms,'collection_id'))>
		</cfif>
		<cfif len(srchTerms) is 0>
			<CFSETTING ENABLECFOUTPUTONLY=0>			
			<font color="##FF0000" size="+2">You must enter some search criteria!</font>	  
			<cfabort>
		</cfif>
		<cfset thisTableName = "SearchResults_#cfid#_#cftoken#">	
		<cftry>
			<cfquery name="die" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				drop table #session.SpecSrchTab#
			</cfquery>
			<cfcatch>
				<!--- not there, so what? --->
			</cfcatch>
		</cftry>
		<cfset checkSql(SqlString)>	
		<cfset SqlString = "create table #session.SpecSrchTab# AS #SqlString#">
		<cfquery name="buildIt" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			#preserveSingleQuotes(SqlString)#
		</cfquery>
		
		<cfset burl="kml.cfm?method=#method#&showErrors=#showErrors#&mapByLocality=#mapByLocality#">
		<cfset burl=burl & "&showUnccepted=#showUnccepted#&userFileName=#userFileName#&action=#action#">	
		<cflocation url="#burl#" addtoken="false">
	</cfoutput>
</cfif>
<!------------------------------------------------------------------------------------------>
<cfif isdefined("action") and #action# is "getFile">
	<cfoutput>
		<cfheader name="Content-Disposition" value="attachment; filename=#f#">
		<cfcontent type="application/vnd.google-earth.kml+xml" file="#internalPath##f#">
	</cfoutput>	
</cfif>
<!----------------------------------------------------------------->
<cfinclude  template="/includes/_header.cfm"> 
<cffunction name="kmlCircle" access="public" returntype="string" output="false">
     <cfargument
	     name="centerlat_form"
	     type="numeric"
	     required="true"/>
	<cfargument
	     name="centerlong_form"
	     type="numeric"
	     required="true"/>
	<cfargument
	     name="radius_form"
	     type="numeric"
	     required="true"/>
	<cfset retn = "
	<Placemark>
	<name>Error</name><visibility>1</visibility>
	<styleUrl>##error-line</styleUrl>
	<LineString>
	<coordinates>">
	<cfset lat = DegToRad(centerlat_form)>
	<cfset long = DegToRad(centerlong_form)>
	<cfset d = radius_form>
	<cfset d_rad=d/6378137>
	<cfloop from="0" to="360" index="i">
		<cfset radial = DegToRad(i)>
		<cfset lat_rad = asin(sin(lat)*cos(d_rad) + cos(lat)*sin(d_rad)*cos(radial))>
		<cfset dlon_rad = atan2(sin(radial)*sin(d_rad)*cos(lat),cos(d_rad)-sin(lat)*sin(lat_rad))>
		<cfset p=pi()>
		<cfset x=(long+dlon_rad + p)>
		<cfset y=(2*p)>
		<cfset lon_rad = ProperMod((long+dlon_rad + p), 2*p) - p>
		<cfset rLong = RadToDeg(lon_rad)>
		<cfset rLat = RadToDeg(lat_rad)>
		<cfset retn = '#retn# #rLong#,#rLat#,0'>	
	</cfloop>
	<cfset retn = '#retn#</coordinates></LineString></Placemark>'>	
	<cfreturn retn>
</cffunction>
<!------------------------------------------------------------->
<cfif #action# is "nothing">
<cfoutput>
	NOTE: Horizontal Datum is NOT transformed correctly. Positions will be misplaced for all non-WGS84 datum points.
	<form name="prefs" id="prefs" method="post" action="kml.cfm">
		<table>
			<tr>
				<td align="right">Show Error Circles? (Makes big filesizes)</td>
				<td>
					<input type="checkbox" 
						<cfif showErrors is 1> checked="checked"</cfif>
						name="showErrors" id="showErrors" value="1">
				</td>
			</tr>
			<tr>
				<td align="right">Show all specimens at each locality represented by query?</td>
				<td>
					<input type="checkbox" 
						<cfif mapByLocality is 1> checked="checked"</cfif>
						name="mapByLocality" id="mapByLocality" value="1">
				</td>
			</tr>
			<tr>
				<td align="right">Show unaccepted coordinate determinations?</td>
				<td>
					<input type="checkbox" 
						<cfif showUnccepted is 1> checked="checked"</cfif>
						name="showUnccepted" id="showUnccepted" value="1"></td>
			</tr>
			<tr>
				<td align="right">File Name</td>
				<td><input type="text" name="userFileName" id="userFileName" size="40" value="#userFileName#"></td>
			</tr>
			<tr>
				<td align="right">Method</td>
				<td>
					<select name="method" id="method">
						<option <cfif method is "download"> selected="selected"</cfif> value="download">Download KML</option>
						<option <cfif method is "link"> selected="selected"</cfif> value="link">Download linkfile</option>
						<option <cfif method is "gmap"> selected="selected"</cfif> value="gmap">Google Maps</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">Color by</td>
				<td>
					<select name="action" id="action">
						<option <cfif action is "colorByCollection"> selected="selected"</cfif> value="colorByCollection">Collection</option>
						<option <cfif action is "colorBySpecies"> selected="selected"</cfif> value="colorBySpecies">Species</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="Go" class="lnkBtn"
   						onmouseover="this.className='lnkBtn btnhov'" onmouseout="this.className='lnkBtn'">
				</td>
			</tr>
		</table>		
    </form>
</cfoutput>
</cfif>






























<!-------------------------------------------------------------------------->
<cfif #action# is "colorBySpecies">
<cfoutput>
    
	<cfif isdefined("userFileName") and len(#userFileName#) gt 0>
		<cfset dlFile = "#userFileName#.kml">
	<cfelse>
		<cfset dlFile = "kmlfile#cfid##cftoken#.kml">
	</cfif>
    <cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select 
			#flatTableName#.collection_object_id,
			#flatTableName#.cat_num,
			to_char(#flatTableName#.began_date,'yyyy-mm-dd') began_date,
			to_char(#flatTableName#.ended_date,'yyyy-mm-dd') ended_date,
			lat_long.dec_lat,
			lat_long.dec_long,
			round(to_meters(lat_long.max_error_distance,lat_long.max_error_units)) errorInMeters,
			lat_long.datum,
			#flatTableName#.scientific_name,
			#flatTableName#.collection,
			#flatTableName#.spec_locality,
			#flatTableName#.locality_id,
			#flatTableName#.verbatimLatitude,
			#flatTableName#.verbatimLongitude,
			lat_long.lat_long_id
		 from 
		 	#flatTableName#,
		 	lat_long,
		 	#table_name#
		 where
		 	#flatTableName#.locality_id = lat_long.locality_id and
		 	lat_long.accepted_lat_long_fg = 1 AND
		 	lat_long.dec_lat is not null and 
		 	lat_long.dec_long is not null and
		 	#flatTableName#.collection_object_id = #table_name#.collection_object_id
		</cfquery>
        <cfquery name="species" dbtype="query">
            select scientific_name from data group by scientific_name
        </cfquery>
        <cfset kml='<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.2"><Document><name>Localities</name>
	        <open>1</open>'>
        <cfloop query="species">
            <cfset thisName=replace(scientific_name," ","_","all")>
            <cfset thisColor=randomHexColor()> 
             <cfset kml='#kml#
                 <Style id="icon_#thisName#">
			      <IconStyle>
			          <color>ff#thisColor#</color>
			         <scale>1.1</scale>
			         <Icon>
			            <href>#application.serverRootUrl#/images/whiteBalloon.png</href>
			         </Icon>
			      </IconStyle>
			   </Style>
            '>
        </cfloop>
        <cffile action="write" file="#internalPath##dlFile#" addnewline="no" output="#kml#" nameconflict="overwrite">
	    <cfloop query="species">
			<cfset thisName=replace(scientific_name," ","_","all")>
		    <cfset kml = "<Folder><name>#thisName#</name><visibility>1</visibility>">
		    
            <cfquery name="loc" dbtype="query">
				select 
					dec_lat,
					dec_long,
					errorInMeters,
					datum,
					spec_locality,
					locality_id,
					verbatimLatitude,
					verbatimLongitude,
					lat_long_id,
					began_date,
					ended_date,
	                collection_object_id,
					cat_num,
					scientific_name,
					collection
				from
					data
				where
					scientific_name='#scientific_name#'
				group by
					dec_lat,
					dec_long,
					errorInMeters,
					datum,
					spec_locality,
					locality_id,
					verbatimLatitude,
					verbatimLongitude,
					lat_long_id,
					began_date,
					ended_date,
	                collection_object_id,
					cat_num,
					scientific_name,
					collection
			</cfquery>
            <cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
		    <cfloop query="loc">
			    <cfset kml='<Placemark><name>#collection# #cat_num# (#scientific_name#)</name>
			        <visibility>1</visibility>
                    <styleUrl>##icon_#thisName#</styleUrl><description>
			        <Timespan><begin>#began_date#</begin><end>#ended_date#</end></Timespan>
			        <![CDATA[Datum: #datum#<br/>
			        Error: #errorInMeters# m<br/>
                '>
			    <cfset kml='#kml#]]></description>
			        <Point>
	      	            <coordinates>#dec_long#,#dec_lat#,0</coordinates>
	    	        </Point>
                '>
	    	    <cfset kml='#kml#</Placemark>'>
	  		    <cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
             </cfloop>

		        
            <cfset kml='</Folder>'><!--- close specimens folder --->
            <cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
              </cfloop>
             <cfset kml='</Document></kml>'>
			<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
            
			<cfset linkFile = "link_#dlFile#">
			<cfset kml='<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0">
				<NetworkLink>
				  <name>Arctos Locations</name>
				  <visibility>1</visibility>
				  <open>1</open>
					<Url>
			    <href>#externalPath##dlFile#</href>
			    </Url>
			    </NetworkLink>
			    </kml>
            '>
			<cffile action="write" file="#internalPath##linkFile#" addnewline="no" output="#kml#" nameconflict="overwrite">
		<cfif method is "link">
			<cfset durl="kml.cfm?action=getFile&p=#URLEncodedFormat("/bnmhMaps/")#&f=#URLEncodedFormat(linkFile)#">
			<cflocation url="#durl#" addtoken="false">
		<cfelseif method is "gmap">
			<cfset durl="http://maps.google.com/maps?q=#externalPath##dlFile#?r=#randRange(1,10000)#">
			<script type="text/javascript" language="javascript">
				window.open('#durl#',"_blank")
			</script>
		<cfelse>	
			<cfset durl="kml.cfm?action=getFile&p=#URLEncodedFormat("/bnmhMaps/")#&f=#URLEncodedFormat(dlFile)#">
			<cflocation url="#durl#" addtoken="false">
		</cfif>
		
	</cfoutput>
</cfif>




























<!-------------------------------------------------------------------------->
<cfif #action# is "colorByCollection">
<cfoutput>
	<cfif isdefined("userFileName") and len(#userFileName#) gt 0>
		<cfset dlFile = "#userFileName#.kml">
	<cfelse>
		<cfset dlFile = "kmlfile#cfid##cftoken#.kml">
	</cfif>	
	<cfif isdefined("mapByLocality") and #mapByLocality# is 1>
		<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select 
				#flatTableName#.collection_object_id,
				#flatTableName#.cat_num,
				to_char(#flatTableName#.began_date,'yyyy-mm-dd') began_date,
				to_char(#flatTableName#.ended_date,'yyyy-mm-dd') ended_date,
				lat_long.dec_lat,
				lat_long.dec_long,
				decode(lat_long.accepted_lat_long_fg,
					1,'yes',
					0,'no') isAcceptedLatLong,
				round(to_meters(lat_long.max_error_distance,lat_long.max_error_units)) errorInMeters,
				lat_long.datum,
				#flatTableName#.scientific_name,
				#flatTableName#.collection,
				#flatTableName#.spec_locality,
				#flatTableName#.locality_id,
				#flatTableName#.verbatimLatitude,
				#flatTableName#.verbatimLongitude,
				lat_long.lat_long_id
			 from 
			 	#flatTableName#,
			 	lat_long
			 where
			 	#flatTableName#.locality_id = lat_long.locality_id and
			 	<cfif showUnccepted is 0>
			 		lat_long.accepted_lat_long_fg = 1 AND
			 	</cfif>
			 	lat_long.dec_lat is not null and lat_long.dec_long is not null and
			 	#flatTableName#.locality_id IN (
			 		select #flatTableName#.locality_id from #table_name#,#flatTableName#
			 		where #flatTableName#.collection_object_id = #table_name#.collection_object_id)
		</cfquery>
	<cfelse>
		<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select 
				#flatTableName#.collection_object_id,
				#flatTableName#.cat_num,
				to_char(#flatTableName#.began_date,'yyyy-mm-dd') began_date,
				to_char(#flatTableName#.ended_date,'yyyy-mm-dd') ended_date,
				lat_long.dec_lat,
				lat_long.dec_long,
				decode(lat_long.accepted_lat_long_fg,
					1,'yes',
					0,'no') isAcceptedLatLong,
				round(to_meters(lat_long.max_error_distance,lat_long.max_error_units)) errorInMeters,
				lat_long.datum,
				#flatTableName#.scientific_name,
				#flatTableName#.collection,
				#flatTableName#.spec_locality,
				#flatTableName#.locality_id,
				#flatTableName#.verbatimLatitude,
				#flatTableName#.verbatimLongitude,
				lat_long.lat_long_id
			 from 
			 	#flatTableName#,
			 	lat_long,
			 	#table_name#
			 where
			 	#flatTableName#.locality_id = lat_long.locality_id and
			 	<cfif showUnccepted is 0>
			 		lat_long.accepted_lat_long_fg = 1 AND
			 	</cfif>
			 	lat_long.dec_lat is not null and 
			 	lat_long.dec_long is not null and
			 	#flatTableName#.collection_object_id = #table_name#.collection_object_id
		</cfquery>
	</cfif>
	<cfset kml = '<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.2"><Document><name>Localities</name>
	<open>1</open>
	<Style id="green-star">
		<IconStyle>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/paddle/grn-stars.png</href>
			</Icon>
		</IconStyle>		
	</Style>
	<Style id="red-star">
      <IconStyle>
        <Icon>
          <href>http://maps.google.com/mapfiles/kml/paddle/red-stars.png</href>
        </Icon>
      </IconStyle>
    </Style>
	<Style id="error-line">
	<LineStyle>
      <color>ff0000ff</color>
      <width>1</width>
    </LineStyle>
    </Style>
	'>
			
			
	<cffile action="write" file="#internalPath##dlFile#" addnewline="no" output="#kml#" nameconflict="overwrite">
	<cfquery name="colln" dbtype="query">
		select collection from data group by collection
	</cfquery>
	<cfloop query="colln">
		<cfquery name="loc" dbtype="query">
			select 
				dec_lat,
				dec_long,
				isAcceptedLatLong,
				errorInMeters,
				datum,
				spec_locality,
				locality_id,
				verbatimLatitude,
				verbatimLongitude,
				lat_long_id,
				began_date,
				ended_date
			from
				data
			where
				collection='#collection#'
			group by
				dec_lat,
				dec_long,
				isAcceptedLatLong,
				errorInMeters,
				datum,
				spec_locality,
				locality_id,
				verbatimLatitude,
				verbatimLongitude,
				lat_long_id,
				began_date,
				ended_date
		</cfquery>
		<cfset kml = "<Folder><name>#collection#</name><visibility>1</visibility>">
		<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
		<cfloop query="loc">
			<cfquery name="sdet" dbtype="query">
				select 
					collection_object_id,
					cat_num,
					scientific_name,
					collection
				from
					data
				where
					locality_id = #locality_id#
				group by
					collection_object_id,
					cat_num,
					scientific_name,
					collection
			</cfquery>
			<cfset kml='<Placemark><name>#kmlStripper(spec_locality)# (#locality_id#)</name>
			<visibility>1</visibility><description>
			<Timespan><begin>#began_date#</begin><end>#ended_date#</end></Timespan>
			<![CDATA[Datum: #datum#<br/>
			Error: #errorInMeters# m<br/>'>
			<cfif isdefined("session.roles") and listfindnocase(session.roles,"coldfusion_user")>
				<cfset kml='#kml#<p><a href="#application.serverRootUrl#/editLocality.cfm?locality_id=#locality_id#">Edit Locality</a></p>'>
			</cfif>
			<cfloop query="sdet">
				<cfset kml='#kml#<a href="#application.serverRootUrl#/SpecimenDetail.cfm?collection_object_id=#collection_object_id#">
					#collection# #cat_num# (<em>#scientific_name#</em>)
				</a><br/>'>
			</cfloop>
			<cfset kml='#kml#]]></description>
			<Point>
	      	<coordinates>#dec_long#,#dec_lat#,0</coordinates>
	    	</Point>'>
	    	<cfif #isAcceptedLatLong# is "yes">
	    		<cfset kml='#kml#<styleUrl>##green-star</styleUrl>
					<Icon><href>http://maps.google.com/mapfiles/kml/paddle/grn-stars.png</href></Icon>'>
	    	<cfelse>
	    	<cfset kml='#kml#<styleUrl>##red-star</styleUrl>
				<Icon><href>http://maps.google.com/mapfiles/kml/paddle/red-stars.png</href></Icon>'>
	    	</cfif>
	    	<cfset kml='#kml#</Placemark>'>
	  		<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
		</cfloop>
		
		<cfset kml = "</Folder>"><!--- close collection folder --->
		<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
	</cfloop>
	
	<cfif isdefined("showErrors") and #showErrors# is 1><!---- turn off errors here --->
		<cfquery name="errors" dbtype="query">
			select errorInMeters,dec_lat,dec_long
			from data 
			where errorInMeters>0
			group by errorInMeters,dec_lat,dec_long
		</cfquery>
		<cfset kml="<Folder><name>Error Circles</name>"><!------made error circles folder--------->
		<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
		<cfloop query="errors">
			<cfset k = kmlCircle(#dec_lat#,#dec_long#,#errorInMeters#)>
			<cfset kml=" #k#">
			<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
		</cfloop>
		<cfset kml = "</Folder>"><!--- close error folder --->
		<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
	</cfif>
	
	
	<cfset kml='</Document></kml>'><!--- close specimens folder --->
			<cffile action="append" file="#internalPath##dlFile#" addnewline="yes" output="#kml#">
			
			<cfset linkFile = "link_#dlFile#">
			<cfset kml='<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0">
				<NetworkLink>
				  <name>Arctos Locations</name>
				  <visibility>1</visibility>
				  <open>1</open>
					<Url>
			    <href>#externalPath##dlFile#</href>
			    </Url>
			</NetworkLink>
			</kml>'>
			<cffile action="write" file="#internalPath##linkFile#" addnewline="no" output="#kml#" nameconflict="overwrite">
				<cfif method is "link">
			<cfset durl="kml.cfm?action=getFile&p=#URLEncodedFormat("/bnmhMaps/")#&f=#URLEncodedFormat(linkFile)#">
			<cflocation url="#durl#" addtoken="false">
		<cfelseif method is "gmap">
			<cfset durl="http://maps.google.com/maps?q=#externalPath##dlFile#?r=#randRange(1,10000)#">
			<script type="text/javascript" language="javascript">
				window.open('#durl#',"_blank")
			</script>
		<cfelse>	
			<cfset durl="kml.cfm?action=getFile&p=#URLEncodedFormat("/bnmhMaps/")#&f=#URLEncodedFormat(dlFile)#">
			<cflocation url="#durl#" addtoken="false">
		</cfif>
	</cfoutput>
	</cfif>