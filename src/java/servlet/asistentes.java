package servlet;

import ConexionconBD.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class asistentes extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/capacitacion/asistentes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        HttpSession sesion = request.getSession();
    
        String rAsis = request.getParameter("rut");
        String nAsis = request.getParameter("nombre");
        String apaAsis = request.getParameter("apPaternoAsistente");
        String amaAsis = request.getParameter("apMaternoAsistente");
        int IdCap = Integer.parseInt(request.getParameter("idCapacitacion"));
        
        ConexionBD conec = new ConexionBD();
        Connection conn = conec.conectar(); 
        
        try{  
            CallableStatement cst = conn.prepareCall("{call RegistrarAsistentes(?,?,?,?,?)}");
            
            cst.setString(1, rAsis);
            cst.setString(2,nAsis);
            cst.setString(3, apaAsis);
            cst.setString(4, amaAsis);
            cst.setInt(5, IdCap);
            cst.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error de SQL" + ex);
        }
        response.sendRedirect("listarCapacitacion");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
