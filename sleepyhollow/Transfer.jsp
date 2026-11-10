<%@ page import="java.sql.*" %>

<%
try {
    String ssn1 = request.getParameter("ssn1");
    String ssn2 = request.getParameter("ssn2");
    String amount = request.getParameter("amount");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn =
        DriverManager.getConnection(
            "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
            "user",
            System.getenv("DB_PASSWORD"));

    // Check if the destination SSN exists in the Employees table
    PreparedStatement checkPs = conn.prepareStatement(
        "SELECT COUNT(*) FROM Employees WHERE ssn = ?"
    );

    checkPs.setString(1, ssn2);
    ResultSet checkRs = checkPs.executeQuery();
    
    int count = 0;
    if (checkRs.next()) {
        count = checkRs.getInt(1);
    }
    checkRs.close();
    checkPs.close();

    // If ssn does not exist, alert the client immediately.

    if (count == 0) {
        out.print("INVALID_DESTINATION");
    } else {
        // Otherwise, we proceed with the transfer insert
        
        PreparedStatement ps =
            conn.prepareStatement(
                "INSERT INTO Transfer " +
                "(from_ssn,to_ssn,transfer_date,amount) " +
                "VALUES(?,?,SYSDATE,?)");

        ps.setString(1, ssn1);
        ps.setString(2, ssn2);
        ps.setDouble(3, Double.parseDouble(amount));

        ps.executeUpdate();
        ps.close();

        out.print("transfer completed");
    }

    conn.close();

}
catch(Exception e){
    out.print("ERROR");
}
%>