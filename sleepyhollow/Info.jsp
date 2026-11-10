<%@ page import="java.sql.*" %>

<%
try {

    String ssn = request.getParameter("ssn");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn =
        DriverManager.getConnection(
            "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
            "user",
            System.getenv("DB_PASSWORD"));

    // To prevent SQL injection prepared statement is added.
    PreparedStatement ps =
        conn.prepareStatement(
            "SELECT e.name, NVL(SUM(es.total_sales),0) " +
            "FROM Employees e " +
            "LEFT JOIN Emp_Sales es ON e.ssn=es.ssn " +
            "WHERE e.ssn=? " +
            "GROUP BY e.name");

    ps.setString(1, ssn);

    ResultSet rs = ps.executeQuery();

    if(rs.next()) {
        out.print(
            rs.getString(1) + "," +
            rs.getDouble(2)
        );
    }

    rs.close();
    ps.close();
    conn.close();

}
catch(Exception e){
    out.print("ERROR");
}
%>