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
                background: linear-gradient(135deg, #f0f2f5 0%, #e0e7ff 100%);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .banner {
                background: var(--primary-color);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 25px 60px;
                font-size: 26px;
                font-weight: 700;
                letter-spacing: 0.5px;
                width: 100%;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            }

            .banner-left {
                font-size: 30px;
            }

            .banner-right {
                font-size: 20px;
                font-weight: normal;
                opacity: 0.95;
            }

            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                padding: 60px 0;
            }

            .reader-container {
                background: #fff;
                padding: 60px 70px;
                border-radius: 20px;
                box-shadow: 0 10px 35px rgba(0, 0, 0, 0.2);
                text-align: center;
                width: 500px;
                max-width: 90%;
                transition: transform 0.3s ease;
            }

            .reader-container:hover {
                transform: translateY(-8px);
            }

            .reader-container h1 {
                color: var(--primary-color);
                font-size: 32px;
                margin-bottom: 20px;
            }

            .reader-container p {
                color: var(--text-color);
                font-size: 19px;
                margin-bottom: 40px;
            }

            .btnRegistering {
                display: inline-block;
                padding: 18px 30px;
                border-radius: 12px;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                color: white;
                background: var(--primary-color);
                transition: all 0.3s ease;
                width: 100%;
                box-sizing: border-box;
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            }

            .btnRegistering:hover {
                background: #0056b3;
                box-shadow: 0 7px 20px rgba(0, 86, 179, 0.5);
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
                <a href="RegisterCard.jsp" class="btnRegistering">Register Reader Card</a>
            </div>
        </div>
    </body>
</html>
