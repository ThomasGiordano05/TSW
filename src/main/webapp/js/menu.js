document.addEventListener("DOMContentLoaded", () => {
    const shopBtn = document.getElementById("shop");
    const shopBlock = document.getElementById("shop-block");

    shopBtn.addEventListener("click", (e) => {
        e.preventDefault();
        shopBlock.classList.toggle("hidden");
    });
});
