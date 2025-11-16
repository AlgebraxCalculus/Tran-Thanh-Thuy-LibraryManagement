<%@page import="model.Staff"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Reader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ArrayList<Reader> listReader = (ArrayList<Reader>) request.getAttribute("result");
    Staff staff = (Staff) session.getAttribute("staff");
    String readerError = (String) request.getAttribute("readerError");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Search Reader</title>
        <style>
            :root {
                --primary-color: #007bff;
                --background-color: #f0f2f5;
                --text-color: #333;
                --border-color: #d0d7de;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                font-size: 20px;
            }

            /* ================= Banner ================ */
            .banner {
                background: var(--primary-color);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 28px 55px;
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 0.5px;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
                position: sticky;
                top: 0;
                z-index: 10;
            }

            .banner-left {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .library-title {
                font-size: 36px;
                font-weight: bold;
                margin-bottom: 6px;
            }

            .staff-info {
                font-size: 20px;
                line-height: 1.8;
            }

            .banner-right {
                font-size: 24px;
                opacity: 0.95;
                text-align: right;
            }

            /* ================= Main Container ================ */
            .main-container {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                align-items: center;
                padding: 50px 25px;
                width: 100%;
                background-color: #fff; /* phông trắng */
                box-shadow: 0 3px 15px rgba(0,0,0,0.12); /* tạo hiệu ứng giống card */
                border-radius: 14px;
                margin: 25px auto;
                max-width: 1200px;
            }

            h1 {
                color: var(--primary-color);
                font-size: 36px;
                font-weight: 600;
                margin-bottom: 40px;
                text-align: center;
                border-bottom: 2px solid var(--border-color);
                padding-bottom: 18px;
            }

            /* ================= Search Form ================ */
            .search-form {
                display: flex;
                flex-wrap: wrap;
                gap: 18px;
                margin-bottom: 40px;
                width: 100%;
            }

            input[type="text"] {
                flex-grow: 1;
                padding: 18px 20px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 20px;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            input[type="text"]:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.28);
                outline: none;
            }

            /* ================= Search Button ================ */
            .btnSearch {
                padding: 18px 40px;
                background: var(--primary-color);
                border: none;
                border-radius: 8px;
                color: white;
                font-size: 20px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.25s;
            }

            .btnSearch:hover {
                background: #0056b3;
            }

            /* ================= Error Message ================ */
            .error-message {
                color: #d9534f;
                font-size: 20px;
                text-align: center;
                margin-bottom: 30px;
                font-weight: bold;
            }

            /* ================= Table ================ */
            .tblReader {
                width: 100%;
                border-collapse: collapse;
                font-size: 18px;
            }

            .tblReader th,
            .tblReader td {
                padding: 18px 14px;
                border-bottom: 1px solid var(--border-color);
            }

            .tblReader th {
                background-color: var(--primary-color);
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 18px;
                letter-spacing: 0.4px;
            }

            .tblReader tbody tr {
                cursor: pointer;
                transition: background-color 0.18s ease;
            }

            .tblReader tbody tr:hover {
                background-color: #e7f1ff;
            }

            .tblReader caption {
                caption-side: top;
                text-align: left;
                font-weight: bold;
                font-size: 20px;
                margin-bottom: 12px;
                color: var(--text-color);
            }
            
            /* ================= Back Button ================ */
            .action-area {
                display: flex;
                justify-content: center; 
                margin-top: 40px;       
            }

            .btnBack {
                padding: 15px 50px;      
                background: #6c757d; 
                border: none;
                border-radius: 8px;  
                color: white;
                font-size: 20px;      
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .btnBack:hover {
                background: #5a6268;    
                transform: translateY(-2px); 
            }
            
        </style>
    </head>

    <body>
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

        <div class="main-container">

            <h1>Search Reader</h1>

            <!-- Search Form -->
            <form class="search-form" method="get" action="<%= request.getContextPath() %>/ReaderServlet">
                <input 
                    type="text" 
                    id="readerCode" 
                    name="readerCode" 
                    placeholder="Enter reader code to search"
                    value="<%= request.getParameter("readerCode") != null ? request.getParameter("readerCode") : "" %>"
                >
                <button type="submit" class="btnSearch">Search</button>
            </form>

            <!-- Error Message -->
            <% if (readerError != null) { %>
                <div class="error-message"><%= readerError %></div>
            <% } %>

            <!-- Table (only show when no error) -->
            <% if (readerError == null) { %>
            <table class="tblReader">
                <caption>Reader Table</caption>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone number</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (listReader != null && !listReader.isEmpty()) {
                            int index = 1;
                            for (Reader r : listReader) {
                    %>
                    <tr class="clickable-row"
                        data-readerid="<%= r.getID() %>"
                        data-fullname="<%= r.getFullName() %>"
                        data-address="<%= r.getAddress() %>"
                        data-phone="<%= r.getPhoneNumber() %>">
                        <td><%= index++ %></td>
                        <td><%= r.getID() %></td>
                        <td><%= r.getFullName() %></td>
                        <td><%= r.getAddress() %></td>
                        <td><%= r.getPhoneNumber() %></td>
                    </tr>
                    <%
                            }
                        } else if (listReader != null) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center; color:#777;">No readers found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <% } %>

            <!-- Hidden Form -->
            <form id="hiddenForm" method="post" action="ReturnSlipServlet">
                <input type="hidden" id="readerIDInput" name="readerID">
                <input type="hidden" id="fullNameInput" name="fullName">
                <input type="hidden" id="addressInput" name="address">
                <input type="hidden" id="phoneInput" name="phoneNumber">
                <input type="hidden" name="action" value="selectReaderToReturn">
            </form>
            
            <div class="action-area">
                <button type="button" class="btnBack"
                        onclick="window.location.href='<%= request.getContextPath() %>/view/libraryStaff/StaffHome.jsp'">
                    Back
                </button>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const rows = document.querySelectorAll(".clickable-row");
                const form = document.getElementById("hiddenForm");

                rows.forEach(row => {
                    row.addEventListener("click", function() {
                        document.getElementById("readerIDInput").value = this.dataset.readerid;
                        document.getElementById("fullNameInput").value = this.dataset.fullname;
                        document.getElementById("addressInput").value = this.dataset.address;
                        document.getElementById("phoneInput").value = this.dataset.phone;
                        form.submit();
                    });
                });
            });
        </script>
    </body>
</html>
