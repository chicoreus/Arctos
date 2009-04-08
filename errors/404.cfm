<cfinclude template="/includes/_header.cfm">
<font color="##FF0000" size="+1">The page you tried to access does not exist.</font>
<p>&nbsp;</p>
<cfset lref=cgi.HTTP_REFERER>
<cfif isdefined("url.ref") and len(url.ref) gt 0>
	<cfset lref=url.ref>
</cfif>	
	<br>The last page you visited was #lref#.
	<cfif #lref# contains "#Application.ServerRootUrl#">
		<br>The link seems to be internal. Please submit a 
		<a href="/info/bugs.cfm">bug report</a> containing any information 
		that might help us resolve this issue.
	<cfelse>
		<br>The referral seems to be external. Click <a href="#lref#" target="_blank">here</a>
		to return to #lref#, and please ask them to fix this problem! 
		<font size="-1">Link opens in a new window.</font>	
	</cfif>

	<br>You probably typed the address incorrectly. If you came from another page, please ask
	them to fix the problem. If you came from somewhere on Arctos, please submit a
	<a href="/info/bugs.cfm">bug report</a>.
		<cfmail subject="Dead Link" to="#Application.PageProblemEmail#" from="dead.link@#application.fromEmail#" type="html">
			A user found a dead link! The referring site was #cgi.HTTP_REFERER#.
			<cfif isdefined("CGI.script_name")>
				<br>The missing page is #Replace(CGI.script_name, "/", "")#
			</cfif>
			<cfif isdefined("session.username")>
				<br>The username is #session.username#
			</cfif>
			<br>The IP requesting the dead link was #cgi.REMOTE_ADDR#
			<br>This message was generated by #cgi.CF_TEMPLATE_PATH#.
			<hr><cfdump var="#cgi#">
		</cfmail>
		 <p>A message has been sent to the site administrator.</p>
		 <p>
		 	Use the tabs in the header or see the <a href="siteMap.cfm">Site Map</a>
			to navigate Arctos
				
			
		 </p>
		 </td></tr>
</table>
	</cfif>
	
</cfoutput>

<!-------------

<cfoutput>

</cfoutput>
<hr>
-------------->
<cfinclude template="/includes/_footer.cfm">