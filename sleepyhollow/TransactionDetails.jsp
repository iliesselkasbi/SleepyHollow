<%@ page import="java.sql.*" %>

<%
try {

    String txnid = request.getParameter("txnid");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn =
        DriverManager.getConnection(
            "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
            "user",
            "pass");

    // To prevent SQL injection prepared statement is added.
    
    PreparedStatement ps1 =
        conn.prepareStatement(
            "SELECT TO_CHAR(t_date,'DD-MON-RR'), amount " + // Wrapped t_date in TO_CHAR with 'DD-MON-RR' format.
            "FROM Transactions " +
            "WHERE trans_id=?");

    ps1.setInt(1, Integer.parseInt(txnid));

    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()) {

        out.print(
            rs1.getString(1) + "," +
            rs1.getDouble(2)
        );
    }

    PreparedStatement ps2 =
        conn.prepareStatement(
            "SELECT p.prod_name, p.p_price, tp.quantity " +
            "FROM Txns_Prods tp " +
            "JOIN Products p " +
            "ON tp.prod_id = p.prod_id " +
            "WHERE tp.trans_id=?");

    ps2.setInt(1, Integer.parseInt(txnid));

    ResultSet rs2 = ps2.executeQuery();

    while(rs2.next()) {

        out.print("#");

        out.print(
            rs2.getString(1) + "," +
            rs2.getDouble(2) + "," +
            rs2.getInt(3)
        );
    }

    rs1.close();
    rs2.close();
    ps1.close();
    ps2.close();
    conn.close();

}
catch(Exception e){
    out.print("ERROR");
}
%>