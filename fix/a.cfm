<cfinclude template="/includes/_header.cfm">
<script type='text/javascript' src='/includes/jquery/jquery-autocomplete/jquery.autocomplete.pack.js'></script>
<script type='text/javascript' src='/includes/checkForm.js'></script>


<form id="theForm">
<label for="singleBirdRemote">asvas</label>
<input type="text" name="singleBirdRemote" id="singleBirdRemote">

<input type="text" id="singleBirdRemote_id" name="singleBirdRemote_id">

<input type="submit" id="submit" value="this is submit"  title="Create Identification">
</form>

<span onclick="checkRequired()">check</span>

<script>
	//setInterval(checkRequired,500);
	
	
	/*
	function checkRequired() {
		var t=jQuery('#singleBirdRemote').val();
		var i=jQuery('#idfld').val();
		//console.log(t.length);
		//console.log(i.length);
		if(t.length>0 && i.length==0){
			jQuery('#singleBirdRemote').addClass('red');
		} else if (t.length>0 && i.length>0) {
			//console.log('remove class');
			jQuery('#singleBirdRemote').removeClass('red').adClass('goodPick');
		}
	}
jQuery("#partname").autocomplete("/ajax/agent.cfm", {
		width: 320,
		max: 20,
		autofill: true,
		highlight: false,
		multiple: false,
		scroll: true,
		scrollHeight: 300
	});
	*/
	$("#singleBirdRemote").autocomplete("/ajax/agent.cfm", {
		width: 260,
		selectFirst: false
	});
	
	
	$("#singleBirdRemote").result(function(event, data, formatted) {
		//console.log('function thingee');
		//console.log(event);
		//console.log(data);
		//console.log(formatted);
		if (data)
			//console.log('if data indeed');
			jQuery('#singleBirdRemote_id').val(data[1]);
			//jQuery(this).parent().next().find("input").val(data[1]);
	});
	
</script>