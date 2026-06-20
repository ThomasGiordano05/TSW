document.addEventListener("DOMContentLoaded", () => {
    const shadow = document.querySelector(".all-shadow");
    const container = document.querySelector(".container-shop");
    const closeBtn = document.getElementById("close-shop");

    // Funzione per chiudere
    function chiudi() {
        shadow.style.display = "none";
        container.style.display = "none";
    }

    // Chiude cliccando sulla X
    closeBtn.addEventListener("click", chiudi);

    // Chiude cliccando nello sfondo scuro
    shadow.addEventListener("click", (e) => {
        if (e.target === shadow) { // Chiude solo se clicchi fuori, non dentro il container
            chiudi();
        }
    });
});