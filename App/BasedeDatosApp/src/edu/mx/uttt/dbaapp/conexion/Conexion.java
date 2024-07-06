/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.dbaapp.conexion;
import java.sql.Connection;


/**
 *
 * @author yisus
 */
public class Conexion {
    public static void conectar(){
        String url = "jdbc:sqlserver://localhost:1433;databaseName=Northwind;encrypt=true;trustServerCertificate=true";
     
        String user = "sa";
        String password = "123456";
        
        conection con = null;
        
        try {
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Conexión exitosa a la base de datos!");
        } finally {
        }
    }
}
