<cfset title="Manage IP and subnet blocking">
<cfinclude template="/includes/_header.cfm">
<cfif action is 'tf'>
	hello
</cfif>

<cfoutput>
<cfif action is "subnet">
	<script src="/includes/sorttable.js"></script>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select 
			subnet 
		from 
			uam.blacklist_subnet
	</cfquery>
	<a href="blacklist.cfm">blacklist home</a>
	<h2>Currently Blocked Subnets</h2>
	<cfloop query="d">
		<br>#subnet# 
		<a href="http://whois.domaintools.com/#subnet#.1.1" target="_blank">whois</a>
	</cfloop>
	<h2>
		Unblocked subnets with >2 blocked IPs
	</h2>
	<p>
		Use this with great care. Blocked subnets here should be mirrored in firewall rules, which will require an email to the network folks. 
		Blocking subnets at the CF level still imposes load on the server.
	</p>
	<p>
		General Guidelines
		<ul>
			<li>
				"Your IP/subnet has been blocked" messages require CF processing. Some subnets regularly fire thousands of these queries
				simultaneously, causing uptime and performance issues for legitimate users. "Flood probes" should be blocked at the firewall.
			 </li>
			 <li>
			 	Some foreign subnets (particularly originating from Eastern Europe) are the origin of continuous probes and no 
			 	obvious legitimate traffic. These can mask dangerous activity and make keeping up with logfiles burdensome. Consider 
			 	blocking these subnets when all other approaches have failed.
			 </li>
			 <li>
			 	US-based subnets should rarely be blocked, except in the case of fatally-aggressive bot traffic or spam injection attempts from
			 	multiple IPs. Use with great caution.
			 </li>
		</ul>
	</p>
	<p>
		Everything redirects to the IP list page so that application variables can be properly set. Sorry about the extra click.
	</p>
	
	<cfquery name="q" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select 
			ip,
			substr(ip,1,instr(ip,'.',1,2)-1) subnet,
			to_char(listdate,'YYYY-MM-DD') listdate
		from 
			uam.blacklist 
		where 
			substr(ip,1,instr(ip,'.',1,2)-1) not in (select subnet from blacklist_subnet)
	</cfquery>
	<cfquery name="sn" dbtype="query">
		select subnet from q group by subnet order by subnet
	</cfquery>
	<table border id="t" class="sortable">
		<tr>
			<th>Subnet</th>
			<th>NumberDistIPs</th>
			<th>firstblock</th>
			<th>lastblock</th>
			<th>whois</th>
			<th>block subnet</th>
		</tr>
		<cfloop query="sn">
			<cfquery name="sndata" dbtype="query">
				select 
					count(*) c,
					min(listdate) firstblock,
					max(listdate) lastblock
				from 
					q 
				where 
					subnet='#subnet#'
			</cfquery>
			<cfif sndata.c gt 2>
				<tr>
					<td>#subnet#</td>
					<td>#sndata.c#</td>
					<td>#sndata.firstblock#</td>
					<td>#sndata.lastblock#</td>
					<td><a href="http://whois.domaintools.com/#subnet#.1.1" target="_blank">[ whois ]</a></td>
					<td><a href="blacklist.cfm?action=blockSubnet&subnet=#subnet#">[ block this subnet ]</a></td>
				</tr>
			</cfif>	
		</cfloop>
	</table>
</cfif>
<!------------------------------------------>


<!------------------------------------------>
<cfif action is "blockSubnet">
	<cfif trim(subnet) is "127.0">
		<cfthrow message = "Local subnet cannot be blacklisted" errorCode = "127001">
		<cfabort>
	</cfif>
	<cfif listlen(subnet,".") is not 2>
		check subnet format 999.999<cfabort>
	</cfif>
	<cfif right(subnet,1) is ".">
		check subnet format 999.999<cfabort>
	</cfif>
	<cfif trim(subnet) is not subnet>
		check subnet format 999.999<cfabort>
	</cfif>
	
	
	
	<cftry>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		insert into blacklist_subnet (subnet) values ('#subnet#')
	</cfquery>
	
	Subnet #subnet# has been added to the blacklist. You should probably send email to the network folks and also 
	blacklist it at the firewall.
	
	<p>
		You must <a href="/Admin/blacklist.cfm">continue to the main blacklist page</a> to push the changes to the application.
	</p>
	<cfcatch>
		<cfdump var=#cfcatch#>
	</cfcatch>
	</cftry>
</cfif>
<!------------------------------------------>


<cfif action is "nothing">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select 
			ip 
		from 
			uam.blacklist 
		where  
			substr(ip,1,instr(ip,'.',1,2)-1) not in (select subnet from blacklist_subnet)
	</cfquery>
	<cfquery name="sn" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		select 
			subnet 
		from 
			uam.blacklist_subnet
	</cfquery>
	<p>
		IMPORTANT NOTE: IPs for blocked subnets are NOT included here. <a href="blacklist.cfm?action=subnet">manage blocked subnets</a>
	</p>
	<p>
		Found #d.recordcount# blocked IPs
	</p>
	
	<cfset application.blacklist=valuelist(d.ip)>
	<cfset application.subnet_blacklist=valuelist(sn.subnet)>
	
	<form name="i" method="post" action="blacklist.cfm">
		<input type="hidden" name="action" value="ins">
		<label for="ip">Add IP</label>
		<input type="text" name="ip" id="ip">
		<br><input type="submit" value="blacklist">
	</form>
	

	<cfloop query="d">
		<br>#ip# <a href="blacklist.cfm?action=del&ip=#ip#">Remove</a>
		<a href="http://whois.domaintools.com/#ip#" target="_blank">whois</a>
	</cfloop>
			<!----------

	-------------->
</cfif>
<!------------------------------------------>
<cfif action is "ins">
	<cfif trim(ip) is "127.0.0.1">
		<cfthrow message = "Local IP cannot be blacklisted" errorCode = "127001">
		<cfabort>
	</cfif>
	<cftry>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		insert into uam.blacklist (ip) values ('#trim(ip)#')
	</cfquery>
	<cflocation url="/Admin/blacklist.cfm">
	<cfcatch>
		<cfdump var=#cfcatch#>
	</cfcatch>
	</cftry>
</cfif>
<!------------------------------------------>
<cfif action is "del">
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,session.sessionKey)#">
		delete from uam.blacklist where ip = '#ip#'
	</cfquery>
	<cflocation url="/Admin/blacklist.cfm">
</cfif>
</cfoutput>


<cfinclude template="/includes/_footer.cfm">