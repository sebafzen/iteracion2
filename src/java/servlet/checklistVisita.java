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

public class checklistVisita extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/visitas/checklistVisita.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        String fechaVi = request.getParameter("fecha_visita");
        
        java.util.Date fechaVis = null;
        try {
            fechaVis = formatoFecha.parse(fechaVi);
        } catch (ParseException ex) {
            Logger.getLogger(checklistVisita.class.getName()).log(Level.SEVERE, null, ex);
        }

        java.sql.Date FECHACHECKLISTVISITA = new java.sql.Date(fechaVis.getTime());
    
        String mejoraV = request.getParameter("mejora");
        int IdVis = Integer.parseInt(request.getParameter("idVisita"));
        
        ConexionBD conec = new ConexionBD();
        Connection conn = conec.conectar(); 
        
        try{  
            CallableStatement cst = conn.prepareCall("{call RegistrarCheckListVisita(?,?,?,?,?)}");
            
            cst.setDate(1, FECHACHECKLISTVISITA);
            cst.setString(2,mejoraV);
            cst.setString(3, "T");
            cst.setInt(4, IdVis);
            cst.setInt(5,200198859);
            cst.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error de SQL" + ex);
        }
        response.sendRedirect("listarVisitas");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}