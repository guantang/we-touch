package cn.mailtech.cmcu.icmsso.service;

import cn.mailtech.ssh.common.util.URLUtil;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tebie.applib.api.APIContext;
import tebie.applib.api.IClient;

import javax.xml.namespace.QName;
import java.io.IOException;
import java.net.Socket;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-18
 * Time: 下午6:25
 * To change this template use File | Settings | File Templates.
 */
public class SsoService {
    private Logger logger = LoggerFactory.getLogger(getClass());
    private Map<String, Map<String, String>> cachedSIds = new ConcurrentHashMap<String, Map<String, String>>();
    private boolean cacheSId = false;
    private String baseDestUrl = "http://%s/webadmin/~%s/~/usr/index_usr.jsp";
    private String namespace = "http://coremail.cn/apiws";
    int apiServerPort = 6195;
    public Map<String, Object> login(String userId, String remoteIp, String serverIp) {
        logger.debug("start login. userIs: {}", userId);
        Map<String, Object> result = new HashMap<String, Object>();
        if (StringUtils.isBlank(userId)) {
            result.put("retcode", -1);
            result.put("result", "fail.sso.user_id.blank");
            return result;
        }
        APIContext apiRet;
        IClient apiClient = null;
        Socket socket;

        try {
            socket = new Socket(serverIp, apiServerPort);
            apiClient = APIContext.getClient(socket);

            Map<String, String> repData = new HashMap<String, String>();
            String SId = "";
            if (cacheSId && cachedSIds.containsKey(userId)) {
                repData = cachedSIds.get(userId);
                SId = repData.get("sid");
                // 检查 sid 是否失效
                apiRet = apiClient.sesTimeOut(SId);
                if (apiRet.getRetCode() != APIContext.RC_NORMAL) {
                    SId = "";
                }
            }

            if (SId.isEmpty()) {
                Map<String, String> reqParams = new LinkedHashMap<String, String>();
                if (remoteIp != null && !remoteIp.isEmpty()) {
                    reqParams.put("remote_ip", remoteIp);
                }
                String loginAttrs = URLUtil.urlencode(reqParams);
                apiRet = apiClient.userLoginEx(userId, loginAttrs);
                if (apiRet.getRetCode() != APIContext.RC_NORMAL) {
                    // 登录不成功
                    dealAPIError(result, apiRet);
                    return result;
                }

                repData = URLUtil.urldecode(apiRet.getResult());
                // 登录成功，缓存sid
                if (cacheSId) {
                    cachedSIds.put(userId, repData);
                }
            }

            SId = repData.get("sid");
            String destUrl = String.format(baseDestUrl, serverIp, SId);
            logger.debug("dest url: {}", destUrl);

            result.put("retcode", 0);
            result.put("desturl", destUrl);
        } catch (IOException e) {
            logger.debug("caught IOException. {}\n{}", e.getMessage(), e);
            result.put("retcode", -1);
            result.put("result", "fail.caught_exception");
            result.put("errorInfo", "caught exception " + e.getMessage());
        } finally {
            if (apiClient != null) {
                try {
                    apiClient.close();
                } catch (Exception e) {
                }
            }
        }
        return result;
    }

    public Map<String, Object> loginByWS(String userId, String remoteIp, String serverIp){
        Map<String, Object> result = new HashMap<String, Object>();
        logger.debug("start login. login to: {}", serverIp);
        try {
            Service service = new Service();
            Call call = (Call) service.createCall();
            call.setTargetEndpointAddress(new java.net.URL("http://" + serverIp + "/apiws/services/API"));
            call.setOperationName(new QName(namespace, "userLoginEx"));
            call.addParameter("user_at_domain", XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
            call.addParameter("attrs", XMLType.XSD_STRING, javax.xml.rpc.ParameterMode.IN);
            call.setReturnType(XMLType.SOAP_VECTOR);
            Map<String, String> reqParams = new LinkedHashMap<String, String>();
            if (remoteIp != null && !remoteIp.isEmpty()) {
                logger.debug("remote_ip is : " + remoteIp);
                reqParams.put("remote_ip", remoteIp);
            }
            reqParams.put("cookiecheck", "");
            String loginAttrs = URLUtil.urlencode(reqParams);
            Object[] s = new Object[]{userId, loginAttrs};
            Vector<String> vector = (Vector<String>)call.invoke(s);
            Map<String, String> ret = URLUtil.urldecode(vector.get(1));
            String destUrl = String.format(baseDestUrl, serverIp, ret.get("sid"));
            logger.debug("dest url: {}", destUrl);
            result.put("retcode", 0);
            result.put("desturl", destUrl);
        } catch (Exception e) {
            logger.debug("caught ServiceException. {}\n{}", e.getMessage(), e);
            result.put("retcode", -1);
            result.put("result", "fail.caught_exception");
            result.put("errorInfo", "caught exception " + e.getMessage());
        }
        return result;
    }

    private void dealAPIError(Map<String, Object> result, APIContext apiRet) {
        logger.debug("api return error. {}, {}", apiRet.getRetCode(), apiRet.getErrorInfo());

        result.put("retcode", apiRet.getRetCode());
        result.put("result", apiRet.getResult());
        result.put("errorInfo", apiRet.getErrorInfo());
    }


    // ---- getter and setters ----

    public void setApiServerPort(int apiServerPort) {
        this.apiServerPort = apiServerPort;
    }

    public void setBaseDestUrl(String baseDestUrl) {
        this.baseDestUrl = baseDestUrl;
    }

    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }

    public boolean isCacheSId() {
        return cacheSId;
    }

    public void setCacheSId(boolean cacheSId) {
        this.cacheSId = cacheSId;
    }
}
