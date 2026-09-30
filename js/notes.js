const selectedSubject = localStorage.getItem("selectedSubject");

const subjectTitle = document.getElementById("subjectTitle");
const notesContainer = document.getElementById("notesContainer");


// Show Subject Name
if (selectedSubject) {
    subjectTitle.textContent = selectedSubject + " - Notes";
} else {
    subjectTitle.textContent = "Study Notes";
}


// ===============================
// C PROGRAMMING
// ===============================

const cProgrammingUnits = {
    "Unit 1": "resources/notes/c-programming/unit1.html",
    "Unit 2": "resources/notes/c-programming/unit2.html",
    "Unit 3": "resources/notes/c-programming/unit3.html",
    "Unit 4": "resources/notes/c-programming/unit4.html",
    "Unit 5": "resources/notes/c-programming/unit5.html"
};


// ===============================
// SOFT SKILLS
// ===============================

const softSkillsUnits = {
    "Unit 1": "resources/notes/soft-skills/unit1.html",
    "Unit 2": "resources/notes/soft-skills/unit2.html",
    "Unit 3": "resources/notes/soft-skills/unit3.html",
    "Unit 4": "resources/notes/soft-skills/unit4.html",
    "Unit 5": "resources/notes/soft-skills/unit5.html"
};


// ===============================
// FUNDAMENTALS OF COMPUTER
// ===============================

const fundamentalsUnits = {
    "Unit 1": "resources/notes/fundamentals-of-computer/unit1.html",
    "Unit 2": "resources/notes/fundamentals-of-computer/unit2.html",
    "Unit 3": "resources/notes/fundamentals-of-computer/unit3.html",
    "Unit 4": "resources/notes/fundamentals-of-computer/unit4.html",
    "Unit 5": "resources/notes/fundamentals-of-computer/unit5.html"
};


// ===============================
// MATHEMATICS
// ===============================

const mathematicsUnits = {
    "Unit 1": "resources/notes/mathematics/unit1.html",
    "Unit 2": "resources/notes/mathematics/unit2.html",
    "Unit 3": "resources/notes/mathematics/unit3.html",
    "Unit 4": "resources/notes/mathematics/unit4.html",
    "Unit 5": "resources/notes/mathematics/unit5.html"
};


// ===============================
// BASICS OF INFORMATION SYSTEM
// ===============================

const basicsInformationSystemUnits = {
    "Unit 1": "resources/notes/basics-of-information-system/unit1.html",
    "Unit 2": "resources/notes/basics-of-information-system/unit2.html",
    "Unit 3": "resources/notes/basics-of-information-system/unit3.html",
    "Unit 4": "resources/notes/basics-of-information-system/unit4.html",
    "Unit 5": "resources/notes/basics-of-information-system/unit5.html"
};


// ===============================
// UNITS
// ===============================

const units = [
    "Unit 1",
    "Unit 2",
    "Unit 3",
    "Unit 4",
    "Unit 5"
];


// ===============================
// CREATE UNIT CARDS
// ===============================

units.forEach(function(unit) {

    const card = document.createElement("div");

    card.className = "card";


    let buttonHTML = `
        <button class="login-btn" onclick="viewUnit('${unit}')">
            View Notes
        </button>
    `;


    // C Programming
    if (selectedSubject === "C Programming") {

        buttonHTML = `
            <a href="${cProgrammingUnits[unit]}"
               class="login-btn"
               style="text-decoration:none; display:inline-block;">
                View Notes
            </a>
        `;
    }


    // Soft Skills
    else if (selectedSubject === "Soft Skills") {

        buttonHTML = `
            <a href="${softSkillsUnits[unit]}"
               class="login-btn"
               style="text-decoration:none; display:inline-block;">
                View Notes
            </a>
        `;
    }


    // Fundamentals of Computer
    else if (selectedSubject === "Fundamentals of Computer") {

        buttonHTML = `
            <a href="${fundamentalsUnits[unit]}"
               class="login-btn"
               style="text-decoration:none; display:inline-block;">
                View Notes
            </a>
        `;
    }


    // Mathematics
    else if (selectedSubject === "Mathematics") {

        buttonHTML = `
            <a href="${mathematicsUnits[unit]}"
               class="login-btn"
               style="text-decoration:none; display:inline-block;">
                View Notes
            </a>
        `;
    }


    // Basics of Information System
    else if (selectedSubject === "Basics of Information System") {

        buttonHTML = `
            <a href="${basicsInformationSystemUnits[unit]}"
               class="login-btn"
               style="text-decoration:none; display:inline-block;">
                View Notes
            </a>
        `;
    }


    // Card HTML
    card.innerHTML = `
        <div class="card-icon">📄</div>

        <h3>${unit}</h3>

        <p>
            ${selectedSubject || "Subject"} - ${unit} Notes
        </p>

        ${buttonHTML}
    `;


    notesContainer.appendChild(card);

});


// ===============================
// OTHER SUBJECTS
// ===============================

function viewUnit(unit) {

    localStorage.setItem("selectedUnit", unit);

    alert(
        "Notes for " +
        (selectedSubject || "Subject") +
        " - " +
        unit +
        " will be added soon."
    );
}