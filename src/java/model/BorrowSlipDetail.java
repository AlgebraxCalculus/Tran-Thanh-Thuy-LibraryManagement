/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author Admin
 */
public class BorrowSlipDetail {
    private int ID;
    private LocalDate dueDate;
    private boolean isReturned;
    private DocumentCopy documentCopy;

    public BorrowSlipDetail() {
        super();
    }

    public BorrowSlipDetail(LocalDate dueDate, boolean isReturned, DocumentCopy documentCopy) {
        this.dueDate = dueDate;
        this.isReturned = isReturned;
        this.documentCopy = documentCopy;
    }

    public int getID() {
        return ID;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public boolean isIsReturned() {
        return isReturned;
    }

    public DocumentCopy getDocumentCopy() {
        return documentCopy;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public void setIsReturned(boolean isReturned) {
        this.isReturned = isReturned;
    }

    public void setDocumentCopy(DocumentCopy documentCopy) {
        this.documentCopy = documentCopy;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
}
