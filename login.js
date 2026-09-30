document.addEventListener("DOMContentLoaded", function () {

    const loginForm = document.getElementById("loginForm");

    const emailInput = document.getElementById("email");

    const passwordInput =
        document.getElementById("password");

    const message =
        document.getElementById("loginMessage");

    const togglePassword =
        document.getElementById("togglePassword");


    /* SHOW / HIDE PASSWORD */

    togglePassword.addEventListener("click", function () {

        if (passwordInput.type === "password") {

            passwordInput.type = "text";

            togglePassword.innerText = "🙈";

        } else {

            passwordInput.type = "password";

            togglePassword.innerText = "👁️";
        }

    });


    /* LOGIN */

    loginForm.addEventListener("submit", function (event) {

        event.preventDefault();

        const email =
            emailInput.value.trim().toLowerCase();

        const password =
            passwordInput.value;

        message.innerText = "";
        message.className = "";


        /* GET REGISTERED USERS */

        let users =
            JSON.parse(
                localStorage.getItem("studyHubUsers")
            ) || [];


        /* DEMO ACCOUNT IF NO USER EXISTS */

        if (users.length === 0) {

            users = [
                {
                    id: 1,
                    name: "Demo Student",
                    email: "student@studyhub.com",
                    password: "123456",
                    course: "BCA",
                    semester: "6",
                    points: 0,
                    xp: 0,
                    streak: 0,
                    badges: [],
                    bookmarks: [],
                    flashcards: [],
                    notesUploaded: 0
                }
            ];

            localStorage.setItem(
                "studyHubUsers",
                JSON.stringify(users)
            );
        }


        /* FIND USER */

        const user =
            users.find(function (item) {

                return (
                    item.email === email &&
                    item.password === password
                );

            });


        /* INVALID LOGIN */

        if (!user) {

            message.innerText =
                "❌ Invalid email or password.";

            message.className =
                "error-message";

            return;
        }


        /* SAVE LOGIN */

        localStorage.setItem(
            "studyHubCurrentUser",
            JSON.stringify(user)
        );


        /* REMEMBER ME */

        const remember =
            document.getElementById("remember").checked;

        if (remember) {

            localStorage.setItem(
                "studyHubRemember",
                "true"
            );

        } else {

            localStorage.removeItem(
                "studyHubRemember"
            );
        }


        /* SUCCESS */

        message.innerText =
            "✅ Login successful! Opening your dashboard...";

        message.className =
            "success-message";


        setTimeout(function () {

            window.location.href =
                "dashboard.html";

        }, 900);

    });

});