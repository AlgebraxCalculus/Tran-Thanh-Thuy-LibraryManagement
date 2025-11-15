/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class BorrowSlip {
    private int ID;
    private LocalDate borrowDate;
    private String note;
    private Reader reader;
    private ArrayList<BorrowSlipDetail> listBorrowSlipDetail;

    public BorrowSlip() {
        super();
        listBorrowSlipDetail = new ArrayList<>();
    }

    public BorrowSlip(LocalDate borrowDate, String note, Reader reader) {
        this.borrowDate = borrowDate;
        this.note = note;
        this.reader = reader;
        listBorrowSlipDetail = new ArrayList<>();
    }

    public int getID() {
        return ID;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public String getNote() {
        return note;
    }

    public Reader getReader() {
        return reader;
    }

    public ArrayList<BorrowSlipDetail> getListBorrowSlipDetail() {
        return listBorrowSlipDetail;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public void setListBorrowSlipDetail(ArrayList<BorrowSlipDetail> listBorrowSlipDetail) {
        this.listBorrowSlipDetail = listBorrowSlipDetail;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
    
}
