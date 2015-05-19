<!----

create table spec_coords as select
  guid,
  locality.dec_lat,
  locality.dec_long,
  locality.s$dec_lat,
  locality.s$dec_long,
  to_meters(locality.MAX_ERROR_DISTANCE,locality.MAX_ERROR_UNITS) err_m,
  getHaversineDistance(locality.dec_lat,locality.dec_long,locality.s$dec_lat,locality.s$dec_long) s_err_km,
  to_meters(locality.MINIMUM_ELEVATION,locality.ORIG_ELEV_UNITS) min_elev_m,
  to_meters(locality.MAXIMUM_ELEVATION,locality.ORIG_ELEV_UNITS) max_elev_m,
  locality.s$elevation s_elev_m,
  geog_auth_rec.higher_geog,
  locality.S$GEOGRAPHY
from
  flat,
  specimen_event,
  collecting_event,
  locality,
  geog_auth_rec
where
  flat.collection_object_id=specimen_event.collection_object_id and
  specimen_event.collecting_event_id=collecting_event.collecting_event_id and
  collecting_event.locality_id=locality.locality_id and
  locality.geog_auth_rec_id=geog_auth_rec.geog_auth_rec_id and
  locality.dec_lat is not null;

-- nope...
drop table spec_coords


create table colln_coords as select
  count(*) numUsingSpecimens,
  guid_prefix,
  locality.dec_lat,
  locality.dec_long,
  locality.s$dec_lat,
  locality.s$dec_long,
  to_meters(locality.MAX_ERROR_DISTANCE,locality.MAX_ERROR_UNITS) err_m,
  getHaversineDistance(locality.dec_lat,locality.dec_long,locality.s$dec_lat,locality.s$dec_long) s_err_km,
  to_meters(locality.MINIMUM_ELEVATION,locality.ORIG_ELEV_UNITS) min_elev_m,
  to_meters(locality.MAXIMUM_ELEVATION,locality.ORIG_ELEV_UNITS) max_elev_m,
  locality.s$elevation s_elev_m,
  geog_auth_rec.higher_geog,
  locality.S$GEOGRAPHY
from
  cataloged_item,
  collection,
  specimen_event,
  collecting_event,
  locality,
  geog_auth_rec
where
  cataloged_item.collection_id=collection.collection_id and
  cataloged_item.collection_object_id=specimen_event.collection_object_id and
  specimen_event.collecting_event_id=collecting_event.collecting_event_id and
  collecting_event.locality_id=locality.locality_id and
  locality.geog_auth_rec_id=geog_auth_rec.geog_auth_rec_id and
  locality.dec_lat is not null
group by
  guid_prefix,
  locality.dec_lat,
  locality.dec_long,
  locality.s$dec_lat,
  locality.s$dec_long,
  to_meters(locality.MAX_ERROR_DISTANCE,locality.MAX_ERROR_UNITS),
  getHaversineDistance(locality.dec_lat,locality.dec_long,locality.s$dec_lat,locality.s$dec_long),
  to_meters(locality.MINIMUM_ELEVATION,locality.ORIG_ELEV_UNITS),
  to_meters(locality.MAXIMUM_ELEVATION,locality.ORIG_ELEV_UNITS),
  locality.s$elevation,
  geog_auth_rec.higher_geog,
  locality.S$GEOGRAPHY
;


create index ix_colln_coords_guid_prefix on colln_coords(guid_prefix) tablespace uam_idx_1;


drop table colln_coords_summary;


create table colln_coords_summary (
	guid_prefix varchar2(255),
	number_of_specimens number,
	number_of_georeferences number,
	specimens_with_georeference number,
	gref_with_calc_georeference number,
	georeferences_with_error number,
	georeferences_with_elevation number,
	calc_error_lt_1 number,
	calc_error_lt_10 number,
	calc_error_gt_10 number,
	calc_elev_fits number);



declare
	ns number;
	ng number;
	gwe number;
	gwce number;
	swg number;
	gwv number;
	el1 number;
	el10 number;
	eg10 number;
	evg number;
begin

	delete from colln_coords_summary;

	-- NOTE: In all the below, "locality" means "distinct values of stuff we're pulling from locality"
	--    and NOT anything involving locality_id

	for r in (select distinct guid_prefix from colln_coords) loop
		insert into colln_coords_summary (
			guid_prefix,
			number_of_specimens,
			number_of_georeferences,
			specimens_with_georeference,
			gref_with_calc_georeference,
			georeferences_with_error,
			georeferences_with_elevation,
			calc_error_lt_1,
			calc_error_lt_10,
			calc_error_gt_10,
			calc_elev_fits
		) values (
			r.guid_prefix,
			(
				--number_of_specimens owned by a collection
				select
					count(*)
				from
					collection,
					cataloged_item
				where
					collection.collection_id=cataloged_item.collection_id and
					collection.guid_prefix=r.guid_prefix
			),
			(
				-- number_of_georeferences - number of localities used by a collection
				select
					count(*)
				from
					colln_coords
				where
					dec_lat is not null and
					guid_prefix=r.guid_prefix
			),
			(
				-- specimens_with_georeference - number of specimens with at least one georeference
				select
					sum(numUsingSpecimens)
				from
					colln_coords
				where
					dec_lat is not null and
					guid_prefix=r.guid_prefix
			),
			(
				--gref_with_calc_georeference - number of localities with both asserted and calculated georeferences
				select count(*) from colln_coords where
					guid_prefix=r.guid_prefix and
					S_ERR_KM is not null -- this will be NULL if either asserted or calculated is MIA
			),
			(
				--georeferences_with_error - number of localities which have asserted georeferences and asserted error
				select
					count(*)
				from
					colln_coords
				where
					err_m is not null and
					guid_prefix=r.guid_prefix
			),
			(
				-- georeferences_with_elevation - number of localities with a curatorial assertion of elevation
				select count(*)
					from colln_coords where min_elev_m is not null and
					guid_prefix=r.guid_prefix
			),
			(
				--calc_error_lt_1 - number of localities with a difference between asserted and calculated points of <1KM
				select count(*) from colln_coords where
					s_err_km is not null and
					getHaversineDistance(dec_lat,dec_long,s$dec_lat,s$dec_long)<1 and
					guid_prefix=r.guid_prefix
			),
			(
				--calc_error_lt_10 - number of localities with a difference between asserted and calculated points between 1 and 10 KM
				select
					count(*)
				from
					colln_coords
				where
					s_err_km is not null and
					getHaversineDistance(dec_lat,dec_long,s$dec_lat,s$dec_long) between 1 and 10 and
					guid_prefix=r.guid_prefix
			),
			(
				--calc_error_gt_10 - number of localities with a difference between asserted and calculated points above 10 KM
				select
					count(*)
				from
					colln_coords
				where
					s_err_km is not null and
					getHaversineDistance(dec_lat,dec_long,s$dec_lat,s$dec_long)>10 and
					guid_prefix=r.guid_prefix
			),
			(
				--calc_elev_fits -  number of localities where calculated elevation is between asserted
				select
					count(*)
				from
					colln_coords
				where
					s_elev_m between min_elev_m and max_elev_m and
					guid_prefix=r.guid_prefix
			)
		);
	end loop;
end;
/

-- just for test

create or replace public synonym colln_coords_summary for colln_coords_summary;
grant select on colln_coords_summary to public;


create or replace public synonym colln_coords for colln_coords;
grant select on colln_coords to public;


		<th>Colln</th>
		<th>##Spec</th>
		<th>##HasGeoref</th>
		<th>Georef/Specm</th>
		<th>##GeoreferencesWithoutError</th>
		<th>##GeoreferencesWithElevation</th>



---->


<cfinclude template="/includes/_header.cfm">
<script src="/includes/sorttable.js"></script>
<cfset title="Arctos Georeference Summary">
<style>
th.rotate {
  /* Something you can count on */
  height: 140px;
  white-space: nowrap;
}

th.rotate > div {
  transform:
    /* Magic Numbers */
    translate(25px, 51px)
    /* 45 is really 360 - 45 */
    rotate(315deg);
  width: 30px;
}
th.rotate > div > span {
  border-bottom: 1px solid #ccc;
  padding: 5px 10px;
}

table.sortable tbody tr:nth-child(2n) td {
  background: #ffcccc;
}
table.sortable tbody tr:nth-child(2n+1) td {
  background: #ccfffff;
}


</style>


<h3>Caveats</h3>

<ul>
<li>This is a cached report and overview. It's not necessarily current or correct. Contact a DBA for an update.</li>
<li>Understanding http://arctosdb.org/documentation/places/specimen-event/ is important. Any specimen may have any number of localities, any
of which may be georeferenced.</li>
<li>It is important to understand the history of a collection in context of Arctos before drawing conclusions from these data. In part:
	<ul>
		<li>Some collections have many "unaccepted" georeferences because an
			old Arctos model allowed only one "accepted" coordinate determination.</li>
		<li>Some collections have many georeferences because of curatorial practices and discipline-specific data. </li>
		<li>Some collections were imported from systems with limited capabilities.</li>
		<li>Some collections where digitized photographically.</li>
	</ul>
 </li>
<li>We employ Google's services to obtain independent spatial and descriptive data. GIGO applies; collections which employ precise geography
and "good" interpretations of verbatim locality into specific locality will have more accurate calculated data
than those collections which employ more general geography or more verbatim specific localities.</li>
</ul>
<cfoutput>


<cfset tke=queryNew("ord,col,hdr,expn")>
<cfset thisRow=1>

<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "guid_prefix", thisRow)>
<cfset QuerySetCell(tke, "hdr", "Collection", thisRow)>
<cfset QuerySetCell(tke, "expn", "Collection", thisRow)>
<cfset thisRow=thisRow+1>

<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "number_of_specimens", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##Specimen", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of specimens held by the collection.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "number_of_georeferences", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##Georef", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences among the collection's specimens.", thisRow)>
<cfset thisRow=thisRow+1>



<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "georeferences_per_specimen", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##GeorefPerSpecimen", thisRow)>
<cfset QuerySetCell(tke, "expn", "##Georef/##Specimen. No indication of distribution is implied. (Rounded 2 places.)", thisRow)>
<cfset thisRow=thisRow+1>



<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "specimens_with_georeference", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##SpecimensWithGeoref", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of specimens with at least one georeference.", thisRow)>
<cfset thisRow=thisRow+1>









<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_spec_geod", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%SpecGeorefd", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of specimens with at least one georeference.", thisRow)>
<cfset thisRow=thisRow+1>






<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "georeferences_with_error", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##GeorefWithErr", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences containing a curatorial assertion of error. 0 (zero) is considerered legacy data synonymous with NULL, not infinitely precise.", thisRow)>
<cfset thisRow=thisRow+1>





<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_geo_w_err", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%GeorefWithErr", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences containing an assertion of error. 0 (zero) is considerered legacy data synonymous with NULL, not infinitely precise.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "gref_with_calc_georeference", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##GeorefWCal", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences also containing a service-derived assertion of error.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_gr_w_c_err", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%GeorefWCal", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences also containing a service-derived assertion of error.", thisRow)>
<cfset thisRow=thisRow+1>







<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "georeferences_with_elevation", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##GeorefWithElev", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences including a curatorial assertion of elevation.", thisRow)>
<cfset thisRow=thisRow+1>

<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_geo_w_elev", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%GeorefWithElev", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences containing an assertion of elevation.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "calc_error_lt_1", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##Err<1", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are within one kilometer of each other.", thisRow)>
<cfset thisRow=thisRow+1>

<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_err_lt_1", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%Err<1", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are within one kilometer of each other.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "calc_error_lt_10", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##Err<10", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are more than one and less than ten kilometers from each other.", thisRow)>
<cfset thisRow=thisRow+1>


<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_err_lt_10", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%Err<10", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are more than one and less than ten kilometers from each other.", thisRow)>
<cfset thisRow=thisRow+1>



<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "calc_error_gt_10", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##Err>10", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are more than ten kilometers from each other.", thisRow)>
<cfset thisRow=thisRow+1>



<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_err_gt_10", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%Err>10", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences in which the asserted point (not considering error) and the calculated point (from various webservice queries) are more than ten kilometers from each other.", thisRow)>
<cfset thisRow=thisRow+1>




<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "calc_elev_fits", thisRow)>
<cfset QuerySetCell(tke, "hdr", "##ElevWithin", thisRow)>
<cfset QuerySetCell(tke, "expn", "Number of georeferences in which the calculated elevation (from various webservice queries) falls within the user-specified elevation range.", thisRow)>
<cfset thisRow=thisRow+1>



<cfset queryAddRow(tke,1)>
<cfset QuerySetCell(tke, "ord", thisRow, thisRow)>
<cfset QuerySetCell(tke, "col", "pct_elev_fits", thisRow)>
<cfset QuerySetCell(tke, "hdr", "%ElevWithin", thisRow)>
<cfset QuerySetCell(tke, "expn", "Percentage of georeferences in which the calculated elevation (from various webservice queries) falls within the user-specified elevation range.", thisRow)>
<cfset thisRow=thisRow+1>





<cfquery name="meta" dbtype="query">
	select * from tke order by ord
</cfquery>


<h3>Column Explanations</h3>
<table border>
	<tr>
		<th>Column</th>
		<th>Explanation</th>
	</tr>
	<cfloop query="meta">
		<tr>
			<td>#hdr#</td>
			<td>#expn#</td>
		</tr>
	</cfloop>
</table>


<cfquery name="cs" datasource="uam_god" >
	select
		guid_prefix,
		number_of_specimens,
		number_of_georeferences,
		round(number_of_georeferences/number_of_specimens,2) georeferences_per_specimen,
		specimens_with_georeference,
		decode(number_of_specimens,0,0,round(specimens_with_georeference/number_of_specimens,2)*100) pct_spec_geod,
		georeferences_with_error,
		decode(number_of_georeferences,0,0,round(georeferences_with_error/number_of_georeferences,2)*100) pct_geo_w_err,
		georeferences_with_elevation,
		decode(number_of_georeferences,0,0,round(georeferences_with_elevation/number_of_georeferences,2)*100) pct_geo_w_elev,
		calc_error_lt_1,
		decode(georeferences_with_error,0,0,round(calc_error_lt_1/georeferences_with_error,2)*100) pct_err_lt_1,
		calc_error_lt_10,
		decode(georeferences_with_error,0,0,round(calc_error_lt_10/georeferences_with_error,2)*100) pct_err_lt_10,
		calc_error_gt_10,
		decode(georeferences_with_error,0,0,round(calc_error_gt_10/georeferences_with_error,2)*100) pct_err_gt_10,
		calc_elev_fits,
		decode(georeferences_with_elevation,0,0,round(calc_elev_fits/georeferences_with_elevation,2)*100) pct_elev_fits,
		gref_with_calc_georeference,
		decode(georeferences_with_error,0,0,round(gref_with_calc_georeference/georeferences_with_error,2)*100) pct_gr_w_c_err
	from
		colln_coords_summary
</cfquery>
<h3>Summary Data</h3>
<p>Click headers to sort. Mouseover headers to view explanation.</p>
<table border id="t" class="sortable">
	<tr>
		<cfloop query="meta">
			<th title="#expn#">#hdr#</th>
		</cfloop>
	</tr>
	<cfloop query="cs">
		<tr title="#guid_prefix#">
			<cfloop query="meta">
				<td>#evaluate("cs." & col)#</td>
			</cfloop>
		</tr>
	</cfloop>
</table>



<!-----


<cfquery name="collns" datasource="uam_god" cachedwithin="#createtimespan(0,0,60,0)#">
	select
		guid_prefix,
		count(*) specimencount
	from
		collection,
		cataloged_item
	where
		collection.collection_id=cataloged_item.collection_id
	group by guid_prefix order by guid_prefix
</cfquery>
<cfoutput>
<table border id="t" class="sortable">
	<tr>
		<th>Colln</th>
		<th>##Spec</th>
		<th>##HasGeoref</th>
		<th>Georef/Specm</th>
		<th>##GeoreferencesWithoutError</th>
		<th>##GeoreferencesWithElevation</th>
	</tr>
	<cfloop query="#collns#">
		<cfquery name="thiscoln" datasource="uam_god" cachedwithin="#createtimespan(0,0,60,0)#">
			select * from colln_coords where guid_prefix='#guid_prefix#'
		</cfquery>



		<tr>
			<td>#guid_prefix#</td>
			<td>#specimencount#</td>
			<cfquery name="geoDet" dbtype="query">
				select sum(numUsingSpecimens) as numgeorefs from thiscoln
			</cfquery>
			<cfif len(geoDet.numgeorefs) is 0>
				<cfset ngr=0>
			<cfelse>
				<cfset ngr=geoDet.numgeorefs>
			</cfif>
			<cfset grps=ngr/specimencount>
			<td>#geoDet.numgeorefs#</td>
			<td>#grps#</td>
			<cfquery name="noerr" dbtype="query">
				select count(*) c from thiscoln where (err_m=0 or err_m is null)
			</cfquery>
			<td>#noerr.c#</td>
			<cfquery name="haselev" dbtype="query">
				select count(*) c from thiscoln where min_elev_m is not null
			</cfquery>
			<td>#haselev.c#</td>

		</tr>
	</cfloop>
</table>

----->
</cfoutput>

<cfinclude template="/includes/_footer.cfm">
