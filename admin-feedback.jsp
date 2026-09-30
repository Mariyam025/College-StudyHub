<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Feedback | Admin</title>

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

            padding: 45px 25px;
        }

        .container {

            width: 95%;
            max-width: 1250px;

            margin: auto;
        }

        h1 {

            font-size: 38px;

            margin-bottom: 8px;

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

        .subtitle {

            color: #94a3b8;

            font-size: 16px;

            margin-bottom: 25px;
        }

        .back-btn {

            display: inline-block;

            margin-bottom: 30px;

            color: #c084fc;

            text-decoration: none;

            font-weight: bold;

            font-size: 16px;
        }

        .back-btn:hover {
            color: #f0abfc;
        }

        .table-box {

            overflow-x: auto;

            padding: 10px;

            border-radius: 20px;

            background:
                rgba(255,255,255,0.06);

            border:
                1px solid
                rgba(255,255,255,0.12);

            box-shadow:
                0 20px 60px
                rgba(0,0,0,0.35);
        }

        table {

            width: 100%;

            min-width: 900px;

            border-collapse: collapse;
        }

        th {

            padding: 17px;

            text-align: left;

            background:
                linear-gradient(
                    90deg,
                    #2563eb,
                    #7c3aed
                );

            color: white;

            font-size: 15px;
        }

        td {

            padding: 17px;

            color: #e2e8f0;

            border-bottom:
                1px solid
                rgba(255,255,255,0.08);
        }

        tr:hover td {

            background:
                rgba(168,85,247,0.08);
        }

        .rating {

            color: #facc15;

            font-weight: bold;

            white-space: nowrap;
        }

        .message {

            color: #cbd5e1;
        }

        .empty {

            text-align: center;

            padding: 35px;

            color: #94a3b8;
        }

        @media(max-width:700px) {

            body {
                padding: 30px 10px;
            }

            h1 {
                font-size: 30px;
            }

        }

    </style>

</head>


<body>

<div class="container">

    <h1>
        Student Feedback
    </h1>

    <p class="subtitle">
        View feedback and ratings submitted by StudyHub students.
    </p>


    <a
        href="admin-dashboard.html"
        class="back-btn">

        &#8592; Back to Admin Dashboard

    </a>


    <div class="table-box">

        <table>

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Student</th>

                    <th>Type</th>

                    <th>Rating</th>

                    <th>Message</th>

                    <th>Date</th>

                </tr>

            </thead>


            <tbody>

<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    String sql =
        "SELECT id, name, review_type, rating, message, created_at " +
        "FROM feedback " +
        "ORDER BY id DESC";

    ps = con.prepareStatement(sql);

    rs = ps.executeQuery();

    boolean found = false;


    while (rs.next()) {

        found = true;

        int id =
            rs.getInt("id");

        String name =
            rs.getString("name");

        String type =
            rs.getString("review_type");

        int rating =
            rs.getInt("rating");

        String message =
            rs.getString("message");

        Timestamp date =
            rs.getTimestamp("created_at");

%>

                <tr>

                    <td>
                        <%= id %>
                    </td>

                    <td>
                        <%= name %>
                    </td>

                    <td>
                        <%= type %>
                    </td>

                    <td class="rating">

                        &#9733;
                        <%= rating %>/5

                    </td>

                    <td class="message">

                        <%= message %>

                    </td>

                    <td>
                        <%= date %>
                    </td>

                </tr>

<%

    }


    if (!found) {

%>

                <tr>

                    <td
                        colspan="6"
                        class="empty">

                        No feedback submitted yet.

                    </td>

                </tr>

<%

    }


} catch (Exception e) {

%>

                <tr>

                    <td
                        colspan="6"
                        class="empty">

                        Error loading feedback:
                        <%= e.getMessage() %>

                    </td>

                </tr>

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

            </tbody>

        </table>

    </div>

</div>

</body>

</html>