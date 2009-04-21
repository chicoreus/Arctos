<cfinclude template = "includes/_header.cfm">
<!--- get taxon name ID if we're passed a scientific name --->
<cfif isdefined("scientific_name") and len(#scientific_name#) gt 0>
	<cfquery name="getTID" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		SELECT taxon_name_id FROM taxonomy WHERE upper(scientific_name)	= '#ucase(scientific_name)#'
	</cfquery>
	<cfif getTID.recordcount is 1>
		<cfset tnid=#getTID.taxon_name_id#>
	<cfelse>
	  	<div class="error">
			<cfoutput>#scientific_name#</cfoutput> was not found.	
		</div>
	</cfif>
</cfif>
<cfif isdefined("taxon_name_id")>
	<cfquery name="c" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
		select scientific_name from taxonomy where taxon_name_id=#taxon_name_id# 
	</cfquery>
	<cflocation url="/name/#c.scientific_name#" addtoken="false">
</cfif>
<cfquery name="getDetails" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	SELECT 
		taxonomy.TAXON_NAME_ID,
		taxonomy.VALID_CATALOG_TERM_FG,
		taxonomy.SOURCE_AUTHORITY,
		taxonomy.FULL_TAXON_NAME,
		taxonomy.SCIENTIFIC_NAME,
		taxonomy.AUTHOR_TEXT,
		common_name,
		taxonomy.genus,
		taxonomy.species,
		taxon_relations.RELATED_TAXON_NAME_ID,
		taxon_relations.TAXON_RELATIONSHIP,
		taxon_relations.RELATION_AUTHORITY,
		related_taxa.SCIENTIFIC_NAME as related_name,
		imp_related_taxa.SCIENTIFIC_NAME imp_related_name,
		imp_taxon_relations.taxon_name_id imp_RELATED_TAXON_NAME_ID,
		imp_taxon_relations.TAXON_RELATIONSHIP imp_TAXON_RELATIONSHIP,
		imp_taxon_relations.RELATION_AUTHORITY imp_RELATION_AUTHORITY
	 from 
	 	taxonomy, 
		common_name, 
		taxon_relations,
		taxonomy related_taxa,
		taxon_relations imp_taxon_relations,
		taxonomy imp_related_taxa
	 WHERE 
		taxonomy.taxon_name_id = common_name.taxon_name_id (+) AND
		taxonomy.taxon_name_id = taxon_relations.taxon_name_id (+) AND
		taxon_relations.related_taxon_name_id = related_taxa.taxon_name_id (+) AND
		taxonomy.taxon_name_id = imp_taxon_relations.related_taxon_name_id (+) AND
		imp_taxon_relations.taxon_name_id = imp_related_taxa.taxon_name_id (+) and
		taxonomy.taxon_name_id = #tnid#
		ORDER BY scientific_name, common_name, related_taxon_name_id
</cfquery>
<Cfoutput query="getDetails" group="scientific_name">
<cfset title="#getDetails.scientific_name#">
<cfset thisSearch = "%22#getDetails.scientific_name#%22">
<cfoutput group="common_name">
	<cfif len(#common_name#) gt 0>
		<cfset thisSearch = "#thisSearch# OR %22#common_name#%22">
	</cfif>	
</cfoutput>
</Cfoutput>
<Cfoutput query="getDetails" group="scientific_name">
	<div align="left">
	  <cfif #VALID_CATALOG_TERM_FG# is 1>
	   <font size="+1"	>
		      <I><B>#SCIENTIFIC_NAME#</B></I>			    
		</font>
		
		      <cfif len(#AUTHOR_TEXT#) gt 0>
			      <font size="+1"	>#AUTHOR_TEXT#</font>
        </cfif>
		  <br>
        <cfelseIF #VALID_CATALOG_TERM_FG# is 0>
		        <p><font size="+1"><I><b>#SCIENTIFIC_NAME#</b></I></font>		            <cfif len(#AUTHOR_TEXT#) gt 0>
		              <font size="+1">#AUTHOR_TEXT#</font>
					 
		              </cfif>
	              <br>
	                <font color="##FF0000" size="-1">&nbsp;&nbsp;&nbsp;&nbsp;This
	                term is not accepted for current identifications.</font><br>
	      
	        </cfif>
  </div>
	<cfif isdefined("session.roles") and listfindnocase(session.roles,"manage_taxonomy")>
		<a href="/Taxonomy.cfm?action=edit&taxon_name_id=#taxon_name_id#">Edit Taxonomy</a>	
	</cfif>
	<P align="left"><b>#FULL_TAXON_NAME#</b>
		
	<p align="left">Authority: <b>#source_Authority#</b>
		
		<p align="left">Common Name(s):<br>
		<cfoutput group="common_name">
			<cfif len(#Common_name#) gt 0>	
				&nbsp;&nbsp;&nbsp;&nbsp;<b>#common_name#</b><br>
			<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;<b>No common names recorded.</b><br>
			</cfif>	
	</cfoutput>
	<p>
	<cfquery name="related" dbtype="query">
		select
			RELATED_TAXON_NAME_ID,
			TAXON_RELATIONSHIP,
			RELATION_AUTHORITY,
			related_name
		from
			getDetails
		where
			RELATED_TAXON_NAME_ID is not null
		group by
			RELATED_TAXON_NAME_ID,
			TAXON_RELATIONSHIP,
			RELATION_AUTHORITY,
			related_name
	</cfquery>
	<cfquery name="imp_related" dbtype="query">
		select
			imp_related_name,
			imp_RELATED_TAXON_NAME_ID,
			imp_TAXON_RELATIONSHIP,
			imp_RELATION_AUTHORITY
		from
			getDetails
		where
			imp_RELATED_TAXON_NAME_ID is not null
		group by
			imp_related_name,
			imp_RELATED_TAXON_NAME_ID,
			imp_TAXON_RELATIONSHIP,
			imp_RELATION_AUTHORITY
	</cfquery>
	<div align="left">Related Taxa:<br>
	 	<cfif related.recordcount is 0 and imp_related.recordcount is 0>
			<b>No related taxa recorded.</b>
		<cfelse>
			<cfloop query="related">
				#TAXON_RELATIONSHIP# of <a href="/TaxonomyDetails.cfm?taxon_name_id=#RELATED_TAXON_NAME_ID#"><i><b>#related_name#</b></i></a>
				<cfif len(RELATION_AUTHORITY) gt 0>
					(Authority: #RELATION_AUTHORITY#)
				</cfif>
				<br>
			</cfloop>
			<cfloop query="imp_related">
				<a href="/TaxonomyDetails.cfm?taxon_name_id=#imp_RELATED_TAXON_NAME_ID#"><i><b>#imp_related_name#</b></i></a>
				is #imp_TAXON_RELATIONSHIP#
				<cfif len(imp_RELATION_AUTHORITY) gt 0>
					(Authority: #imp_RELATION_AUTHORITY#)
				</cfif>
				<br>
			</cfloop>
		</cfif>	    
    </div>
	<p>
		Links:
		<ul>
			<li>
				Search Arctos for <a href="/SpecimenResults.cfm?taxon_name_id=#taxon_name_id#">
					exactly <I>#SCIENTIFIC_NAME#</I></a>
				or <a href="/SpecimenResults.cfm?scientific_name=#scientific_name#">like <em>#scientific_name#</em></a>
			</li>
			<li>
				<a href="http://images.google.com/images?q=#thisSearch#" target="_blank">
					<img src="/images/GoogleImage.gif" width="40" border="0">&nbsp;Google Images</a>
			</li>
			<li>
				<cfset srchName = #replace(scientific_name," ","+","all")#>
				<a href="http://ispecies.org/?q=#srchName#">iSpecies</a>
			</li>
			<li>
				<cfset srchName = #replace(scientific_name," ","%20","all")#>
				<a href="http://www.itis.gov/servlet/SingleRpt/SingleRpt?search_topic=Scientific_Name&search_value=#srchName#&search_kingdom=every&search_span=containing&categories=All&source=html&search_credRating=all"><img src="/images/itis.gif" border="0" width="30">&nbsp;ITIS</a>
			</li>
			<li>
				<cfset srchName = #replace(scientific_name," ","%20","all")#>
				<a href="http://www.unep-wcmc.org/isdb/CITES/Taxonomy/tax-species-result.cfm?displaylanguage=eng&Genus=%25#genus#%25&source=animals&Species=#species#"><img src="/images/UNEP.jpg" border="0" width="30">&nbsp;UNEP</a>
			</li>			
		</ul>			
	</p>
</Cfoutput> 
<cfinclude template = "includes/_footer.cfm">