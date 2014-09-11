<cfcomponent>

<cffunction name="saveAgent" access="remote">
	<cfif not isdefined("escapeQuotes")>
		<cfinclude template="/includes/functionLib.cfm">
	</cfif>
	<cfoutput>
		<cftry>
			<cftransaction>
				<!--- agent --->
				<cfquery name="updateAgent" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
					UPDATE agent SET 
						agent_remarks = '#escapeQuotes(agent_remarks)#',
						agent_type='#agent_type#',
						preferred_agent_name='#escapeQuotes(preferred_agent_name)#'
					WHERE
						agent_id = #agent_id#
				</cfquery>
				<!---- agent names --->
				<cfloop list="#structKeyList(url)#" index="key">
					<cfif left(key,16) is "agent_name_type_">
						<cfset thisAgentNameID=listlast(key,"_")>
						<cfset thisAgentNameType=url["agent_name_type_#thisAgentNameID#"]>
						<cfset thisAgentName=url["agent_name_#thisAgentNameID#"]>
						<cfif thisAgentNameID contains "new">
							<cfif len(thisAgentName) gt 0>
								<cfquery name="nan" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
									INSERT INTO agent_name (
										agent_name_id,
										agent_id,
										agent_name_type,
										agent_name
									) VALUES (
										sq_agent_name_id.nextval,
										<cfqueryparam value = "#agentID#" CFSQLType = "CF_SQL_INTEGER">,
										'#thisAgentNameType#',
										'#escapeQuotes(thisAgentName)#'
									)
								</cfquery>
							</cfif>
						<cfelseif thisAgentName is "DELETE">
							<cfquery name="nan" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								delete from agent_name where agent_name_id=<cfqueryparam value = "#thisAgentNameID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						<cfelse>
							<cfquery name="nan" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								update 
									agent_name 
								set 
									agent_name='#escapeQuotes(thisAgentName)#',
									agent_name_type='#thisAgentNameType#'
								where agent_name_id=<cfqueryparam value = "#thisAgentNameID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						</cfif>
					</cfif>
				</cfloop>
				<!---- relationships ---->
				<cfloop list="#structKeyList(url)#" index="key">
					<cfif left(key,19) is "agent_relationship_">
						<cfset thisAgentRelationshipID=listlast(key,"_")>
						<cfset thisAgentRelationship=url["agent_relationship_#thisAgentRelationshipID#"]>
						<cfset thisRelatedAgentName=url["related_agent_#thisAgentRelationshipID#"]>
						<cfset thisRelatedAgentID=url["related_agent_id_#thisAgentRelationshipID#"]>
						<cfif thisAgentRelationshipID contains "new" and len(thisAgentRelationship) gt 0>
							<cfquery name="newReln" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								INSERT INTO agent_relations (
									AGENT_ID,
									RELATED_AGENT_ID,
									AGENT_RELATIONSHIP)
								VALUES (
									<cfqueryparam value = "#agent_id#" CFSQLType = "CF_SQL_INTEGER">,
									<cfqueryparam value = "#thisRelatedAgentID#" CFSQLType = "CF_SQL_INTEGER">,
									'#thisAgentRelationship#')		  
							</cfquery>
						<cfelseif thisAgentRelationship is "DELETE">
							<cfquery name="killRel" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								delete from agent_relations where agent_relationship_id=<cfqueryparam value = "#thisAgentRelationshipID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						<cfelse>
							<cfquery name="changeRelated" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								UPDATE agent_relations SET
									related_agent_id = <cfqueryparam value = "#thisRelatedAgentID#" CFSQLType = "CF_SQL_INTEGER">,
									agent_relationship='#thisAgentRelationship#'
								WHERE agent_relationship_id=<cfqueryparam value = "#thisAgentRelationshipID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						</cfif>
					</cfif>
				</cfloop>
				<!---- status ---->
				<cfloop list="#structKeyList(url)#" index="key">
					<cfif left(key,13) is "agent_status_">
						<cfset thisAgentStatusID=listlast(key,"_")>
						<cfset thisAgentStatus=url["agent_status_#thisAgentStatusID#"]>
						<cfset thisAgentStatusDate=url["status_date_#thisAgentStatusID#"]>
						<cfset thisAgentStatusRemark=url["status_remark_#thisAgentStatusID#"]>
						<cfif thisAgentStatusID contains "new" and len(thisAgentStatus) gt 0>
							<cfquery name="newStatus" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								insert into agent_status (
									AGENT_STATUS_ID,
									AGENT_ID,
									AGENT_STATUS,
									STATUS_DATE,
									STATUS_REMARK
								) values (
									sq_AGENT_STATUS_ID.nextval,
									#agent_id#,
									'#agent_status#',
									'#status_date#',
									'#escapequotes(status_remark)#'
								)
							</cfquery>
						<cfelseif thisAgentStatus is "DELETE">
							<cfquery name="newStatus" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								delete from  agent_status where agent_status_id=<cfqueryparam value = "#thisAgentStatusID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						<cfelse>
							<cfquery name="newStatus" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
								update agent_status 
								set
									AGENT_STATUS='#AGENT_STATUS#',
									STATUS_DATE='#STATUS_DATE#',
									STATUS_REMARK='#escapequotes(status_remark)#'
								where AGENT_STATUS_ID=<cfqueryparam value = "#thisAgentStatusID#" CFSQLType = "CF_SQL_INTEGER">
							</cfquery>
						</cfif>
					</cfif>
				</cfloop>
			</cftransaction>
		<cfreturn "success">
		<cfcatch>
			<cfset m= cfcatch.message & ': ' & cfcatch.detail>
			<cfif isdefined("cfcatch.sql")>
				<cfset m= m & ' ' & cfcatch.sql>
			</cfif>
			<cfreturn m>
			<cf_logError subject="error caught: saveAgent" attributeCollection=#cfcatch#>
		</cfcatch>
		</cftry>
	</cfoutput>
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