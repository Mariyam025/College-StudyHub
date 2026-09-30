<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>StudyHub Statistics</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {

            font-family: Arial, sans-serif;

            min-height: 100vh;

            color: white;

            background:
                radial-gradient(
                    circle at top left,
                    #312e81,
                    transparent 35%
                ),
                radial-gradient(
                    circle at bottom right,
                    #831843,
                    transparent 35%
                ),
                #080b18;

            padding: 50px 25px;
        }

        .container {

            width: 90%;
            max-width: 1100px;

            margin: auto;
        }

        h1 {

            font-size: 38px;

            margin-bottom: 35px;

            background:
                linear-gradient(
                    90deg,
                    #a855f7,
                    #ec4899,
                    #38bdf8
                );

            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat {

            margin: 18px 0;

            padding: 22px 25px;

            border-radius: 15px;

            background:
                linear-gradient(
                    90deg,
                    rgba(37,99,235,0.30),
                    rgba(124,58,237,0.20)
                );

            border:
                1px solid
                rgba(255,255,255,0.10);

            font-size: 18px;

            font-weight: bold;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.20);
        }

        .number {

            color: #c084fc;

            font-size: 22px;

        }

        .back {

            display: inline-block;

            margin-top: 25px;

            color: #c084fc;

            text-decoration: none;

            font-weight: bold;
        }

        .back:hover {

            color: #f0abfc;
        }

    </style>

</head>


<body>

<div class="container">

    <h1>
        StudyHub Statistics
    </h1>


<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

int students = 0;
int notes = 0;
int handwritten = 0;
int pyqs = 0;
int feedback = 0;

try {

    con = DBConnection.getConnection();


    // STUDENTS

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM users"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        students = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // PERSONAL NOTES

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM personal_notes"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        notes = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // HANDWRITTEN NOTES

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM handwritten_notes"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        handwritten = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // PYQs

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM pyqs"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        pyqs = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // FEEDBACK

    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM feedback"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        feedback = rs.getInt(1);
    }

%>


    <div class="stat">

        Registered Students:

        <span class="number">
            <%= students %>
        </span>

    </div>


    <div class="stat">

        Study Notes:

        <span class="number">
            <%= notes %>
        </span>

    </div>


    <div class="stat">

        Handwritten Notes:

        <span class="number">
            <%= handwritten %>
        </span>

    </div>


    <div class="stat">

        PYQs:

        <span class="number">
            <%= pyqs %>
        </span>

    </div>


    <div class="stat">

        Feedback:

        <span class="number">
            <%= feedback %>
        </span>

    </div>


<%

} catch (Exception e) {

%>

    <div class="stat">

        Database Error:

        <%= e.getMessage() %>

    </div>

<%

} finally {

    try {
        if (rs != null) rs.close();
    } catch (Exception e) {}

    try {
        if (ps != null) ps.close();
    } catch (Exception e) {}

    try {
        if (con != null) con.close();
    } catch (Exception e) {}

}

%>


    <a
        href="admin-dashboard.html"
        class="back">

        &#8592; Back to Admin Dashboard

    </a>

</div>

</body>

</html>