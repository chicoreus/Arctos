<!---
drop table ds_temp_agent_split;

create table ds_temp_agent_split (
	key number not null,
	agent_type varchar2(255),
	preferred_name varchar2(255),
	first_name varchar2(255),
	middle_name varchar2(255),
	last_name varchar2(255),
	birth_date date,
	death_date date,
	prefix varchar2(255),
	suffix varchar2(255),
	other_name_1  varchar2(255),
	other_name_type_1   varchar2(255),
	other_name_2  varchar2(255),
	other_name_type_2   varchar2(255),
	other_name_3  varchar2(255),
	other_name_type_3   varchar2(255),
	agent_remark varchar2(4000),
	status varchar2(4000)
	);
	
create public synonym ds_temp_agent_split for ds_temp_agent_split;
grant all on ds_temp_agent_split to coldfusion_user;
grant select on ds_temp_agent_split to public;

 CREATE OR REPLACE TRIGGER ds_temp_agent_split_key                                         
 before insert  ON ds_temp_agent_split
 for each row 
    begin     
    	if :NEW.key is null then                                                                                      
    		select somerandomsequence.nextval into :new.key from dual;
    	end if;                                
    end;                                                                                            
/
sho err
---->
<cfinclude template="/includes/_header.cfm">
<cfif action is "nothing">
	<br>upload a CSV list of agent names with header "preferred_name". 
	<br>This form accepts only agent type=person; create everything else manually.
	<br>This form is not magic; you are responsible for the result.
	<br>This app only returns a file which may then be cleaned up and bulkloaded. Clean preferred_name and reload as many times as necessary before
	accepting the result.
	<br>Upload a smaller file if you get a timeout.
	<br>status=found one match agents exist and do not need loaded, or match the namestring of an existing agent and need made unique.
	<br>status "did you mean...." suggestions are last-name matches. Fix your data or add an alias to the existing agent if there's a good suggestion.
	<br>status=null recpords will, all else being correct, probably load
	<cfform name="atts" method="post" enctype="multipart/form-data">
		<input type="hidden" name="Action" value="getFile">
		<input type="file" name="FiletoUpload" size="45">
		<input type="submit" value="Upload this file" class="savBtn">
	</cfform>
</cfif>
<cfif action is "getFile">
<cfoutput>
	<!--- put this in a temp table --->
	<cfquery name="killOld" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		delete from ds_temp_agent_split
	</cfquery>
	<cffile action="READ" file="#FiletoUpload#" variable="fileContent">
	<cfset fileContent=replace(fileContent,"'","''","all")>
	<cfset arrResult = CSVToArray(CSV = fileContent.Trim()) />
	<cfset numberOfColumns = ArrayLen(arrResult[1])>
	<cfset colNames="">
	<cfloop from="1" to ="#ArrayLen(arrResult)#" index="o">
		<cfset colVals="">
			<cfloop from="1"  to ="#ArrayLen(arrResult[o])#" index="i">
				 <cfset numColsRec = ArrayLen(arrResult[o])>
				<cfset thisBit=arrResult[o][i]>
				<cfif #o# is 1>
					<cfset colNames="#colNames#,#thisBit#">
				<cfelse>
					<cfset colVals="#colVals#,'#thisBit#'">
				</cfif>
			</cfloop>
		<cfif #o# is 1>
			<cfset colNames=replace(colNames,",","","first")>
		</cfif>	
		<cfif len(colVals) gt 1>
			<cfset colVals=replace(colVals,",","","first")>
			<cfif numColsRec lt numberOfColumns>
				<cfset missingNumber = numberOfColumns - numColsRec>
				<cfloop from="1" to="#missingNumber#" index="c">
					<cfset colVals = "#colVals#,''">
				</cfloop>
			</cfif>
			<cfquery name="ins" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				insert into ds_temp_agent_split (#colNames#) values (#preservesinglequotes(colVals)#)				
			</cfquery>
		</cfif>
	</cfloop>
</cfoutput>
<cflocation url="agentNameSplitter.cfm?action=validate" addtoken="false">
</cfif>
<cfif action is "validate">
<cfoutput>
	<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select * from ds_temp_agent_split			
	</cfquery>
	<cfquery name="ctsuffix" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select suffix from ctsuffix
	</cfquery>
	<cfquery name="ctprefix" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select prefix from ctprefix
	</cfquery>
	<cfset sfxLst=valuelist(ctsuffix.suffix)>
	<cfset pfxLst=valuelist(ctprefix.prefix)>
	<cfloop query="d">
		<cfset s=''>
		<cfset pfx=''>
		<cfset sfx=''>
		<cfset firstn=''>
		<cfset lastn=''>
		<cfset mdln=''>
		<cfif len(trim(preferred_name)) is 0>
			<cfset s=listappend(s,"preferred_name may not be blank",";")>
		</cfif>
		<cfif trim(preferred_name) is not preferred_name>
			<cfset s=listappend(s,"leading or trailing spaces",";")>
		</cfif>
		<cfif preferred_name contains "  ">
			<cfset s=listappend(s,"preferred_name may not contain double spaces",";")>
		</cfif>
		<cfquery name="isThere" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			select agent_id from agent_name where agent_name='#preferred_name#'
		</cfquery>
		<cfif isThere.recordcount is 1>
			<cfset s=listappend(s,"found #isThere.recordcount# match",";")>	
		<cfelseif isThere.recordcount gt 1>
			<cfset s=listappend(s,"found #isThere.recordcount# matches-merge or make unique",";")>
		</cfif>
		<cfloop index="i" list="#preferred_name#" delimiters=" ,;">
			<cfif listfindnocase(pfxLst,i)>
				<cfset pfx=i>
			</cfif>
			<cfif listfindnocase(sfxLst,i)>
				<cfset sfx=i>
			</cfif>
		</cfloop>
		<cfset thisName=preferred_name>
		<cfif len(pfx) gt 0>
			<cfset thisName=replace(thisName,pfx,'')>
		</cfif>
		<cfif len(sfx) gt 0>
			<cfset thisName=replace(thisName,sfx,'')>
		</cfif>
		<cfset thisName=trim(thisName)>
		<cfif right(thisname,1) is ",">
			<cfset thisName=left(thisName,len(thisName)-1)>
		</cfif>
		<cfif listlen(thisName," ") is 1>
			<cfset s=listappend(s,"will not deal with no-space agents",";")>	
		<cfelseif listlen(thisName," ") is 2>
			<cfset firstn=listFirst(thisName," ")>
			<cfset lastn=listLast(thisName," ")>
		<cfelse>
			<cfset firstn=listFirst(thisName," ")>
			<cfset lastn=listLast(thisName," ")>
			<cfset mdln=thisName>
			<cfset mdln=replace(mdln,firstn,'')>
			<cfset mdln=replace(mdln,lastn,'')>
			<cfset mdln=trim(mdln)>
		</cfif>
		<cfif s does not contain "found">
			<cfquery name="ln" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
				select agent_name from preferred_agent_name,person where 
				person.person_id=preferred_agent_name.agent_id and
				person.last_name='#lastn#'
				group by agent_name
			</cfquery>
			<cfif ln.recordcount gt 0>
				<cfset s=listappend(s,"did you mean any of:#chr(10)# #valuelist(ln.agent_name,"#chr(10)#")#?",";")>	
			</cfif>
		</cfif>
		<cfquery name="d" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
			update ds_temp_agent_split set
				agent_type='person',
				preferred_name='#preferred_name#',
				first_name='#firstn#',
				middle_name='#mdln#',
				last_name='#lastn#',
				birth_date='',
				death_date='',
				prefix='#pfx#',
				suffix='#sfx#',
				other_name_1='',
				other_name_type_1='',
				other_name_2='',
				other_name_type_2='',
				other_name_3='',
				other_name_type_3='',
				agent_remark='',
				status='#s#'
			where key=#key#
		</cfquery>
	</cfloop>
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select * from ds_temp_agent_split			
	</cfquery>
	<cfset theCols=data.columnList>
	<cfset theCols=listdeleteat(theCols,listFindNoCase(theCols,"key"))>
	<script src="/includes/sorttable.js"></script>
	<table border id="t" class="sortable">
		<tr>
			<cfloop list="#theCols#" index="i">
				<th>#i#</th>
			</cfloop>
		</tr>
		<cfloop query="data">
			<tr>
				<cfloop list="#theCols#" index="i">
					<td>
						#evaluate("data." & i)#
					</td>
				</cfloop>
			</tr>
		</cfloop>
	</table>
	
	<a href="agentNameSplitter.cfm?action=download">download</a>
</cfoutput>
</cfif>
<cfif action is "download">
	<cfquery name="data" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select * from ds_temp_agent_split			
	</cfquery>
	<cfset theCols=data.columnList>
	<cfset theCols=listdeleteat(theCols,listFindNoCase(theCols,"key"))>
	<cfset variables.encoding="UTF-8">
	<cfset variables.fileName="#Application.webDirectory#/download/splitAgentNames.csv">
	<cfscript>
		variables.joFileWriter = createObject('Component', '/component.FileWriter').init(variables.fileName, variables.encoding, 32768);
		variables.joFileWriter.writeLine(theCols); 
	</cfscript>
	
	<cfloop query="data">
		<cfset d=''>
		<cfloop list="#theCols#" index="i">
			<cfset t='"' & evaluate("data." & i) & '"'>
			<cfset d=listappend(d,t,",")>
		</cfloop>
		<cfscript>
			variables.joFileWriter.writeLine(d); 
		</cfscript>
	</cfloop>
	<cfscript>	
		variables.joFileWriter.close();
	</cfscript>
	<cflocation url="/download.cfm?file=splitAgentNames.csv" addtoken="false">
	<a href="/download/splitAgentNames.csv">Click here if your file does not automatically download.</a>		
</cfif>
<cfinclude template="/includes/_footer.cfm">
