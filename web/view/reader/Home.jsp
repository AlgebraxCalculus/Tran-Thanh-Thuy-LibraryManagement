<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Homepage</title>
        <style>
            :root {
                --primary-color: #007bff;
                --background-color: #f0f2f5;
                --text-color: #333;
                --border-color: #ddd;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: var(--background-color);
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

            /* Container chính */
            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .reader-container {
                background: #fff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 400px;
            }

            .reader-container h1 {
                color: var(--primary-color);
                font-size: 26px;
                margin-bottom: 10px;
            }

            .reader-container p {
                color: var(--text-color);
                font-size: 16px;
                margin-bottom: 30px;
            }

            .btn {
                display: inline-block;
                padding: 14px 25px;
                border-radius: 6px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
                color: white;
                background: var(--primary-color);
                transition: background 0.3s ease;
                width: 100%;
                box-sizing: border-box;
            }

            .btn:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="banner">
            <div class="banner-left">📚 Library Management</div>
            <div class="banner-right">Reader registers as a reader card</div>
        </div>

        <div class="main-container">
            <div class="reader-container">
                <h1>Welcome, new reader!</h1>
                <p>Please select a function below:</p>
                <a href="RegisterCard.jsp" class="btn">Register Reader Card</a>
            </div>
        </div>
    </body>
</html>
