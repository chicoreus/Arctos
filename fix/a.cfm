<cfinclude template="/includes/_header.cfm">
<cfhtmlhead text='<script src="http://maps.googleapis.com/maps/api/js?client=gme-museumofvertebrate1&sensor=false&libraries=places,geometry" type="text/javascript"></script>'>
<script src="/includes/jquery/jquery-autocomplete/jquery.autocomplete.pack.js" language="javascript" type="text/javascript"></script>
<script src="/includes/jquery.multiselect.min.js"></script>

<script>
/*
    jQuery("form#addFav").submit(function(event) {
        event.preventDefault();
        alert("hello");
    });
*/

jQuery(document).ready(function() {
			$("#collection_id").multiselect({
			minWidth: "500",
			height: "300"
		});
		});


</script>


<select name="collection_id" id="collection_id" size="3" multiple="multiple">
				
		<optgroup label="University of Alaska Museum (UAM)">
				<option>Archeology</option>
				<option>Bird specimens</option>
				<option>Earth Science</option>
				<option>Cryptogam specimens (ALA)</option>
				<option>Invertebrate specimens</option>
		</optgroup>
		<optgroup label="Natural History Museum of Utah (UMNH)">
				<option>Bird specimens</option>
				<option>Insect specimens</option>
				<option>Amphibian and reptile specimens</option>
				<option>Mollusc specimens</option>
		</optgroup>
</select>




