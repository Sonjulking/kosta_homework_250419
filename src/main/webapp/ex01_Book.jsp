<%@ page import="db.ConnectionProvider"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
    <head>
        <title>Title</title>
        <style>

            body {
                font-family: '맑은 고딕';
                background: linear-gradient(to bottom, white, pink);
                color: black;
                padding: 40px;
            }

            h2 {
                color: lightpink;
                text-align: center;
                margin-bottom: 30px;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            }

            table {
                margin: 0 auto;
                width: 60%;
                border-collapse: separate;
                background-color: #ffffffcc;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            th {
                border-radius: 5px;
                padding: 15px;
                font-size: 18px;
                background-color: rgba(221, 160, 221, 0.5);
                font-weight: bold;
                color: #333333;
                text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.5);
            }

            td {
                border-radius: 5px;
                text-align: center;
                padding: 12px;
                font-size: 16px;

            }

        </style>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            LocalDate today = LocalDate.now(); //오늘 날짜 구하기
            String publisher = request.getParameter("publisher");
            String sql = "SELECT b.bookname, b.price " +
                    "FROM orders o " +
                    "JOIN book b " +
                    "ON b.bookid = o.bookid " +
                    "AND b.publisher = ? " +
                    "AND TO_CHAR(o.orderdate, 'yyyy-mm-dd') = TO_CHAR(SYSDATE, 'yyyy-mm-dd')";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = ConnectionProvider.getConnection();
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, publisher);
                rs = pstmt.executeQuery();
        %>
        <h2>
            금일(<%=today%>) <%=publisher%> 출판사에서 판매된 도서 정보
        </h2>
        <table>
            <tr>
                <th>책제목</th>
                <th>가격</th>
            </tr>
            <%while (rs.next()) {%>
            <tr>
                <td>
                    <%= rs.getString("bookname") %>
                </td>
                <td>
                    <%= rs.getInt("price") %>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <%
            } catch (SQLException e) {
                System.out.println("예외발생 : " + e.getMessage());
            } finally {
                ConnectionProvider.close(conn, pstmt, rs);
            }
        %>

    </body>
</html>
