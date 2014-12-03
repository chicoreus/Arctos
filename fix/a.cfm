<cfinclude template="/includes/_header.cfm">
<!---------------------









!!!!!!!!!!!!!!!! CUIDADO!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!DO NOT EDIT THIS FILE!!!!!!!!!!!!!!!!

use instead 

https://docs.google.com/spreadsheet/ccc?key=0AtA8jKNH8nVLdFVTY1E3cENlLTB0ZDVRZ0s4QzZtclE&authkey=CNWr24kB&hl=en#gid=0



save as CSV, copypasta in below

!!!!!!!!!!!!!!!! CUIDADO!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!DO NOT EDIT THIS FILE!!!!!!!!!!!!!!!!









---------------------------->

<!--- CSV header ONLY goes here ---->
<cfsavecontent variable="header">
</cfsavecontent>
<!--- CSV, minus header, goes here ---->
<cfsavecontent variable="csv">
Front End ,Arctos ,Specify ,CollectionSpace,So what?
Back End ,Oracle is an enterprise-class RDBMS known for its concurrency management and stability. ,MySQL is a lightweight open-source RDBMS designed for fast query access. Not designed for archival usage. Limited concurrency management. ,postgres,Oracle is bulletproof and comes with a formalized support community. MySQL is a popular open-source package with many known vulnerabilities
Batch edits ,Most data; many access points ,None ,in dev,"Most everything in Arctos can be done to multiple specimens concurrently, in ways that reflect handling practices."
Bulk Import ,No practical record limit. ,2000-row limit. ,in development,Anything from a collector's data file to an entire collection from a legacy database may be imported into Arctos.
Business Model ,Short-term NSF and institutional support. ,Short-term NSF and institutional support. ,,
Business Rules ,"In DB, where they're always enforced. ","In application layer, where they may be bypassed (by DB updates, add-on applications, or Application bugs) ",application layer,"This problematic and untrustworthy arrangement in Arctos's direct ancestor largely influenced Arctos's advanced model. Any activity that bypasses the application layer - like a simple SQL update - also bypasses all business rules that reside in the application layer, ultimately resulting in corrupt data."
Cost ,"Software freely available to noncommercial enterprises. Hosting, development, and administrative costs are shared and negotiable. ","Free software, requires hardware, someone to maintain it, a defensible backup strategy, and network access. ",billed to collection (ca. 100K/year preliminary),"Free software does not equate to free, or even affordable, implementation and maintenance, nor does it ensure the security of the public data with which you've been entrusted."
Cultural Collections,Included,none ,none,"Arctos' deep normalization made plugging cultural collections an easy task. Search by cultural descriptions, or the taxonomy of the ""material"" used in manufacture. "
Customizations ,User-customizable search and results. Collection-specific appearance and CSS. ,Operator customizable search and results. ,,Arctos users can control how they search for and present data. Collections can customize the look and feel of Arctos through their Virtual Private Database portal.
Data Exploration,"Dynamic data-based expansion or contraction of search results; filter by map, add or remove search terms, add or remove results columns. Also find specimens linked from Media, Taxonomy, Projects, Publications, Places, GenBank, Google, etc.",search field/get fields back.,,"Arctos data are tightly linked and deeply integrated with each other and related Internet resources, and those connections are represented in the forms."
Data Model ,"Highly normalized; easily ""pluggable"" and expandable. 83 tables, 836 columns. ","Denormalized. 143 tables, 2400 columns (1 May 2009) ",,"Normalized structures provide for higher-quality (=more searchable) data, allow much greater flexibility, make future data manipulations and migrations much more trustworthy, and allow us to very easily ""plug in"" external resources, such as TACC, GenBank, and BOLD. "
Data Quality ,Defined and enforced by the Arctos community. ,Left to individual operators. ,,"Arctos is a community, and we do strive to do things ""the right way."" That sometimes requires collections to reconsider their standards and procedures. We've had no unresolveable differences, and we present a strong community front that influences standards for organizations such as GBIF."
Description ,"Enterprise software, hardware, backups (one in Fairbanks, one in Austin, one in San Diego), professional systems administration. ","Specify is software. User responsible for hardware setup, sysadmin, backups, etc. ",CSpace is software.,"Arctos just works, and your data are safe. Arctos is a centralized system, in which an IT staff maintains the firewall, watches for intrusions, organizes and tests backup strategies, patches software, maintains hardware, and deals with all the other complexities of maintaining a system. We have security specialists, database administrators, systems administrators, and developers watching all aspects of Arctos for potential performance and security issues."
Development Model ,"Release early, release often. Let users intimately guide every aspect of progress. Formalized issue tracking, Steering Committee, Advisory Committee. ",Release infrequently. May consider user input from the Specify Forum. ,monthly release (annual full release),"Arctos is 100% built in close cooperation with actual users. The development team's primary job is to generalize the specific needs of the users so that all Arctos participants can benefit from seemingly unrelated projects. For example, funding to link MVZ's bird call library to specimens resulted in developments that also allow us to serve bat calls, herbarium sheet images, historic field photographs, and videos of modern collecting activities."
DiGIR/IPT ,Integral and automatic.,Coming soon? Manually maintained cache. ,none,"Arctos has always been at the forefront of online communications, and we intend to stay there, influencing and inspiring the larger community."
Front End ,"ColdFusion (system works under PHP, Java, et al.) ",Java (including business rules) ,,"While ColdFusion is our heavy lifter, our back end, security, and data model architecture allows us to confidently interact with data through any sort of plugin, written in any language, including command-line SQL."
GenBank,Reciprocal relationships; automated discovery of uncited GenBank specimens,none ,none,"Arctos data are tightly linked and deeply integrated with each other and related Internet resources. Records submitted to Arctos form links to GenBank, and notify GenBank which links back. Arctos records properly submitted to GenBank automatically link to Arctos. Records in GenBank but not Arctos are automatically detected and Curators are notified."
Identifiers,"GUID, URL, DOIs",none ,none,"Arctos assigns each specimen a ""DWC GUID,"" which is in turn used to construct a ""permanent"" URL (the ""real GUID""). Arctos can provide DataCite DOIs for longer-term (post-HTTP) permanence."
Interfaces ,Intuitive customizable web applications. ,Roll your own queries against tables. ,,"Arctos presents data in the context of specimens, projects, publications, and other intuitive ""nodes."""
Living Collections ,No apparent obstacles.,Possible future development if the community wants to develop a separate schema. ,,"Thusfar, our normalized model has allowed the seamless addition of many collection types. Paleontology required one additional table, an easy addition thanks again to our normalized schema. We see no obstacles to adding living collections."
Locality Model,"Any specimen may have any number of normalized ""locality stacks."" Select parts of ""locality stacks"" may be shared.",flat,flat,"Cultural items may have several places of manufacture, use, and collection. Biopsied animals have events of birth, sampling, and death. Hosts and parasites may share everything except collecting method. Arctos is normalized to accurately reflect all of those relationships and more."
Mapping ,"BerkeleyMapper, Google Maps (Business), Google Earth, download KML. Coordinates are represented spatially, everything. Automated reverse georeference checks, one-click georeferencing. Uncertainty represented as error circles. ",Point mapping via downloadable KML ,,"Much of the value of geospatial data attached to specimens is in its error estimates. Arctos faithfully represents those data in many customizable formats. We pioneered communication with BerkeleyMapper, and are leading the way in adding rangemaps to BerkeleyMapper's capabilities. Arctos calls Google reverse georeference services, and will notify appropriate personnell when predicted and asserted georeferences do not match (commonly attributable to coordinate sign omission in transcribed data). Specimens may be located by choosing areas on maps (including or expluding error). Most forms which contain coordinates also contain inline maps."
Media ,"Any file or application, related to any data ""node."" Stored anywhere on Internet, or uploaded (multi-petabyte storage capability). Images, sound files, documents, movies. TAGs to relate specific areas of images (optionally paginated as documents) to specimens, agents, events.",Stored on local filesystem or MorphBank. Relate to?????? ,,"Arctos deals elegantly with everything from images of herbarium sheets to historic photographs of collecting events to bird call observations, and allows users to store Media anywhere in any format. It's all online - give it a try!"
Notifications,"Automated notifications of loans due, permits expiring, unprocessed accessions, potential specimen relationships.",none ,none,"Arctos uniquely provides tools as services well beyond the traditional ""specimen database."" Notifications are automatically sent then a potentially-related specimen is detected (which is turn serve as a check on the validity of the original relationship), before (and after) permits expire, when loans are becoming (and past) due, and when accessioned material has not yet been cataloged. "
Object Tracking /Barcodes,"Individual Specimen Parts are tracked and loaned. Hundreds of ""barcode friendly"" applicatons to split lots, catalog ""duplicates,"" find specimens, move objects, etc.",Cataloged Items are tracked and loaned. ,cataloged items,"Contrary to traditional models, ""cataloged items"" are nothing but abstract assemblages of parts. Parts (which can be anything from a whole animal to an organ subsample) are the traceable atomic entity, and tracking them allows us to deal with the realities of loans, storage, and mislabeling at the most appropriate level. Barcodes may also be used to track things like unprocessed but accessioned material, and trigger email notifications when certain events occur (e.g., a ""bare accession"" notification is sent a year after an accession is scanned into a processing location if no material has been cataloged from that accession.) "
Online Access ,Integral ,Coming soon? Limited to query only? Limited data available? ,i can't get there,"Arctos is and always has been online, where we continue to lead the way in communication between related databases, such as GenBank."
Permissions ,"In DB, where they're always enforced. May be used to define Virtual Private Databases. ",In application layer. ,application layer,Any activity that bypasses the application layer - like a simple SQL update - also bypasses all permissions that reside in the application layer. MySQL provides limited user partitioning. Orace provides operation by user at row in table permissions.
Publications/Citations ,Inherent ,Unclear ,,"Arctos has a commitment to allowing museums to prominently demonstrate their inherent value through usage. Loans, Borrows, Accessions, Publications, Citations, and Projects allow us to demonstrate any level of specimen acquisition and usage, from well-cited formal publications to graduate projects to elementary school classroom projects. Many reports to detect unreported citations, undocumented specmen usage are included in Arctos."
Saved queries ,"Save, name, email dynamic queries of several types",Save static results sets. Email to agents with email addresses. ,,"Arctos users can easily bookmark and return to specific, dynamic data sets."
Security ,Independent layers in application and DB. Professionally managed and audited. ,"In application layer, determined by system administrator. ",application layer,"Application-level security is notoriously difficult to secure, particularly when implemented over a ""soft"" environment, such as MySQL. Arctos runs an Enterprise-class front end over a hardened, Enterprise-class backend. No security threat has ever penetrated either layer."
Shared Data/Cross-Collection Query,"Data are shared or ""siloed"" as appropriate. Taxon names are fully shared, while classifications may be shared or excllusive to a collection.",none ,none,"""Everything from Minnesota"" or ""all specimens collected by AGENT"" are possible (and common) queries in Arctos. Arctos exploits shared data to provide cross-collection queries - ""tapeworms of Canids,"" for example. In addition to query, shared data may be pulled for cataloging - a parasite can pull collectors and locality information from a host (making cataloging only a matter of entering individual-specific data), for example."
System Requirements ,Reasonably modern browser and Internet access ,Lowest common denominator ,,"While Specify may be capable of running on consumer-grade hardware, we would suggest that Museums' commitment to data preservation should preclude such activity."
Taxon-specific attributes ,"User-definable, infinitely expandable determinations. Allows adding any biological collection. ",Predefined assertions. ,,"This is really an extension of normalization. Specify's schema is full of fields called ""Number42"" or ""Text12,"" which are labeled at the interface level and used for flexibility and operator customization. These are easy to program, and work reasonably well if one can reliably predict just how many and what types of data will show up. We find that an impossible task, and have normalized such structures. Arctos data are clearly labeled (I would hate to be the programmer who figures out that ""Number42"" has been used to multiple types of values over the years, a fact only recorded in one particular application!) and infinitely expandable. We can record any number of determinations (even of the same attribute - e.g., age based on cementum layers from various teeth or by various labs), along with date, determiner, and method."
Taxonomy ,"Formal separation of taxonomy and determinations. Accommodates composite taxonomy (hybrids, multiple taxa in one object) through identification formulae. Taxonomy pulled from GlobalNames.org",Determinations treated as taxonomy. ,lists (authority),"More than a matter of formality, this allows us to describe complex relationships among and between taxonomy (e.g., multi-generational hybrids are well within our capacities), and to be as precise or as imprecise as the data allow. It also gives us the opportunity to utilize external taxonomic resources, primarily GlobalNames.org, which provides for searchability (e.g., Neotoma-->Muridae) simultaneous with curatorial assertions (e.g., Neotoma-->Cricetidae)."
</cfsavecontent>

<cfdump var=#csv#>


<cfset  util = CreateObject("component","component.utilities")>
	<cfset d = util.CSVToQuery(CSV=#csv#)>
	
	<cfdump var=#d#>
	
	<!-------
	<cffile action = "write"
			
			
<cffunction name="CSVToQuery" access="public" returntype="query" output="false" hint="Converts the given CSV string to a query.">
		<!--- from http://www.bennadel.com/blog/501-parsing-csv-values-in-to-a-coldfusion-query.htm ---->
		<cfargument name="CSV" type="string" required="true" hint="This is the CSV string that will be manipulated."/>
 		<cfargument name="Delimiter" type="string" required="false" default="," hint="This is the delimiter that will separate the fields within the CSV value."/>
 		<cfargument name="Qualifier" type="string" required="false" default="""" hint="This is the qualifier that will wrap around fields that have special characters embeded."/>
 		<cfargument name="FirstRowIsHeadings" type="boolean" required="false" default="true" hint="Set to false if the heading row is absent"/>
	
	
	
<script src="/includes/sorttable.js"></script>

<table border id="t" class="sortable">

<style>
	.table {display:table;width:100%}
	.tr {display:table-row}
	.td {display:table-cell;border:1px solid black;margin:1em;}
	.institutiongroup {border:1px dotted green;}
	.institutionheader {border:1px dotted purple;}
	.collectionrow {border:1px dotted purple;margin-left:3em;}
	.70%{width:70%;}
</style>

<div class="institutiongroup">
	<div class="institutionheader">
		inst
	</div>
	<div class="collectionrow">
		<div class="table">
			<div class="tr">
				<div class="td 70%">
					<div>stuff</div>
					<div>nextrow</div>
				</div>
				<div class="td">
					another cell
				</div>
					
			</div>
		</div>
	</div>
</div>
---->
<!---------------



<div style="display:table">
				<div style="display:table-row">
					<div style="display:table-cell">
						<div style="display:table">
							<div style="display:table-row">
								<div style="display:table-cell">
									descrn
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="display:table-row">
					
				</div>
			</div>
		</div>
		
		
		
		--------->
		
		
		
<hr>


<cfhtmlhead text='<script src="http://maps.googleapis.com/maps/api/js?client=gme-museumofvertebrate1&sensor=false&libraries=places,geometry" type="text/javascript"></script>'>
<script src="/includes/jquery/jquery-autocomplete/jquery.autocomplete.pack.js" language="javascript" type="text/javascript"></script>
<script src="/includes/jquery.multiselect.min.js"></script>


<link rel="stylesheet" href="/includes/jquery.multiselect.css" />


<script>

jQuery(document).ready(function() {
			$("#collection_id").multiselect({
			minWidth: "500",
			height: "300"
		});
		});


</script>


<select name="collection_id" id="collection_id" size="3" multiple="multiple">
		<optgroup label="Natural History Museum of Utah (UMNH)">
				<option>Amphibian and reptile specimens</option>
				<option>Bird specimens</option>
				<option>Insect specimens</option>
				<option>Mollusc specimens</option>
		</optgroup>	
		<optgroup label="Museum of Vertebrate Zoology (MVZ), University of California-Berkeley">
				<option>Amphibian and reptile observations</option
				<option>Anatomical preparations</option>
				<option>Bird eggs/nests</option>
				<option>Bird observations</option>
				<option>Bird specimens</option>
				<option>Mammal specimens</option>>
		</optgroup>	
		<optgroup label="University of Alaska Museum (UAM)">
				<option>Archeology</option>
				<option>Bird specimens</option>
				<option>Cryptogam specimens (ALA)</option>
				<option>Earth Science</option>
				<option>Invertebrate specimens</option>
		</optgroup>

</select>




