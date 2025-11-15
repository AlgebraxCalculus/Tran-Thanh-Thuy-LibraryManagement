package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	public static Connection con;
	
	public DAO(){
		if(con == null){
			String dbUrl = "jdbc:mysql://localhost:3306/LibMan?autoReconnect=true&useSSL=false";
			String dbClass = "com.mysql.jdbc.Driver";

			try {
				Class.forName(dbClass);
				con = DriverManager.getConnection (dbUrl, "root", "Thuy2004@");
				System.out.println("CONNECTED SUCCESSFULLY!");
			}catch (Exception e) {
				 System.out.println("FAILED TO CONNECT DB!!!");
				e.printStackTrace();
				con = null;
			}
		}
	}
}