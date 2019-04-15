package com.lly.interceptor;

import com.lly.po.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        // 获取请求的URL
        String url = request.getRequestURI();
        System.out.println("url为" + url);
        // URL:除了登录请求外，其他的URL都进行拦截控制
        if (url.indexOf("/login.action") >= 0) {
            return true;
        }
        // 获取Session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("USER_LOGIN");
        // 判断Session中是否有用户数据，如果有，则返回true,继续向下执行
        if (user != null) {
//				return true;
//			} else {
//				if(url.indexOf("/userSetting.action")>=0) {
//					return true;
//				}
//				request.getRequestDispatcher("/WEB-INF/jsp/admin.jsp").forward(request, response);
            return true;
//			}
        }
        // 不符合条件的给出提示信息，并转发到登录页面
        request.setAttribute("msg", "您还没有登录，请先登录！");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        return false;
    }

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
            throws Exception {
        // TODO Auto-generated method stub

    }

}
