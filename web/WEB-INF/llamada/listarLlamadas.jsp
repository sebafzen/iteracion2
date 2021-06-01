<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <%
            Class.forName("oracle.jdbc.OracleDriver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "sebafzen", "duoc");
            Statement st = con.createStatement();
            HttpSession sesion = request.getSession();
        %>
        
        <style>
            body{
                background-color: #EBFBE8;
            }
            table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 80%;
            }

            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
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
            .btn-buscar,
            .btn-todos,
            .btn-crear {

                    color: black;
                    border: 1px solid #fbfbf8;
            }

            .btn-sgant {
                    background-color: #A1FF6A;
                    color: #020747;
            }

            .btn-editar {
                    background: #93937f;
                    color: #fbfbf8;
            }

            .btn-eliminar {
                    background: #bf270f;
                    color: #fbfbf8;
            }
        </style>
    </head>
    <body>
        <ul>
            <li><a href="listarContrato">Contratos</a></li>
            <li><a href="listarCapacitacion">Capacitaciones</a></li>
            <li><a href="listarAsesoria">Asesorias</a></li>
            <li><a href="listarVisitas">Visitas</a></li>
            <li><a href="listarLlamadas">Llamadas</a></li>
            <li style="float:right"><a href="logout">Cerrar Sesion</a></li>
        </ul>
        <br>
        <a href="profesional">Home/ </a><a href="listarLlamadas">Listado de llamadas/ </a>
        <h2>Listado de Alertas</h2>
        <a href="registrarLlamada" class="btn btn-crear ">Registrar Llamada</a>
        <br><br>
	<table class="table table-sm table-striped">
            <thead>
                <tr>
                    <th>Fecha de Alerta</th>
                    <th>Descripción</th>
                    <th>Cliente</th>
                </tr>
            </thead>
            <tbody>
                <%  
                    String idProfes = sesion.getAttribute("idProfesional").toString();
                    String queryCapacitaciones = "select ll.FECHALLAMADA, ll.DESCRIPCIONLLAMADA, cl.NOMBRE from llamada ll INNER JOIN CLIENTE cl ON ll.cliente_rut_cliente = cl.rut_cliente WHERE ll.profesional_rut_profesional = '"+idProfes+"'";
                    ResultSet rsLlamadas = st.executeQuery(queryCapacitaciones);                
                    while(rsLlamadas.next()){
                    java.sql.Date fechaLla = rsLlamadas.getDate("FECHALLAMADA");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaLlam = dateFormat.format(fechaLla);
                %>
                <tr>
                    <th><%= fechaLlam%></th>
                    <th><%= rsLlamadas.getString("DESCRIPCIONLLAMADA")%></th>
                    <th><%= rsLlamadas.getString("NOMBRE")%></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
    </body>
</html>
