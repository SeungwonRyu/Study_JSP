package table;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class FeatureDAO {
    private Connection conn = null;
    private Statement stmt = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    // 생성자 (클래스 생성시 DB 연결)
    public FeatureDAO() {
        try {
            String url = "jdbc:sqlserver://10.3.9.207:1433;DatabaseName=slim";
            String id = "sa";
            String pw = "drsoft1234!";
            String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

            Class.forName(driver);
            conn = DriverManager.getConnection(url, id, pw);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<FeatureDTO> featureSelect() {
        ArrayList<FeatureDTO> featureDTO = new ArrayList<FeatureDTO>();

        try {
            String sql = "select * from slimFeatureCodes";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while(rs.next()) {
                String serverName = rs.getString("ServerName");
                String feature = rs.getString("Feature");
                int maxLicense = rs.getInt("DisplayMaxLicense");
                int updateLicense = rs.getInt("UpdateMaxLicense");

                FeatureDTO fdto = new FeatureDTO(serverName, feature, maxLicense, updateLicense);
                featureDTO.add(fdto);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }

        return featureDTO;
    }
}