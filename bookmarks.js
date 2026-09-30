
let bookmarks = [];


/* =========================
   LOAD BOOKMARKS
========================= */

async function loadBookmarks(){

    try{

        const response =
            await fetch("load-bookmarks.jsp");

        const data =
            await response.json();

        bookmarks = data;

        displayBookmarks();

    }
    catch(error){

        console.log(
            "Load Bookmark Error:",
            error
        );

    }

}


/* =========================
   SAVE BOOKMARK
========================= */

async function saveBookmark(
    title,
    subject,
    type,
    url
){

    if(!title || title.trim() === ""){

        alert("Bookmark title is required.");

        return;

    }


    const formData =
        new URLSearchParams();

    formData.append(
        "title",
        title
    );

    formData.append(
        "subject",
        subject || ""
    );

    formData.append(
        "type",
        type || "Note"
    );

    formData.append(
        "url",
        url || ""
    );


    try{

        const response =
            await fetch(
                "save-bookmark.jsp",
                {
                    method:"POST",

                    headers:{
                        "Content-Type":
                        "application/x-www-form-urlencoded"
                    },

                    body:formData
                }
            );


        const result =
            await response.json();


        if(result.success){

            alert(
                "Bookmark saved successfully!"
            );

            await loadBookmarks();

        }
        else{

            alert(result.message);

        }

    }
    catch(error){

        console.log(
            "Save Bookmark Error:",
            error
        );

        alert(
            "Unable to save bookmark."
        );

    }

}


/* =========================
   DELETE BOOKMARK
========================= */

async function deleteBookmark(id){

    if(
        !confirm(
            "Delete this bookmark?"
        )
    ){

        return;

    }


    try{

        const response =
            await fetch(
                "delete-bookmark.jsp?id=" + id
            );


        const result =
            await response.json();


        if(result.success){

            await loadBookmarks();

        }
        else{

            alert(result.message);

        }

    }
    catch(error){

        console.log(
            "Delete Bookmark Error:",
            error
        );

        alert(
            "Unable to delete bookmark."
        );

    }

}


/* =========================
   DISPLAY BOOKMARKS
========================= */

function displayBookmarks(){

    const container =
        document.getElementById(
            "bookmarksContainer"
        );


    if(!container){

        return;

    }


    container.innerHTML = "";


    if(bookmarks.length === 0){

        container.innerHTML = `

            <div class="empty-state">

                <h3>
                    No bookmarks yet
                </h3>

                <p>
                    Your saved study resources
                    will appear here.
                </p>

            </div>

        `;

        return;

    }


    bookmarks.forEach(bookmark => {

        const card =
            document.createElement("div");


        card.className =
            "bookmark-card";


        card.innerHTML = `

            <div class="bookmark-content">

                <span class="bookmark-type">

                    ${escapeHTML(
                        bookmark.type || "Resource"
                    )}

                </span>


                <h3>

                    ${escapeHTML(
                        bookmark.title
                    )}

                </h3>


                <p>

                    ${escapeHTML(
                        bookmark.subject || "General"
                    )}

                </p>


                ${
                    bookmark.url
                    ?
                    `
                    <a
                        href="${escapeAttribute(
                            bookmark.url
                        )}"
                        target="_blank"
                        rel="noopener noreferrer">

                        Open Resource →

                    </a>
                    `
                    :
                    ""
                }

            </div>


            <button
                type="button"
                class="delete-bookmark"
                onclick="deleteBookmark(${bookmark.id})">

                Delete

            </button>

        `;


        container.appendChild(card);

    });

}


function searchBookmarks(){

    const input =
        document.getElementById(
            "searchBookmarks"
        );


    if(!input){

        return;

    }


    const keyword =
        input.value
        .toLowerCase()
        .trim();


    document
        .querySelectorAll(".bookmark-card")
        .forEach(card => {

            const text =
                card.innerText
                .toLowerCase();

            card.style.display =
                text.includes(keyword)
                ? ""
                : "none";

        });

}



function escapeHTML(text){

    const div =
        document.createElement("div");

    div.textContent =
        text || "";

    return div.innerHTML;

}


function escapeAttribute(text){

    return String(text || "")
        .replace(/&/g,"&amp;")
        .replace(/"/g,"&quot;")
        .replace(/</g,"&lt;")
        .replace(/>/g,"&gt;");

}


/* =========================
   PAGE LOAD
========================= */

document.addEventListener(
    "DOMContentLoaded",
    function(){

        loadBookmarks();


        const search =
            document.getElementById(
                "searchBookmarks"
            );


        if(search){

            search.addEventListener(
                "input",
                searchBookmarks
            );

        }

    }
);
