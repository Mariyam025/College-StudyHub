
document.addEventListener("DOMContentLoaded", function () {

    loadStudentData();
    loadDate();
    applyDarkMode();

});


// ================= STUDENT DATA =================

function loadStudentData() {

    // Temporary demo data
    // Login/database ko disturb nahi karega

    const user = {
        name: "Student",
        email: "student@studyhub.com",
        course: "BCA",
        semester: "6",
        points: 0,
        xp: 0
    };

    setText("studentName", user.name);
    setText("navName", user.name);
    setText("profileName", user.name);

    setText("profileEmail", user.email);
    setText("profileCourse", user.course);
    setText(
        "profileSemester",
        "Semester " + user.semester
    );

    setText("points", user.points);
    setText("xp", user.xp);
    setText("badges", 0);

    setText("quizCompleted", 0);
    setText("notesUploaded", 0);
    setText("bookmarksCount", 0);

    const firstLetter =
        user.name.charAt(0).toUpperCase();

    setText("navAvatar", firstLetter);
    setText("profileAvatar", firstLetter);

    calculateProgress(0, 0);

}


// ================= SET TEXT =================

function setText(id, value) {

    const element =
        document.getElementById(id);

    if (element) {
        element.textContent = value;
    }

}


// ================= PROGRESS =================

function calculateProgress(
    quizCompleted,
    notesUploaded
) {

    const quizProgress =
        Math.min(quizCompleted / 10, 1) * 70;

    const notesProgress =
        Math.min(notesUploaded / 5, 1) * 30;

    const progress =
        Math.min(
            Math.round(
                quizProgress + notesProgress
            ),
            100
        );

    const progressBar =
        document.getElementById("progressBar");

    if (progressBar) {
        progressBar.style.width =
            progress + "%";
    }

    const progressPercent =
        document.querySelector(".progress-percent");

    if (progressPercent) {
        progressPercent.textContent =
            progress + "%";
    }

}


// ================= DATE =================

function loadDate() {

    const today = new Date();

    setText(
        "currentDay",
        today.toLocaleDateString(
            "en-IN",
            {
                weekday: "long"
            }
        )
    );

    setText(
        "currentDate",
        today.toLocaleDateString(
            "en-IN",
            {
                day: "numeric",
                month: "long",
                year: "numeric"
            }
        )
    );

}


// ================= PROFILE MENU =================

function toggleProfileMenu() {

    const menu =
        document.getElementById("profileMenu");

    if (menu) {
        menu.classList.toggle("show");
    }

}


document.addEventListener(
    "click",
    function(event) {

        const menu =
            document.getElementById("profileMenu");

        const profile =
            document.querySelector(".profile-mini");

        if (
            menu &&
            profile &&
            !profile.contains(event.target) &&
            !menu.contains(event.target)
        ) {

            menu.classList.remove("show");

        }

    }
);


// ================= DARK MODE =================

const darkModeBtn =
    document.getElementById("darkModeBtn");


function applyDarkMode() {

    const enabled =
        localStorage.getItem(
            "studyHubDarkMode"
        ) === "true";

    if (enabled) {

        document.body.classList.add(
            "dark-mode"
        );

        if (darkModeBtn) {
            darkModeBtn.textContent = "☀️";
        }

    }

}


if (darkModeBtn) {

    darkModeBtn.addEventListener(
        "click",
        function() {

            document.body.classList.toggle(
                "dark-mode"
            );

            const enabled =
                document.body.classList.contains(
                    "dark-mode"
                );

            localStorage.setItem(
                "studyHubDarkMode",
                enabled
            );

            darkModeBtn.textContent =
                enabled ? "☀️" : "🌙";

        }
    );

}


// ================= LOGOUT =================

function logout() {

    window.location.href =
        "logout.jsp";

}
