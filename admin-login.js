document.addEventListener("DOMContentLoaded", function () {

    const form =
        document.getElementById("adminLoginForm");

    const message =
        document.getElementById("adminMessage");


    form.addEventListener("submit", function (event) {

        event.preventDefault();


        const email =
            document.getElementById("adminEmail")
            .value.trim()
            .toLowerCase();

        const password =
            document.getElementById("adminPassword")
            .value;


        /*
         * DEMO ADMIN LOGIN
         */

        const adminEmail =
            "admin@studyhub.com";

        const adminPassword =
            "admin123";


        if (
            email === adminEmail &&
            password === adminPassword
        ) {

            const admin = {

                name: "StudyHub Admin",

                email: adminEmail,

                role: "admin",

                loginTime:
                    new Date().toISOString()

            };


            localStorage.setItem(
                "studyHubAdmin",
                JSON.stringify(admin)
            );


            message.innerText =
                "✅ Admin login successful!";

            message.className =
                "success";


            setTimeout(function () {

                window.location.href =
                    "admin-dashboard.html";

            }, 900);


        } else {

            message.innerText =
                "❌ Invalid admin credentials.";

            message.className =
                "error";

        }

    });

});