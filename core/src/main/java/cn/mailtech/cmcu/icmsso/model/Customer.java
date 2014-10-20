package cn.mailtech.cmcu.icmsso.model;

import cn.mailtech.ssh.common.model.BaseObject;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-19
 * Time: 上午11:03
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="icm_customer")
@XmlRootElement
public class Customer extends BaseObject implements Serializable {

    @Id
    @Column(name = "customer_id")
    @GeneratedValue(strategy=IDENTITY)
    private Long customerId;

    @Column(name="domain", nullable=false, length = 255)
    private String domain; // not null


    @Column(name="customer_name", nullable=false, length = 255)
    private String customerName; // not null

    public  Customer() {

    }
    public Customer(String name, String domain) {
        this.customerName = name;
        this.domain = domain;
    }


    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }


    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("Customer{");
        sb.append("customerId=").append(customerId);
        sb.append(", domain='").append(domain).append('\'');
        sb.append(", name='").append(customerName).append('\'');
        sb.append('}');
        return sb.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Customer)) return false;

        Customer customer = (Customer) o;

        return !(customerId != null ? !customerId.equals(customer.customerId) : customer.customerId != null);
    }

    @Override
    public int hashCode() {
        return customerId != null ? customerId.hashCode() : 0;
    }
}
