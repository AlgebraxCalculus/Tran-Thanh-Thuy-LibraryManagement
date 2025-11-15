/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.DAO.con;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.FineDetail;
import model.ReturnSlip;
import model.ReturnSlipDetail;

/**
 *
 * @author Admin
 */
public class ReturnSlipDAO extends DAO {
    public ReturnSlipDAO() {
	super();
    }
    
    public boolean addReturnSlip(ReturnSlip returnSlip) {
        boolean result = true;

        String addReturnSlipSql = "INSERT INTO tbl_ReturnSlip (returnDate, tbl_ReaderID, tbl_StaffID) VALUES (?, ?, ?)";
        String addReturnSlipDetailSql = "INSERT INTO tbl_ReturnSlipDetail (tbl_ReturnSlipID, tbl_BorrowSlipDetailID) VALUES (?, ?)";
        String addFineDetailSql = "INSERT INTO tbl_FineDetail (note, tbl_ReturnSlipDetailID, tbl_FineID) VALUES (?, ?, ?)";

        try {
            con.setAutoCommit(false);

            // Thêm ReturnSlip
            PreparedStatement ps = con.prepareStatement(addReturnSlipSql, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, java.sql.Date.valueOf(returnSlip.getReturnDate()));
            ps.setInt(2, returnSlip.getReader().getID());
            ps.setInt(3, returnSlip.getStaff().getID());
            System.out.println("DEBUG returnDate: " + returnSlip.getReturnDate());
            System.out.println("DEBUG staffID: " + returnSlip.getStaff().getID());
            System.out.println("DEBUG readerID: " + returnSlip.getReader().getID());

            ps.executeUpdate();

            ResultSet generatedSlipKeys = ps.getGeneratedKeys();
            int returnSlipId = 0;
            if (generatedSlipKeys.next()) {
                returnSlipId = generatedSlipKeys.getInt(1);
            }

            // Thêm từng ReturnSlipDetail
            ArrayList<ReturnSlipDetail> listRSD = returnSlip.getListReturnSlipDetail();
            if (listRSD != null && !listRSD.isEmpty()) {
                for (ReturnSlipDetail rsd : listRSD) {
                    PreparedStatement psDetail = con.prepareStatement(addReturnSlipDetailSql, Statement.RETURN_GENERATED_KEYS);
                    psDetail.setInt(1, returnSlipId);
                    psDetail.setInt(2, rsd.getBorrowSlipDetail().getID());
                    psDetail.executeUpdate();

                    ResultSet generatedDetailKeys = psDetail.getGeneratedKeys();
                    int rsdId = 0;
                    if (generatedDetailKeys.next()) {
                        rsdId = generatedDetailKeys.getInt(1);
                    }

                    // Thêm FineDetail nếu có
                    ArrayList<FineDetail> listFine = rsd.getListFineDetail();
                    if (listFine != null && !listFine.isEmpty()) {
                        for (FineDetail fd : listFine) {
                            PreparedStatement psFine = con.prepareStatement(addFineDetailSql);
                            psFine.setString(1, fd.getNote());
                            psFine.setInt(2, rsdId);
                            psFine.setInt(3, fd.getFine().getID());
                            psFine.executeUpdate();
                            psFine.close();
                        }
                    }

                    psDetail.close();
                    generatedDetailKeys.close();
                }
            }

            // Commit toàn bộ
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
