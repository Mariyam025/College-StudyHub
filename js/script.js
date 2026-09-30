function logout() {

    localStorage.removeItem("loggedIn");
    localStorage.removeItem("studentName");

    window.location.href = "index.html";
}


const studentName = localStorage.getItem("studentName");

if (studentName) {
    document.getElementById("studentName").textContent = studentName;
}