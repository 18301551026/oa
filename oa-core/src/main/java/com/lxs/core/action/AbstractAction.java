package com.lxs.core.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public abstract class AbstractAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {

	protected HttpServletRequest request;
	protected HttpServletResponse response;
	
	public static final String LIST  = "list";
	public static final String LIST_ACTION  = "listAction";
	public static final String ADD  = "add";
	public static final String UPDATE  = "update";
	public static final String UPDATE_ACTION = "updateAction";
	public static final String INDEX  = "index";
	
	public static final String PAGE  = "page";
	
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	protected PrintWriter getOut() {
		PrintWriter out = null;
		response.setContentType("text/html; charset=UTF-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return out;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}	
	
	
}
