/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class ReturnSlipDetail {
    private int ID;
    private int overdueDays;
    private ArrayList<FineDetail> listFineDetail;
    private BorrowSlipDetail borrowSlipDetail;

    public ReturnSlipDetail() {
        super();
        listFineDetail = new ArrayList<>();
    }

    public ReturnSlipDetail(int overdueDays, BorrowSlipDetail borrowSlipDetail) {
        this.overdueDays = overdueDays;
        listFineDetail = new ArrayList<>();
        this.borrowSlipDetail = borrowSlipDetail;
    }

    public int getID() {
        return ID;
    }

    public int getOverdueDays() {
        return overdueDays;
    }

    public ArrayList<FineDetail> getListFineDetail() {
        return listFineDetail;
    }

    public BorrowSlipDetail getBorrowSlipDetail() {
        return borrowSlipDetail;
    }

    public void setOverdueDays(int overdueDays) {
        this.overdueDays = overdueDays;
    }

    public void setListFineDetail(ArrayList<FineDetail> listFineDetail) {
        this.listFineDetail = listFineDetail;
    }

    public void setBorrowSlipDetail(BorrowSlipDetail borrowSlipDetail) {
        this.borrowSlipDetail = borrowSlipDetail;
    }
    
}
