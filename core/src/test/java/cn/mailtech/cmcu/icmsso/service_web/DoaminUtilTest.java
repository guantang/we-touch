package cn.mailtech.cmcu.icmsso.service_web;

import cn.mailtech.cmcu.icmsso.BaseServiceTest;
import cn.mailtech.cmcu.icmsso.util.DomainUtil;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-10-14
 * Time: 下午5:40
 * To change this template use File | Settings | File Templates.
 */
public class DoaminUtilTest extends BaseServiceTest {
    @Autowired
    private DomainUtil domainUtil;
    @Test
    public void testDomainFormat() {
        System.out.println(domainUtil.formatDomain("xudong.com.cn"));
        System.out.println(domainUtil.formatDomain("test.xudong.com.cn"));
    }
}
