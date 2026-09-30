<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Handwritten Notes | Admin</title>

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

            min-width: 950px;

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

        .open-btn,
        .download-btn {

            display: inline-block;

            padding: 9px 14px;

            margin: 3px;

            border-radius: 9px;

            text-decoration: none;

            font-weight: bold;

            font-size: 13px;

            color: white;
        }

        .open-btn {

            background:
                linear-gradient(
                    90deg,
                    #6366f1,
                    #8b5cf6
                );
        }

        .download-btn {

            background:
                linear-gradient(
                    90deg,
                    #ec4899,
                    #f43f5e
                );
        }

        .open-btn:hover,
        .download-btn:hover {

            transform: translateY(-1px);
        }

        .empty {

            text-align: center;

            padding: 35px;

            color: #94a3b8;
        }

        @media(max-width:700px) {

            body {

                padding:
                    30px 10px;
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
        Handwritten Notes
    </h1>

    <p class="subtitle">
        Review notes uploaded by StudyHub students.
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

                    <th>Subject</th>

                    <th>Title</th>

                    <th>File</th>

                    <th>Points</th>

                    <th>Uploaded</th>

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
        "SELECT id, student_name, subject, title, " +
        "file_path, points, created_at " +
        "FROM handwritten_notes " +
        "ORDER BY id DESC";

    ps = con.prepareStatement(sql);

    rs = ps.executeQuery();

    boolean found = false;


    while (rs.next()) {

        found = true;

        int id =
            rs.getInt("id");

        String student =
            rs.getString("student_name");

        String subject =
            rs.getString("subject");

        String title =
            rs.getString("title");

        String filePath =
            rs.getString("file_path");

        int points =
            rs.getInt("points");

        Timestamp uploaded =
            rs.getTimestamp("created_at");

%>

                <tr>

                    <td>
                        <%= id %>
                    </td>

                    <td>
                        <%= student %>
                    </td>

                    <td>
                        <%= subject %>
                    </td>

                    <td>
                        <%= title %>
                    </td>

                    <td>

                        <a
                            href="<%= request.getContextPath() %>/<%= filePath %>"
                            target="_blank"
                            class="open-btn">

                            Open

                        </a>


                        <a
                            href="<%= request.getContextPath() %>/<%= filePath %>"
                            download
                            class="download-btn">

                            Download

                        </a>

                    </td>

                    <td>
                        <%= points %>
                    </td>

                    <td>
                        <%= uploaded %>
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

                        No handwritten notes uploaded yet.

                    </td>

                </tr>

<%

    }


} catch(Exception e) {

%>

                <tr>

                    <td
                        colspan="7"
                        class="empty">

                        Error loading handwritten notes:
                        <%= e.getMessage() %>

                    </td>

                </tr>

<%

} finally {

    try {
        if(rs != null) rs.close();
    } catch(Exception e) {}

    try {
        if(ps != null) ps.close();
    } catch(Exception e) {}

    try {
        if(con != null) con.close();
    } catch(Exception e) {}

}

%>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>