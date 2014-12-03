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
<cfsavecontent variable="strCSV">
FrontEnd,Arctos,Specify,CollectionSpace,SoWhat
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
<cfset strCSV = Trim( strCSV ) />

<cfset strRegEx = (
"(""(?:[^""]|"""")*""|[^"",\r\n]*)" &
"(,|\r\n?|\n)?"
)/> 



<cfset objPattern = CreateObject(
"java",
"java.util.regex.Pattern"
).Compile(
JavaCast( "string", strRegEx )
)
/> 


<cfset objMatcher = objPattern.Matcher(
JavaCast( "string", strCSV )
) />
  

<cfset arrData = ArrayNew( 1 ) />


<cfset ArrayAppend( arrData, ArrayNew( 1 ) ) />



<cfloop condition="objMatcher.Find()">
 
<!--- Get the field token value. --->
<cfset REQUEST.Value = objMatcher.Group(
JavaCast( "int", 1 )
) />
 
<!--- Remove the field qualifiers (if any). --->
<cfset REQUEST.Value = REQUEST.Value.ReplaceAll(
JavaCast( "string", "^""|""$" ),
JavaCast( "string", "" )
) />
 
<!--- Unesacepe embedded qualifiers (if any). --->
<cfset REQUEST.Value = REQUEST.Value.ReplaceAll(
JavaCast( "string", "(""){2}" ),
JavaCast( "string", "$1" )
) />
 
<!--- Add the field value to the row array. --->
<cfset ArrayAppend(
arrData[ ArrayLen( arrData ) ],
REQUEST.Value
) />
 
 
<!---
Get the delimiter. If no delimiter group was matched,
this will destroy the variable in the REQUEST scope.
--->
<cfset REQUEST.Delimiter = objMatcher.Group(
JavaCast( "int", 2 )
) />
 
 
<!--- Check for delimiter. --->
<cfif StructKeyExists( REQUEST, "Delimiter" )>
 
<!---
Check to see if we need to start a new array to
hold the next row of data. We need to do this if the
delimiter we just found is NOT a field delimiter.
--->
<cfif (REQUEST.Delimiter NEQ ",")>
 
<!--- Start new row data array. --->
<cfset ArrayAppend(
arrData,
ArrayNew( 1 )
) />
 
</cfif>
 
<cfelse>
 
<!---
If there is no delimiter, then we are done parsing
the CSV file data. Break out rather than just ending
the loop to make sure we don't get any extra data.
--->
<cfbreak />
 
</cfif>
 
</cfloop>
 
 
<!--- Dump out CSV data array. --->
<cfdump
var="#arrData#"
label="CSV File Data"
/> 





<script src="/includes/sorttable.js"></script>
<!---

---->
<cfoutput>
<cfset  util = CreateObject("component","component.utilities")>

	<cfset d = csvq(csv=csv)>
<cfdump var=#d#>

<!----
<table border id="t" class="sortable">
	<tr>
		<cfloop list="#header#" delimiters="," index="h">
			<th>#h#</th>
		</cfloop>
	</tr>
	<cfloop list="#csv#" index="r" delimiters="#chr(10)#">
		<tr>
			<cfloop list="#r#" delimiters="," index="f">
				<td>#f#</td>
			</cfloop>
		</tr>
	</cfloop>
</table>

--------->
</cfoutput>


