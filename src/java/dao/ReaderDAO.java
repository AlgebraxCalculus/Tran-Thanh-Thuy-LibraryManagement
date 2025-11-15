/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Reader;
import model.ReaderCard;

/**
 *
 * @author Admin
 */
public class ReaderDAO extends DAO {
    public ReaderDAO() {
	super();
    }
    
    public boolean addReader (Reader reader, ReaderCard readerCard) {
        boolean result = true;
        String addMembersql = "INSERT INTO tbl_LibraryMember"
                + "(username, password, fullName, dateOfBirth, address, phoneNumber) VALUES "
                + "(?, ?, ?, ?, ?, ?)";
        String addReadersql = "INSERT INTO tbl_Reader"
                + "(tbl_LibraryMemberID) VALUES "
                + "(?)";
        String addReaderCardsql = "INSERT INTO tbl_ReaderCard"
                + "(issueDate, tbl_ReaderID) VALUES (CURRENT_DATE, ?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(addMembersql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, reader.getUsername());
            ps.setString(2, reader.getPassword());
            ps.setString(3, reader.getFullName());
            ps.setDate(4, java.sql.Date.valueOf(reader.getDateOfBirth()));
            ps.setString(5, reader.getAddress());
            ps.setString(6, reader.getPhoneNumber());
            ps.executeUpdate();
            
            ResultSet generatedKeys = ps.getGeneratedKeys(); 
            if (generatedKeys.next()) {
                int readerId = generatedKeys.getInt(1);
                ps = con.prepareStatement(addReadersql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, readerId);
                ps.executeUpdate();
                
                ps = con.prepareStatement(addReaderCardsql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, readerId);
                ps.executeUpdate();
            }
            con.commit();
        } catch(Exception e) {
            result = false;
            try {
		con.rollback();
	} catch(Exception ex) {
		result = false;
		ex.printStackTrace();
	}
                e.printStackTrace();
	} finally {
		try {
                    con.setAutoCommit(true);
		}catch(Exception ex) {
                    result = false;
                    ex.printStackTrace();
		}
	}
	return result;
    }
    
    public ArrayList<Reader> searchReader (int id) {
        ArrayList<Reader> result = new ArrayList<Reader>();
        String sql = "SELECT lm.ID, lm.fullName, lm.address, lm.phoneNumber "
                   + "FROM tbl_LibraryMember lm "
                   + "JOIN tbl_Reader r ON lm.ID = r.tbl_LibraryMemberID "
                   + "WHERE lm.ID = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Reader reader = new Reader();
                reader.setID(rs.getInt("ID"));
                reader.setFullName(rs.getString("fullName"));
                reader.setAddress(rs.getString("address"));
                reader.setPhoneNumber(rs.getString("phoneNumber"));
                result.add(reader);
            }
	}catch(Exception e){
            e.printStackTrace();
	}	
	return result;
    }
}
