package dao;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {

            System.out.println("================================");
            System.out.println("StudyHub MySQL Connection SUCCESS!");
            System.out.println("================================");

        } else {

            System.out.println("================================");
            System.out.println("StudyHub MySQL Connection FAILED!");
            System.out.println("================================");

        }
    }
}