import java.io.*;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");

        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");

            Connection conn =
                DriverManager.getConnection(
                    "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu",
                    "mmahtab",
                    System.getenv("DB_PASSWORD"));

            PreparedStatement ps =
                conn.prepareStatement(
                    "SELECT ssn FROM Login " +
                    "WHERE username=? AND passwd=?");

            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                response.getWriter().print(
                    "Yes:" + rs.getString("ssn"));
            }
            else {
                response.getWriter().print("No");
            }

            rs.close();
            ps.close();
            conn.close();

        }
        catch(Exception e) {
            response.getWriter().print("No");
        }
    }
}