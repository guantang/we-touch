package cn.mailtech.cmcu.icmsso.util;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-10-14
 * Time: 下午5:15
 * To change this template use File | Settings | File Templates.
 */
public class DomainUtil {
    private String[] topdomains;

    private String replaceStr;

    public String formatDomain(String domain) {
        String tempStr = domain;
        try {
            for (String topdomain : topdomains) {
                if (tempStr.endsWith(topdomain)) {
                    int indexOf = tempStr.lastIndexOf(topdomain);
                    tempStr = tempStr.substring(0, indexOf - 1);
                    int indexOfDot = tempStr.lastIndexOf(".");
                    tempStr = tempStr.substring(indexOfDot + 1, tempStr.length());
                    tempStr += "." + replaceStr;
                    tempStr = "mail." + tempStr;
                    break;
                }
            }
        }  catch (Exception e) {
            return domain;
        }
        return tempStr;
    }

    public String[] getTopdomains() {
        return topdomains;
    }

    public void setTopdomains(String[] topdomains) {
        this.topdomains = topdomains;
    }

    public String getReplaceStr() {
        return replaceStr;
    }

    public void setReplaceStr(String replaceStr) {
        this.replaceStr = replaceStr;
    }
}
