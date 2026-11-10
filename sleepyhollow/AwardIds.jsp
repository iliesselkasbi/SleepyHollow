<%@ page import="java.sql.*" %>

<%
try {

    String ssn = request.getParameter("ssn");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn =
        DriverManager.getConnection(
            "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
            "user",
            "pass");

    // To prevent SQL injection prepared statement is added.
    PreparedStatement ps =
        conn.prepareStatement(
            "SELECT DISTINCT award_id " +
            "FROM Granted " +
            "WHERE ssn=?");

    ps.setString(1, ssn);

    ResultSet rs = ps.executeQuery();

    boolean first = true;

    while(rs.next()) {

        if(!first)
            out.print("#");

        out.print(rs.getInt(1));

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