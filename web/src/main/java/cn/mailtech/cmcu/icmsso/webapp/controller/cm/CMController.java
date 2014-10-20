package cn.mailtech.cmcu.icmsso.webapp.controller.cm;

import cn.mailtech.cmcu.icmsso.model.Customer;
import cn.mailtech.cmcu.icmsso.model.PageInf;
import cn.mailtech.cmcu.icmsso.repository.CustomerRepository;
import cn.mailtech.cmcu.icmsso.webapp.controller.MyBaseController;
import cn.mailtech.ssh.common.service.context.ServiceResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cm")
public class CMController extends MyBaseController {
    @Autowired
    private CustomerRepository customerRepository;

    @RequestMapping(value = "/searchCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> searchCustomer(HttpServletRequest request) throws IOException {
        String key = request.getParameter("key");
        logger.info("search for customers whose customername contain [{}]", key);
        ServiceResult result = new ServiceResult();
        Map<String, Object> customers = new HashMap<String, Object>();
        Customer c = new Customer();
        c.setCustomerName("%" + key + "%");
        c.setDomain("%" + key + "%");
        Page<Customer> page = customerRepository.findByLikeExampleOr(c, new PageInf(0, 10));
        List<Customer> list = page.getContent();
        for (Customer customer: list) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("domain", customer.getDomain());
            customers.put(customer.getCustomerName(), map);
        }
        result.setData(customers);
        return result.toAjaxResult();
    }
}
