/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author norar
 */
@Entity
@Table(name = "PLAN_SERVICIO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PlanServicio.findAll", query = "SELECT p FROM PlanServicio p")
    , @NamedQuery(name = "PlanServicio.findByIdPlanServicio", query = "SELECT p FROM PlanServicio p WHERE p.idPlanServicio = :idPlanServicio")
    , @NamedQuery(name = "PlanServicio.findByNombreplan", query = "SELECT p FROM PlanServicio p WHERE p.nombreplan = :nombreplan")
    , @NamedQuery(name = "PlanServicio.findByDescripcionplan", query = "SELECT p FROM PlanServicio p WHERE p.descripcionplan = :descripcionplan")
    , @NamedQuery(name = "PlanServicio.findByCostoplan", query = "SELECT p FROM PlanServicio p WHERE p.costoplan = :costoplan")
    , @NamedQuery(name = "PlanServicio.findByEstado", query = "SELECT p FROM PlanServicio p WHERE p.estado = :estado")})
public class PlanServicio implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "planServicioIdPlanServicio")
    private Collection<Contrato> contratoCollection;
    @JoinColumn(name = "ASESORIA_ID_ASESORIA", referencedColumnName = "ID_ASESORIA")
    @ManyToOne
    private Asesoria asesoriaIdAsesoria;
    @JoinColumn(name = "CAPACITACION_ID_CAPACITACION", referencedColumnName = "ID_CAPACITACION")
    @ManyToOne
    private Capacitacion capacitacionIdCapacitacion;
    @JoinColumn(name = "LLAMADA_ID_LLAMADA", referencedColumnName = "ID_LLAMADA")
    @ManyToOne
    private Llamada llamadaIdLlamada;
    @JoinColumn(name = "VISITA_ID_VISITA", referencedColumnName = "ID_VISITA")
    @ManyToOne
    private Visita visitaIdVisita;

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_PLAN_SERVICIO")
    private int idPlanServicio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "NOMBREPLAN")
    private String nombreplan;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "DESCRIPCIONPLAN")
    private String descripcionplan;
    @Basic(optional = false)
    @NotNull
    @Column(name = "COSTOPLAN")
    private int costoplan;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "ESTADO")
    private String estado;

    public PlanServicio() {
    }

    public PlanServicio(int idPlanServicio) {
        this.idPlanServicio = idPlanServicio;
    }

    public PlanServicio( String nombreplan, String descripcionplan, int costoplan, String estado) {
       // this.idPlanServicio = idPlanServicio;
        this.nombreplan = nombreplan;
        this.descripcionplan = descripcionplan;
        this.costoplan = costoplan;
        this.estado = estado;
    }

    public int getIdPlanServicio() {
        return idPlanServicio;
    }

    public void setIdPlanServicio(int idPlanServicio) {
        this.idPlanServicio = idPlanServicio;
    }

    public String getNombreplan() {
        return nombreplan;
    }

    public void setNombreplan(String nombreplan) {
        this.nombreplan = nombreplan;
    }

    public String getDescripcionplan() {
        return descripcionplan;
    }

    public void setDescripcionplan(String descripcionplan) {
        this.descripcionplan = descripcionplan;
    }

    public int getCostoplan() {
        return costoplan;
    }

    public void setCostoplan(int costoplan) {
        this.costoplan = costoplan;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return "modelo.PlanServicio[ idPlanServicio=" + idPlanServicio + " ]";
    }

    @XmlTransient
    public Collection<Contrato> getContratoCollection() {
        return contratoCollection;
    }

    public void setContratoCollection(Collection<Contrato> contratoCollection) {
        this.contratoCollection = contratoCollection;
    }

    public Asesoria getAsesoriaIdAsesoria() {
        return asesoriaIdAsesoria;
    }

    public void setAsesoriaIdAsesoria(Asesoria asesoriaIdAsesoria) {
        this.asesoriaIdAsesoria = asesoriaIdAsesoria;
    }

    public Capacitacion getCapacitacionIdCapacitacion() {
        return capacitacionIdCapacitacion;
    }

    public void setCapacitacionIdCapacitacion(Capacitacion capacitacionIdCapacitacion) {
        this.capacitacionIdCapacitacion = capacitacionIdCapacitacion;
    }

    public Llamada getLlamadaIdLlamada() {
        return llamadaIdLlamada;
    }

    public void setLlamadaIdLlamada(Llamada llamadaIdLlamada) {
        this.llamadaIdLlamada = llamadaIdLlamada;
    }

    public Visita getVisitaIdVisita() {
        return visitaIdVisita;
    }

    public void setVisitaIdVisita(Visita visitaIdVisita) {
        this.visitaIdVisita = visitaIdVisita;
    }
    
}
