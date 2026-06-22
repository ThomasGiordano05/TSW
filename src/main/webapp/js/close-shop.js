document.addEventListener("DOMContentLoaded", () => {
    const shadow = document.querySelector(".all-shadow");
    const container = document.querySelector(".container-shop");
    const closeBtn = document.getElementById("close-shop");

    function chiudi() {
        shadow.style.display = "none";
        container.style.display = "none";
    }

    closeBtn.addEventListener("click", chiudi);

    shadow.addEventListener("click", (e) => {
        if (e.target === shadow) { 
            chiudi();
        }
    });
});