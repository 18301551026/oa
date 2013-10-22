package com.lxs.security.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lxs.core.common.SystemConstant;
import com.lxs.security.domain.User;
import com.lxs.security.service.IUserService;

/**
 * 自定义标签：根据当前用户的权限隐藏元素
 * @author Administrator
 *
 */
@SuppressWarnings("serial")
public class ValidateAuth extends TagSupport {
	
	private IUserService userService;
	
	private String path;
	
	/* 
	 * EVAL_BODY_INCLUDE：显示标签中间内容
	 * SKIP_BODY：隐藏标签中间内容
	 * 
	 */
	@Override
	public int doStartTag() throws JspException {
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());
		userService = ac.getBean(IUserService.class);		
		User currentUser = (User) this.pageContext.getSession().getAttribute(SystemConstant.CURRENT_USER);
		if (userService.validateAuth(currentUser.getId(), path)) {
			return EVAL_BODY_INCLUDE;
		} else {
			return SKIP_BODY;
		}
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
