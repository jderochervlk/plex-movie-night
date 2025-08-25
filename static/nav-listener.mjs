const details = [...document.querySelectorAll("details")];

addEventListener("click", function (e) {
  if (!details.some((f) => f.contains(e.target))) {
    details.forEach((f) => f.removeAttribute("open"));
  } else {
    details.forEach((f) =>
      !f.contains(e.target) ? f.removeAttribute("open") : ""
    );
  }
});
