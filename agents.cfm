<cfif not isdefined("agent_id")>
	<cfset agent_id=-1>
</cfif>
<cfinclude template="/includes/_header.cfm">
<cfset title='Manage Agents'>
<cfoutput>
<script>
	
</script>
<table>
	<tr>
		<td>
			search
		</td>
		<td colspan="2">
			edit thingy
		</td>
	</tr>
	<tr>
		<td>
			result		
		</td>
	</tr>
</table>
<frameset rows="40,*">
	<frame src="/includes/_agentSearchFrameHeader.cfm" name="_header" noresize scrolling="no">
	<frameset cols="310,*">
		<frameset rows="295,*">
 			<frame src="/AgentSearch.cfm" name="_search">
 			<frame src="/AgentGrid.cfm" name="_pick">
		</frameset>
		<frameset rows="100%,*">
			<frame src="/editAllAgent.cfm?agent_id=#agent_id#" name="_person" >
		<frame src="/UntitledFrame-3"></frameset>
	</frameset>
</frameset>
<noframes>
gotta have frames
</noframes>
</cfoutput>
