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
public class ReaderCard {
    private int ID;
    private LocalDate issueDate;
    private LocalDate expiryDate;

    public ReaderCard() {
        super();
    }

    public ReaderCard(LocalDate issueDate) {
        super();
        this.issueDate = LocalDate.now();
    }

    public int getID() {
        return ID;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public LocalDate getExpiryDate() {
        return issueDate.plusYears(1);
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }
    
}
