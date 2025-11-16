<%-- 
    Document   : ConfirmReturn
    Created on : Oct 2, 2025, 3:47:00 PM
    Author     : Admin
--%>

<%@page import="model.ReturnSlip"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Staff"%>
<%@page import="model.Reader"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.BorrowSlipDetail"%>
<%@page import="model.ReturnSlipDetail"%>
<%@page import="model.Fine"%>
<%@page import="model.FineDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
        Staff staff = (Staff) session.getAttribute("staff");
        Reader reader = (Reader) session.getAttribute("reader");
        ArrayList<ReturnSlipDetail> listReturnSlipDetail =
            (ArrayList<ReturnSlipDetail>) session.getAttribute("listReturnSlipDetail");
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirm Return</title>
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
                width: 1000px; /* Tăng chiều rộng */
                margin: 40px auto;
                text-align: left;
            }

            h1 {
                color: var(--primary-color);
                text-align: center;
                font-size: 32px; /* Tăng kích thước font */
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 15px;
                margin-bottom: 30px;
            }

            /* Info section */
            .info-section {
                margin-bottom: 30px;
                font-size: 20px; /* Tăng kích thước font */
            }

            .info-section p {
                margin: 8px 0;
            }

            /* Tables */
            .data-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 30px;
                font-size: 16px; /* Tăng kích thước font bảng */
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .data-table caption {
                font-size: 20px; /* Tăng kích thước font caption */
                margin-bottom: 15px;
            }

            .data-table th, .data-table td {
                padding: 15px; /* Tăng padding bảng */
                border-bottom: 1px solid var(--border-color);
            }

            .data-table th {
                background-color: var(--primary-color);
                color: white;
                text-transform: uppercase;
                font-size: 16px; /* Tăng kích thước font */
            }

            .data-table tbody tr:hover td {
                background-color: #f7f9fa;
            }

            /* Fine table */
            .tblFine th:nth-child(4), .tblFine td:nth-child(4) {
                text-align: right;
                color: #cc0000;
                font-weight: bold;
            }

            /* Summary */
            .summary-footer {
                margin-top: 40px;
                font-size: 18px; /* Tăng kích thước font */
            }

            .total-fine {
                display: flex;
                justify-content: space-between;
                background-color: #f8f9fa; /* Màu nền nhẹ nhàng hơn */
                border-radius: 8px;
                padding: 15px 20px; /* Tăng padding */
                margin-top: 15px;
                font-size: 18px;
                border-left: 5px solid var(--primary-color);
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .total-fine span {
                color: var(--primary-color);
                font-weight: 700;
            }

            .total-fine:last-of-type {
                background-color: #dff0d8;
                color: #155724;
                font-weight: 800;
                border-left-color: var(--success-color);
                border-top: 3px solid #155724;
                font-size: 22px; /* Tăng kích thước tổng */
                margin-top: 20px;
            }
            
            p.total-fine:first-of-type { /* Fine Amount */
                 border-left-color: #ffc107; /* Màu vàng cho Fine */
            }

            /* Buttons */
            .action-area {
                margin-top: 40px;
                text-align: right;
            }
            
            .btnCancel {
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

            .btnCancel:hover {
                background: #5a6268;
            }

            .btnConfirm {
                padding: 15px 35px; /* Tăng padding button */
                background: var(--success-color);
                border: none;
                border-radius: 6px;
                color: white;
                font-size: 18px; /* Tăng kích thước font button */
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                transition: background-color 0.3s ease;
            }

            .btnConfirm:hover {
                background: #1e7e34;
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

    <div class="main-container">
        <h1>RETURN SLIP</h1>

        <div class="info-section">
            <p>- Library staff: <strong><%= staff != null ? staff.getFullName() : "N/A" %></strong></p>

            <table class="data-table tblReader">
                <caption style="caption-side: top; text-align: left; font-weight: bold; font-size: 18px;">Reader</caption>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Reader Code</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td><%= reader != null ? reader.getID() : "N/A" %></td>
                        <td><%= reader != null ? reader.getFullName() : "N/A" %></td>
                        <td><%= reader != null ? reader.getAddress() : "N/A" %></td>
                        <td><%= reader != null ? reader.getPhoneNumber() : "N/A" %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Returned documents -->
        <table class="data-table tblReturnedDocuments">
            <caption style="caption-side: top; text-align: left; font-weight: bold; font-size: 18px;">Returned Documents</caption>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Barcode</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Overdue (days)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int i = 1;
                    for (ReturnSlipDetail rsd : listReturnSlipDetail) {
                        BorrowSlipDetail bsd = rsd.getBorrowSlipDetail();
                        String barcode = bsd.getDocumentCopy().getBarcode();
                        String title = bsd.getDocumentCopy().getDocument().getTitle();
                        String type = bsd.getDocumentCopy().getDocument().getCategory();
                        LocalDate dueDate = bsd.getDueDate();
                        LocalDate returnDate = LocalDate.now();
                        int overdue = rsd.getOverdueDays();
                %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= barcode %></td>
                    <td><%= title %></td>
                    <td><%= type %></td>
                    <td><%= dueDate %></td>
                    <td><%= returnDate %></td>
                    <td style="text-align:center;"><%= overdue %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <%
            boolean hasFineDetail = false;
            float totalFine = 0;
            float totalLateFee = 0;

            for (ReturnSlipDetail rsd : listReturnSlipDetail) {
                int overdueDays = rsd.getOverdueDays();
                if (overdueDays > 0) totalLateFee += overdueDays * 2000;
                if (rsd.getListFineDetail() != null && !rsd.getListFineDetail().isEmpty())
                    hasFineDetail = true;
            }
            float grandTotal = totalFine + totalLateFee;
        %>

        <% if (hasFineDetail) { %>
        <table class="data-table tblFine">
            <caption style="caption-side: top; text-align: left; font-weight: bold; font-size: 18px;">Fine Details</caption>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Barcode</th>
                    <th>Fine Name</th>
                    <th>Amount</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int j = 1;
                    for (ReturnSlipDetail rsd : listReturnSlipDetail) {
                        String barcode = rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode();
                        if (rsd.getListFineDetail() != null && !rsd.getListFineDetail().isEmpty()) {
                            for (FineDetail fd : rsd.getListFineDetail()) {
                                Fine fine = fd.getFine();
                                totalFine += fine.getAmount();
                %>
                <tr>
                    <td><%= j++ %></td>
                    <td><%= barcode %></td>
                    <td><%= fine.getName() %></td>
                    <td><%= String.format("%,.0f VNĐ", fine.getAmount()).replace(',', '.') %></td>
                    <td><%= fd.getNote() != null ? fd.getNote() : "" %></td>
                </tr>
                <% } } } grandTotal = totalFine + totalLateFee; %>
            </tbody>
        </table>
        <% } else { %>
            <p style="font-style: italic; color: gray; margin-top: 10px;">No fines applied for this return.</p>
        <% } %>

        <div class="summary-footer">
            <p class="total-fine"><span>TOTAL FINE AMOUNT:</span> <%= String.format("%,.0f VNĐ", totalFine).replace(',', '.') %></p>
            <p class="total-fine"><span>TOTAL LATE RETURN FEE:</span> <%= String.format("%,.0f VNĐ", totalLateFee).replace(',', '.') %></p>
            <p class="total-fine"><span>TOTAL:</span> <%= String.format("%,.0f VNĐ", grandTotal).replace(',', '.') %></p>
        </div>

        <div class="action-area" style="display:flex; justify-content: space-between;">
            <button type="button" class="btnCancel"
                onclick="window.location.href='<%= request.getContextPath() %>/view/libraryStaff/SearchReader.jsp'">
                Cancel
            </button>
            <form action="<%= request.getContextPath() %>/ReturnSlipServlet" method="post">
                <input type="hidden" name="action" value="confirmReturn">
                <button type="submit" class="btnConfirm">Confirm</button>
            </form>
        </div>
    </div>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
    <script>
        const msg = "<%= message %>";
        if (msg.includes("successfully")) {
            alert(msg);
            window.location.href = "view/libraryStaff/StaffHome.jsp";
        } else {
            alert(msg);
            window.location.href = "view/libraryStaff/ConfirmReturn.jsp";
        }
    </script>
    <% } %>
    </body>
</html>
