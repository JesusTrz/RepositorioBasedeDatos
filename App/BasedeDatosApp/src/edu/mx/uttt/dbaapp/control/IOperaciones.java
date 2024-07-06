/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package edu.mx.uttt.dbaapp.control;

import java.util.List;

/**
 *
 * @author yisus
 */
public interface IOperaciones {
    void agregar(Objet cli);
    boolean eliminar(Objet cli);
    boolean actualizar(Objet cli);
    List<Object> consultar();
}
