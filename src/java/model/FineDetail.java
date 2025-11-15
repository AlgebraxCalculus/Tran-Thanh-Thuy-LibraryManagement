/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class FineDetail {
    private int ID;
    private String note;
    private Fine fine;

    public FineDetail() {
        super();
    }

    public FineDetail(String note, Fine fine) {
        this.note = note;
        this.fine = fine;
    }

    public int getID() {
        return ID;
    }

    public String getNote() {
        return note;
    }

    public Fine getFine() {
        return fine;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setFine(Fine fine) {
        this.fine = fine;
    }
    
}
