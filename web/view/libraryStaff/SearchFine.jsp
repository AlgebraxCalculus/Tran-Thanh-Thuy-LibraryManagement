<%-- 
    Document   : SearchFine
    Created on : Oct 2, 2025, 3:47:00 PM
    Author     : Admin
--%>

<%@page import="model.Staff"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ReturnSlipDetail"%>
<%@page import="model.Fine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
        ArrayList<Fine> result = (ArrayList<Fine>) request.getAttribute("result");
        ArrayList<ReturnSlipDetail> listReturnSlipDetail =
            (ArrayList<ReturnSlipDetail>) session.getAttribute("listReturnSlipDetail");
        Staff staff = (Staff) request.getAttribute("staff");
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Search Fines</title>
        <style>
            :root {
                --primary-color: #007bff;
                --background-color: #f0f2f5;
                --text-color: #333;
                --border-color: #ddd;
                --success-color: #28a745; 
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                margin: 0;
                font-size: 16px; /* Tăng kích thước font cơ bản */
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

            /* ===== Main ===== */
            .main-container {
                background: #fff;
                padding: 50px; /* Tăng padding */
                border-radius: 10px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                width: 1100px; /* Tăng chiều rộng */
                margin: 40px auto;
                text-align: left;
            }

            h1 {
                color: var(--primary-color);
                text-align: center;
                font-size: 30px; /* Tăng kích thước font */
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 15px;
                margin-bottom: 35px;
            }

            .search-form {
                display: flex;
                gap: 15px;
                margin-bottom: 40px;
            }

            input[type="text"] {
                flex-grow: 1;
                padding: 15px; /* Tăng padding input */
                border: 1px solid var(--border-color);
                border-radius: 6px;
                font-size: 18px; /* Tăng kích thước font input */
            }

            input[type="text"]:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.35);
                outline: none;
            }

            .btnSearch {
                padding: 15px 30px; /* Tăng padding button */
                background: var(--primary-color);
                border: none;
                border-radius: 6px;
                color: white;
                font-size: 18px; /* Tăng kích thước font button */
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btnSearch:hover {
                background: #0056b3;
            }

            /* ===== Tables ===== */
            .results-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 35px;
                font-size: 16px; /* Tăng kích thước font bảng */
            }

            .results-table th,
            .results-table td {
                padding: 15px; /* Tăng padding bảng */
                border-bottom: 1px solid var(--border-color);
            }

            .results-table th {
                background-color: var(--primary-color);
                color: white;
                text-transform: uppercase;
                font-size: 16px; /* Tăng kích thước font */
            }

            .results-table tbody tr:hover td {
                background-color: #f7f9fa;
            }

            /* Tăng độ rộng cột cho tblFine */
            #tblFine th:nth-child(1), #tblFine td:nth-child(1) { width: 6%; text-align: center; }
            #tblFine th:nth-child(2), #tblFine td:nth-child(2) { width: 12%; text-align: center; }
            #tblFine th:nth-child(3), #tblFine td:nth-child(3) { width: 40%; }
            #tblFine th:nth-child(4), #tblFine td:nth-child(4) { text-align: right; width: 15%; }
            #tblFine th:nth-child(5), #tblFine td:nth-child(5) { width: 27%; text-align: center; }


            .note-input {
                width: 98%;
                padding: 6px 8px; /* Tăng padding input */
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 1em;
            }

            tfoot td {
                background-color: #e9ecef; /* Đổi màu nền footer */
                border-top: 3px solid var(--primary-color);
                padding: 18px; /* Tăng padding footer */
                font-weight: bold;
                font-size: 18px;
            }

            .total-label {
                text-align: right;
                color: var(--primary-color);
            }

            .total-amount {
                text-align: right;
                color: #cc0000;
                font-weight: bold;
                font-size: 1.1em;
            }

            .action-area {
                margin-top: 40px;
                text-align: right;
            }
            
            .btnBack {
                padding: 15px 35px; /* Tăng padding button */
                background: #6c757d;
                border: none;
                border-radius: 6px;
                color: white;
                font-size: 18px; /* Tăng kích thước font button */
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btnBack:hover {
                background: #5a6268;
            }

            .btnMakePayment {
                padding: 15px 35px; /* Tăng padding button */
                background: var(--success-color);
                border: none;
                border-radius: 6px;
                color: white;
                font-size: 18px; /* Tăng kích thước font button */
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btnMakePayment:hover {
                background: #1e7e34;
            }

            .barcode-list {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                justify-content: center;
            }

            .barcode-item {
                border: 1px solid var(--border-color);
                border-radius: 6px;
                padding: 10px 15px; /* Tăng padding item */
                background: #fff;
                cursor: pointer;
                transition: background 0.2s;
                font-size: 15px;
            }

            .barcode-item.selected {
                background: var(--primary-color);
                color: white;
            }
        </style>
    </head>
    <body>

    <!-- ===== Banner ===== -->
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

    <!-- ===== Main Content ===== -->
    <div class="main-container">
        <h1>Search Fines</h1>

        <form class="search-form" method="get" action="<%= request.getContextPath() %>/FineServlet">
            <input type="text" name="key" placeholder="Enter Fine Name..." required>
            <button type="submit" class="btnSearch">Search</button>
        </form>

        <form id="fineForm" method="post" action="<%= request.getContextPath() %>/FineServlet">
            <table class="results-table" id="tblFine">
                <caption style="text-align:left; font-weight:bold; font-size:18px;">Available Fines</caption>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Code</th>
                        <th>Fine Name</th>
                        <th>Amount</th>
                        <th>Apply to Document</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (result != null && !result.isEmpty()) {
                            int i = 1;
                            for (Fine fine : result) {
                    %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= fine.getID() %></td>
                        <td><%= fine.getName() %></td>
                        <td style="text-align:right;">
                            <%= String.format("%,d VNĐ", (int) fine.getAmount()).replace(',', '.') %>
                        </td>
                        <td>
                            <%
                                if (listReturnSlipDetail != null) {
                                    for (ReturnSlipDetail rsd : listReturnSlipDetail) {
                                        String checkboxId = "chk_" + fine.getID() + "_" + rsd.getID();
                                        boolean checked = request.getParameterValues("applyFineFor") != null &&
                                            java.util.Arrays.asList(
                                                request.getParameterValues("applyFineFor")
                                            ).contains(fine.getID() + "_" + rsd.getID());
                            %>
                            <label style="display:block;" class="barcode-label" data-rsd-id="<%= rsd.getID() %>">
                                <input type="checkbox"
                                       name="applyFineFor"
                                       class="fine-checkbox"
                                       id="<%= checkboxId %>"
                                       value="<%= fine.getID() + "_" + rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode() %>"
                                       data-fine-id="<%= fine.getID() %>"
                                       data-fine-name="<%= fine.getName() %>"
                                       data-fine-amount="<%= (int) fine.getAmount() %>"
                                       data-rsd-id="<%= rsd.getID() %>"
                                       data-barcode="<%= rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode() %>"
                                       <%= checked ? "checked" : "" %>>
                                <input type="hidden"
                                       name="fineName_<%= fine.getID() %>_<%= rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode() %>"
                                       value="<%= fine.getName() %>">
                                <input type="hidden"
                                       name="fineAmount_<%= fine.getID() %>_<%= rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode() %>"
                                       value="<%= (int) fine.getAmount() %>">
                                <%= rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode() %>
                            </label>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center;">No fines found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <table class="results-table" id="tblFineDetail">
                <caption style="text-align:left; font-weight:bold; font-size:18px;">Fine Detail</caption>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Code</th>
                        <th>Barcode</th>
                        <th>Fine Name</th>
                        <th>Amount</th>
                        <th>Note</th>
                    </tr>
                </thead>
                <tbody id="fineDetailBody">
                    <tr>
                        <td colspan="6" style="text-align:center;">Select fines above to view details.</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="total-label">Total Amount:</td>
                        <td colspan="2" id="totalFineAmount" class="total-amount">0 VNĐ</td>
                    </tr>
                </tfoot>
            </table>

            <div class="action-area" style="display:flex; justify-content: space-between;">
                    <button type="button" class="btnBack"
                        onclick="sessionStorage.removeItem('selectedFines'); window.location.href='<%= request.getContextPath() %>/view/libraryStaff/BorrowedDocument.jsp'">
                        Back
                    </button>
                <button type="submit" class="btnMakePayment">Make Payment</button>
            </div>
        </form>
    </div>

    <script src="<%= request.getContextPath() %>/js/fine.js"></script>
    </body>
</html>
