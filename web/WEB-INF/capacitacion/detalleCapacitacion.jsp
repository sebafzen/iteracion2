<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="ConexionconBD.ConexionBD"%>
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
        <a href="profesional">Home/ </a><a href="listarContrato">Listado de Capacitaciones/ </a><a href="detallesContrato">Detalle de Capacitación/ </a>
        <h2>Capacitación N°<%=request.getParameter("idCapacitacionSeleccionada")%></h2>
        <br>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Fecha</th>
                <th>Descripcion Capacitacion</th>
                <th>Cliente</th>
            </tr>
            </thead>
            <tbody>
            <%  
                    String idCapacitacion = request.getParameter("idCapacitacionSeleccionada").toString();
                    String queryCapacitaciones = "SELECT ca.FECHACAPACITACION, ca.DESCRIPCIONCAPACITACION, cl.NOMBRE FROM CAPACITACION ca INNER JOIN CLIENTE cl ON ca.cliente_rut_cliente = cl.rut_cliente WHERE ca.id_capacitacion = '"+idCapacitacion+"'";
                    ResultSet rsCpacitacion = st.executeQuery(queryCapacitaciones);                
                    while(rsCpacitacion.next()){
                    java.sql.Date fechaCap = rsCpacitacion.getDate("FECHACAPACITACION");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaCapa = dateFormat.format(fechaCap);
                %>
                <tr>
                    <th><%= fechaCapa%></th>
                    <th><%= rsCpacitacion.getString("DESCRIPCIONCAPACITACION")%></th>
                    <th><%= rsCpacitacion.getString("NOMBRE")%></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
        <br>
        <h2>Asistentes</h2>
        <br>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Rut</th>
                <th>Nombre</th>
                <th>Apellido Paterno</th>
                <th>Apellido Materno</th>
            </tr>
            </thead>
            <tbody>
            <%  
                    String queryCapacitaciones2 = "SELECT asi.RUT_ASISTENTE, asi.NOMBREASISTENTE, asi.APPATERNOASISTENTE, asi.APMATERNOASISTENTE FROM ASISTENTE asi INNER JOIN CAPACITACION ca ON asi.capacitacion_id_capacitacion = ca.id_capacitacion WHERE ca.id_capacitacion = '"+idCapacitacion+"'";
                    ResultSet rsCpacitacion2 = st.executeQuery(queryCapacitaciones2);                
                    while(rsCpacitacion2.next()){
                %>
                <tr>
                    <th><%= rsCpacitacion2.getString("RUT_ASISTENTE")%></th>
                    <th><%= rsCpacitacion2.getString("NOMBREASISTENTE")%></th>
                    <th><%= rsCpacitacion2.getString("APPATERNOASISTENTE")%></th>
                    <th><%= rsCpacitacion2.getString("APMATERNOASISTENTE")%></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>  
        <br>
        <h2>Materiales</h2>
        <br>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Material</th>
                <th>Costo del Material</th>
            </tr>
            </thead>
            <tbody>
            <%  
                    String queryCapacitaciones3 = "SELECT ma.NOMBREMATERILES, ma.COSTOMATERIALES FROM MATERIAL ma INNER JOIN CAPACITACION ca ON ma.capacitacion_id_capacitacion = ca.id_capacitacion WHERE ca.id_capacitacion = '"+idCapacitacion+"'";
                    ResultSet rsCpacitacion3 = st.executeQuery(queryCapacitaciones3);                
                    while(rsCpacitacion3.next()){
                %>
                <tr>
                    <th><%= rsCpacitacion3.getString("NOMBREMATERILES")%></th>
                    <th>$<%= rsCpacitacion3.getInt("COSTOMATERIALES")%></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>    
    </body>
</html>
