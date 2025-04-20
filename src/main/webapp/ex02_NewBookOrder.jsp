<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="db.ConnectionProvider"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
    <head>
        <title>Title</title>
        <style>
            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");

            String bookNameSql = "select bookid, bookname from book";
            String customerNameSql = "select custid, name from customer";

            Connection conn = null;
            Statement bookStmt = null;
            Statement customerStmt = null;

            ResultSet bookRs = null;
            ResultSet customerRs = null;

            try {
                conn = ConnectionProvider.getConnection();
                customerStmt = conn.createStatement();
                bookStmt = conn.createStatement();
                customerRs = customerStmt.executeQuery(customerNameSql);
                bookRs = bookStmt.executeQuery(bookNameSql);

        %>

        <form action="ex02_NewBookOrderOK.jsp" method="post">
            <select name="custid">
                <%while (customerRs.next()) {%>
                <option value=<%=customerRs.getInt("custid")%>>
                    <%=customerRs.getString("name")%>
                </option>
                <%
                    }
                %>
            </select>
            <select name="bookid">
                <%while (bookRs.next()) {%>
                <option value=<%=bookRs.getInt("bookid")%>>
                    <%=bookRs.getString("bookname")%>
                </option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="제출">
        </form>
        <%
            } catch (Exception e) {
                System.out.println("예외발생 : " + e.getMessage());
            } finally {
                ConnectionProvider.close(conn, bookStmt, bookRs);
                ConnectionProvider.close(conn, customerStmt, customerRs);
            }
        %>
    </body>
</html>
