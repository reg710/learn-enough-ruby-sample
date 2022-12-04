// Menu manipulation

// Adds a toggle listener
function addToggleListener(selected_id, event_type, menu_id, toggle_class) {
  let selected_element = document.querySelector(`#${selected_id}`);
  selected_element.addEventListener(event_type, function (event) {
    event.preventDefault();
    event.stopPropagation();
    let menu = document.querySelector(`#${menu_id}`);
    menu.classList.toggle(toggle_class);
  });
}

// Add toggle listerns to listen for clicks
document.addEventListener("turbo:load", function () {
  addToggleListener("hamburger", "touchstart", "navbar-menu", "collapse");
  addToggleListener("hamburger", "click", "navbar-menu", "collapse");
  addToggleListener("account", "click", "dropdown-menu", "active");
});

// document.addEventListener("turbo:load", function() {
//     let hamburger = document.querySelector("#hamburger");
//     hamburger.addEventListener("touchstart", function(event) {
//         event.preventDefault();
//         event.stopPropagation();
//         let menu = document.querySelector("#navbar-menu");
//         menu.classList.toggle("collapse");
//     });
//     hamburger.addEventListener("click", function(event) {
//         event.preventDefault();
//         event.stopPropagation();
//         let menu = document.querySelector("#navbar-menu");
//         menu.classList.toggle("collapse");
//     });

//     let account = document.querySelector("#account");
//     account.addEventListener("click", function(event) {
//         event.preventDefault();
//         event.stopPropagation();
//         let menu = document.querySelector("#dropdown-menu")
//         menu.classList.toggle("active");
//     });
// });
