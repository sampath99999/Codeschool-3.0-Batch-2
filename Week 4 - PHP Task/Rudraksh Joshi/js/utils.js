export function restrictAcessLogin() {
  // there is no user
  if (localStorage.getItem("token") == null) {
    Swal.fire(
      "you were logged out,please login again",
      "redirecting....",
      "warning"
    );

    setTimeout(() => {
      location.replace("../html/sign_up.html");
    }, 1500);
  }
}
export function restrictAcessSignUp() {
  // there is no user
  if (localStorage.getItem("token")) {
    Swal.fire("you are already logged in.", "redirecting....", "info");

    setTimeout(() => {
      location.replace("../html/profile.html");
    }, 1500);
  }
}

export function redirectAlert() {
  let timerInterval;
  Swal.fire({
    title: "Log in Successfull",
    html: "almost there.....",
    timer: 2000,
    timerProgressBar: true,
    didOpen: () => {
      Swal.showLoading();
    },
    willClose: () => {
      clearInterval(timerInterval);
    },
  });
}
