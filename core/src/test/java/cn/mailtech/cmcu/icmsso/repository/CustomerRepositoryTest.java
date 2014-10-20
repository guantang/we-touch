package cn.mailtech.cmcu.icmsso.repository;

import cn.mailtech.cmcu.icmsso.model.Customer;
import cn.mailtech.cmcu.icmsso.model.PageInf;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;

import java.util.List;

import static org.junit.Assert.*;

public class CustomerRepositoryTest extends BaseDaoTestCase {

    @Autowired
    private CustomerRepository customerRepository;

    @Test
    public void testFindByLike() {
        Customer customer = new Customer();
        customer.setCustomerName("%b%");
        Page<Customer> page = customerRepository.findByLikeExample(customer, new PageInf(0, 10));
        System.out.println("testFindByLike : " + page.getTotalElements());
        assertNotNull(page);
    }

    @Test
    public void testGet() {
        Customer customer = customerRepository.findOne(-1L);
        assertNotNull(customer);

        customer = customerRepository.findOne(-1000L);
        assertNull(customer);
    }

    @Test
    public void testAddAndRemove() {
        Customer customer = new Customer("name_aaa", "domain_bbbb");

        log.debug("adding customer.");
        customer = customerRepository.save(customer);
        assertNotNull(customer.getCustomerId());

        log.debug("removing customer {}.", customer.getCustomerId());
        customerRepository.delete(customer.getCustomerId());
        customer = customerRepository.findOne(customer.getCustomerId());
        assertNull(customer);
    }

    @Test
    public void testFindByCustomerName() {
        {
            List<Customer> customers = customerRepository.findByCustomerName("b02");
            assertNotNull(customers);
            assertTrue(!customers.isEmpty());
            assertEquals(1, customers.size());
        }
        {
            List<Customer> customers = customerRepository.findByCustomerName("b003");
            assertTrue(customers.isEmpty());
        }
    }
}
