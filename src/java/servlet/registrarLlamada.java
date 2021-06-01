package servlet;

import ConexionconBD.ConexionBD;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class registrarLlamada extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/llamada/registrarLlamada.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        HttpSession sesion = request.getSession();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        String fechaLla = request.getParameter("fLlamada");
        
        java.util.Date fechallam = null;
        
        try {
            fechallam = formatoFecha.parse(fechaLla);
        } catch (ParseException ex) {
            Logger.getLogger(agregarCapacitacion.class.getName()).log(Level.SEVERE, null, ex);
        }

        java.sql.Date fechaLlamada = new java.sql.Date(fechallam.getTime());       
        
        String descrip = request.getParameter("descLlamada");
        String idCliente = request.getParameter("id_cliente");
        String IdProf = sesion.getAttribute("idProfesional").toString();
        
        ConexionBD conec = new ConexionBD();
        Connection conn = conec.conectar(); 
        
        try{  
            CallableStatement cst = conn.prepareCall("{call RegistrarLlamada(?,?,?,?,?)}");
            
            cst.setDate(1, fechaLlamada);
            cst.setString(2,descrip);
            cst.setInt(3, 1);
            cst.setString(4, idCliente);
            cst.setString(5, IdProf);
            cst.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error de SQL" + ex);
        }
        response.sendRedirect("listarLlamadas");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
