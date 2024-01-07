import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class ReservationBean {
    private Connection con;

    public ReservationBean(String filePath) {
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            con = DriverManager.getConnection("jdbc:ucanaccess://" + filePath + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ResultSet getReservationData() {
        ResultSet resultSet = null;
        try {
            Statement smt = con.createStatement();
            String sql = "SELECT prescription.Date, prescription.Time, Count(prescription.Time) AS time之筆數 FROM prescription GROUP BY prescription.Date, prescription.Time ORDER BY prescription.Time";
            resultSet = smt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public void closeConnection() {
        try {
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}