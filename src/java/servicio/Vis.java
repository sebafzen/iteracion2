package servicio;

import java.util.ArrayList;
import modelo.Visita;
import modelo.Usuario;

public class Vis {
    private ArrayList<Visita> cntr;
    private Usuario activo;

    public void agregarVisita(Visita vs){
        this.cntr.add(vs);
    }

    public ArrayList<Visita> getVisita(){
        return this.cntr;
    }

    public Usuario getActivo(){
        return this.activo;
    } 
}
