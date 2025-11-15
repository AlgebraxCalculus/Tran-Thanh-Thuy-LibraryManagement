/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Staff;

/**
 *
 * @author Admin
 */
public class StaffDAO extends DAO {
    public StaffDAO() {
	super();
    }
    
    public boolean checkLogin(Staff staff) {
	boolean result = false;
	String sql = "SELECT lm.ID, lm.fullName, s.role "
                   + "FROM tbl_LibraryMember lm "
                   + "JOIN tbl_Staff s ON lm.ID = s.tbl_LibraryMemberID "
                   + "WHERE lm.username = ? AND lm.password = ?";
	try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staff.getUsername());
            ps.setString(2, staff.getPassword());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                staff.setID(rs.getInt("ID"));
		staff.setFullName(rs.getString("fullName"));
                staff.setRole(rs.getString("role"));
		result = true;
            }
	} catch(Exception e){
            e.printStackTrace();
	}
	return result;
    }
}
