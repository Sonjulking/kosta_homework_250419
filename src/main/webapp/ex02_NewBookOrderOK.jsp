<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="db.ConnectionProvider"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
    <head>
        <title>Title</title>
        <style>
            h2 {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            int custid = Integer.parseInt(request.getParameter("custid"));
            int bookid = Integer.parseInt(request.getParameter("bookid"));


            Connection conn = null;
            int maxOrderId;
            String maxIdSql = "select max(orderid) as maxId from orders";
            Statement maxIdstmt = null;
            ResultSet maxIdRs = null;

            int bookPrice;
            String bookPriceSql = "select price from book where bookid=?";
            PreparedStatement bookPricePstmt = null;
            ResultSet bookPriceRs = null;

            int re = -1;
            String orderInsertSql = "insert into orders(orderid, custid, bookid, saleprice, orderdate) values (?, ?, ?, ?, sysdate) ";
            PreparedStatement orderInsertPstmt = null;

            try {
                conn = ConnectionProvider.getConnection();

                maxIdstmt = conn.createStatement();
                maxIdRs = maxIdstmt.executeQuery(maxIdSql);

                if (maxIdRs.next()) {
                    maxOrderId = maxIdRs.getInt("maxId");
                } else {
                    maxOrderId = 0;
                }
                bookPricePstmt = conn.prepareStatement(bookPriceSql);
                bookPricePstmt.setInt(1, bookid);
                bookPriceRs = bookPricePstmt.executeQuery();

                if (bookPriceRs.next()) {
                    bookPrice = bookPriceRs.getInt("price");
                } else {
                    bookPrice = 0;
                }

                orderInsertPstmt = conn.prepareStatement(orderInsertSql);
                orderInsertPstmt.setInt(1, maxOrderId + 1); //최대 orderid값 + 1해줌
                orderInsertPstmt.setInt(2, custid);
                orderInsertPstmt.setInt(3, bookid);
                orderInsertPstmt.setInt(4, (int) (bookPrice + (bookPrice * 0.1))); //책가격의 10%마진 설정
                re = orderInsertPstmt.executeUpdate();
        %>
        <%if (re > 0) {%>
        <h2 style="color:green;">성공</h2>
        <%} else {%>
        <h2 style="color: red;">실패</h2>
        <%}%>
        <%
            } catch (Exception e) {
                System.out.println("예외발생 : " + e.getMessage());
            } finally {
            }
        %>
    </body>
</html>
