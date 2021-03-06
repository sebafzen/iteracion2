/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author norar
 */
@Entity
@Table(name = "ACCIDENTE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Accidente.findAll", query = "SELECT a FROM Accidente a")
    , @NamedQuery(name = "Accidente.findByIdAccidente", query = "SELECT a FROM Accidente a WHERE a.idAccidente = :idAccidente")
    , @NamedQuery(name = "Accidente.findByDescripcionaccidente", query = "SELECT a FROM Accidente a WHERE a.descripcionaccidente = :descripcionaccidente")
    , @NamedQuery(name = "Accidente.findByFechaaccidente", query = "SELECT a FROM Accidente a WHERE a.fechaaccidente = :fechaaccidente")})
public class Accidente implements Serializable {

    @JoinColumn(name = "CLIENTE_ID_CLIENTE", referencedColumnName = "ID_CLIENTE")
    @ManyToOne(optional = false)
    private Cliente clienteIdCliente;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "accidenteIdAccidente")
    private Collection<Alerta> alertaCollection;

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_ACCIDENTE")
    private int idAccidente;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "DESCRIPCIONACCIDENTE")
    private String descripcionaccidente;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FECHAACCIDENTE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaaccidente;

    public Accidente() {
    }

    public Accidente(int idAccidente) {
        this.idAccidente = idAccidente;
    }

    public Accidente(String descripcionaccidente, Date fechaaccidente) {
        //this.idAccidente = idAccidente;
        this.descripcionaccidente = descripcionaccidente;
        this.fechaaccidente = fechaaccidente;
    }

    public int getIdAccidente() {
        return idAccidente;
    }

    public void setIdAccidente(int idAccidente) {
        this.idAccidente = idAccidente;
    }

    public String getDescripcionaccidente() {
        return descripcionaccidente;
    }

    public void setDescripcionaccidente(String descripcionaccidente) {
        this.descripcionaccidente = descripcionaccidente;
    }

    public Date getFechaaccidente() {
        return fechaaccidente;
    }

    public void setFechaaccidente(Date fechaaccidente) {
        this.fechaaccidente = fechaaccidente;
    }


    @Override
    public String toString() {
        return "modelo.Accidente[ idAccidente=" + idAccidente + " ]";
    }

    public Cliente getClienteIdCliente() {
        return clienteIdCliente;
    }

    public void setClienteIdCliente(Cliente clienteIdCliente) {
        this.clienteIdCliente = clienteIdCliente;
    }

    @XmlTransient
    public Collection<Alerta> getAlertaCollection() {
        return alertaCollection;
    }

    public void setAlertaCollection(Collection<Alerta> alertaCollection) {
        this.alertaCollection = alertaCollection;
    }
    
}
