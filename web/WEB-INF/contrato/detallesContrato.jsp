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
            int IdContrato = Integer.parseInt(request.getParameter("idContrato"));
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
        <a href="profesional">Home/ </a><a href="listarContrato">Listado de contratos/ </a><a href="detallesContrato">Detalle de contrato/ </a>
        <h2>Contrato N°<%=IdContrato%></h2>
        <br>
        <h3>Cliente</h3>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Rut</th>
                <th>Nombre</th>
                <th>Rubro</th>
            </tr>
            </thead>
            <tbody>
                <%  
                    String querydetalleContratos = "SELECT cl.RUT_CLIENTE, cl.NOMBRE, cl.RUBRO FROM CLIENTE cl INNER JOIN CONTRATO co ON co.cliente_rut_cliente = cl.rut_cliente WHERE co.id_contrato = '"+IdContrato+"'";
                    ResultSet rsDetalleContrato = st.executeQuery(querydetalleContratos);                
                    while(rsDetalleContrato.next()){
                %>
                <tr>
                    <td><%=rsDetalleContrato.getString("RUT_CLIENTE")%></td>
                    <td><%=rsDetalleContrato.getString("NOMBRE")%></td>
                    <td><%=rsDetalleContrato.getString("RUBRO")%></td>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
        <br><br>
        <h3>Contrato</h3>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Fecha de Inicio</th>
                <th>Fecha de Termino</th>
                <th>Plan Contratado</th>
                <th>Detalles del Plan</th>
                <th>Costo del Plan</th>
                <th>Estado del Contrato</th>
            </tr>
            </thead>
            <tbody>
                <%  
                    String querydetalleContrato2 = "SELECT co.FECHAINICIO, co.FECHATERMINO, pl.NOMBREPLAN, pl.DESCRIPCIONPLAN, pl.COSTOPLAN, co.ESTADO FROM CONTRATO co INNER JOIN PLAN_SERVICIO pl ON co.plan_servicio_id_plan_servicio = pl.id_plan_servicio WHERE co.id_contrato = '"+IdContrato+"'";
                    ResultSet rsDetalleContrato2 = st.executeQuery(querydetalleContrato2);                
                    while(rsDetalleContrato2.next()){
                    java.sql.Date fechaIni = rsDetalleContrato2.getDate("FECHAINICIO");
                    java.sql.Date fechaTer = rsDetalleContrato2.getDate("FECHATERMINO");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaIn = dateFormat.format(fechaIni);
                    String fechaTe = dateFormat.format(fechaTer);
                %>
                <tr>
                    <td><%=fechaIn%></td>
                    <td><%=fechaTe%></td>
                    <td><%=rsDetalleContrato2.getString("NOMBREPLAN")%></td>
                    <td><%=rsDetalleContrato2.getString("DESCRIPCIONPLAN")%></td>
                    <td>$<%=rsDetalleContrato2.getInt("COSTOPLAN")%></td>
                    <%
                        String estado = "";
                        if(rsDetalleContrato2.getString("ESTADO").equalsIgnoreCase("T")){
                            estado = "ACTIVO";
                        }else {
                            estado = "INACTIVO";
                        }
                    %>
                    <td><%=estado%></td>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
        <br><br>
        <h3>Servicio Extra</h3>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Descripción</th>
                <th>Fecha</th>
                <th>Costo</th>
            </tr>
            </thead>
            <tbody>
                <%  
                    String querydetalleContrato3 = "SELECT se.DESCRIPCIONEXTRA, se.FECHAEXTRA, se.COSTOEXTRA FROM SERVICIOEXTRA se INNER JOIN CONTRATO co ON se.contrato_id_contrato = co.id_contrato WHERE co.id_contrato = '"+IdContrato+"'";
                    ResultSet rsDetalleContrato3 = st.executeQuery(querydetalleContrato3);                
                    while(rsDetalleContrato3.next()){
                    java.sql.Date fechaExt = rsDetalleContrato3.getDate("FECHAEXTRA");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaEx = dateFormat.format(fechaExt);
                %>
                <tr>
                    <td><%=rsDetalleContrato3.getString("DESCRIPCIONEXTRA")%></td>
                    <td><%=fechaEx%></td>
                    <td>$<%=rsDetalleContrato3.getString("COSTOEXTRA")%></td>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>    
    </body>
</html>
