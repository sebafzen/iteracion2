package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import servicio.User;
import ConexionconBD.ConexionBD;

public class login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession s = request.getSession();
        
        User u = (User)s.getAttribute("user");
        if(u==null)
            request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
        else{
           request.getRequestDispatcher("WEB-INF/agregarUsuario.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        
        ConexionBD conec = new ConexionBD();
        String email = request.getParameter("txtEmail");
        String pass = request.getParameter("txtPass");
        int tipoUser = conec.loguear(email, pass);
        
        if(tipoUser == 2){
            sesion.setAttribute("email", email);
            sesion.setAttribute("Tipousuario", tipoUser);
            String idProfesional = conec.obtenerIdProfesional(email, pass);
            sesion.setAttribute("idProfesional", idProfesional);
            String nomProfesional = conec.obtenerNombreProfesional(email, pass);
            sesion.setAttribute("nombreProfesional", nomProfesional);
            response.sendRedirect("profesional");
        }else if(tipoUser == 3){
            sesion.setAttribute("email", email);
            sesion.setAttribute("Tipousuario", tipoUser);
            String idCliente = conec.obtenerIdCliente(email, pass);
            sesion.setAttribute("idCliente", idCliente);
            String nomCliente = conec.obtenerNombreCliente(email, pass);
            sesion.setAttribute("nombreCliente", nomCliente);
            response.sendRedirect("cliente");
        }
        if(request.getParameter("cerrar") != null){
            sesion.invalidate();
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
