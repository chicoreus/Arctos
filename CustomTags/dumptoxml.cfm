<cfif IsDefined("Attributes.v")><cfset var = Evaluate("Caller." & Attributes.v)><cfelseif IsDefined("Attributes.variable")>
<cfset var = Evaluate("Caller." & Attributes.variable)><cfset Attributes.v = Attributes.variable><cfelse>
<cfthrow type="SmartObjects.cf_dumptoxml.MissingAttribute.Variable" message="cf_dumptoxml: Required Attribute &quot;variable&quot; not defined"></cfif>
<cfoutput><cfif IsQuery(var)><cfloop index="i" list="#var.columnlist#">[ HELP NEW THING!!! ]  #trim(i)#</cfloop>
<cfloop index="i" from="1" to="#var.RecordCount#"><cfloop index="j" list="#var.columnlist#">
[ HELP NEW THING2!!! ]  #trim(HTMLEditFormat(Evaluate("var." & j & "[i]")))#</cfloop>
</cfloop><cfelseif IsStruct(var)>
<cfloop item="i" collection="#var#">
<cfif isnumeric(i)>
	<cfset i="Number_" & i>
</cfif>
<#trim(i)#><cf_dumptoxml variable="var['#i#']"></#trim(i)#></cfloop>
<cfelseif IsArray(var)><cfloop index="i" from="1" to="#ArrayLen(var)#"><#trim(i)#><cftry>
<cf_dumptoxml variable="var[#i#]"><cfcatch type="Any">&nbsp;</cfcatch></cftry></#trim(i)#></cfloop><cfelse>#trim(HTMLEditFormat(replace(var,'=','[EQUALS]','all')))#</cfif></cfoutput>