/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.dbaapp.vista;

import javax.swing.JOptionPane;

/**
 *
 * @author yisus
 */
public class VistaCliente {
    public static void main(String[] args) {
    try {
            String x = JOptionPane.showInputDialog("Introduce un valor");
        double y = Double.parseDouble(x);
        System.out.println(y);
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
            System.out.println("Error: No se puede convertir una cadena a doble");
        }finally{
            System.out.println("Todo bien ok vato loco ");
        }
       
        System.out.println("Hola chavos");
    }
}
