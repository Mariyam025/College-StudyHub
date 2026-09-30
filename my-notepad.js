
let notes = [];

let editingId = null;


/* =========================
   LOAD NOTES FROM DATABASE
========================= */

async function loadNotes(){

    try{

        const response =
            await fetch("load-notes.jsp");

        const data =
            await response.json();

        notes = data;

        displayNotes();

    }
    catch(error){

        console.log(
            "Load Notes Error:",
            error
        );

    }

}


/* =========================
   SAVE NOTE
========================= */

async function saveNote(){

    const title =
        document.getElementById("noteTitle").value.trim();

    const subject =
        document.getElementById("noteSubject").value;

    const content =
        document.getElementById("noteContent").value;

    const color =
        document.getElementById("noteColor").value;


    if(title === ""){

        alert("Please enter note title");

        return;

    }


    const formData =
        new URLSearchParams();

    formData.append("title",title);
    formData.append("subject",subject);
    formData.append("content",content);
    formData.append("color",color);


    try{

        const response =
            await fetch(
                "save-note.jsp",
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

            alert("Note saved successfully!");


            clearForm();


            await loadNotes();

        }
        else{

            alert(result.message);

        }

    }
    catch(error){

        console.log(
            "Save Note Error:",
            error
        );

        alert(
            "Unable to save note"
        );

    }

}


/* =========================
   DELETE NOTE
========================= */

async function deleteNote(id){

    if(
        !confirm(
            "Are you sure you want to delete this note?"
        )
    ){

        return;

    }


    try{

        const response =
            await fetch(
                "delete-note.jsp?id=" + id
            );


        const result =
            await response.json();


        if(result.success){

            alert(
                "Note deleted successfully!"
            );


            await loadNotes();

        }
        else{

            alert(result.message);

        }

    }
    catch(error){

        console.log(
            "Delete Note Error:",
            error
        );

        alert(
            "Unable to delete note"
        );

    }

}


/* =========================
   DISPLAY NOTES
========================= */

function displayNotes(){

    const container =
        document.getElementById(
            "notesContainer"
        );


    if(!container){

        return;

    }


    container.innerHTML = "";


    if(notes.length === 0){

        container.innerHTML = `
            <div class="empty-state">
                <h3>No notes yet</h3>
                <p>Create your first personal note.</p>
            </div>
        `;

        return;

    }


    notes.forEach(note => {

        const card =
            document.createElement("div");


        card.className =
            "note-card";


        card.style.borderTop =
            "4px solid " +
            (note.color || "#a855f7");


        card.innerHTML = `

            <div class="note-header">

                <div>

                    <h3>
                        ${escapeHTML(note.title)}
                    </h3>

                    <span class="note-subject">
                        ${escapeHTML(note.subject || "General")}
                    </span>

                </div>

            </div>


            <p class="note-content">

                ${escapeHTML(note.content || "")}

            </p>


            <div class="note-footer">

                <small>
                    ${note.createdAt || ""}
                </small>


                <button
                    type="button"
                    onclick="deleteNote(${note.id})">

                    Delete

                </button>

            </div>

        `;


        container.appendChild(card);

    });

}


/* =========================
   CLEAR FORM
========================= */

function clearForm(){

    const title =
        document.getElementById("noteTitle");

    const subject =
        document.getElementById("noteSubject");

    const content =
        document.getElementById("noteContent");


    if(title){
        title.value = "";
    }

    if(subject){
        subject.value = "";
    }

    if(content){
        content.value = "";
    }

}


/* =========================
   SEARCH NOTES
========================= */

function searchNotes(){

    const searchInput =
        document.getElementById(
            "searchNotes"
        );


    if(!searchInput){

        return;

    }


    const keyword =
        searchInput.value
        .toLowerCase()
        .trim();


    const filtered =
        notes.filter(note =>

            (note.title || "")
            .toLowerCase()
            .includes(keyword)

            ||

            (note.subject || "")
            .toLowerCase()
            .includes(keyword)

            ||

            (note.content || "")
            .toLowerCase()
            .includes(keyword)

        );


    const oldNotes =
        notes;


    notes = filtered;

    displayNotes();

    notes = oldNotes;

}


/* =========================
   SECURITY
========================= */

function escapeHTML(text){

    const div =
        document.createElement("div");

    div.textContent =
        text;

    return div.innerHTML;

}


/* =========================
   PAGE LOAD
========================= */

document.addEventListener(
    "DOMContentLoaded",
    function(){

        loadNotes();


        const saveButton =
            document.getElementById(
                "saveNoteBtn"
            );


        if(saveButton){

            saveButton.addEventListener(
                "click",
                saveNote
            );

        }


        const searchInput =
            document.getElementById(
                "searchNotes"
            );


        if(searchInput){

            searchInput.addEventListener(
                "input",
                searchNotes
            );

        }

    }
);
