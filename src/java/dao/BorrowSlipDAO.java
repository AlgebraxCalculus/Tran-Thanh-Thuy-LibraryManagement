/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.DAO.con;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.BorrowSlip;
import model.BorrowSlipDetail;
import model.Document;
import model.DocumentCopy;

/**
 *
 * @author Admin
 */
public class BorrowSlipDAO extends DAO {
    public BorrowSlipDAO() {
	super();
    }
    
    public ArrayList<BorrowSlip> getBorrowedDocumentByReader(int id) {
        ArrayList<BorrowSlip> result = new ArrayList<BorrowSlip>();
        String sql = "SELECT bs.ID AS borrowSlipID, bsd.ID AS borrowSlipDetailID, dc.barcode, d.title, d.category, bs.borrowDate, bsd.dueDate "
                    + "FROM tbl_BorrowSlipDetail bsd "
                    + "JOIN tbl_BorrowSlip bs ON bsd.tbl_BorrowSlipID = bs.ID "
                    + "JOIN tbl_DocumentCopy dc ON bsd.tbl_DocumentCopyID = dc.ID "
                    + "JOIN tbl_Document d ON dc.tbl_DocumentID = d.ID "
                    + "WHERE bs.tbl_ReaderID = ? AND bsd.isReturned = FALSE";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            BorrowSlip currentSlip = null;
            int lastSlipId = -1;
            while(rs.next()){
                int borrowSlipID = rs.getInt("borrowSlipID");
                if (borrowSlipID != lastSlipId) {
                    currentSlip = new BorrowSlip();
                    currentSlip.setID(borrowSlipID);
                    currentSlip.setBorrowDate(rs.getDate("borrowDate").toLocalDate());
                    currentSlip.setListBorrowSlipDetail(new ArrayList<>());
                    result.add(currentSlip);
                    lastSlipId = borrowSlipID;
                }
                Document document = new Document();
                document.setTitle(rs.getString("title"));
                document.setCategory(rs.getString("category"));
                
                DocumentCopy documentCopy = new DocumentCopy();
                documentCopy.setBarcode(rs.getString("barcode"));
                documentCopy.setDocument(document);
                
                BorrowSlipDetail borrowSlipDetail = new BorrowSlipDetail();
                borrowSlipDetail.setID(rs.getInt("borrowSlipDetailID"));
                borrowSlipDetail.setDocumentCopy(documentCopy);
                borrowSlipDetail.setDueDate(rs.getDate("dueDate").toLocalDate());
                
                if (currentSlip != null) {
                    currentSlip.getListBorrowSlipDetail().add(borrowSlipDetail);
                }
            }
	} catch(Exception e){
            e.printStackTrace();
	}	
	return result;
    }
}
