<%@ page import="db.ConnectionProvider"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String sql = "select * from student";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = ConnectionProvider.getConnection();
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
        %>
        <table border="1">
            <tr>
                <th>이름</th>
                <th>국어</th>
                <th>영어</th>
                <th>수학</th>
                <th>총점</th>
                <th>평균</th>
            </tr>
            <%while (rs.next()) {%>
            <tr>
                <td>
                    <%= rs.getString("name") %>
                </td>
                <td>
                    <%= rs.getInt("kor") %>
                </td>
                <td>
                    <%= rs.getInt("eng") %>
                </td>
                <td>
                    <%= rs.getInt("math") %>
                </td>
                <td>
                    <%= rs.getInt("tot") %>
                </td>
                <td>
                    <%= rs.getInt("avg") %>
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
                ConnectionProvider.close(conn, stmt, rs);
            }
        %>
    </body>
</html>
