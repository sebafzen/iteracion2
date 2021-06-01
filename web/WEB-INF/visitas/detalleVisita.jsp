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
        <a href="profesional">Home/ </a><a href="listarVisitas">Listado de visitas/ </a>
        <h2>Visita N°<%=request.getParameter("idVisitaSeleccionada")%></h2>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Descripción de la Visita</th>
                <th>Fecha de la Visita</th>
                <th>Cliente</th>
            </tr>
            </thead>
            <tbody>
                <%  
                    String idVisita = request.getParameter("idVisitaSeleccionada").toString();
                    String queryVisitas = "SELECT v.tipovisita, v.fechavisita, cli.nombre FROM VISITA v INNER JOIN CLIENTE cli ON v.CLIENTE_RUT_CLIENTE = cli.RUT_CLIENTE WHERE v.ID_VISITA = '"+idVisita+"'";
                    ResultSet rsVisitas = st.executeQuery(queryVisitas);                
                    while(rsVisitas.next()){
                    java.sql.Date fechaVi = rsVisitas.getDate("fechavisita");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaVis = dateFormat.format(fechaVi);
                %>
                <tr>
                    <th><%=rsVisitas.getString("tipovisita")%></th>
                    <th><%=fechaVis%></th>
                    <th><%=rsVisitas.getString("nombre")%></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
        <br>
        <h2>Checklist</h2>
	<table class="table table-sm table-striped">
            <thead>
            <tr>
                <th>Fecha</th>
                <th>Mejora</th>
                <th>Fecha de Modificación</th>
            </tr>
            </thead>
            <tbody>
                <%  
                    String queryVisitas2 = "SELECT chv.FECHACHECKLISTVISITA, chv.MEJORA, chv.FECHAMODIFICACION FROM CHECKLISTVISITA chv INNER JOIN VISITA v ON v.id_visita = chv.visita_id_visita WHERE v.id_visita = '"+idVisita+"'";
                    ResultSet rsVisitas2 = st.executeQuery(queryVisitas2);                
                    while(rsVisitas2.next()){
                    java.sql.Date fechaVi = rsVisitas2.getDate("FECHACHECKLISTVISITA");
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String fechaVis = dateFormat.format(fechaVi);
                %>
                <tr>
                    <th><%=fechaVis%></th>
                    <th><%=rsVisitas2.getString("MEJORA")%></th>
                    <th><input type="date" name="fechaModificadaVisita"></th>
                </tr>
                <%
                    } 
                %>
            </tbody>
        </table>
    </body>
</html>
