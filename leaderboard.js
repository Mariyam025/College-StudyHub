// ================= CURRENT USER =================

let currentUser = JSON.parse(
    localStorage.getItem("studyHubCurrentUser")
);


// ================= DEMO STUDENTS =================

let students = JSON.parse(
    localStorage.getItem("studyHubStudents")
) || [
    {
        name: "Riya",
        xp: 1200,
        points: 1200
    },
    {
        name: "Aarav",
        xp: 850,
        points: 850
    },
    {
        name: "Karan",
        xp: 720,
        points: 720
    },
    {
        name: "Sneha",
        xp: 650,
        points: 650
    },
    {
        name: "Aditya",
        xp: 540,
        points: 540
    },
    {
        name: "Priya",
        xp: 450,
        points: 450
    }
];


// ================= PAGE LOAD =================

document.addEventListener("DOMContentLoaded", function () {

    loadMyStats();

    loadLeaderboard();

    setupDarkMode();

});


// ================= MY STATS =================

function loadMyStats() {

    if (!currentUser) {

        window.location.href = "login.html";

        return;
    }


    let xp = Number(currentUser.xp || 0);

    let points = Number(currentUser.points || 0);

    let streak = Number(currentUser.streak || 0);

    let badges = Array.isArray(currentUser.badges)
        ? currentUser.badges.length
        : Number(currentUser.badges || 0);


    document.getElementById("myXP").textContent = xp;

    document.getElementById("myPoints").textContent = points;

    document.getElementById("myStreak").textContent = streak;

    document.getElementById("myBadges").textContent = badges;


    // Avatar

    let name = currentUser.name || "Student";

    document.getElementById("userAvatar").textContent =
        name.charAt(0).toUpperCase();


    // Add current user to leaderboard

    students = students.filter(function (student) {

        return student.email !== currentUser.email;

    });


    students.push({

        name: name,

        email: currentUser.email,

        xp: xp,

        points: points

    });


    localStorage.setItem(
        "studyHubStudents",
        JSON.stringify(students)
    );

}


// ================= LEADERBOARD =================

function loadLeaderboard() {

    let filter =
        document.getElementById(
            "leaderboardFilter"
        ).value;


    let sortedStudents = [...students];


    sortedStudents.sort(function (a, b) {

        return Number(b[filter] || 0) -
               Number(a[filter] || 0);

    });


    let list =
        document.getElementById(
            "leaderboardList"
        );


    list.innerHTML = "";


    sortedStudents.forEach(function (student, index) {

        // Top 3 are already displayed above

        if (index < 3) return;


        let row =
            document.createElement("div");

        row.className = "leader-row";


        let initial =
            (student.name || "Student")
            .charAt(0)
            .toUpperCase();


        row.innerHTML = `

            <div class="row-rank">
                ${index + 1}
            </div>

            <div class="row-avatar">
                ${initial}
            </div>

            <div class="row-name">

                <strong>
                    ${student.name || "Student"}
                </strong>

                <span>
                    StudyHub Student
                </span>

            </div>

            <div class="row-xp">

                ${Number(student[filter] || 0)}
                ${filter === "xp" ? "XP" : "Points"}

            </div>

        `;


        list.appendChild(row);

    });


    updateTopThree(sortedStudents);

}


// ================= TOP 3 =================

function updateTopThree(sortedStudents) {

    let topUsers =
        document.querySelectorAll(
            ".top-user"
        );


    if (sortedStudents[0]) {

        topUsers[1].querySelector(
            ".leader-avatar"
        ).textContent =
            getInitial(sortedStudents[0].name);

        topUsers[1].querySelector(
            "h3"
        ).textContent =
            sortedStudents[0].name;

        topUsers[1].querySelector(
            "p"
        ).textContent =
            sortedStudents[0].xp + " XP";

    }


    if (sortedStudents[1]) {

        topUsers[0].querySelector(
            ".leader-avatar"
        ).textContent =
            getInitial(sortedStudents[1].name);

        topUsers[0].querySelector(
            "h3"
        ).textContent =
            sortedStudents[1].name;

        topUsers[0].querySelector(
            "p"
        ).textContent =
            sortedStudents[1].xp + " XP";

    }


    if (sortedStudents[2]) {

        topUsers[2].querySelector(
            ".leader-avatar"
        ).textContent =
            getInitial(sortedStudents[2].name);

        topUsers[2].querySelector(
            "h3"
        ).textContent =
            sortedStudents[2].name;

        topUsers[2].querySelector(
            "p"
        ).textContent =
            sortedStudents[2].xp + " XP";

    }

}


// ================= INITIAL =================

function getInitial(name) {

    return (name || "S")
        .charAt(0)
        .toUpperCase();

}


// ================= FILTER =================

document.getElementById(
    "leaderboardFilter"
).addEventListener(
    "change",
    function () {

        loadLeaderboard();

    }
);


// ================= DARK MODE =================

function setupDarkMode() {

    let darkButton =
        document.getElementById(
            "darkModeBtn"
        );


    let savedMode =
        localStorage.getItem(
            "studyHubDarkMode"
        );


    if (savedMode === "true") {

        document.body.classList.add(
            "dark-mode"
        );

        darkButton.textContent = "☀️";

    }


    darkButton.addEventListener(
        "click",
        function () {

            document.body.classList.toggle(
                "dark-mode"
            );


            let enabled =
                document.body.classList.contains(
                    "dark-mode"
                );


            localStorage.setItem(
                "studyHubDarkMode",
                enabled
            );


            darkButton.textContent =
                enabled ? "☀️" : "🌙";

        }
    );

}