jQuery( function($) {
	setInterval(checkRequired,500);
});
function checkRequired(){
	// REQUIREMENT: form submit button has id of formID + _submit
	// REQUIREMENT: form submit has a title
	// REQUIREMENT: required hidden fields have the same ID as their visible field, plus "_id"
	// 		so, agent + agent_id are treated as a pair (the visual clues go with agent)
	$('form').each(function(){
		var fid=this.id;
		var hasIssues=0;
		var allFormObjs = $('#' + fid).formSerialize();
		var AFA=allFormObjs.split('&');
		for (i=0;i<AFA.length;i++){
			var fp=AFA[i].split('=');
			var ffName=fp[0];
			var ffVal=fp[1];
			var ffClass=$("#" + ffName).attr('class');
			var isId=ffName.substr(ffName.length-3,3);
			if (isId=='_id') {
				var thisElem=ffName.substr(0,ffName.length-3);
			} else {
				var thisElem=ffName;
			}
			if (ffClass=='reqdClr' && ffVal==''){
				hasIssues+=1;
				

				var lbl=getLabelForId(thisElem).className='badPickLbl';

			} else {
				var lbl=getLabelForId(thisElem).className='';
			}
		}
		var sbmBtnStr=fid + "_submit";
		var sbmBtn=document.getElementById(sbmBtnStr);
		var v=sbmBtn.value;
		if (hasIssues > 0) {
			// form is NOT ready for submission
			document.getElementById(fid).setAttribute('onsubmit',"return false");
			sbmBtn.value="Not ready...";		
		} else {
			document.getElementById(fid).removeAttribute('onsubmit');
			sbmBtn.value=sbmBtn.title;	
		}
	});
}