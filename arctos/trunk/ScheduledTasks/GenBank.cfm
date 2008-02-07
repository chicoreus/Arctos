<!--- 
	builds reciprocal links from GenBank
	Run daily
	Run after adding GenBank other IDs
	Requires: 
		Application.genBankPrid
		Application.genBankPwd (encrypted)
		Application.genBankUsername
---->
<cfoutput>
<cfquery name="nucleotide" datasource="#Application.web_user#">
	select
		display_value,
		a.collection_object_id,
		cat_num,
		c.collection_cde,
		c.INSTITUTION_ACRONYM
	FROM
		cataloged_item a,
		coll_obj_other_id_num b,
		collection c
	where
		a.collection_object_id = b.collection_object_id AND
		a.collection_id = c.collection_id AND
		b.other_id_type='GenBank'
</cfquery>

<cfset header="------------------------------------------------#chr(10)#prid: #Application.genBankPrid##chr(10)#dbase: Nucleotide#chr(10)#!base.url: #Application.ServerRootUrl#/SpecimenDetail.cfm?">
<cffile action="write" file="#Application.webDirectory#/temp/nucleotide.ft" addnewline="no" output="#header#">
<cfset i=1>
<cfloop query="nucleotide">
	<cfset oneLine="#chr(10)#------------------------------------------------#chr(10)#linkid: #i##chr(10)#query: #display_value##chr(10)#base: &base.url;#chr(10)#rule: collection_object_id=#collection_object_id##chr(10)#name: #institution_acronym# #collection_cde# #cat_num#">
		<cfset i=#i#+1>
		<cffile action="append" file="#Application.webDirectory#/temp/nucleotide.ft" addnewline="no" output="#oneLine#">
</cfloop>

<cfquery name="taxonomy" datasource="#Application.web_user#">
	select 
		distinct(scientific_name)
	FROM 
		cataloged_item a, 
		identification c, 
		coll_obj_other_id_num d 
	WHERE 
		a.collection_object_id = c.collection_object_id AND 
		c.accepted_id_fg=1 AND 
		a.collection_object_id = d.collection_object_id AND 
		d.other_id_type='GenBank'
</cfquery>
<cfset header="------------------------------------------------#chr(10)#prid: #Application.genBankPrid##chr(10)#dbase: Taxonomy#chr(10)#!base.url: #Application.ServerRootUrl#/SpecimenResults.cfm?OIDType=GenBank&">
<cffile action="write" file="#Application.webDirectory#/temp/taxonomy.ft" addnewline="no" output="#header#">
<cfset i=1>
<cfloop query="taxonomy">
	<cfset oneLine="#chr(10)#------------------------------------------------#chr(10)#linkid: #i##chr(10)#query: #scientific_name# [name]#chr(10)#base: &base.url;#chr(10)#rule: scientific_name=#scientific_name##chr(10)#name: #scientific_name# with GenBank sequence accessions">		<cfset i=#i#+1>
		<cffile action="append" file="#Application.webDirectory#/temp/taxonomy.ft" addnewline="no" output="#oneLine#">
</cfloop>
<cfquery name="AllUsedSciNames" datasource="#Application.web_user#">
	select 
		distinct(scientific_name) from identification
</cfquery>
<cfset header="------------------------------------------------#chr(10)#prid: #Application.genBankPrid##chr(10)#dbase: Taxonomy#chr(10)#!base.url: #Application.ServerRootUrl#/TaxonomyResults.cfm?">
<cffile action="write" file="#Application.webDirectory#/temp/names.ft" addnewline="no" output="#header#">
<cfset i=1>
<cfloop query="AllUsedSciNames">
	<cfset oneLine="#chr(10)#------------------------------------------------#chr(10)#linkid: #i##chr(10)#query: #scientific_name# [name]#chr(10)#base: &base.url;#chr(10)#rule: full_taxon_name=#scientific_name##chr(10)#name: #scientific_name# taxonomy">
		<cfset i=#i#+1>
		<cffile action="append" file="#Application.webDirectory#/temp/names.ft" addnewline="no" output="#oneLine#">
</cfloop>
<!----
<cfquery name="uamsp2" datasource="#Application.web_user#">
	select 
		distinct(scientific_name) from taxonomy
		genus, 
		species, 
		subspecies, 
		a.collection_object_id, 
		cat_num 
	FROM 
		cataloged_item a, 
		identification_taxonomy b, 
		taxonomy e,
		identification c, 
		coll_obj_other_id_num d 
	WHERE 
		a.collection_object_id = c.collection_object_id AND 
		c.accepted_id_fg=1 AND 
		c.identification_id=b.identification_id AND 
		b.taxon_name_id=e.taxon_name_id AND 
		a.collection_object_id = d.collection_object_id AND 
		d.other_id_type='GenBank sequence accession'
</cfquery>
<cfset header="------------------------------------------------#chr(10)#prid: 5299#chr(10)#dbase: Taxonomy#chr(10)#!base.url: http://arctos.database.museum/TaxonomyResults.cfm?">
<cffile action="write" file="/var/www/html/temp/uamsp2.ft" addnewline="no" output="#header#">
<cfset i=1>
<cfloop query="uam2">
	<cfset oneLine="#chr(10)#------------------------------------------------#chr(10)#linkid: #i##chr(10)#query: #scientific_name# [name]#chr(10)#base: &base.url;#chr(10)#rule: full_taxon_name=#scientific_name##chr(10)#name: search UAM: #scientific_name#">
		<cfset i=#i#+1>
		<cffile action="append" file="/var/www/html/temp/uamsp2.ft" addnewline="no" output="#oneLine#">
</cfloop>
<cfquery name="uamsp3" datasource="#Application.web_user#">
	select 
		scientific_name 
	FROM 
		cataloged_item a, 
		identification c, 
		coll_obj_other_id_num d 
	WHERE 
		a.collection_object_id = c.collection_object_id AND 
		a.collection_object_id = d.collection_object_id AND 
		c.accepted_id_fg=1 AND 
		d.other_id_type='GenBank sequence accession'
</cfquery>
<cfset header="------------------------------------------------#chr(10)#prid: 5299#chr(10)#dbase: Taxonomy#chr(10)#!base.url: http://arctos.database.museum/TaxonomyResults.cfm?">
<cffile action="write" file="/var/www/html/temp/uamsp3.ft" addnewline="no" output="#header#">
<cfset i=1>
<cfloop query="uam2">
	<cfset oneLine="#chr(10)#------------------------------------------------#chr(10)#linkid: #i##chr(10)#query: #scientific_name# [sname]#chr(10)#base: &base.url;#chr(10)#rule: full_taxon_name=#scientific_name##chr(10)#name: search UAM: #scientific_name#">
		<cfset i=#i#+1>
		<cffile action="append" file="/var/www/html/temp/uamsp3.ft" addnewline="no" output="#oneLine#">
</cfloop>


---->
<cfftp action="open" username="#Application.genBankUsername#" password="#decrypt(Application.genBankPwd,'genbank')#" server="ftp-private.ncbi.nih.gov" connection="genbank" passive="yes">
	<cfftp connection="genbank" action="changedir"  directory="holdings">
	<cfftp connection="genbank" action="putfile" localfile="#Application.webDirectory#/temp/nucleotide.ft" remotefile="nucleotide.ft" name="Put_nucleotide">
	<cfftp connection="genbank" action="putfile" localfile="#Application.webDirectory#/temp/taxonomy.ft" remotefile="taxonomy.ft" name="Put_taxonomy">
	<cfftp connection="genbank" action="putfile" localfile="#Application.webDirectory#/temp/names.ft" remotefile="names.ft" name="Put_names">
	<cfftp connection="genbank" action="close">
<!----

---->
</cfoutput>