package com.test.dl.service;

import com.test.dl.dao.UserDAO;
import com.test.dl.model.User;

import java.util.List;

public class UserService {

    private UserDAO dao = new UserDAO();

    public User login(String username, String password) {
        if (username == null || password == null) return null;
        return dao.login(username.trim(), password);
    }

    public User findByUsername(String username) {
        return dao.findByUsername(username);
    }

    public List<User> findAll() {
        return dao.findAll();
    }

    public boolean register(User user) {
        User exist = dao.findByUsername(user.getUsername());
        if (exist != null) return false;
        return dao.insert(user);
    }
}
