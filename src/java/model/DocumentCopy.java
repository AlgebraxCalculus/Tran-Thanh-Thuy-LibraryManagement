/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class DocumentCopy {
    private int ID;
    private String barcode;
    private String condition;
    private String status;
    private Document document;

    public DocumentCopy() {
        super();
    }

    public DocumentCopy(String barcode, String condition, String status, Document document) {
        this.barcode = barcode;
        this.condition = condition;
        this.status = status;
        this.document = document;
    }

    public int getID() {
        return ID;
    }

    public String getBarcode() {
        return barcode;
    }

    public String getCondition() {
        return condition;
    }

    public String getStatus() {
        return status;
    }

    public Document getDocument() {
        return document;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setDocument(Document document) {
        this.document = document;
    }
    
}
