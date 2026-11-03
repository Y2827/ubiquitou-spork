package com.test.dl.action;

import org.apache.struts2.ActionSupport;
import org.apache.struts2.ModelDriven;
import com.test.dl.model.User;
import com.test.dl.service.UserService;
import org.apache.struts2.ServletActionContext;

import jakarta.servlet.http.HttpSession;

public class LoginAction extends ActionSupport implements ModelDriven<User> {

    private User user = new User();
    private UserService service = new UserService();
    private String tip;

    @Override
    public User getModel() { return user; }

    public String execute() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        session.removeAttribute("loginUser");
        return INPUT;
    }

    public String login() {
        User u = service.login(user.getUsername(), user.getPassword());
        if (u == null) {
            tip = "用户名或密码错误！";
            addActionError(tip);
            return INPUT;
        }
        HttpSession session = ServletActionContext.getRequest().getSession();
        session.setAttribute("loginUser", u);
        return SUCCESS;
    }

    public String logout() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session != null) session.invalidate();
        return "logout";
    }

    public String register() {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            addActionError("用户名不能为空"); return INPUT;
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            addActionError("密码不能为空"); return INPUT;
        }
        if (user.getRealName() == null || user.getRealName().trim().isEmpty()) {
            addActionError("姓名不能为空"); return INPUT;
        }
        User existing = service.findByUsername(user.getUsername());
        if (existing != null) {
            addActionError("该用户名已被注册"); return INPUT;
        }
        user.setRole("STUDENT");
        boolean ok = service.register(user);
        if (ok) {
            addActionMessage("注册成功，请登录");
        } else {
            addActionError("注册失败，请稍后再试");
        }
        return INPUT;
    }

    public String getTip() { return tip; }
    public void setTip(String tip) { this.tip = tip; }
}
