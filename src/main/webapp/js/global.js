$.ajaxSetup({
	cache:false
})

function showAjaxLogo(){
	$('<img id="ajaxWait" style="z-index:10000" src="../images/ajaxWait.gif"/>').appendTo('body');
	$('#ajaxWait').position({
		of:'body',
		my:'center center',
		at:'center center'
	});
	
}

function hideAjaxLogo(){
	$('#ajaxWait').remove();
	
}