<!----
	Custom tag to handle broken queries.
	
	Hopefully, clues users in to what they did wrong.
	Sends email to site admins with 
	page, error, and SQL that died
	
	DLM 
---->
<cfset attributes.title = "Error!">
<cfif #cgi.REMOTE_ADDR# is "66.249.65.35"
	OR #cgi.REMOTE_ADDR# is "66.249.64.68">
	<!---- it's Google, send em to the search page ---->
	<cflocation url="/SpecimenSearch.cfm">
</cfif>
<cfoutput>
<table cellpadding="10">
	<tr><td valign="top"><img src="/images/oops.gif"></td>
	<td>
		<font color="##FF0000" size="+1">
		The query you submitted failed!</font>  <br>
			<blockquote>
				<em>
					<font color="##FF0000">
						<strong>#caller.queryError#</strong>
					</font>
		    	</em>
			</blockquote>
			<ul>
				<li>
					Did your query time out? Try adding parameters or lowering your Detail Level in <a href="/login.cfm">Preferences</a>.
				</li>
				<li>
					Did you enter enough information to process the request? Required fields look like 
						<input type="text" class="reqdClr" size="8">
				</li>
				<li>
					Did you use a special character? Special characters ( ', %, ##, _, etc.)
					 have specific meanings for some applications and may cause some queries to fail.
				</li>
			</ul>

<p>If you can't resolve this issue, please submit a <a href="/info/bugs.cfm">Bug Report</a>, 
including any information that may help us help you!</p>
<p>We sincerely aploogize for the inconvenience.</p>

<p><strong>The query you submitted was parsed out as:</strong>
	<blockquote>
		#caller.sql#
	</blockquote>
</p>
	
This message has been logged. Please submit a <a href="/info/bugs.cfm">bug report</a>
if you have any additional information that will help us resolve this problem, or 
use your browser's back button to try again. 
	<cfmail subject="Broken Query" to="#Application.PageProblemEmail#" from="query.error@arctos.database.museum" type="html">
		A query died!
		<cfsavecontent variable="errortext">
Exceptions:
		<hr>
		<cfif isdefined("exception")>
			<cfdump var="#exception#" label="exception">
		</cfif>
		<hr>
		Client Dump:
		<hr>
		<cfdump var="#client#" label="client">
		<hr>
		Form Dump:
		<hr>
		<cfdump var="#form#" label="form">
		<hr>
		URL Dump:
		<hr>
		<cfdump var="#url#" label="url">
		<cfdump var="#caller#" label="caller">

</cfsavecontent>
		<br>
		<strong>Time of exception:</strong> #dateformat(now(),'dd mmm yyyy')# #TimeFormat(Now(),'HH:mm:ss')#
		<p><strong>Error Message:</strong> 
		<blockquote>
			#caller.queryError#
		</blockquote>
		<p>SQL:</p>
		<blockquote>
			#caller.sql#
		</blockquote>
		</p>
		
		<p><strong>The page that caused this error was:</strong> #cgi.SCRIPT_NAME#
		
		<cfif isdefined("client.username")>
			<p><strong>The user was logged in as:</strong> #client.username# (#cgi.REMOTE_ADDR#)
		</cfif>
				<br>This message was generated by /queryError.cfm.
	</cfmail>
</cfoutput>


	</td></tr>
</table>


<cfabort>