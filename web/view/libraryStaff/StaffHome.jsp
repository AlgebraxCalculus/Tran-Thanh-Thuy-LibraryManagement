<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Staff staff = (Staff) session.getAttribute("staff");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Library Staff Home</title>
        <style>
            /* ========== Theme Colors ========== */
            :root {
                --primary-color: #007bff;
                --logout-color: #dc3545;
                --background-color: #eef2f7;
                --text-color: #333;
                --border-color: #ddd;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                font-size: 17px;
            }

            /* ========== Banner ========== */
            .banner {
                background: var(--primary-color);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 30px 60px;
                font-size: 26px;
                font-weight: bold;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
            }

            .banner-left {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .library-title {
                font-size: 32px;
                font-weight: bold;
            }

            .staff-info {
                font-size: 18px;
                line-height: 1.7;
            }

            .banner-right {
                font-size: 22px;
                font-weight: 500;
                opacity: 0.95;
                text-align: right;
            }

            /* ========== Main Container ========== */
            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px;
            }

            /* ========== Staff Container ========== */
            .staff-container {
                background: #fff;
                padding: 60px 50px;
                border-radius: 16px;
                width: 600px;
                text-align: center;
                box-shadow: 0 8px 28px rgba(0, 0, 0, 0.18);
                transition: transform 0.2s;
            }

            .staff-container:hover {
                transform: translateY(-6px);
            }

            .staff-container h1 {
                color: var(--primary-color);
                font-size: 34px;
                margin-bottom: 15px;
                font-weight: 600;
            }

            .staff-container p {
                color: var(--text-color);
                font-size: 20px;
                margin-bottom: 40px;
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 20px;
            }

            /* ========== Button Styles ========== */
            .btn {
                display: block;
                padding: 18px 0;
                border-radius: 10px;
                color: white;
                font-size: 22px;
                font-weight: bold;
                text-decoration: none;
                width: 100%;
                margin-bottom: 20px;
                transition: background 0.3s;
            }

            .btnReturning {
                background-color: var(--primary-color);
            }

            .btnReturning:hover {
                background-color: #0056b3;
            }

            .btnLogOut {
                background-color: var(--logout-color);
            }

            .btnLogOut:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <!-- Banner -->
        <div class="banner">
            <div class="banner-left">
                <div class="library-title">📚 Library Management</div>
                <div class="staff-info">
                    <div><strong>Full name:</strong> ${staff.fullName}</div>
                    <div><strong>Role:</strong> ${staff.role}</div>
                </div>
            </div>
            <div class="banner-right">Reader returns documents</div>
        </div>

        <!-- Main Content -->
        <div class="main-container">
            <div class="staff-container">
                <h1>Welcome Staff ${staff.fullName}!</h1>
                <p>Please select a function below:</p>

                <a href="<%= request.getContextPath() %>/view/libraryStaff/SearchReader.jsp" class="btn btnReturning">Return Documents</a>
                <a href="view/libraryStaff/Login.jsp" class="btn btnLogOut">Log out</a>
            </div>
        </div>
    </body>
</html>
