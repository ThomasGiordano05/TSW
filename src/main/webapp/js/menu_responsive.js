document.addEventListener("DOMContentLoaded", function() {
    const nv = document.getElementById('navbutton');
	const dp = document.getElementById('dropdown');
	
	if(nv && dp){
		
		nv.addEventListener('click', function(e){
			e.preventDefault();
			
			dp.classList.toggle('hidden');
		});
	}
});