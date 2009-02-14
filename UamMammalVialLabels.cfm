<cfif not isdefined("collection_object_id")>
		<cfabort>
	</cfif>
	<cfquery name="ctAtt" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select distinct(attribute_type) from ctAttribute_type order by attribute_type
</cfquery>
<cfset attList = "">
<cfloop query="ctAtt">
	<cfif len(#attList#) is 0>
		<cfset attList = "#ctAtt.attribute_type#">
	<cfelse>
		<cfset attList = "#attList#,#ctAtt.attribute_type#">
	</cfif>
</cfloop>
<cfset seleAttributes = "">
<cfloop query="ctAtt">
			<cfset thisName = #ctAtt.attribute_type#>
			<cfset thisName = #replace(thisName," ","_","all")#>
			<cfset thisName = #replace(thisName,"-","_","all")#>
			<cfset thisName = #left(thisName,20)#>
			<cfif #thisName# is not "sex"><!--- already got it --->
				<cfset seleAttributes = "#seleAttributes# ,ConcatAttributeValue(cataloged_item.collection_object_id,'#ctAtt.attribute_type#') 
				as #thisName#">
			</cfif>
		</cfloop>
<cfset sql="
select
			cataloged_item.collection_object_id,
			cat_num,
			scientific_name,
			state_prov,
			country,
			quad,
			county,
			island,
			sea,
			feature,
			spec_locality,
			CASE orig_lat_long_units
				WHEN 'decimal degrees' THEN dec_lat || 'd'
				WHEN 'deg. min. sec.' THEN lat_deg || 'd ' || lat_min || 'm ' || lat_sec || 's ' || lat_dir
				WHEN 'degrees dec. minutes' THEN lat_deg || 'd ' || dec_lat_min || 'm ' || lat_dir
			END as VerbatimLatitude,
			CASE orig_lat_long_units
				WHEN 'decimal degrees' THEN dec_long || 'd'
				WHEN'degrees dec. minutes' THEN long_deg || 'd ' || dec_long_min || 'm ' || long_dir
				WHEN 'deg. min. sec.' THEN long_deg || 'd ' || long_min || 'm ' || long_sec || 's ' || long_dir
			END as VerbatimLongitude,
			concatColl(cataloged_item.collection_object_id) as collectors,
			ConcatAttributeValue(cataloged_item.collection_object_id,'sex') as sex,
			concatotherid(cataloged_item.collection_object_id) as other_ids,
			concatparts(cataloged_item.collection_object_id) as parts,
			verbatim_date,
			accn_num_prefix,
			accn_num,
			accn_num_suffix
			#seleAttributes#
		FROM
			cataloged_item
			INNER JOIN identification ON (cataloged_item.collection_object_id = identification.collection_object_id)
			INNER JOIN collecting_event ON (cataloged_item.collecting_event_id = collecting_event.collecting_event_id)
			INNER JOIN locality ON (collecting_event.locality_id = locality.locality_id)
			INNER JOIN geog_auth_rec ON (locality.geog_auth_rec_id = geog_auth_rec.geog_auth_rec_id)
			LEFT OUTER JOIN accepted_lat_long ON (locality.locality_id = accepted_lat_long.locality_id)
			LEFT OUTER JOIN accn ON (cataloged_item.accn_id=accn.transaction_id)			
		WHERE
			accepted_id_fg=1 AND cataloged_item.collection_object_id IN (#collection_object_id#)		
			">
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		#preservesinglequotes(sql)#
	</cfquery>

<cfoutput>
<!---

--->
<cfdocument 
	format="flashpaper"
	pagetype="letter"
	margintop="0"
	marginbottom="0"
	marginleft="0"
	marginright="0"
	orientation="portrait"
	fontembed="yes" >
	
<link rel="stylesheet" type="text/css" href="/includes/_cfdocstyle.css">
<cfset i=0>
<cfset t=0>

<cfset r=1>

<cfset rc = data.recordcount>

<cfset numRows = 10>
<cfset numCols = 5>
<cfset lPos = 0><!--- position from left --->
<cfset tPos = 0><!--- position from top --->
<cfset pageNum = 1><!--- position from top --->
<cfset width = 150>
<cfset height=88>
<cfset pageHeight=975>
<cfset bug="">
<cfset thisRow = 1>

 <cfloop query="data">
 	
	<cfset coordinates = "">
	<cfif len(#verbatimLatitude#) gt 0 AND len(#verbatimLongitude#) gt 0>
		<cfset coordinates = "#verbatimLatitude# / #verbatimLongitude#">
		<cfset coordinates = replace(coordinates,"d","&##176;","all")>
		<cfset coordinates = replace(coordinates,"m","'","all")>
		<cfset coordinates = replace(coordinates,"s","''","all")>
		<cfset coordinates = replace(coordinates," ","","all")>
	</cfif>
	<cfset geog = "">
		<cfif #state_prov# is "Alaska">
			<cfset geog = "USA: Alaska">
			<cfif len(#island#) gt 0>
				<cfset geog = "#geog#, #island#">
			</cfif>
			<cfif len(#sea#) gt 0>
				<cfif len(#quad#) is 0>
					<cfset geog = "#geog#, #sea#">
				</cfif>
			</cfif>
			<cfif len(#quad#) gt 0>
					<cfif not #geog# contains " Quad">
						<cfset geog = "#geog#, #quad# Quad">
					</cfif>
			</cfif>
			
			<cfif len(#feature#) gt 0>
				<cfset geog = "#geog#, #feature#">
			</cfif>
			<cfif len(#spec_locality#) gt 0>
				<cfset geog = "#geog#; #spec_locality#">
			</cfif>
		<cfelse>
		  	<cfif len(#country#) gt 0>
				<cfif #country# is "United States">
					<cfset geog = "USA: ">
				</cfif>
				<cfset geog = "#country#: ">
			</cfif>
			<cfif len(#sea#) gt 0>
				<cfset geog = "#geog#, #sea#">
			</cfif>
			<cfif len(#state_prov#) gt 0>
				<cfset geog = "#geog#, #state_prov#">
			</cfif>
			<cfif len(#island#) gt 0>
				<cfset geog = "#geog#, #island#">
			</cfif>
			<cfif len(#quad#) gt 0>
				<cfset geog = "#geog#, #quad# Quad">
			</cfif>
			<cfif len(#feature#) gt 0>
				<cfset geog = "#geog#, #feature#">
			</cfif>
			<cfif len(#spec_locality#) gt 0>
				<cfset geog = "#geog#; #spec_locality#">
			</cfif>
		</cfif>
		<cfset geog=replace(geog,": , ",": ","all")>
		<cfset sexcode = "">
		<cfif len(#trim(sex)#) gt 0>
			<cfif #trim(sex)# is "male">
				<cfset sexcode = "M">
			<cfelseif #trim(sex)# is "female">
				<cfset sexcode = "F">
			<cfelse>
				<cfset sexcode = "?">
			</cfif>
		</cfif>
		<cfset FieldNum = "">
		<cfset af = "">
		<cfloop list="#other_ids#" index="val" delimiters=";">
			<cfif #val# contains "Field Num=">
				<cfset FieldNum = "Field##: #replace(val,"Field Num=","")#">
			</cfif>
			<cfif #val# contains "AF=">
				<cfset af = "#replace(val,"="," ")#">
			</cfif>
		</cfloop>
		
		<cfif #collectors# contains ",">
			<Cfset spacePos = find(",",collectors)>
			<cfset thisColl = left(collectors,#SpacePos# - 1)>
			<cfset thisColl = "#thisColl# et al.">
		<cfelse>
			<cfset thisColl = #collectors#>
		</cfif>
		<cfset totlen = "">
		<cfset taillen = "">
		<cfset hf = "">
		<cfset efn = "">
		<cfset weight = "">
		<cfset totlen_val = "">
		<cfset taillen_val = "">
		<cfset hf_val = "">
		<cfset efn_val = "">
		<cfset weight_val = "">
		<cfset totlen_units = "">
		<cfset taillen_units = "">
		<cfset hf_units = "">
		<cfset efn_units = "">
		<cfset weight_units = "">
				
		<cfloop list="#attList#" index="val">
			<cfset thisName = #val#>
			<cfset thisName = #replace(thisName," ","_","all")#>
			<cfset thisName = #replace(thisName,"-","_","all")#>
			<cfset thisName = #left(thisName,20)#>
			
			<cfif #val# is "total length">
				<cfset totlen = "#evaluate("data." &  thisName)#">
			</cfif>
			<cfif #val# is "tail length">
				<cfset taillen = "#evaluate("data." &  thisName)#">
			</cfif>
			<cfif #val# is "hind foot with claw">
				<cfset hf = "#evaluate("data." &  thisName)#">
			</cfif>
			<cfif #val# is "ear from notch">

				<cfset efn = "#evaluate("data." &  thisName)#">
			</cfif>
			<cfif #val# is "weight">
				<cfset weight = "#evaluate("data." &  thisName)#">
			</cfif>
		</cfloop>
		<cfif len(#totlen#) gt 0>
			<cfif #trim(totlen)# contains " ">
				<cfset spacePos = find(" ",totlen)>
				<cfset totlen_val = trim(left(totlen,#spacePos#))>
				<cfset totlen_Units = trim(right(totlen,len(totlen) - #spacePos#))>
			</cfif>		
		</cfif>
		<cfif len(#taillen#) gt 0>
			<cfif #trim(taillen)# contains " ">
				<cfset spacePos = find(" ",taillen)>
				<cfset taillen_val = trim(left(taillen,#spacePos#))>
				<cfset taillen_Units = trim(right(taillen,len(taillen) - #spacePos#))>
			</cfif>		
		</cfif>
		<cfif len(#hf#) gt 0>
			<cfif #trim(hf)# contains " ">
				<cfset spacePos = find(" ",hf)>
				<cfset hf_val = trim(left(hf,#spacePos#))>
				<cfset hf_Units = trim(right(hf,len(hf) - #spacePos#))>
			</cfif>		
		</cfif>
		<cfif len(#efn#) gt 0>
			<cfif trim(#efn#) contains " ">
				<cfset spacePos = find(" ",efn)>
				<cfset efn_val = trim(left(efn,#spacePos#))>
				<cfset efn_Units = trim(right(efn,len(efn) - #spacePos#))>
			</cfif>		
		</cfif>
		<cfif len(#weight#) gt 0>
			<cfif trim(#weight#) contains " ">
				<cfset spacePos = find(" ",weight)>
				<cfset weight_val = trim(left(weight,#spacePos#))>
				<cfset weight_Units = trim(right(weight,len(weight) - #spacePos#))>
			</cfif>		
		</cfif>
		
			<cfif len(#totlen#) gt 0>
				<cfif #totlen_Units# is "mm">
					<cfset meas = "#totlen_val#-">
				<cfelse>
					<cfset meas = "#totlen_val# #totlen_units#-">
				</cfif>
			<cfelse>
				<cfset meas="X-">
			</cfif>
			
			<cfif len(#taillen#) gt 0>
				<cfif #taillen_Units# is "mm">
					<cfset meas = "#meas##taillen_val#-">
				<cfelse>
					<cfset meas = "#meas##taillen_val# #taillen_Units#-">
				</cfif>
			<cfelse>
				<cfset meas="#meas#X-">
			</cfif>
			
			<cfif len(#hf#) gt 0>
				<cfif #hf_Units# is "mm">
					<cfset meas = "#meas##hf_val#-">
				<cfelse>
					<cfset meas = "#meas##hf_val# #hf_Units#-">
				</cfif>
			<cfelse>
				<cfset meas="#meas#X-">
			</cfif>
	
			<cfif len(#efn#) gt 0>
				<cfif #efn_Units# is "mm">
					<cfset meas = "#meas##efn_val#&##8801;">
				<cfelse>
					<cfset meas = "#meas##efn_val# #efn_Units#&##8801;">
				</cfif>
			<cfelse>
				<cfset meas="#meas#X&##8801;">
			</cfif>
			
			<cfif len(#weight#) gt 0>
				<cfset meas = "#meas##weight_val# #weight_Units#">
			<cfelse>
				<cfset meas="#meas#X">
			</cfif>
		<cfset accn=#accn_num_prefix#>
		<cfif len(#accn_num#) is 1>
			<cfset accn="#accn#.00#accn_num#">
		<cfelseif  len(#accn_num#) is 2>
			<cfset accn="#accn#.0#accn_num#">
		<cfelse>
			<cfset accn="#accn#.#accn_num#">
		</cfif>
		<cfset stripParts = "">
		<cfset tiss = "">
		<cfloop list="#parts#" delimiters=";" index="p">
			<cfif #p# contains "(frozen)">
				<cfset tiss="tissues (frozen)">
			<cfelse>
				<cfif len(#stripParts#) is 0>
					<cfset stripParts = #p#>
				<cfelse>
					<cfset stripParts = "#stripParts#; #p#">
				</cfif>
			</cfif>
		</cfloop>
		<cfif len(#tiss#) gt 0>
			<cfset stripParts = "#stripParts#; #tiss#">
		</cfif>
		<cfset thisDate = "">
		<cftry>
			<cfset thisDate = #dateformat(verbatim_date,"dd mmm yyyy")#>
			<cfcatch>
				<cfset thisDate = #verbatim_date#>
			</cfcatch>
		</cftry>
	<cfset t=#t#+1>	
	<cfset i=#i#+1>	
	<cfif #i# is 1>
		<table cellpadding="0" cellspacing="0">	
	</cfif>
	
	<cfif #t# is 1>
				<tr>
			</cfif>
			<cfset borderstyle = "border-bottom: 1 px solid ##CCCCCC; border-left: 1 px solid ##CCCCCC;">
					<cfif #i# lte #numCols#><!--- first row of the table --->
						<cfset borderstyle = "#borderstyle#; border-top: 1 px solid ##CCCCCC;">
					</cfif>
					<cfif #r# is #rc#><!--- LAST RECORD row of the table --->
						<cfset borderstyle = "#borderstyle#; border-right: 1 px solid ##CCCCCC;">
					</cfif>
					<cfif #t# is #numCols#><!--- RIGHT COLUMN --->
						<cfset borderstyle = "#borderstyle#; border-right: 1 px solid ##CCCCCC;">
					</cfif>
					
					<td style="padding:0px; #borderstyle#">
					
		<div style="  position:relative;  width:#width#px; height:#height#px;" align="center">
			
			<div style="position:absolute; top:3px; left:2px; width:40px; 
				height:10px; padding-left:2px; padding-right:2px;" align="left"  class="arial6b">
				UAM #cat_num#
				</div>
			<div style="position:absolute; top:3px; left:40px; width:108px; overflow:hidden;
				height:10px; padding-left:2px; padding-right:2px;" align="right"  class="arial6b">
				#Scientific_Name#</i>
				</div>
			<div style="position:absolute; top:12px; left:2px; width:144px; overflow:hidden;
				height:21px; padding-left:2px; padding-right:2px;" align="left"  class="arial6">
				#geog#
			</div>
			<div style="position:absolute; top:33px; left:2px; width:100px; overflow:hidden; 
				height:7px; padding:1px;" align="left"  class="arial6">
				#coordinates#
			</div>
			<div style="position:absolute; top:33px; left:95px; width:52px; overflow:hidden; 
				height:7px; padding:1px; ;" align="right"  class="arial6">
				<cfif len(#quad#) gt 0>
					[#quad#]&nbsp;
				</cfif>
			</div>
			<div style="position:absolute; top:40px; left:2px; width:144px; overflow:hidden; 
				height:14px; padding:1px;" align="left"  class="arial6">
				Coll:&nbsp;&nbsp;#thisColl#
			</div>
			<div style="position:absolute; top:54px; left:2px; width:75px; overflow:hidden; 
				height:7px; padding:1px;" align="left"  class="arial6">
				#thisDate#
			</div>
			<div style="position:absolute; top:54px; left:81px; width:65px; overflow:hidden; 
				height:7px; padding:1px;" align="right"  class="arial6">
				Sex: #sexcode#
			</div>
			<div style="position:absolute; top:62px; left:2px; width:95px; overflow:hidden; 
				height:7px; padding:1px;" align="left"  class="arial6">
				#meas#
			</div>
			<div style="position:absolute; top:62px; left:101px; width:45px; overflow:hidden; 
				height:7px; padding:1px;" align="right"  class="arial6">
				#af#
			</div>
			<div style="position:absolute; top:69px; left:2px; width:144px; overflow:hidden; 
				height:9px; padding:1px;" align="left"  class="arial4">
				#stripParts#
			</div>
			<div style="position:absolute; top:78px; left:2px; width:77px; overflow:hidden; 
				height:7px; padding:1px;" align="left"  class="arial6">
				#FieldNum#
			</div>
			<div style="position:absolute; top:78px; left:81px; width:65px; overflow:hidden; 
				height:7px; padding:1px;" align="right"  class="arial6">
				Accn #accn#&nbsp;
			</div>
		</div>
	
	</td>
			<cfif #t# is #numCols#>
				<cfset t=0>
				</tr>
				</cfif>
	<cfif #i# is (#numRows# * #numCols#)>
		<cfset i=0>
		</table>
		<cfdocumentitem type="pagebreak"></cfdocumentitem>
		<!---
		--->
	</cfif>	
			
	<cfset lPos = #lPos# + #width#>
	<cfset r=#r#+1>
	</cfloop>
	<!-----
	
	----->
	</cfdocument>
	</cfoutput>
