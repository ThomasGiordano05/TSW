document.addEventListener("DOMContentLoaded", () => {
    const shopBtn = document.getElementById("shop");
    const shopBlock = document.getElementById("shop-block");

    shopBtn.addEventListener("click", (e) => {
        e.preventDefault();
        e.defaultPropagation();
        shopBlock.classList.toggle("hidden");
    });
    
    document.addEventListener("click", (e) =>{
	       if(!shopBlock.classList.contains("hidden") && !shopBlock.contains(e.target)){
		        shopBlock.classList.add("hidden");
		}
	});
});
