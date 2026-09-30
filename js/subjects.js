const subjects = {
    1: [
        "Soft Skills",
        "Fundamentals of Computer",
        "Mathematics",
        "C Programming",
        "Basics of Information System"
    ],

    2: [
        "Data Structure",
        "DBMS",
        "Operating System",
        "Discrete Mathematics",
        "Digital Electronics"
    ],

    3: [
        "OOP Using Java",
        "Software Engineering",
        "Computer Architecture",
        "Python Programming",
        "Accounting and Financial Management"
    ],

    4: [
        "Advanced Java",
        "Design and Analysis of Algorithms",
        "Web Design",
        "Computer Graphics",
        "Managerial Economics"
    ],

    5: [
        "Computer Networks",
        "Artificial Intelligence",
        "Cyber Law",
        "Data Analytics",
        "Software Testing"
    ],

    6: [
        "Machine Learning",
        "Multimedia Systems",
        "Software Project Management"
    ]
};


const semesterSelect = document.getElementById("semesterSelect");
const subjectsContainer = document.getElementById("subjectsContainer");


semesterSelect.addEventListener("change", function () {

    const semester = this.value;

    subjectsContainer.innerHTML = "";

    if (semester === "") {
        subjectsContainer.innerHTML = `
            <p class="select-message">
                Please select a semester to view subjects.
            </p>
        `;
        return;
    }

    const semesterSubjects = subjects[semester];

    semesterSubjects.forEach(function (subject) {

        const card = document.createElement("div");

        card.className = "subject-card";

        card.innerHTML = `
            <div class="subject-icon">📚</div>
            <h3>${subject}</h3>

            <button onclick="openNotes('${subject}')">
                View Notes
            </button>
        `;

        subjectsContainer.appendChild(card);
    });
});


function openNotes(subject) {

    localStorage.setItem("selectedSubject", subject);

    window.location.href = "notes.html";
}