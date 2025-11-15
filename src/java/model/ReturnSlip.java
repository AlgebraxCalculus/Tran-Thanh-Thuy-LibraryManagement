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
public class ReturnSlip {
    private int ID;
    private LocalDate returnDate;
    private float totalFine;
    private ArrayList<ReturnSlipDetail> listReturnSlipDetail;
    private Reader reader;
    private Staff staff;

    public ReturnSlip() {
        super();
        listReturnSlipDetail = new ArrayList<>();
    }

    public ReturnSlip(LocalDate returnDate, float totalFine,Reader reader, Staff staff) {
        this.returnDate = returnDate;
        this.totalFine = totalFine;
        this.reader = reader;
        this.staff = staff;
        listReturnSlipDetail = new ArrayList<>();
    }

    public int getID() {
        return ID;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public float getTotalFine() {
        return totalFine;
    }

    public ArrayList<ReturnSlipDetail> getListReturnSlipDetail() {
        return listReturnSlipDetail;
    }

    public Reader getReader() {
        return reader;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public void setTotalFine(float totalFine) {
        this.totalFine = totalFine;
    }

    public void setListReturnSlipDetail(ArrayList<ReturnSlipDetail> listReturnSlipDetail) {
        this.listReturnSlipDetail = listReturnSlipDetail;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }
    
}
