package cn.mailtech.cmcu.icmsso.repository;

import cn.mailtech.cmcu.icmsso.model.Customer;
import cn.mailtech.ssh.common.dao.SearchableRepository;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-19
 * Time: 上午11:10
 * To change this template use File | Settings | File Templates.
 */
public interface CustomerRepository  extends SearchableRepository<Customer, Long> {

    List<Customer> findByCustomerName(String customerName);
}
