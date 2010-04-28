<cfinclude template="/includes/_pickHeader.cfm">
<script type='text/javascript' language="javascript" src='/includes/internalAjax.js'></script>

<cffunction name="getPartAttrSelect">
	<cfargument name="u_or_v" type="string">
	<cfargument name="patype" type="string">
	<cfargument name="paval" type="string">
	<cfargument name="paid" type="numeric">
	
	<cfquery name="k" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select * from ctspec_part_att_att where attribute_type='#patype#'
	</cfquery>
	<cfif u_or_v is "v">
		<cfif len(k.VALUE_code_table) gt 0>
			<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				select * from #k.VALUE_code_table#
			</cfquery>
			<cfloop list="#d.columnlist#" index="i">
				<cfif i is not "description" and i is not "collection_cde">
					<cfquery name="r" dbtype="query">
						select #i# d from d order by #i#
					</cfquery>
				</cfif>
			</cfloop>
			<cfsavecontent variable="rv">
				<select name="attribute_value_#paid">
					<cfloop query="r">
						<option <cfif paval is r.d>selected="selected" </cfif> value="#r.d#">#r.d#</option>
					</cfloop>
				</select>
			</cfsavecontent>
			<cfreturn rv>
		</cfif>
	</cfif>
	<!--------
	<cfif len(k.VALUE_code_table) gt 0>
		<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select * from #k.VALUE_code_table#
		</cfquery>
		<cfloop list="#d.columnlist#" index="i">
			<cfif i is not "description" and i is not "collection_cde">
				<cfquery name="r" dbtype="query">
					select #i# d from d order by #i#
				</cfquery>
			</cfif>
		</cfloop>
		<cfreturn "boogity@@">
	<cfelseif len(k.unit_code_table) gt 0>
		<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select * from #k.unit_code_table#
		</cfquery>
		<cfloop list="#d.columnlist#" index="i">
			<cfif i is not "description" and i is not "collection_cde">
				<cfquery name="r" dbtype="query">
					select #i# d from d order by #i#
				</cfquery>
			</cfif>
		</cfloop>
		<cfreturn "boogity@@">
	<cfelse>
		<cfreturn "boogity@@">
	</cfif>
	------------>
</cffunction>
<cfif action is "nothing">
<script language="JavaScript" src="/includes/jquery/jquery.ui.datepicker.min.js" type="text/javascript"></script>
<script>
	jQuery(document).ready(function() {
		jQuery(function() {
			jQuery("#determined_date_new").datepicker();
		});
	});
</script>
<cfoutput>
	<cfquery name="ctspecpart_attribute_type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select attribute_type from ctspecpart_attribute_type order by attribute_type
	</cfquery>

	<cfquery name="pAtt" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select
			 part_attribute_id,
			 attribute_type,
			 attribute_value,
			 attribute_units,
			 determined_date,
			 determined_by_agent_id,
			 attribute_remark
		from
			specimen_part_attribute
		where
			collection_object_id=#partID#
	</cfquery>
	
	<hr>
		
		<form name="f" method="post" action="partAtts.cfm">
		<input type="hidden" name="partID" value="#partID#">
		<input type="hidden" name="action">
	<table border>
		
		<tr>
			<th>Attribute</th>
			<th>Value</th>
			<th>Units</th>
			<th>Date</th>
			<th>DeterminedBy</th>
			<th>Remark</th>
		</tr>
		<cfset i=0>
		<cfloop query="pAtt">
			<tr id="r_#part_attribute_id#">
				<td>#attribute_type#</td>
				<td id="v_#part_attribute_id#">#getPartAttrSelect('v',attribute_type,attribute_value,part_attribute_id)#</td>
				<td id="u_#part_attribute_id#">#getPartAttrSelect('u',attribute_type,attribute_units,part_attribute_id)#
					
				</td>
				<td>#determined_date#</td>
				<td>#determined_by_agent_id#</td>
				<td>#attribute_remark#</td>
				<td>woot</td>
			</tr>
			<cfset i=i+1>
		</cfloop>
		<input type="hidden" name="numPAtt" value="#i#">	
		<tr id="r_new" class="newRec">
			<td>
				<select id="attribute_type_new" name="attribute_type_new" onchange="setPartAttOptions('new',this.value)">
					<option value=""></option>
					<cfloop query="ctspecpart_attribute_type">
						<option value="#attribute_type#">#attribute_type#</option>
					</cfloop>
				</select>
			</td>
			<td id="v_new">
				<INPut type="hidden" name="attribute_value_new">
			</td>
			<td id="u_new">
				<input type="hidden" name="attribute_units_new">
			</td>
			<td id="d_new">
				<input type="text" name="determined_date_new" id="determined_date_new">
			</td>
			<td id="a_new">
				<input type="hidden" name="determined_id_new" id="determined_id_new">
				<input type="text" name="determined_agent_new" id="determined_agent_new"
					onchange="getAgent('determined_id_new',this.id,'f',this.value);" onkeypress="return noenter(event);">
			</td>
			<td id="r_new">
				<input type="text" name="attribute_remark_new" id="attribute_remark_new">
			</td>
			<td>
				<input type="button" onclick="f.action.value='insPart';submit();" value="Create">
			</td>
		</tr>
		
	</table>
	</form>
	<cfdump var="#pAtt#">

</cfoutput>	
</cfif>
<cfif action is "insPart">
	<cfquery name="k" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		insert into specimen_part_attribute (
			collection_object_id,
			attribute_type,
			attribute_value,
			attribute_units,
			determined_date,
			determined_by_agent_id,
			attribute_remark
		) values (
			#partID#,
			'#attribute_type_new#',
			'#attribute_value_new#',
			'#attribute_units_new#',
			'#determined_date_new#',
			'#determined_id_new#',
			'#attribute_remark_new#'
		)	
	</cfquery>
	<cflocation url="partAtts.cfm?partID=#partID#" addtoken="false">
</cfif>