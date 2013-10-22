package com.lxs.security.common;

import com.lxs.core.common.SystemConstant;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

public class SecurityHolder {
	
	public static User getCurrentUser() {
		return (User) ActionContext.getContext().getSession().get(SystemConstant.CURRENT_USER);
	}

}
