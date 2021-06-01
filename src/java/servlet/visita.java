package servlet;

import ConexionconBD.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "visita", urlPatterns = {"/visita"})
public class visita extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/visitas/visita.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        String fechaVi = request.getParameter("fechaVisita");
      
        java.util.Date fechaVis = null;
        try {
            fechaVis = formatoFecha.parse(fechaVi);
        } catch (ParseException ex) {
            Logger.getLogger(visita.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        java.sql.Date FECHAVISITA = new java.sql.Date(fechaVis.getTime());      
        
        String idCliente = request.getParameter("id_cliente");
        String tipVisita = request.getParameter("tipoVisita");
        String IdProf = sesion.getAttribute("idProfesional").toString();
        
        ConexionBD conec = new ConexionBD();
        Connection conn = conec.conectar(); 
        
        try{  
            CallableStatement cst = conn.prepareCall("{call RegistrarVisita(?,?,?,?)}");
            cst.setString(1, tipVisita);
            cst.setDate(2, FECHAVISITA);
            cst.setString(3, idCliente); 
            cst.setString(4, IdProf);
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