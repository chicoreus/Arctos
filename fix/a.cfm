fff
<cftry>
	t1
	<cftry>t2
	<CFCATCH>C2</CFCATCH>
	</cftry>
	<cfcatch>c1</cfcatch>
</cftry>

out
<cfhttp url="http://data.rbge.org.uk/herb/E00314421" method="get">
</cfhttp>


<cfdump var=#cfhttp#>


<cfhttp url="http://login.corral.tacc.utexas.edu/SpecimenDetailRDF.cfm" method="get">
</cfhttp>

<cfdump var=#cfhttp#>