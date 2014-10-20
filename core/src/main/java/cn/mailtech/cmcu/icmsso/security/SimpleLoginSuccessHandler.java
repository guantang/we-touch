package cn.mailtech.cmcu.icmsso.security;

import cn.mailtech.cmcu.icmsso.service.SsoService;
import cn.mailtech.cmcu.icmsso.util.DomainUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-19
 * Time: 上午9:30
 * To change this template use File | Settings | File Templates.
 */
public class SimpleLoginSuccessHandler implements AuthenticationSuccessHandler{
    protected final Logger logger = LoggerFactory.getLogger(getClass());

    private SsoService ssoService;

    private String adminAccount;

    private String ssoAccount;

    private boolean forwardToDestination = false;

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    private DomainUtil domainUtil;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        //To change body of implemented methods use File | Settings | File Templates.
        if(this.forwardToDestination){
            logger.info("Login success,Forwarding to "+this.adminAccount);
            request.getRequestDispatcher("/login").forward(request, response);
        }else{
            if (adminAccount.equals(authentication.getName())) {
                this.redirectStrategy.sendRedirect(request, response, "/admin/manager");
            } else {
                String serverIp = request.getParameter("domain");
                if (null == serverIp || "".equals(serverIp)) {
                    logger.info("lack of domain, fail to sso");
                    this.redirectStrategy.sendRedirect(request, response, "/login");
                    return;
                }
                logger.info("user [{}] sso to {}", ssoAccount, serverIp);
                String formatDomain = domainUtil.formatDomain(serverIp);
                logger.info("after format, doamin is {}", formatDomain);
                Map<String, Object> ssoResult = ssoService.loginByWS(ssoAccount, request.getRemoteAddr(), formatDomain);
                if (((Integer)ssoResult.get("retcode")) == 0) {
                    logger.info("redirect to url : {}", ssoResult.get("desturl"));
                    response.sendRedirect((String)ssoResult.get("desturl"));
                } else {
                    logger.info("fail to sso to domain by user [{}]", ssoAccount);
                    this.redirectStrategy.sendRedirect(request, response, "/login");
                }
            }
        }
    }

    public String getIpAddress(HttpServletRequest request){
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public SsoService getSsoService() {
        return ssoService;
    }

    public void setSsoService(SsoService ssoService) {
        this.ssoService = ssoService;
    }

    public void setSsoAccount(String ssoAccount) {
        this.ssoAccount = ssoAccount;
    }

    public void setAdminAccount(String adminAccount) {
        this.adminAccount = adminAccount;
    }

    public void setForwardToDestination(boolean forwardToDestination) {
        this.forwardToDestination = forwardToDestination;
    }

    public void setDomainUtil(DomainUtil domainUtil) {
        this.domainUtil = domainUtil;
    }
}
