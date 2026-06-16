const loginBox = document.querySelector(".login");
const registerBox = document.querySelector(".register");

document.getElementById("link_register").onclick = function(e) {
  e.preventDefault();
  loginBox.classList.add("hidden");
  registerBox.classList.remove("hidden");
}

document.getElementById("link_login").onclick = function(e) {
  e.preventDefault();
  registerBox.classList.add("hidden");
  loginBox.classList.remove("hidden");
}
