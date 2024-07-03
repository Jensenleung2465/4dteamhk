<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.IOException" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify User</title>
</head>
<body>
    <h1>Verify User</h1>

    <%
        // 從 JSON 文件中獲取用戶數據
        JSONParser parser = new JSONParser();
        try {
            Object obj = parser.parse(new FileReader("users.json"));
            JSONObject userData = (JSONObject) obj;

            // 獲取表單提交的用戶名和密碼
            String username = request.getParameter("name");
            String password = request.getParameter("pswd");

            // 進行用戶名密碼的驗證
            boolean isValidUser = false;
            for (Object key : userData.keySet()) {
                JSONArray users = (JSONArray) userData.get(key);
                for (int i = 0; i < users.size(); i++) {
                    JSONObject user = (JSONObject) users.get(i);
                    if (username != null && password != null && username.equals(user.get("name")) && password.equals(user.get("pswd"))) {
                        isValidUser = true;
                        break;
                    }
                }
                if (isValidUser) {
                    break;
                }
            }

            if (isValidUser) {
                // 用戶名密碼正確, 將用戶名發送到 PHP 頁面
                response.sendRedirect("send_to_php.php?username=" + username);
            } else {
                // 用戶名密碼錯誤, 顯示一個空白頁面
    %>
        <about:blank>
    <%
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
