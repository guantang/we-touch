package cn.mailtech.cmcu.icmsso.webapp.controller.admin;

import cn.mailtech.cmcu.icmsso.model.Customer;
import cn.mailtech.cmcu.icmsso.model.PageConf;
import cn.mailtech.cmcu.icmsso.model.PageInf;
import cn.mailtech.cmcu.icmsso.repository.CustomerRepository;
import cn.mailtech.cmcu.icmsso.service.SsoService;
import cn.mailtech.cmcu.icmsso.util.PageUtil;
import cn.mailtech.cmcu.icmsso.webapp.controller.MyBaseController;
import cn.mailtech.ssh.common.service.context.ServiceResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-19
 * Time: 下午3:27
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/admin")
public class AdminController  extends MyBaseController {
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private PageConf pageConf;


    @RequestMapping(value = "/manager")
    @ResponseBody
    public ModelAndView manager(HttpServletRequest request) throws IOException {
        String page = request.getParameter("currentPage");
        int currentPage = 0;
        if (page != null && page.length() > 0) {
            try {
                currentPage = Integer.parseInt(page);
            } catch (Exception e) {
                currentPage = 0;
            }
        }
        Map<String, Object> params = new HashMap<String, Object>();
        List customers = customerRepository.findAll();
        int totalPage = customers.size() / pageConf.getPageSize();
        totalPage = customers.size() % pageConf.getPageSize() == 0 ? totalPage : totalPage + 1;
        PageConf pageIndex = PageUtil.getPage(currentPage, pageConf.getPageSize(), customers.size());
        customers = customers.subList(pageIndex.getBegin(), pageIndex.getEnd());
        params.put("customers", customers);
        params.put("totalPage", totalPage);
        logger.info("display {} customers, total page number is {}", customers.size(), totalPage);
        return new ModelAndView("admin/admin").addAllObjects(params);
    }

    @RequestMapping(value = "/page")
    @ResponseBody
    public Map<String, Object> customerPage(@RequestParam("currentPage") int currentPage) {
        ServiceResult result = new ServiceResult();
        Map<String, Object> data = new HashMap<String, Object>();
        List customers = customerRepository.findAll();
        if (customers == null) {
            data.put("retcode", -1);
        } else {
            data.put("retcode", 0);
            int totalPage = customers.size() / pageConf.getPageSize();
            totalPage = customers.size() % pageConf.getPageSize() == 0 ? totalPage : totalPage + 1;
            data.put("totalPage", totalPage);
        }
        PageConf pageIndex = PageUtil.getPage(currentPage, pageConf.getPageSize(), customers.size());
        customers = customers.subList(pageIndex.getBegin(), pageIndex.getEnd());
        data.put("customers", customers);
        result.setData(data);
        return result.toAjaxResult();
    }


    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> delete(@RequestParam("id") long id) {
        logger.info("delete customer [{}]", id);
        ServiceResult result = new ServiceResult();
        Map<String, Object> data = new HashMap<String, Object>();
        customerRepository.delete(id);
        Customer customer = customerRepository.findOne(id);
        if (customer != null) {
            data.put("retcode", -1);
        } else {
            data.put("retcode", 0);
        }
        result.setData(data);
        return result.toAjaxResult();
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ServiceResult result = new ServiceResult();
        Map<String, Object> data = new HashMap<String, Object>();
        Customer customer = new Customer(request.getParameter("customerName"), request.getParameter("domain"));
        logger.info("add customer, customer's info is :　" + customer);
        customer = customerRepository.save(customer);
        if (customer.getCustomerId() == null) {
            data.put("retcode", -1);
        } else {
            data.put("retcode", 0);
            data.put("customer", customer);
        }
        result.setData(data);
        response.sendRedirect("manager");
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> search(@RequestParam("currentPage") int currentPage,
                       @RequestParam("searchName") String customername,
                       @RequestParam("searchDomain") String domain)throws IOException {
        ServiceResult result = new ServiceResult();
        Map<String, Object> data = new HashMap<String, Object>();
        Customer customer = new Customer("%" + customername + "%", "%" + domain + "%");
        logger.info("search customers by customer [{}]", customer);
        PageInf pageInf =  new PageInf(currentPage, pageConf.getPageSize());
        pageInf.setOffset((currentPage - 1) * pageConf.getPageSize());
        Page<Customer> page = customerRepository.findByLikeExample(customer, pageInf);
        List customers = page.getContent();
        if (customers == null) {
            data.put("retcode", -1);
        } else {
            data.put("retcode", 0);
            data.put("customers", customers);
            data.put("totalPage", page.getTotalPages());
            logger.info("display {} customers, total page number is {}", customers.size(), page.getTotalPages());
        }
        result.setData(data);
        return result.toAjaxResult();
    }
}
