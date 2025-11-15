/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Fine {
    private int ID;
    private String name;
    private float amount;

    public Fine() {
        super();
    }

    public Fine(String name, float amount) {
        this.name = name;
        this.amount = amount;
    }

    public int getID() {
        return ID;
    }

    public String getName() {
        return name;
    }

    public float getAmount() {
        return amount;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
    
}
