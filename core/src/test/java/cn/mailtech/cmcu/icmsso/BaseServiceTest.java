package cn.mailtech.cmcu.icmsso;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

@ContextConfiguration(
        locations = {"classpath:/applicationContext-resources.xml",
                "classpath:/applicationContext-dao.xml",
                "classpath:**/applicationContext*.xml"})
public abstract class BaseServiceTest extends AbstractJUnit4SpringContextTests {
}
