package cn.mailtech.cmcu.icmsso.util;

import cn.mailtech.cmcu.icmsso.model.PageConf;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-21
 * Time: 下午1:42
 * To change this template use File | Settings | File Templates.
 */
public class PageUtil {

    public static PageConf getPage(int currentPage, int pageSize, int total) {
        int begin = 0;
        int end = 0;
        if (total >= currentPage * pageSize) {
            begin = currentPage * pageSize;
        }
        if (total >= begin + pageSize) {
            end = begin + pageSize;
        } else {
            end = total;
        }
        return new PageConf(begin, end);
    }

}
