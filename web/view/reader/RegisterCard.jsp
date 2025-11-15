<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reader Card Registration</title>
        <style>
            :root {
                --primary-color: #007bff;
                --background-color: #f0f2f5;
                --text-color: #333;
                --border-color: #ddd;
                --success-color: #28a745;
                --success-hover-color: #1e7e34;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--background-color);
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* Banner */
            .banner {
                background: var(--primary-color);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 18px 40px;
                font-size: 22px;
                font-weight: bold;
                letter-spacing: 0.5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .banner-left {
                font-size: 24px;
            }

            .banner-right {
                font-size: 18px;
                font-weight: normal;
                opacity: 0.95;
            }

            /* Container */
            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .registration-form {
                background: #fff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 480px;
            }

            .form-title {
                color: var(--primary-color);
                font-size: 26px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 25px;
                border-bottom: 2px solid var(--primary-color);
                padding-bottom: 10px;
                text-transform: uppercase;
            }

            .form-group {
                margin-bottom: 18px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: var(--text-color);
            }

            .form-control {
                width: 100%;
                padding: 12px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                font-size: 16px;
                box-sizing: border-box;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
            }

            .btnSave {
                width: 100%;
                padding: 14px;
                background: var(--success-color);
                border: none;
                border-radius: 6px;
                color: white;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-top: 15px;
            }

            .btnSave:hover {
                background: var(--success-hover-color);
            }
        </style>
    </head>
    <body>
        <div class="banner">
            <div class="banner-left">📚 Library Management</div>
            <div class="banner-right">Reader registers as a reader card</div>
        </div>

        <div class="main-container">
            <div class="registration-form">
                <h2 class="form-title">Reader Card Registration</h2>

                <form action="<%= request.getContextPath() %>/ReaderServlet" method="post">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>

                    <div class="form-group">
                        <label for="dob">Date of Birth:</label>
                        <input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="DD/MM/YYYY" required pattern="\d{2}/\d{2}/\d{4}">
                    </div>

                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                    </div>

                    <button type="submit" class="btnSave">Save</button>
                </form>
            </div>
        </div>
        <script>
        document.querySelector("form").addEventListener("submit", function (e) {
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();
            const fullName = document.getElementById("fullName").value.trim();
            const dob = document.getElementById("dateOfBirth").value.trim();
            const address = document.getElementById("address").value.trim();
            const phone = document.getElementById("phoneNumber").value.trim();

            // Username: 4–20 chars, no spaces
            const usernameRegex = /^[A-Za-z0-9_]{4,20}$/;

            // Password: min 8 chars + letter + digit
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

            // Full Name: only letters + spaces
            const fullNameRegex = /^[A-Za-zÀ-ỹ\s]+$/;

            // Date: DD/MM/YYYY + valid date check
            const dateRegex = /^\d{2}\/\d{2}\/\d{4}$/;

            // Phone: digits only, 9–11 chars
            const phoneRegex = /^\d{9,11}$/;

            // VALIDATION LOGIC
            if (!usernameRegex.test(username)) {
                alert("Invalid username!\n- 4 to 20 characters\n- No spaces\n- Letters, digits, underscore allowed.");
                e.preventDefault();
                return;
            }

            if (!passwordRegex.test(password)) {
                alert("Invalid password!\n- Must be at least 8 characters\n- Must include letters and numbers.");
                e.preventDefault();
                return;
            }

            if (!fullNameRegex.test(fullName)) {
                alert("Full name can contain only letters and spaces!");
                e.preventDefault();
                return;
            }

            if (!dateRegex.test(dob)) {
                alert("Date of Birth must follow DD/MM/YYYY format.");
                e.preventDefault();
                return;
            }

            // Check real date validity
            const [day, month, year] = dob.split("/").map(Number);
            const dateObj = new Date(year, month - 1, day);

            if (
                dateObj.getFullYear() !== year ||
                dateObj.getMonth() !== month - 1 ||
                dateObj.getDate() !== day
            ) {
                alert("Invalid date of birth!");
                e.preventDefault();
                return;
            }

            if (address.length < 5) {
                alert("Address must be at least 5 characters!");
                e.preventDefault();
                return;
            }

            if (!phoneRegex.test(phone)) {
                alert("Invalid phone number!\nMust be 9–11 digits.");
                e.preventDefault();
                return;
            }
        });
        </script>

        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) { 
        %>
        <script>
            const msg = "<%= message %>";
            alert(msg);
            if (msg.includes("successfully")) {
                window.location.href = "view/reader/Home.jsp";
            } else {
                window.location.href = "view/reader/RegisterCard.jsp";
            }
        </script>
        <% } %>
    </body>
</html>
