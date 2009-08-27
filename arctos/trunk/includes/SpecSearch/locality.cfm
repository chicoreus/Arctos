<!----
<script type="text/javascript" language="javascript">
	jQuery(document).ready(function() {
		jQuery("#geology_attribute_value").autocomplete("/ajax/tData.cfm?action=suggestGeologyAttVal", {
			width: 320,
			max: 20,
			autofill: true,
			highlight: false,
			multiple: false,
			scroll: true,
			scrollHeight: 300
		});	
	});
	</script>
	---->
<cfquery name="ctElevUnits" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select orig_elev_units from CTORIG_ELEV_UNITS
</cfquery>
<cfquery name="ContOcean" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select continent_ocean from ctContinent ORDER BY continent_ocean
</cfquery>
<cfquery name="Country" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select distinct(country) from geog_auth_rec order by country
</cfquery>
<cfquery name="IslGrp" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select island_group from ctIsland_Group order by Island_Group
</cfquery>
<cfquery name="Feature" datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select distinct(Feature) from geog_auth_rec order by Feature
</cfquery>
<cfquery name="ctgeology_attribute"  datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select attribute from geology_attribute_hierarchy group by attribute order by attribute 
</cfquery>
<cfquery name="ctgeology_attribute_val"  datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select attribute_value from geology_attribute_hierarchy group by attribute_value order by attribute_value 
</cfquery>
<cfquery name="ctlat_long_error_units"  datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select lat_long_error_units from ctlat_long_error_units group by lat_long_error_units order by lat_long_error_units 
</cfquery>
<cfquery name="ctverificationstatus"  datasource="user_login" username="#session.dbuser#" password="#decrypt(session.epw,cfid)#">
	select verificationstatus from ctverificationstatus group by verificationstatus order by verificationstatus 
</cfquery>
<cfoutput>
<table id="t_identifiers" class="ssrch">
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_geology_attribute">Geology Attribute:</span>
		</td>
		<td class="srch">
			<select name="geology_attribute" id="geology_attribute" size="1">
				<option value=""></option>
				<cfloop query="ctgeology_attribute">
					<option value="#attribute#">#attribute#</option>
				</cfloop>
			</select>		
		</td>
	</tr>			
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_geology_attribute_value">Geology Attribute Value:</span>
		</td>
		<td class="srch">
			<input type="text" name="geology_attribute_value" id="geology_attribute_value" size="50">
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_geology_hierarchies">Traverse Geology Hierarchies:</span>
		</td>
		<td class="srch">
			<select name="geology_hierarchies" id="geology_hierarchies" size="1">
				<option value="1">yes</option>
				<option value="0">no</option>
			</select>	
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_continent_ocean">Continent/Ocean:</span>
		</td>
		<td class="srch">
			<select name="continent_ocean" id="continent_ocean" size="1">
				<option value=""></option>
				<cfloop query="ContOcean"> 
					<option value="#ContOcean.continent_ocean#">#ContOcean.continent_ocean#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_country">Country:</span>
		</td>
		<td class="srch">
			<select name="country" id="country" size="1">
				<option value=""></option>
				<cfloop query="Country">
					<option value="#Country.Country#">#Country.Country#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_state_prov">State/Province:</span>
		</td>
		<td class="srch">
			<input type="text" name="state_prov" id="state_prov" size="50">
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_quad">Map Name:</span>
		</td>
		<td class="srch">
			<input type="text" name="quad" id="quad" size="50">
			<span class="infoLink" onclick="getQuadHelp();">Choose</span>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_county">County:</span>
		</td>
		<td class="srch">
			<input type="text" name="county" id="county" size="50">
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_island_group">Island Group:</span>
		</td>
		<td class="srch">
			<select name="island_group" id="island_group" size="1">
				  <option value=""></option>
				  <cfloop query="IslGrp"> 
					<option value="#IslGrp.Island_Group#">#IslGrp.Island_Group#</option>
				  </cfloop> 
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_island">Island:</span>
		</td>
		<td class="srch">
			<input type="text" name="island" id="island" size="50">
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_feature">Geographic Feature:</span>
		</td>
		<td class="srch">
			<select name="feature" id="feature" size="1">
				<option value=""></option>
				<cfloop query="Feature">
					<option value="#Feature.Feature#">#Feature.Feature#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_spec_locality">Specific&nbsp;Locality:</span>
		</td>
		<td class="srch">
			<input type="text" name="spec_locality" id="spec_locality" size="50">
			<span class="infoLink" onclick="var e=document.getElementById('spec_locality');e.value='='+e.value;">Add = for exact match</span>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="elevation">Elevation:</span>
		</td>
		<td class="srch">
			<input type="text" name="minimum_elevation" id="minimum_elevation" size="5"> - 
			<input type="text" name="maximum_elevation" id="maximum_elevation" size="5">
			<select name="orig_elev_units" id="orig_elev_units" size="1">
				<option value=""></option>
				<cfloop query="ctElevUnits">
					<option value="#ctElevUnits.orig_elev_units#">#ctElevUnits.orig_elev_units#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="_verificationstatus">Verification Status:</span>
		</td>
		<td class="srch">
			<select name="verificationstatus" id="verificationstatus" size="1">
				<option value=""></option>
				<cfloop query="ctverificationstatus">
					<option value="#ctverificationstatus.verificationstatus#">#ctverificationstatus.verificationstatus#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="max_error_distance">Maximum Uncertainty:</span>
		</td>
		<td class="srch">
			<input type="text" name="min_max_error" id="min_max_error" size="5"> - 
			<input type="text" name="max_max_error" id="max_max_error" size="5">
			<select name="max_error_units" id="max_error_units" size="1">
				<option value=""></option>
				<cfloop query="ctlat_long_error_units">
					<option value="#ctlat_long_error_units.lat_long_error_units#">#ctlat_long_error_units.lat_long_error_units#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="lbl">
			<span class="helpLink" id="bounding_box">Bounding Box:</span>
		</td>
		<td class="srch">
			<input type="text" name="nwLat" id="nwLat" size="8"
			<input type="text" name="nwlong" id="nwlong" size="8">		
			<input type="text" name="selat" id="selat" size="8">			
			<input type="text" name="selong" id="selong" size="8">
			<!----
			<cfset apiKey="ABQIAAAAO1U4FM_13uDJoVwN--7J3xRt-ckefprmtgR9Zt3ibJoGF3oycxTHoy83TEZbPAjL1PURjC9X2BvFYg"> 


	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAO1U4FM_13uDJoVwN--7J3xRt-ckefprmtgR9Zt3ibJoGF3oycxTHoy83TEZbPAjL1PURjC9X2BvFYg" type="text/javascript"></script>

---->
<cfhtmlhead text='<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAO1U4FM_13uDJoVwN--7J3xRt-ckefprmtgR9Zt3ibJoGF3oycxTHoy83TEZbPAjL1PURjC9X2BvFYg" type="text/javascript"></script>
'>

<cfhtmlhead text='<script src="http://gmaps-utility-library.googlecode.com/svn/trunk/dragzoom/release/src/dragzoom_packed.js" type="text/javascript"></script>
'>



		<!----
		---->
		<div id="map_canvas" style="width: 500px; height: 300px"></div>
		
<script language="javascript" type="text/javascript">
	
	function initializeMap() {
      console.log('i am initializeMap');
      if (GBrowserIsCompatible()) {
	      var map = new GMap2(document.getElementById("map_canvas"));
	      var center = new GLatLng(50, -148);
	      map.setCenter(center, 1);
	      map.addControl(new GSmallMapControl());
	      var boxStyleOpts = {
			opacity:.0,
	  		border:"2px solid red"
			}
			var otherOpts = {
			   overlayRemoveTime:99999999999999,  
			   buttonHTML:"select area",
			   buttonZoomingHTML:"draw rectangle",
			   buttonStartingStyle:{border: '1px solid black', padding: '2px'},
			   buttonZoomingStyle:{background: '##FF0'}    
			 };
	      var callbacks = {
	    //buttonclick:function(){console.log("Looks like you activated DragZoom!")},
	    //dragstart:function(){console.log("Started to Drag . . .");G.map.removeOverlay(zoomAreaPoly);},
	    //dragging:function(x1,y1,x2,y2){console.log("Dragging, currently x="+x2+",y="+y2)},
	    dragend:function(nw,ne,se,sw,nwpx,nepx,sepx,swpx){
	    	//console.log("Zoom! nw="+nw+";se="+se);
		    document.getElementById('nwLat').value=nw.lat();
		    document.getElementById('nwlong').value=nw.lng();
		    document.getElementById('selat').value=se.lat();
		    document.getElementById('selong').value=se.lng();
	    }
			};
			map.addControl(new DragZoomControl(boxStyleOpts, otherOpts, callbacks));	
	      
	     }
    }
	
		     initializeMap();
	
	
</script>
			
			<!----
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" width="250" colspan="2">
						
					</td>
				</tr>
				<tr>
					<td align="left" nowrap>
						<strong><em>NW Latitude:</em></strong> <input type="text" name="nwLat" id="nwLat" size="8">
						<strong><em>NW Longitude:</em></strong> <input type="text" name="nwlong" id="nwlong" size="8">						
					</td>
				</tr>
				<tr>
					<td align="left" nowrap>
						<strong><em>SE Latitude:</em></strong> <input type="text" name="selat" id="selat" size="8">
						<strong><em>SE Longitude:</em></strong> <input type="text" name="selong" id="selong" size="8">
					</td>
				</tr>
			</table>
			---->
		</td>
	</tr>	
</table>
</cfoutput>