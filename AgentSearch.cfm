<cfinclude template="includes/_frameHeader.cfm">
<cfquery name="ctagent_name_type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#" cachedwithin="#createtimespan(0,0,60,0)#">
	select agent_name_type from ctagent_name_type order by agent_name_type
</cfquery>
<cfquery name="ctagent_type" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#" cachedwithin="#createtimespan(0,0,60,0)#">
	select agent_type from ctagent_type order by agent_type
</cfquery>
<cfquery name="ctagent_status" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#" cachedwithin="#createtimespan(0,0,60,0)#">
	select agent_status from ctagent_status order by agent_status
</cfquery>
<script language="javascript" type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#status_date").datepicker();
	});
</script>
<span class="infoLink pageHelp" onclick="getDocs('agent');">Page Help</span>
Agent Search
<cfoutput>
<form name="agntSearch" action="AgentGrid.cfm" method="post" target="_pick">
	<input type="hidden" name="Action" value="search">
	<label for="anyName"><a href="javascript:void(0);" onClick="getDocs('agent','anynamesearch')">Any part of any name</a></label>
	<input type="text" name="anyName" id="anyName" size="75">
	<table width="100%">
		<tr>
			<td>
				<label for="agent_type">Agent Type</label>
				<select name="agent_type" size="1" id="agent_type">
					<option value=""></option>
					<cfloop query="ctagent_type">
						<option value="#agent_type#">#agent_type#</option>
					</cfloop>
				</select>
			</td>
			<td>
				<label for="agent_id">AgentID</label>
				<input type="text" name="agent_id" size="6" id="agent_id">
			</td>
		</tr>
	</table>
	<label for="address"><a href="javascript:void(0);" onClick="getDocs('agent','address')">Address</a></label>
	<input type="text" name="address" id="address" size="75">
	<table width="100%">
		<tr>
			<td>
				<label for="agent_status">Agent Status</label>
				<select name="agent_status" size="1" id="agent_status">
					<option value=""></option>
					<cfloop query="ctagent_status">
						<option value="#agent_status#">#agent_status#</option>
					</cfloop>
				</select>
			</td>
			<td>
				<label for="status_date_oper">date match type</label>
				<select name="status_date_oper" size="1" id="status_date_oper">
					<option value="<=">Before</option>
					<option selected value="=" >At</option>
					<option value=">=">After</option>
				</select>
			</td>
			<td>
				<label for="status_date">Status Date</label>
				<input type="text" size="6" name="status_date" id="status_date" size="15">
			</td>
		</tr>
	</table>
	<table width="100%">
		<tr>
			<td>
				<label for="agent_name_type">Agent Name Type</label>
				<select name="agent_name_type" size="1" id="agent_name_type">
					<option value=""></option>
					<cfloop query="ctagent_name_type">
						<option value="#agent_name_type#">#agent_name_type#</option>
					</cfloop>
				</select>
			</td>
			<td>
				<label for="agent_name">Agent Name</label>
				<input type="text" name="agent_name" id="agent_name" size="35">
			</td>
		</tr>
	</table>
	<table width="100%">
		<tr>
			<td>
				<input type="submit" value="Search" class="schBtn">
			</td>
			<td><input type="reset" value="Clear Form" class="clrBtn"></td>
			<td>
			<input type="button" 
				value="Create New Agent" 
				class="insBtn"
				onClick="window.open('editAllAgent.cfm?action=newAgent','_person');">
			</td>
		</tr>
	</table>
</form>
</cfoutput>	
<cfinclude template="includes/_pickFooter.cfm">