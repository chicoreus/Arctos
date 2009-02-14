<cfinclude template="/includes/_header.cfm">
	<cfoutput>
			<cfquery name="annotations" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				select
					permit_id,
					EXP_DATE,
					PERMIT_NUM,
					ADDRESS,
					round(EXP_DATE - sysdate) expires_in_days,
					EXP_DATE,
					CONTACT_AGENT_ID
				FROM
					permit,
					electronic_address			
				WHERE
					permit.CONTACT_AGENT_ID = electronic_address.agent_id AND
					ADDRESS_TYPE='e-mail' AND
					EXP_DATE - sysdate < 90 and 
					EXP_DATE - sysdate >= 0
			</cfquery>
			<cfquery name="exp30ID" dbtype="query">
				select CONTACT_AGENT_ID from permitExpIn30 group by CONTACT_AGENT_ID
			</cfquery>
			
			<cfloop query="exp30ID">
				<cfquery name="exp30names" dbtype="query">
					select ADDRESS from permitExpIn30 where CONTACT_AGENT_ID=#exp30ID.CONTACT_AGENT_ID#
					group by ADDRESS
				</cfquery>
				<cfquery name="exp30Indiv" dbtype="query">
					select * from permitExpIn30 where CONTACT_AGENT_ID=#CONTACT_AGENT_ID# order by expires_in_days
				</cfquery>
				<cfmail to="#exp30names.ADDRESS#" subject="Expiring Permits" from="reminder@#Application.fromEmail#" type="html">
					The following permits expire within 90 days:
					<p>
						<cfloop query="exp30Indiv">
							<a href="#Application.ServerRootUrl#/Permit.cfm?Action=search&permit_id=#permit_id#">Permit##: #PERMIT_NUM#</a> expires on #dateformat(exp_date,'dd mmm yyyy')# (#expires_in_days# days)<br>
						</cfloop>
					</p>
				</cfmail>
			</cfloop>
			
			<cfquery name="expLoan" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				select 
					loan.transaction_id,
					RETURN_DUE_DATE,
					LOAN_NUM_PREFIX,
					LOAN_NUM,
					LOAN_NUM_SUFFIX,
					agent_name,
					address,
					AUTH_AGENT_ID,
					round(RETURN_DUE_DATE - sysdate) expires_in_days
				FROM 
					loan,
					trans,
					preferred_agent_name,
					electronic_address
				WHERE
					loan.transaction_id = trans.transaction_id AND
					trans.RECEIVED_AGENT_ID = preferred_agent_name.agent_id AND
					trans.AUTH_AGENT_ID = electronic_address.agent_id AND
					ADDRESS_TYPE='e-mail' AND
					RETURN_DUE_DATE - sysdate < 30 and 
					RETURN_DUE_DATE - sysdate >= 0 AND
					LOAN_STATUS != 'closed'
			</cfquery>
			<cfloop query="expLoan">
				<cfquery name="expLoanAddr" dbtype="query">
					select ADDRESS from expLoan where AUTH_AGENT_ID=#expLoan.AUTH_AGENT_ID#
					group by ADDRESS
				</cfquery>
				<cfquery name="expLoanIndiv" dbtype="query">
					select * from expLoan where AUTH_AGENT_ID=#AUTH_AGENT_ID# order by expires_in_days
				</cfquery>
				<cfmail to="#expLoan.ADDRESS#" subject="Loans Due" from="reminder@#Application.fromEmail#" type="html">
					The following oans are due within 30 days:
					<p>
						<cfloop query="expLoanIndiv">
							<a href="#Application.ServerRootUrl#/Loan.cfm?Action=editLoan&transaction_id=#transaction_id#">
								Loan##: #LOAN_NUM_PREFIX#-#LOAN_NUM#-#LOAN_NUM_SUFFIX#</a> to #agent_name# is due on #dateformat(RETURN_DUE_DATE,'dd mmm yyyy')# (#expires_in_days# days)<br>
						</cfloop>
					</p>
				</cfmail>
			</cfloop>
	</cfoutput>
	
	
<cfinclude template="/includes/_footer.cfm">