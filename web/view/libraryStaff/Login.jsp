<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <style>
        /* ========== Theme Colors ========== */
        :root {
            --primary-color: #007bff;
            --background-color: #e9eef3;
            --text-color: #333;
            --border-color: #ccc;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            font-size: 16px;
        }

        /* ========== Banner ========== */
        .banner {
            background: var(--primary-color);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 50px;
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .banner-left {
            font-size: 28px;
        }

        .banner-right {
            font-size: 20px;
            opacity: 0.95;
        }

        /* ========== Main Container ========== */
        .main-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            box-sizing: border-box;
            min-height: calc(100vh - 120px);
        }

        /* ========== Login Box ========== */
        .login-container {
            background: #fff;
            padding: 70px 60px;
            border-radius: 14px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.18);

            /* CHỈNH Ở ĐÂY CHO RỘNG HƠN */
            width: 650px;
            max-width: 95%;

            text-align: center;
            transition: transform 0.2s ease-in-out;
        }

        .login-container:hover {
            transform: translateY(-6px);
        }

        .login-container h1 {
            color: var(--primary-color);
            font-size: 36px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .login-container h2 {
            color: var(--text-color);
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 35px;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 15px;
            text-transform: uppercase;
        }

        /* ========== Form Styles ========== */
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            font-size: 17px;
            color: var(--text-color);
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 18px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 17px;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.35);
            outline: none;
        }

        .btnLogin {
            width: 100%;
            padding: 20px;
            background: var(--primary-color);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 15px;
        }

        .btnLogin:hover {
            background: #0056b3;
        }
    </style>
    </head>
    <body>
        <!-- Banner -->
        <div class="banner">
            <div class="banner-left">📚 Library Management</div>
            <div class="banner-right">Reader returns documents</div>
        </div>

        <!-- Main Content -->
        <div class="main-container">
            <div class="login-container">
                <h1>Welcome to University Library!</h1>
                <h2>Login Page</h2>
                <form method="post" action="<%= request.getContextPath() %>/StaffServlet">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <button type="submit" class="btnLogin">Login</button>
                </form>
            </div>
        </div>
    </body>
</html>
