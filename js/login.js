document.getElementById("loginForm").addEventListener("submit", function(event) {

    event.preventDefault();

    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const message = document.getElementById("loginMessage");

    // Demo login
    if (username === "student" && password === "1234") {

        localStorage.setItem("loggedIn", "true");
        localStorage.setItem("studentName", "Student");

        window.location.href = "dashboard.html";

    } else {

        message.textContent = "Invalid ID or password!";
        message.style.color = "red";
    }
});