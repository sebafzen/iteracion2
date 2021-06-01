<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
        Class.forName("oracle.jdbc.OracleDriver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "sebafzen", "duoc");
        Statement st = con.createStatement();
    %>
    
    <style>
        
        body{
                background-color: #EBFBE8;
            }
         input[type=text],input[type=password],input[type=number],input[type=email], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        div {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }
        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover:not(.active) {
            background-color: #111;
        }

        .active {
            background-color: #4CAF50;
        }
    </style>
    <body>
        <%
            HttpSession sesion = request.getSession();
            String email;
            String pass;
                
            if(sesion.getAttribute("email") != null && sesion.getAttribute("pass") != null){
                email = sesion.getAttribute("email").toString();
                pass = sesion.getAttribute("pass").toString();
            }
        %>
        <ul>
            <li><a href="listarContrato">Contratos</a></li>
            <li><a href="listarCapacitacion">Capacitaciones</a></li>
            <li><a href="listarAsesoria">Asesorias</a></li>
            <li><a href="listarVisitas">Visitas</a></li>
            <li><a href="listarLlamadas">Llamadas</a></li>
            <li style="float:right"><a href="logout">Cerrar Sesion</a></li>
        </ul>
        <br>
        <a href="profesional">Home/ </a><a href="listarLlamadas">Listado de llamadas/ </a><a href="registrarLlamada">Registar llamada/ </a>
        <h3>Registrar Llamada</h3>

        <div>
            <form action="registrarLlamada" method="POST">
                <label>Fecha de Llamada</label>
                <br><br>
                <input type="date" name="fLlamada" required>
                <br><br>
                <label>Descripcion de Llamada</label>
                <input type="text" name="descLlamada" placeholder="Escriba la Descripción de la Llamada" required>
                <label>Cliente</label>
                <select name="id_cliente">
                    <option value="sinAsignar" disabled selected hidden>Sin Asignar</option>
                    <%    
                      //Mostrar Profesionales en ComboBox  
                      String queryCliente = "SELECT cl.RUT_CLIENTE, cl.NOMBRE FROM CLIENTE cl INNER JOIN CONTRATO co ON cl.rut_cliente = co.cliente_rut_cliente ORDER BY NOMBRE";
                      ResultSet rsCliente = st.executeQuery(queryCliente);
                      
                      while(rsCliente.next()){
                    %>
                        <option value="<%=rsCliente.getString("RUT_CLIENTE")%>"><%=rsCliente.getString("NOMBRE")%></option>
                    <%
                      } 
                    %>
                </select>
                <br><br>
                
                <input type="submit" value="Registrar Llamada">
            </form>
        </div>
    </body>
</html>