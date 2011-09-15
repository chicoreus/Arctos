<cfinclude template="/includes/_header.cfm">
<cfset title="Magic Taxonomy Thingee II">
<cfif action is "nothing">
	find taxa
	<form name="srch" method="post" action="sqlTaxonomy.cfm">
		<input type="hidden" name="action" value="findem">
		<table>
			<tr>
				<td>
				<label for="TAXON_NAME_ID">TAXON_NAME_ID</label>
						<input name="TAXON_NAME_ID" id="TAXON_NAME_ID" type="text">
						
						<label for="PHYLCLASS">PHYLCLASS</label>
						<input name="PHYLCLASS" id="PHYLCLASS" type="text">
						
						<label for="PHYLORDER">PHYLORDER</label>
						<input name="PHYLORDER" id="PHYLORDER" type="text">
						
						<label for="SUBORDER">SUBORDER</label>
						<input name="SUBORDER" id="SUBORDER" type="text">
						
						<label for="FAMILY">FAMILY</label>
						<input name="FAMILY" id="FAMILY" type="text">
						
						<label for="SUBFAMILY">SUBFAMILY</label>
						<input name="SUBFAMILY" id="SUBFAMILY" type="text">
						
						<label for="GENUS">GENUS</label>
						<input name="GENUS" id="GENUS" type="text">
						
						<label for="SUBGENUS">SUBGENUS</label>
						<input name="SUBGENUS" id="SUBGENUS" type="text">
						<label for="nomenclatural_code">nomenclatural_code</label>
						<input name="nomenclatural_code" id="nomenclatural_code" type="text">
				</td>
				<td>
				<label for="SPECIES">SPECIES</label>
						<input name="SPECIES" id="SPECIES" type="text">
						
						<label for="SUBSPECIES">SUBSPECIES</label>
						<input name="SUBSPECIES" id="SUBSPECIES" type="text">
						
						<label for="VALID_CATALOG_TERM_FG">VALID_CATALOG_TERM_FG</label>
						<input name="VALID_CATALOG_TERM_FG" id="VALID_CATALOG_TERM_FG" type="text">
						
						<label for="SOURCE_AUTHORITY">SOURCE_AUTHORITY</label>
						<input name="SOURCE_AUTHORITY" id="SOURCE_AUTHORITY" type="text">
						
						<label for="AUTHOR_TEXT">AUTHOR_TEXT</label>
						<input name="AUTHOR_TEXT" id="AUTHOR_TEXT" type="text">
						
						<label for="INFRASPECIFIC_RANK">INFRASPECIFIC_RANK</label>
						<input name="INFRASPECIFIC_RANK" id="INFRASPECIFIC_RANK" type="text">
						
						<label for="PHYLUM">PHYLUM</label>
						<input name="PHYLUM" id="PHYLUM" type="text">
						
						<label for="TRIBE">TRIBE</label>
						<input name="TRIBE" id="TRIBE" type="text">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="FULL_TAXON_NAME">FULL_TAXON_NAME</label>
					<input name="FULL_TAXON_NAME" id="FULL_TAXON_NAME" type="text" size="80">
				</td>
			</tr>
		</table>
		<input type="submit" value="find em">
	</form>
	</cfif>		
<cfif action is "findem">
<script src="/includes/sorttable.js"></script>
	<cfoutput>
		<cfquery name="getData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select * from taxonomy where
			1=1
			<cfif isdefined("TAXON_NAME_ID") and len(#TAXON_NAME_ID#) gt 0>
				and TAXON_NAME_ID IN ( #TAXON_NAME_ID# )
			</cfif>
			<cfif isdefined("PHYLCLASS") and len(#PHYLCLASS#) gt 0>
				and upper(PHYLCLASS) like '%#ucase(PHYLCLASS)#%'
			</cfif>
			<cfif isdefined("PHYLORDER") and len(#PHYLORDER#) gt 0>
				and upper(PHYLORDER) like '%#ucase(PHYLORDER)#%'
			</cfif>
			<cfif isdefined("SUBORDER") and len(#SUBORDER#) gt 0>
				and upper(SUBORDER) like '%#ucase(SUBORDER)#%'
			</cfif>
			<cfif isdefined("FAMILY") and len(#FAMILY#) gt 0>
				and upper(FAMILY) like '%#ucase(FAMILY)#%'
			</cfif>
			<cfif isdefined("SUBFAMILY") and len(#SUBFAMILY#) gt 0>
				and upper(SUBFAMILY) like '%#ucase(SUBFAMILY)#%'
			</cfif>
			<cfif isdefined("GENUS") and len(#GENUS#) gt 0>
				and upper(GENUS) like '%#ucase(GENUS)#%'
			</cfif>
			<cfif isdefined("SPECIES") and len(#SPECIES#) gt 0>
				and upper(SPECIES) like '%#ucase(SPECIES)#%'
			</cfif>
			<cfif isdefined("SUBGENUS") and len(#SUBGENUS#) gt 0>
				and upper(SUBGENUS) like '%#ucase(SUBGENUS)#%'
			</cfif>
			<cfif isdefined("SUBSPECIES") and len(#SUBSPECIES#) gt 0>
				and upper(SUBSPECIES) like '%#ucase(SUBSPECIES)#%'
			</cfif>
			<cfif isdefined("SOURCE_AUTHORITY") and len(#SOURCE_AUTHORITY#) gt 0>
				and upper(SOURCE_AUTHORITY) like '%#ucase(SOURCE_AUTHORITY)#%'
			</cfif>
			<cfif isdefined("AUTHOR_TEXT") and len(#AUTHOR_TEXT#) gt 0>
				and upper(AUTHOR_TEXT) like '%#ucase(AUTHOR_TEXT)#%'
			</cfif>
			<cfif isdefined("INFRASPECIFIC_RANK") and len(#INFRASPECIFIC_RANK#) gt 0>
				and upper(INFRASPECIFIC_RANK) like '%#ucase(INFRASPECIFIC_RANK)#%'
			</cfif>
			<cfif isdefined("PHYLUM") and len(#PHYLUM#) gt 0>
				and upper(PHYLUM) like '%#ucase(PHYLUM)#%'
			</cfif>
			<cfif isdefined("TRIBE") and len(#TRIBE#) gt 0>
				and upper(TRIBE) like '%#ucase(TRIBE)#%'
			</cfif>
			<cfif isdefined("VALID_CATALOG_TERM_FG") and len(#VALID_CATALOG_TERM_FG#) gt 0>
				and VALID_CATALOG_TERM_FG = #VALID_CATALOG_TERM_FG#
			</cfif>
			<cfif isdefined("FULL_TAXON_NAME") and len(#FULL_TAXON_NAME#) gt 0>
				and upper(FULL_TAXON_NAME) like '%#ucase(FULL_TAXON_NAME)#%'
			</cfif>
			<cfif isdefined("nomenclatural_code") and len(#nomenclatural_code#) gt 0>
				and upper(nomenclatural_code) like '%#ucase(nomenclatural_code)#%'
			</cfif>
			and rownum < 1000
		</cfquery>
		<strong>Found #getData.recordcount# records.</strong>
		<table id="t" class="sortable" border="1">
			<tr>
				<th>TAXON_NAME_ID</th>
				<th>PHYLUM</th>
				<th>PHYLCLASS</th>
				<th>SUBCLASS</th>
				<th>PHYLORDER</th>
				<th>SUBORDER</th>
				<th>SUPERFAMILY</th>
				<th>FAMILY</th>
				<th>SUBFAMILY</th>
				<th>TRIBE</th>
				<th>GENUS</th>
				<th>SUBGENUS</th>
				<th>SPECIES</th>
				<th>INFRASPECIFIC_RANK</th>
				<th>SUBSPECIES</th>
				<th>VALID_CATALOG_TERM_FG</th>
				<th>AUTHOR_TEXT</th>
				<th>SOURCE_AUTHORITY</th>
				<th>TAXON_REMARKS</th>
				<th>SCIENTIFIC_NAME</th>				
				<th>nomenclatural_code</th>			
				<th>taxon_status</th>
			</tr>
		<cfloop query="getData">
			<tr>
				<td>#TAXON_NAME_ID#</td>
				<td>#PHYLUM#</td>
				<td>#PHYLCLASS#</td>
				<td>#SUBCLASS#</td>
				<td>#PHYLORDER#</td>
				<td>#SUBORDER#</td>
				<td>#SUPERFAMILY#</td>
				<td>#FAMILY#</td>
				<td>#SUBFAMILY#</td>
				<td>#TRIBE#</td>
				<td>#GENUS#</td>
				<td>#SUBGENUS#</td>
				<td>#SPECIES#</td>
				<td>#INFRASPECIFIC_RANK#</td>
				<td>#SUBSPECIES#</td>
				<td>#VALID_CATALOG_TERM_FG#</td>
				<td>#AUTHOR_TEXT#</td>
				<td>#SOURCE_AUTHORITY#</td>
				<td>#TAXON_REMARKS#</td>
				<td>#SCIENTIFIC_NAME#</td>
				<td>#nomenclatural_code#</td>
				<td>#taxon_status#</td>
			</tr>
		</cfloop>
		</table>
		<cfif getData.recordcount gt 0>
			<cfset upList = "KINGDOM,PHYLUM,PHYLCLASS,SUBCLASS,PHYLORDER,SUBORDER,SUPERFAMILY,FAMILY,SUBFAMILY,TRIBE,GENUS,SUBGENUS,SPECIES,INFRASPECIFIC_RANK,SUBSPECIES,VALID_CATALOG_TERM_FG,SOURCE_AUTHORITY,AUTHOR_TEXT,TAXON_REMARKS,nomenclatural_code,taxon_status">
			<hr>
			Use this form to update all records in the table above.
			<br>Everything gets updated when you click - be sure.
			<br>Update is exact match including nonprinting characters.
			<br>Be paranoid.
			<br>Got 999 records? You're probably not seeing everything and you're about to make a huge mess. Don't.	
			<form name="buildIt" method="post" action="sqlTaxonomy.cfm">
				<input type="hidden" name="action" value="update">
				<input type="hidden" name="taxonnameidlist" value="#valuelist(getData.taxon_name_id)#">
				<br>For everything in the table above,<br><strong>UPDATE taxonomy SET</strong>
				<select name="upFld" id="upFld" size="1">
				<cfloop list="#upList#" index="f">
					<option value="#f#">#f#</option>
				</cfloop>
				</select>
				<strong>=</strong>
				<input type="text" name="upTo" id="upTo">
			<br><input type="submit" value="Make Changes">
			</form>
		</cfif>
	</cfoutput>
</cfif>
<cfif action is "update">
	<cfoutput>
		<form name="buildIt" method="post" action="sqlTaxonomy.cfm">
			<input type="hidden" name="action" value="findem">
			<input type="hidden" name="taxon_name_id" value="#taxonnameidlist#">
		<br><input type="submit" value=" [ return to taxon table ] ">
		</form>
		<cfquery name="getData" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			update taxonomy set #upFld# =  '#upTo#' where taxon_name_id in (#taxonnameidlist#)
		</cfquery>
	</cfoutput>
</cfif>
<cfinclude template="/includes/_footer.cfm">