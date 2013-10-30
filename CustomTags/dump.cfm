<!--- 
MODIFIED FROM

CF_Dump.cfm v1.3

dump into a simple table

call with

<cf_dump v=attributes>

where attributes is a struct

--->

<cfset var = Evaluate("Caller." & Attributes.v)>
<cfoutput>
	<cfif IsQuery(var)>
		<table width="100%" border="1" cellspacing="0" cellpadding="3"><tr><td colspan="#ListLen(var.ColumnList)#">
			<b>QUERY with #ListLen(var.ColumnList)# fields and #var.RecordCount# records</b>
		</td>
	</tr>
	<tr><td>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
<tr>
<cfloop index="i" list="#var.columnlist#">
<td><font face="Arial" size="2">#i#</font></td>
</cfloop>
</tr>
<cfloop index="i" from="1" to="#var.RecordCount#">
<tr>
<cfloop index="j" list="#var.columnlist#">
<td valign="top" align="left">#HTMLEditFormat(Evaluate("var." & j & "[i]"))#&nbsp;</td>
</cfloop>
</tr>
</cfloop>
</table>
</td></tr>
</table>
<cfelseif IsStruct(var)>
	
		<table width="100%" border="1" cellspacing="0" cellpadding="3">
			<tr bgcolor="eeeeee">
				<td colspan="2">
					
					<b>STRUCTURE with #StructCount(var)# elements</b>
				</td>
			</tr>
			<tr><td>
					<table width="100%" border="1" cellspacing="0" cellpadding="3">
						<cfloop item="i" collection="#var#">
						
							<tr>
								<td nowrap valign="top">#i#</td>
								<td valign="top">
									<CF_Dump variable="var['#i#']">
								</td>
								
							</tr>
						</cfloop>
					</table>
			</td></tr>
		</table>

	<cfelseif IsArray(var)>
	
		<table width="100%" border="1" cellspacing="0" cellpadding="3">
			<tr bgcolor="eeeeee">
				<td colspan="2">
					
					<b>ARRAY with #ArrayLen(var)# elements</b>
				</td>
			</tr>
			<tr><td>
					<table width="100%" border="1" cellspacing="0" cellpadding="3">
						<cfloop index="i" from="1" to="#ArrayLen(var)#">
							<tr>
								<td nowrap valign="top">#i#</td>

								<td valign="top">
									<cftry>
										<CF_Dump variable="var[#i#]">
										<cfcatch type="Any">&nbsp;</cfcatch>
									</cftry>
									
								</td>
							</tr>
						</cfloop>
					</table>
			</td></tr>
		</table>
		
		
	<!--- Attribute is a normal scalar value --->
	<cfelse>
		&quot;#HTMLEditFormat(var)#&quot;
		
		<!--- Output WDDX if possible --->
		<cftry>
			<cfwddx action="WDDX2CFML" input="#var#" output="wddx">
			<br><b>This Is A WDDX Variable</b>
			<CF_Dump variable="wddx">
			<cfcatch type="ANY"></cfcatch>
		</cftry>
	</cfif>

</cfoutput>

