package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {

    public static boolean registerUser(
            String name,
            String email,
            String course,
            int semester,
            String password) {

        String sql = "INSERT INTO users " +
                     "(name, email, course, semester, password) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                return false;
            }

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, course);
            ps.setInt(4, semester);
            ps.setString(5, password);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}