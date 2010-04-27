<cfinclude template="/includes/_header.cfm">
<cfif action is "nothing">
	<cfoutput>
		<cfquery name="ctAttribute_type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select distinct(attribute_type) from ctspecpart_attribute_type
		</cfquery>
		<cfquery name="thisRec" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			Select * from ctspec_part_att_att
			order by attribute_type
		</cfquery>
		<cfquery name="allCTs" datasource="uam_god">
			select distinct(table_name) as tablename from sys.user_tables where table_name like 'CT%' order by table_name
		</cfquery>
		<br>Create Attribute Control
		<table class="newRec" border>
			<tr>
				<th>Attribute</th>
				<th>Value Code Table</th>
				<th>Units Code Table</th>
				<th>&nbsp;</th>
			</tr>
			<form method="post" action="f_ctspec_part_att_att.cfm">
				<input type="hidden" name="action" value="newValue">
				<tr>
					<td>				
						<select name="attribute_type" size="1">
							<option value=""></option>
							<cfloop query="ctAttribute_type">
							<option 
								value="#ctAttribute_type.attribute_type#">#ctAttribute_type.attribute_type#</option>
							</cfloop>
						</select>
					</td>
					<td>
						<cfset thisValueTable = #thisRec.value_code_table#>
						<select name="value_code_table" size="1">
							<option value="">none</option>
							<cfloop query="allCTs">
							<option 
							value="#allCTs.tablename#">#allCTs.tablename#</option>
							</cfloop>
						</select>			
					</td>
					<td>
						<cfset thisUnitsTable = #thisRec.units_code_table#>
						<select name="units_code_table" size="1">
							<option value="">none</option>
							<cfloop query="allCTs">
							<option 
							value="#allCTs.tablename#">#allCTs.tablename#</option>
							</cfloop>
						</select>
					</td>
					<td>
						<input type="submit" 
							value="Create" 
							class="insBtn">	
					</td>
				</tr>
			</form>
		</table>
			<br>Edit Attribute Controls
			<table border>
				<tr>
					<th>Attribute</th>
					<th>Value Code Table</th>
					<th>Units Code Table</th>
					<th>&nbsp;</th>
				</tr>
				<cfset i=1>
				<cfloop query="thisRec">
					<form name="att#i#" method="post" action="CodeTableEditor.cfm">
						<input type="hidden" name="action" value="">
						<input type="hidden" name="tbl" value="#tbl#">
						<input type="hidden" name="oldAttribute_type" value="#Attribute_type#">
						<input type="hidden" name="oldvalue_code_table" value="#value_code_table#">
						<input type="hidden" name="oldunits_code_table" value="#units_code_table#">
						<tr>
							<td>
								<cfset thisAttType = #thisRec.attribute_type#>
									<select name="attribute_type" size="1">
										<option value=""></option>
										<cfloop query="ctAttribute_type">
										<option 
													<cfif #thisAttType# is "#ctAttribute_type.attribute_type#"> selected </cfif>value="#ctAttribute_type.attribute_type#">#ctAttribute_type.attribute_type#</option>
										</cfloop>
									</select>
							</td>
							<td>
								<cfset thisValueTable = #thisRec.value_code_table#>
								<select name="value_code_table" size="1">
									<option value="">none</option>
									<cfloop query="allCTs">
									<option 
									<cfif #thisValueTable# is "#allCTs.tablename#"> selected </cfif>value="#allCTs.tablename#">#allCTs.tablename#</option>
									</cfloop>
								</select>
							</td>
							<td>
								<cfset thisUnitsTable = #thisRec.units_code_table#>
								<select name="units_code_table" size="1">
									<option value="">none</option>
									<cfloop query="allCTs">
									<option 
									<cfif #thisUnitsTable# is "#allCTs.tablename#"> selected </cfif>value="#allCTs.tablename#">#allCTs.tablename#</option>
									</cfloop>
								</select>
							</td>
							<td>
								<input type="button" 
									value="Save" 
									class="savBtn"
								 	onclick="att#i#.action.value='saveEdit';submit();">	
								<input type="button" 
									value="Delete" 
									class="delBtn"
								  	onclick="att#i#.action.value='deleteValue';submit();">	
							</td>
						</tr>
					</form>
				<cfset i=#i#+1>
			</cfloop>
		</table>
	</cfoutput>
</cfif>
<cfinclude template="/includes/_footer.cfm">