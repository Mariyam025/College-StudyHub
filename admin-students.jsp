<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Students | Admin</title>

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

            padding: 50px;
        }

        .container {
            width: 95%;
            max-width: 1200px;
            margin: auto;
        }

        h1 {
            font-size: 38px;
            margin-bottom: 25px;

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

        .back-btn {
            display: inline-block;
            margin-bottom: 30px;

            color: #c084fc;
            text-decoration: none;

            font-size: 17px;
            font-weight: bold;
        }

        .back-btn:hover {
            color: #f0abfc;
        }

        .table-box {
            overflow-x: auto;

            background: rgba(255,255,255,0.06);

            border: 1px solid rgba(255,255,255,0.12);

            border-radius: 20px;

            padding: 10px;

            box-shadow:
                0 20px 50px rgba(0,0,0,0.35);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th {
            padding: 18px;

            text-align: left;

            background:
                linear-gradient(
                    90deg,
                    #2563eb,
                    #7c3aed
                );

            color: white;

            font-size: 16px;
        }

        td {
            padding: 17px;

            border-bottom:
                1px solid
                rgba(255,255,255,0.08);

            color: #e2e8f0;
        }

        tr:hover td {
            background:
                rgba(168,85,247,0.08);
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #94a3b8;
        }

        @media(max-width:700px) {

            body {
                padding: 25px 10px;
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
        &#128105;&#8205;&#127979; Registered Students
    </h1>

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
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Semester</th>
                    <th>Points</th>
                    <th>XP</th>

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
        "SELECT id, name, email, course, semester, points, xp " +
        "FROM users ORDER BY id DESC";

    ps = con.prepareStatement(sql);

    rs = ps.executeQuery();

    boolean found = false;

    while (rs.next()) {

        found = true;

%>

                <tr>

                    <td>
                        <%= rs.getInt("id") %>
                    </td>

                    <td>
                        <%= rs.getString("name") %>
                    </td>

                    <td>
                        <%= rs.getString("email") %>
                    </td>

                    <td>
                        <%= rs.getString("course") %>
                    </td>

                    <td>
                        <%= rs.getInt("semester") %>
                    </td>

                    <td>
                        <%= rs.getInt("points") %>
                    </td>

                    <td>
                        <%= rs.getInt("xp") %>
                    </td>

                </tr>

<%

    }

    if (!found) {

%>

                <tr>

                    <td
                        colspan="7"
                        class="empty">

                        No registered students found.

                    </td>

                </tr>

<%

    }

} catch (Exception e) {

%>

                <tr>

                    <td
                        colspan="7"
                        class="empty">

                        Error loading students:
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