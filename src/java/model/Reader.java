/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Reader extends LibraryMember {
    private ReaderCard readerCard;

    public Reader() {
        super();
    }
    
    public Reader(ReaderCard readerCard) {
        super();
        this.readerCard = readerCard;
    }

    public ReaderCard getReaderCard() {
        return readerCard;
    }

    public void setReaderCard(ReaderCard readerCard) {
        this.readerCard = readerCard;
    }
    
}
