/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.DAO.con;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Fine;

/**
 *
 * @author Admin
 */
public class FineDAO extends DAO {
    public FineDAO() {
	super();
    }
    
    public ArrayList<Fine> searchFine (String key) {
        ArrayList<Fine> result = new ArrayList<Fine>();
        String sql = "SELECT * FROM tbl_Fine WHERE name LIKE ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Fine fine = new Fine();
                fine.setID(rs.getInt("ID"));
                fine.setName(rs.getString("name"));
                fine.setAmount(rs.getFloat("amount"));
                result.add(fine);
            }
	}catch(Exception e){
            e.printStackTrace();
	}	
	return result;
    }
}
