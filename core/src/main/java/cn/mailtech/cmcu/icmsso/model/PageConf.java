package cn.mailtech.cmcu.icmsso.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-21
 * Time: 下午1:32
 * To change this template use File | Settings | File Templates.
 */
public class PageConf {
    private int pageSize = 10;

    private int begin = 0;

    private int end = 0;

    public PageConf(){}

    public PageConf(int begin, int end) {
        this.begin = begin;
        this.end = end;
    }


    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getBegin() {
        return begin;
    }

    public void setBegin(int begin) {
        this.begin = begin;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }
}
