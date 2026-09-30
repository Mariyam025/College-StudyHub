document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("registerForm");
    const message = document.getElementById("registerMessage");

    form.addEventListener("submit", function (event) {

        const name = document.getElementById("name").value.trim();
        const email = document.getElementById("email").value.trim();
        const course = document.getElementById("course").value;
        const semester = document.getElementById("semester").value;
        const password = document.getElementById("password").value;
        const confirmPassword =
            document.getElementById("confirmPassword").value;

        message.innerText = "";
        message.className = "";

        if (name.length < 3) {
            event.preventDefault();
            message.innerText = "❌ Please enter your full name.";
            message.className = "error-message";
            return;
        }

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {
            event.preventDefault();
            message.innerText = "❌ Please enter a valid email.";
            message.className = "error-message";
            return;
        }

        if (course === "") {
            event.preventDefault();
            message.innerText = "❌ Please select your course.";
            message.className = "error-message";
            return;
        }

        if (semester === "") {
            event.preventDefault();
            message.innerText = "❌ Please select your semester.";
            message.className = "error-message";
            return;
        }

        if (password.length < 6) {
            event.preventDefault();
            message.innerText =
                "❌ Password must contain at least 6 characters.";
            message.className = "error-message";
            return;
        }

        if (password !== confirmPassword) {
            event.preventDefault();
            message.innerText = "❌ Passwords do not match.";
            message.className = "error-message";
            return;
        }

        message.innerText =
            "⏳ Creating your StudyHub account...";
        message.className = "success-message";

        // Form will submit to register-process.jsp
    });

});