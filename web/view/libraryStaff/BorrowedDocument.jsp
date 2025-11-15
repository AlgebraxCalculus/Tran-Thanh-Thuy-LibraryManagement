<%@page import="model.Staff"%>
<%@page import="model.BorrowSlipDetail"%>
<%@page import="model.BorrowSlip"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ArrayList<BorrowSlip> borrowedList = (ArrayList<BorrowSlip>) session.getAttribute("borrowedList");
    Staff staff = (Staff) request.getAttribute("staff");
    String errorMessage = (String) session.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Borrowed Documents</title>
        <style>
            :root {
                --primary-color: #007bff;
                --background-color: #f0f2f5;
                --text-color: #333;
                --border-color: #d0d7de;
                --success-color: #28a745;
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

            /* Banner */
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
                box-shadow: 0 3px 8px rgba(0,0,0,0.15);
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

            /* Main Container */
            .main-container {
                background-color: #fff;
                max-width: 1200px;
                margin: 25px auto;
                padding: 50px;
                border-radius: 14px;
                box-shadow: 0 3px 15px rgba(0,0,0,0.12);
                text-align: center;
            }

            h1 {
                color: var(--primary-color);
                font-size: 36px;
                font-weight: 600;
                margin-bottom: 30px;
                border-bottom: 2px solid var(--border-color);
                padding-bottom: 18px;
            }

            /* Table */
            .tblBorrowedDocument {
                width: 100%;
                border-collapse: collapse;
                font-size: 18px;
                margin-top: 25px;
            }

            .tblBorrowedDocument th, .tblBorrowedDocument td {
                padding: 16px 14px;
                border-bottom: 1px solid var(--border-color);
                text-align: left;
            }

            .tblBorrowedDocument th {
                background-color: var(--primary-color);
                color: white;
                font-weight: bold;
                text-transform: uppercase;
            }

            .tblBorrowedDocument th:nth-child(8),
            .tblBorrowedDocument td:nth-child(8) {
                text-align: center;
            }

            .tblBorrowedDocument tbody tr:hover td {
                background-color: #e7f1ff;
            }

            .tblBorrowedDocument caption {
                caption-side: top;
                text-align: left;
                font-weight: bold;
                font-size: 20px;
                margin-bottom: 12px;
                color: var(--text-color);
            }

            /* Buttons */
            .btnBack, .btnNext {
                padding: 18px 40px;
                border-radius: 8px;
                font-size: 20px;
                font-weight: bold;
                color: white;
                border: none;
                cursor: pointer;
                transition: background 0.25s ease;
            }

            .btnBack { background-color: #6c757d; }
            .btnBack:hover { background-color: #5a6268; }

            .btnNext { background-color: var(--success-color); }
            .btnNext:hover { background-color: #1e7e34; }

            .action-area {
                display: flex;
                justify-content: space-between;
                margin-top: 35px;
            }

            /* Error Message */
            .error-message {
                color: #d9534f;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 25px;
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
            <h1>Borrowed Documents Management</h1>
            <h2>Reader code: <%= session.getAttribute("readerId") %></h2>

            <% if (errorMessage != null) { %>
                <div class="error-message"><%= errorMessage %></div>
                <% session.removeAttribute("errorMessage"); %>
            <% } %>

            <form method="post" action="<%= request.getContextPath() %>/ReturnSlipServlet">
                <input type="hidden" name="action" value="selectDocumentsToReturn">

                <table class="tblBorrowedDocument">
                    <caption>Borrowed Documents Table</caption>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Code</th>
                            <th>Barcode</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Borrow Date</th>
                            <th>Due Date</th>
                            <th>Select</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (borrowedList != null && !borrowedList.isEmpty()) {
                                int index = 1;
                                for (BorrowSlip slip : borrowedList) {
                                    if (slip.getListBorrowSlipDetail() != null) {
                                        for (BorrowSlipDetail d : slip.getListBorrowSlipDetail()) {
                        %>
                        <tr>
                            <td><%= index++ %></td>
                            <td><%= d.getID() %></td>
                            <td><%= d.getDocumentCopy().getBarcode() %></td>
                            <td><%= d.getDocumentCopy().getDocument().getTitle() %></td>
                            <td><%= d.getDocumentCopy().getDocument().getCategory() %></td>
                            <td><%= slip.getBorrowDate() %></td>
                            <td><%= d.getDueDate() %></td>
                            <td><input type="checkbox" name="selectedBorrowSlipDetailIDs" value="<%= d.getID() %>"></td>
                        </tr>
                        <%
                                        }
                                    }
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" style="text-align:center; color:#777;">No borrowed documents found.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <div class="action-area">
                    <button type="button" class="btnBack" onclick="window.history.back();">Back</button>
                    <button type="submit" class="btnNext">Next</button>
                </div>
            </form>
        </div>
    </body>
</html>
