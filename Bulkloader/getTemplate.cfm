<cfinclude template="/includes/_header.cfm">
<cfif action is "nothing">
<cfquery name="blt" datasource="uam_god">
	select column_name from user_tab_cols where table_name='BULKLOADER'
	order by internal_column_id
</cfquery>
<cfoutput>
	<cfset everything=valuelist(blt.column_name)>
	<cfset required="COLLECTION_OBJECT_ID,ENTEREDBY,ACCN,TAXON_NAME,NATURE_OF_ID,ID_MADE_BY_AGENT,MADE_DATE,VERBATIM_DATE,BEGAN_DATE,ENDED_DATE,HIGHER_GEOG,SPEC_LOCALITY,VERBATIM_LOCALITY,COLLECTION_CDE,INSTITUTION_ACRONYM,COLL_OBJ_DISPOSITION,CONDITION,COLLECTOR_AGENT_1,COLLECTOR_ROLE_1,PART_NAME_1,PART_CONDITION_1,PART_LOT_COUNT_1,PART_DISPOSITION_1,COLLECTING_METHOD,COLLECTING_SOURCE">
	<cfset basicCoords="ORIG_LAT_LONG_UNITS, DATUM,LAT_LONG_REF_SOURCE,MAX_ERROR_DISTANCE,MAX_ERROR_UNITS,GEOREFMETHOD,DETERMINED_BY_AGENT,DETERMINED_DATE,LAT_LONG_REMARKS,VERIFICATIONSTATUS,GPSACCURACY,EXTENT">
	<cfset dms="LATDEG,LATMIN,LATSEC,LATDIR,LONGDEG,LONGMIN,LONGSEC,LONGDIR">
	<cfset ddm="LATDEG,DEC_LAT_MIN,LATDIR,LONGDEG,DEC_LONG_MIN,LONGDIR">
	<cfset dd="DEC_LAT,DEC_LONG">
	<cfset utm="UTM_ZONE,UTM_EW,UTM_NS">
	<cfset n=5>
	<cfset oid="CAT_NUM"> 
	<cfloop from="1" to="#n#" index="i">
		<cfset oid=listappend(oid,"OTHER_ID_NUM_" & i)>
		<cfset oid=listappend(oid,"OTHER_ID_NUM_TYPE_" & i)>	
	</cfloop>
	<cfset n=8>
	<cfset coll=""> 
	<cfloop from="1" to="#n#" index="i">
		<cfset oid=listappend(oid,"COLLECTOR_AGENT_" & i)>
		<cfset oid=listappend(oid,"COLLECTOR_ROLE_" & i)>	
	</cfloop>
	<cfset n=12>
	<cfset part=""> 
	<cfloop from="1" to="#n#" index="i">
		<cfset oid=listappend(oid,"PART_NAME_" & i)>
		<cfset oid=listappend(oid,"PART_MODIFIER_" & i)>
		<cfset oid=listappend(oid,"PRESERV_METHOD_" & i)>
		<cfset oid=listappend(oid,"PART_CONDITION_" & i)>
		<cfset oid=listappend(oid,"PART_BARCODE_" & i)>
		<cfset oid=listappend(oid,"PART_CONTAINER_LABEL_" & i)>
		<cfset oid=listappend(oid,"PART_LOT_COUNT_" & i)>
		<cfset oid=listappend(oid,"PART_DISPOSITION_" & i)>
		<cfset oid=listappend(oid,"PART_REMARK_" & i)>	
	</cfloop>
	
	<cfset n=10>
	<cfset attr=""> 
	<cfloop from="1" to="#n#" index="i">
		<cfset oid=listappend(oid,"ATTRIBUTE_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_VALUE_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_UNITS_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_REMARKS_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_DATE_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_DET_METH_" & i)>
		<cfset oid=listappend(oid,"ATTRIBUTE_DETERMINER_" & i)>
	</cfloop>
	
	<cfset n=6>
	<cfset geol=""> 
	<cfloop from="1" to="#n#" index="i">
		<cfset oid=listappend(oid,"GEOLOGY_ATTRIBUTE_" & i)>
		<cfset oid=listappend(oid,"GEO_ATT_VALUE_" & i)>
		<cfset oid=listappend(oid,"GEO_ATT_DETERMINER_" & i)>
		<cfset oid=listappend(oid,"GEO_ATT_DETERMINED_DATE_" & i)>
		<cfset oid=listappend(oid,"GEO_ATT_DETERMINED_METHOD_" & i)>
		<cfset oid=listappend(oid,"GEO_ATT_REMARK_" & i)>
	</cfloop>
												  
  											     
 												 
	<!---
	

 RELATIONSHIP										      VARCHAR2(60)
 RELATED_TO_NUMBER									      VARCHAR2(60)
 RELATED_TO_NUM_TYPE									      VARCHAR2(255)
 MIN_DEPTH										      VARCHAR2(20)
 MAX_DEPTH										      VARCHAR2(20)
 DEPTH_UNITS										      VARCHAR2(30)

 COLL_OBJECT_HABITAT									      VARCHAR2(255)
 ASSOCIATED_SPECIES									      VARCHAR2(4000)
 LOCALITY_ID										      VARCHAR2(20)

  										      VARCHAR2(60)

 					      VARCHAR2(4000)
 GEOLOGY_ATTRIBUTE_2									      VARCHAR2(255)
 GEO_ATT_VALUE_2									      VARCHAR2(255)
 GEO_ATT_DETERMINER_2									      VARCHAR2(255)
 GEO_ATT_DETERMINED_DATE_2								      VARCHAR2(255)
 GEO_ATT_DETERMINED_METHOD_2								      VARCHAR2(255)
 GEO_ATT_REMARK_2									      VARCHAR2(4000)
 GEOLOGY_ATTRIBUTE_3									      VARCHAR2(255)
 GEO_ATT_VALUE_3									      VARCHAR2(255)
 GEO_ATT_DETERMINER_3									      VARCHAR2(255)
 GEO_ATT_DETERMINED_DATE_3								      VARCHAR2(255)
 GEO_ATT_DETERMINED_METHOD_3								      VARCHAR2(255)
 GEO_ATT_REMARK_3									      VARCHAR2(4000)
 GEOLOGY_ATTRIBUTE_4									      VARCHAR2(255)
 GEO_ATT_VALUE_4									      VARCHAR2(255)
 GEO_ATT_DETERMINER_4									      VARCHAR2(255)
 GEO_ATT_DETERMINED_DATE_4								      VARCHAR2(255)
 GEO_ATT_DETERMINED_METHOD_4								      VARCHAR2(255)
 GEO_ATT_REMARK_4									      VARCHAR2(4000)
 GEOLOGY_ATTRIBUTE_5									      VARCHAR2(255)
 GEO_ATT_VALUE_5									      VARCHAR2(255)
 GEO_ATT_DETERMINER_5									      VARCHAR2(255)
 GEO_ATT_DETERMINED_DATE_5								      VARCHAR2(255)
 GEO_ATT_DETERMINED_METHOD_5								      VARCHAR2(255)
 GEO_ATT_REMARK_5									      VARCHAR2(4000)
 GEOLOGY_ATTRIBUTE_6									      VARCHAR2(255)
 GEO_ATT_VALUE_6									      VARCHAR2(255)
 GEO_ATT_DETERMINER_6									      VARCHAR2(255)
 GEO_ATT_DETERMINED_DATE_6								      VARCHAR2(255)
 GEO_ATT_DETERMINED_METHOD_6								      VARCHAR2(255)
 GEO_ATT_REMARK_6									      VARCHAR2(4000)
 COLLECTING_EVENT_ID									      NUMBER
---->

<br><span class="likeLink" onclick="clearAll('#everything#')">Clear All</span>
<br><span class="likeLink" onclick="checkList('#required#')">Add Required</span>
<br><span class="likeLink" onclick="checkList('#basicCoords#')">Add basic coordinate info</span>
<br><span class="likeLink" onclick="checkList('#dms#')">Add DMS coordinate info</span>
<br><span class="likeLink" onclick="checkList('#ddm#')">Add DM.m coordinate info</span>
<br><span class="likeLink" onclick="checkList('#dd#')">Add D.d coordinate info</span>
<br><span class="likeLink" onclick="checkList('#utm#')">Add UTM coordinate info</span>
<br><span class="likeLink" onclick="checkList('#oid#')">Add Identifiers</span>
<br><span class="likeLink" onclick="checkList('#coll#')">Add Agents</span>
<br><span class="likeLink" onclick="checkList('#part#')">Add parts</span>
<br><span class="likeLink" onclick="checkList('#attr#')">Add attributes</span>
<br><span class="likeLink" onclick="checkList('#geol#')">Add geology</span>

<script>
function clearAll(list) {
	var a = list.split(',');
	for (i=0; i<a.length; ++i) {
		//alert(eid);
		if (document.getElementById(a[i])) {
			//alert(eid);
			document.getElementById(a[i]).checked=false;
		}
	}
}
function checkList(list) {
	var a = list.split(',');
	for (i=0; i<a.length; ++i) {
		//alert(eid);
		if (document.getElementById(a[i])) {
			//alert(eid);
			document.getElementById(a[i]).checked=true;
		}
	}
}
</script>
	<form name="f" method="post" action="getTemplate.cfm">
		<input type="hidden" name="action" value="getTemplate">
		<label for="format">Format</label>
		<select name="format" id="format">
			<option value="tab">Tab-delimited text</option>
		</select>
		<input type="submit" value="build template">
		<cfloop query="blt">
			<br>#column_name# <input type="checkbox" name="fld" id="#column_name#" value="#column_name#" checked="checked">
		</cfloop>
	</form>
</cfoutput>
</cfif>
<cfif action is 'getTemplate'>
	<cfdump var=#form#>
</cfif>