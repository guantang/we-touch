package cn.mailtech.cmcu.icmsso.model;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-9-19
 * Time: 下午8:44
 * To change this template use File | Settings | File Templates.
 */
public class PageInf implements Pageable{
    private int pageNumber;

    private int pageSize;

    private int offset;

    public PageInf() {}

    public PageInf(int pageNumber, int pageSize) {
        this.pageNumber = pageNumber;
        this.pageSize = pageSize;
        this.offset = 0;
    }

    @Override
    public int getPageNumber() {
        return pageNumber;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public int getPageSize() {
        return pageSize;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public int getOffset() {
        return offset;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Sort getSort() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
}
