<cfcomponent>




<cffunction name="saveAgent" access="remote">
	<cfif not isdefined("escapeQuotes")>
		<cfinclude template="/includes/functionLib.cfm">
	</cfif>
	<cfdump var=#url#>
	<cfoutput>
<cfloop list="#structKeyList(url)#" index="key">
	<br>Key: #key#, Value: #url[key]#
	<cfif left(key,16) is "agent_name_type_">
		<p>
			<cfset thisAgentNameID=listlast(key,"_")>
			
			<br>thisAgentNameID: #thisAgentNameID#
			<cfset thisAgentNameType=url["agent_name_type_#thisAgentNameID#"]>
			<br>thisAgentNameType: #thisAgentNameType#
			
			<cfset thisAgentName=url["agent_name_#thisAgentNameID#"]>
			
			<br>thisAgentName: #thisAgentName#
			<cfif thisAgentNameID contains "new" and len(thisAgentName) gt 0>
				<br>inserting
			<cfelseif thisAgentName is "DELETE">
				<br>delete
			<cfelse>
				<br>update
			</cfif>
		</p>
	</cfif>
</cfloop>

<cfloop list="#structKeyList(url)#" index="key">
	<br>Key: #key#, Value: #url[key]#
	<cfif left(key,13) is "agent_status_">
		<p>
			<cfset thisAgentStatusID=listlast(key,"_")>
			<br>thisAgentStatusID: #thisAgentStatusID#

			<cfset thisAgentStatus=url["agent_status_#thisAgentStatusID#"]>
			<br>thisAgentStatus: #thisAgentStatus#
			
			<cfset thisAgentStatusDate=url["status_date_#thisAgentStatusID#"]>
			<br>thisAgentStatusDate: #thisAgentStatusDate#
			
			<cfset thisAgentStatusRemark=url["status_remark_#thisAgentStatusID#"]>
			<br>thisAgentStatusRemark: #thisAgentStatusRemark#
			
			
			<cfif thisAgentStatusID contains "new" and len(thisAgentStatus) gt 0>
				<br>inserting
			<cfelseif thisAgentStatus is "DELETE">
				<br>delete
			<cfelse>
				<br>update
			</cfif>
		</p>
	</cfif>
</cfloop>



<cfloop list="#structKeyList(url)#" index="key">
	<br>Key: #key#, Value: #url[key]#
	<cfif left(key,19) is "agent_relationship_">
		<p>
			<cfset thisAgentRelationshipID=listlast(key,"_")>
			<br>thisAgentRelationshipID: #thisAgentRelationshipID#

			<cfset thisAgentRelationship=url["agent_relationship_#thisAgentRelationshipID#"]>
			<br>thisAgentRelationship: #thisAgentRelationship#
			
			<cfset thisRelatedAgentName=url["related_agent_#thisAgentRelationshipID#"]>
			<br>thisRelatedAgentName: #thisRelatedAgentName#
			
			<cfset thisRelatedAgentID=url["related_agent_id_#thisAgentRelationshipID#"]>
			<br>thisRelatedAgentID: #thisRelatedAgentID#
			
			
			<cfif thisAgentRelationshipID contains "new" and len(thisAgentRelationship) gt 0>
				<br>inserting
			<cfelseif thisAgentRelationship is "DELETE">
				<br>delete
			<cfelse>
				<br>update
			</cfif>
		</p>
	</cfif>
</cfloop>




</cfoutput>

<cfabort>
	<cftry>
	
	=&agent_relationship_new1=&related_agent_id_new1=&related_agent_new1=
		<cftransaction>
			<cfquery name="updateAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
				UPDATE agent SET 
					agent_remarks = '#escapeQuotes(agent_remarks)#',
					agent_type='#agent_type#',
					preferred_agent_name='#escapeQuotes(preferred_agent_name)#'
				WHERE
					agent_id = #agent_id#
			</cfquery>
			

		</cftransaction>
	<cfreturn "success">
	<cfcatch>
		<cfreturn cfcatch.message & ': ' & cfcatch.detail>
	</cfcatch>
	</cftry>
</cffunction>






<cffunction name="saveAgentxxx" access="remote">
	<cftry>
	<cfquery name="n" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select sq_agent_name_id.nextval n from dual
	</cfquery>

	<cfquery name="updateName" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		INSERT INTO agent_name (
			agent_name_id, agent_id, agent_name_type, agent_name)
		VALUES (
			#n.n#, #agent_id#, '#agent_name_type#','#agent_name#')
	</cfquery>
		<cfset d = querynew("status,agent_name_id,agent_name_type,agent_name")>
		<cfset temp = queryaddrow(d,1)>
		<cfset temp = QuerySetCell(d, "status", "success",1)>
		<cfset temp = QuerySetCell(d, "agent_name_id", n.n,1)>
		<cfset temp = QuerySetCell(d, "agent_name_type", agent_name_type,1)>
		<cfset temp = QuerySetCell(d, "agent_name", agent_name,1)>
		<cfreturn d>
	<cfcatch>
		<cfset d = querynew("status")>
		<cfset temp = queryaddrow(d,1)>
		<cfset temp = QuerySetCell(d, "status", cfcatch.message & ': ' & cfcatch.detail,1)>
		<cfreturn d>
	</cfcatch>
	</cftry>
</cffunction>


<!------------------------------------->

<cffunction name="findAgents" access="remote">
	<cfoutput>
	
	<cfif not isdefined("escapeQuotes")>
		<cfinclude template="/includes/functionLib.cfm">
	</cfif>
	
	
	<cfset sql = "SELECT 
					agent.agent_id,
					agent.preferred_agent_name,
					agent.agent_type
				FROM 
					agent,
					agent_name,
					agent_status
				WHERE 
					agent.agent_id=agent_name.agent_id (+) and
					agent.agent_id=agent_status.agent_id (+) and
					agent.agent_id > -1
					">
					

	<cfif isdefined("anyName") AND len(anyName) gt 0>
		<cfset sql = "#sql# AND upper(agent_name.agent_name) like '%#trim(ucase(escapeQuotes(anyName)))#%'">
	</cfif>
	<cfif isdefined("agent_id") AND isnumeric(#agent_id#)>
		<cfset sql = "#sql# AND agent.agent_id = #agent_id#">
	</cfif>
	<cfif isdefined("status_date") AND len(status_date) gt 0>
		<cfset sql = "#sql# AND status_date #status_date_oper# '#status_date#'">
	</cfif>
	<cfif isdefined("agent_status") AND len(agent_status) gt 0>
		<cfset sql = "#sql# AND agent_status='#agent_status#'">
	</cfif>			
	<cfif isdefined("address") AND len(#address#) gt 0>
		<cfset sql = "#sql# AND agent.agent_id IN (select agent_id from addr where upper(formatted_addr) like '%#ucase(address)#%')">
	</cfif>
	<cfif isdefined("agent_name_type") AND len(agent_name_type) gt 0>
		<cfset sql = "#sql# AND agent_name_type='#agent_name_type#'">
	</cfif>
	<cfif isdefined("agent_type") AND len(agent_type) gt 0>
		<cfset sql = "#sql# AND agent.agent_type='#agent_type#'">
	</cfif>
	<cfif isdefined("agent_name") AND len(agent_name) gt 0>
		<cfset sql = "#sql# AND upper(agent_name.agent_name) like '%#ucase(escapeQuotes(agent_name))#%'">
	</cfif>
	<cfif isdefined("created_by") AND len(created_by) gt 0>
		<cfset sql = "#sql# AND agent.created_by_agent_id in (select agent_id from agent_name where upper(agent_name.agent_name) like '%#ucase(escapeQuotes(created_by))#%')">
	</cfif>
	
	<cfif isdefined("created_date") AND len(created_date) gt 0>
		<cfif len(created_date) is 4>
			<cfset filter='YYYY'>
		<cfelseif len(created_date) is 7>
			<cfset filter='YYYY-MM'>
		<cfelseif len(created_date) is 10>
			<cfset filter='YYYY-MM-DD'>
		<cfelse>
			Search created date as YYYY, YYYY-MM, YYYY-MM-DD
			<cfabort>
		</cfif>
		<cfset sql = "#sql# AND to_char(CREATED_DATE,'#filter#') #create_date_oper# '#created_date#'">
	</cfif>
	<cfset sql = "#sql# GROUP BY  agent.agent_id,
						agent.preferred_agent_name,
						agent.agent_type">
	<cfset sql = "#sql# ORDER BY agent.preferred_agent_name">

	<cfquery name="getAgents" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		#preservesinglequotes(sql)#
	</cfquery>
	<cfreturn getAgents>
	<!----
	<cfif getAgents.recordcount is 0>
	    <span class="error">Nothing Matched.</span>
	</cfif>
	<div style="height:20em; overflow:auto;">
		<cfloop query="getAgents">
			<div class="likeLink" onclick="loadEditAgent('#agent_id#');">
				#preferred_agent_name# <font size="-1">(#agent_type#: #agent_id#)</font> 
		   </div>
		</cfloop>
	</div>
	---->
</cfoutput>
</cffunction>

</cfcomponent>