<%@ page import = "java.sql.*" %>

<% 
try {
    String awardid = request.getParameter("awardid");
    String ssn = request.getParameter("ssn");

    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn = 
        DriverManager.getConnection(
            "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
            "user",
            "pass");

    // To prevent SQL injection prepared statement is added.

    PreparedStatement ps = conn.prepareStatement(

        // TO_CHAR() is added because java was converting the date to YYYY-MM-DD format.

        "SELECT TO_CHAR(g.award_date, 'DD-MON-RR') AS formatted_date, ac.center_name " +
        "FROM Granted g " +
        "JOIN Award_Centers ac " +
        "ON g.center_id = ac.center_id " +
        "WHERE g.award_id = ? AND g.ssn = ?");

        ps.setInt(1, Integer.parseInt(awardid));
        ps.setString(2, ssn);

        ResultSet rs = ps.executeQuery();

        boolean first = true;

        while(rs.next()) {

            if(!first) {
                out.print("#");
            }

            out.print(

                
                rs.getString(1) + "," + // changed this line from rs.getDate(1) to getString(1)
                rs.getString(2)
            );

            first = false;
        }

        rs.close();
        ps.close();
        conn.close();
    }

    catch (Exception e) {
        out.print("ERROR");
    }
%>