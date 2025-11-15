/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;

import model.BorrowSlipDetail;

/**
 *
 * @author Admin
 */
public class BorrowSlipDetailDAO extends DAO {
    public BorrowSlipDetailDAO() {
	super();
    }

    public boolean updateStatus(ArrayList<BorrowSlipDetail> listBorrowSlipDetail) {
        boolean result = true;
        String updateStatusSql = "UPDATE tbl_BorrowSlipDetail SET isReturned = ? WHERE ID = ?";

        try {
            con.setAutoCommit(false);

            PreparedStatement ps = con.prepareStatement(updateStatusSql);

            for (BorrowSlipDetail bsd : listBorrowSlipDetail) {
                ps.setBoolean(1, true);  
                ps.setInt(2, bsd.getID());
                ps.executeUpdate();
            }

            con.commit();

        } catch (Exception e) {
            result = false;
            try {
                con.rollback();
            } catch (Exception ex) {
                result = false;
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ex) {
                result = false;
                ex.printStackTrace();
            }
        }

        return result;
    }

}
