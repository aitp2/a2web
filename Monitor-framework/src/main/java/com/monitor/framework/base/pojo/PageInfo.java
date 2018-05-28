package com.monitor.framework.base.pojo;

import java.util.ArrayList;
import java.util.List;

public class PageInfo {

    public PageInfo() {

        pageNum = 1;
        pageSize = 10;
    }

    public PageInfo(Integer pageSize) {

        this.pageNum = 1;
        this.pageSize = pageSize;
    }

    // 当前页数
    private int pageNum;

    // 每页记录数
    private int pageSize;

    // 总记录数
    private int count;

    // 总页数
    private int pageCount;
    
    //当前页从哪条记录
    private int numfrom;
    
    //当前页到哪条记录
    private int numto;
    
    //上一页页数
    private int lastPageNum;
    
    //下一页页数
    private int nextPageNum;

    // 结果集
    List pojoList = new ArrayList();

    public int getPageNum() {

        return pageNum;
    }

    public void setPageNum(int pageNum) {

        this.pageNum = pageNum;
    }

    public int getPageSize() {

        return pageSize;
    }

    public void setPageSize(int pageSize) {

        this.pageSize = pageSize;
    }

    public int getCount() {

        return count;
    }

    public void setCount(int count) {

        this.count = count;
    }

    public int getPageCount() {

        pageCount = count / pageSize;
        if (count % pageSize > 0) {
            ++pageCount;
        }
        return pageCount;
    }

    public List getPojoList() {

        return pojoList;
    }

    public void setPojoList(List pojoList) {

        this.pojoList = pojoList;
    }

	public int getNumfrom() {
		numfrom = (pageNum-1) *pageSize  + 1;
		return numfrom;
	}

	public void setNumfrom(int numfrom) {
		this.numfrom = numfrom;
	}

	public int getNumto() {
		numto = (pageNum) * pageSize;
		return numto;
	}

	public void setNumto(int numto) {
		this.numto = numto;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getLastPageNum() {
		lastPageNum = this.pageNum - 1;
		if(lastPageNum == 0){
			lastPageNum = 1;
		}
		return lastPageNum;
	}

	public void setLastPageNum(int lastPageNum) {
		this.lastPageNum = lastPageNum;
	}

	public int getNextPageNum() {
		nextPageNum = this.pageNum + 1;
		if(nextPageNum > this.getPageCount()){
			nextPageNum = this.getPageCount();
		}
		return nextPageNum;
	}

	public void setNextPageNum(int nextPageNum) {
		this.nextPageNum = nextPageNum;
	}

}
