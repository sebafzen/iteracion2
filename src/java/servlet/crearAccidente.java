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

public class crearAccidente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/cliente/crearAccidente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        HttpSession sesion = request.getSession();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        String fechaAcc = request.getParameter("dfechaAccidente");
        
        java.util.Date fechaAcci = null;
        
        try { 
            fechaAcci = formatoFecha.parse(fechaAcc);
        } catch (ParseException ex) {
            Logger.getLogger(crearAccidente.class.getName()).log(Level.SEVERE, null, ex);
        }

        java.sql.Date fechaAccidente = new java.sql.Date(fechaAcci.getTime()); 
        
        String descripAcci = request.getParameter("txtDescAccidente");
        String IdClie = sesion.getAttribute("idCliente").toString();
        
        ConexionBD conec = new ConexionBD();
        Connection conn = conec.conectar(); 
        
        try{  
            CallableStatement cst = conn.prepareCall("{call RegistrarAccidente(?,?,?)}");
            
            cst.setString(1, descripAcci);
            cst.setDate(2, fechaAccidente);
            cst.setString(3, IdClie);
            cst.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error de SQL" + ex);
        }
        
        response.sendRedirect("cliente");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
