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
            "SELECT trans_id, TO_CHAR(t_date, 'DD-MON-RR') AS t_date, amount " +
            "FROM Transactions " +
            "WHERE ssn=? " +
            "ORDER BY Transactions.t_date");

    ps.setString(1, ssn);

    ResultSet rs = ps.executeQuery();

    boolean first = true;

    while(rs.next()) {

        if(!first){
            out.print("#");
        }
            

        out.print(
            rs.getInt("trans_id") + "," +
            rs.getString("t_date") + "," +
            rs.getDouble("amount")
        );

        first = false;
    }

    rs.close();
    ps.close();
    conn.close();

}
catch(Exception e){
    out.print("ERROR");
}
%>