let selectedRating = 0;


/* =========================================
   PAGE LOAD
========================================= */

document.addEventListener("DOMContentLoaded", function () {

    console.log("Feedback JS Loaded");


    /* ===============================
       STAR BUTTONS
    =============================== */

    const stars =
        document.querySelectorAll("#stars button");

    stars.forEach(function (star, index) {

        star.addEventListener("click", function (event) {

            event.preventDefault();

            selectedRating = index + 1;

            updateStars();

        });

    });


    /* ===============================
       SUBMIT BUTTON
    =============================== */

    const submitButton =
        document.querySelector(".submit-btn");

    if (submitButton) {

        submitButton.addEventListener(
            "click",
            submitFeedback
        );

    }


    /* ===============================
       LOAD EXISTING FEEDBACK
    =============================== */

    loadFeedback();

});


/* =========================================
   UPDATE STARS
========================================= */

function updateStars() {

    const stars =
        document.querySelectorAll("#stars button");

    stars.forEach(function (star, index) {

        if (index < selectedRating) {

            star.style.color = "#fbbf24";

        } else {

            star.style.color = "#64748b";

        }

    });


    const ratingText =
        document.getElementById("ratingText");


    if (ratingText) {

        const messages = [
            "",
            "⭐ Poor",
            "⭐⭐ Fair",
            "⭐⭐⭐ Good",
            "⭐⭐⭐⭐ Very Good",
            "⭐⭐⭐⭐⭐ Excellent"
        ];

        ratingText.textContent =
            messages[selectedRating];

    }

}


/* =========================================
   SUBMIT FEEDBACK
========================================= */

async function submitFeedback(event) {

    if (event) {
        event.preventDefault();
    }


    const name =
        document
        .getElementById("studentName")
        .value
        .trim();


    const reviewType =
        document
        .getElementById("reviewType")
        .value;


    const message =
        document
        .getElementById("feedbackText")
        .value
        .trim();


    /* ===============================
       VALIDATION
    =============================== */

    if (name === "") {

        alert("Please enter your name.");

        return;
    }


    if (reviewType === "") {

        alert("Please select what you are reviewing.");

        return;
    }


    if (selectedRating === 0) {

        alert("Please select a rating.");

        return;
    }


    if (message === "") {

        alert("Please write your feedback.");

        return;
    }


    /* ===============================
       SEND TO JSP
    =============================== */

    const data =
        new URLSearchParams();

    data.append("name", name);
    data.append("reviewType", reviewType);
    data.append("rating", selectedRating);
    data.append("message", message);


    try {

        const response =
            await fetch(
                "/CollegeStudyHub/save-feedback.jsp",
                {
                    method: "POST",

                    credentials: "include",

                    headers: {
                        "Content-Type":
                            "application/x-www-form-urlencoded"
                    },

                    body:
                        data.toString()
                }
            );


        const result =
            await response.json();


        console.log(
            "Server Response:",
            result
        );


        if (result.success) {

            alert(
                "⭐ Feedback submitted successfully!"
            );


            /* CLEAR */

            document.getElementById(
                "studentName"
            ).value = "";


            document.getElementById(
                "reviewType"
            ).value = "";


            document.getElementById(
                "feedbackText"
            ).value = "";


            selectedRating = 0;

            updateStars();

            loadFeedback();


        } else {

            alert(
                result.message ||
                "Feedback could not be submitted."
            );

        }

    }

    catch (error) {

        console.error(
            "Feedback Error:",
            error
        );

        alert(
            "Unable to connect to server."
        );

    }

}


/* =========================================
   LOAD FEEDBACK
========================================= */

async function loadFeedback() {

    try {

        const response =
            await fetch(
                "/CollegeStudyHub/load-feedback.jsp",
                {
                    credentials: "include"
                }
            );


        const feedback =
            await response.json();


        displayFeedback(feedback);


    }

    catch (error) {

        console.error(
            "Load Feedback Error:",
            error
        );

    }

}


/* =========================================
   DISPLAY FEEDBACK
========================================= */

function displayFeedback(feedback) {

    const list =
        document.getElementById(
            "feedbackList"
        );


    const average =
        document.getElementById(
            "averageRating"
        );


    if (!list) {
        return;
    }


    list.innerHTML = "";


    if (!feedback || feedback.length === 0) {

        list.innerHTML = `
            <div class="empty-feedback">
                <h3>No feedback yet</h3>
                <p>Be the first student to share your experience.</p>
            </div>
        `;

        if (average) {
            average.textContent = "0.0";
        }

        return;
    }


    let total = 0;


    feedback.forEach(function (item) {

        const rating =
            Number(item.rating || 0);

        total += rating;


        const card =
            document.createElement("div");


        card.className =
            "feedback-item";


        card.innerHTML = `

            <div class="feedback-top">

                <div>

                    <h3>
                        ${escapeHTML(item.name)}
                    </h3>

                    <span>
                        ${escapeHTML(item.reviewType)}
                    </span>

                </div>

                <div class="feedback-stars">
                    ${"★".repeat(rating)}
                </div>

            </div>

            <p class="feedback-message">
                ${escapeHTML(item.message)}
            </p>

        `;


        list.appendChild(card);

    });


    if (average) {

        average.textContent =
            (total / feedback.length)
            .toFixed(1);

    }

}


/* =========================================
   SECURITY
========================================= */

function escapeHTML(text) {

    const div =
        document.createElement("div");

    div.textContent =
        text || "";

    return div.innerHTML;

}
