package com.lly.service.impl;

import com.lly.dao.UserDao;
import com.lly.po.User;
import com.lly.service.UserService;
import com.lly.utils.MD5Util;
import com.lly.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User findUser(String username, String password) {
        User user = userDao.findUser(username, MD5Util.string2MD5(password));
        return user;
    }

    @Override
    public void updatePassword(int id, String password) {
        userDao.updatePassword(id, MD5Util.string2MD5(password));
    }

    @Override
    public int updateUserInfo(User user) {
        return userDao.updateUserInfo(user);
    }

    @Override
    public void updateUserImg(String headImg, int id) {
        userDao.updateUserImg(headImg, id);
    }

    @Override
    public Page<User> userPage(int page, int rows, String code, String username, String name) {
        int userCount = userDao.userCount(code, username, name);
        int start = (page - 1) * rows;
        List<User> userList = userDao.userList(start, rows, code, username, name);
        Page<User> userPage = new Page<>();
        userPage.setPage(page);
        userPage.setRows(userList);
        userPage.setSize(rows);
        userPage.setTotal(userCount);
        return userPage;
    }

    @Override
    public int deleteUser(int id) {
        return userDao.deleteUser(id);
    }

    @Override
    public int updateUserState(int state, int id) {
        return userDao.updateUserState(id, state);
    }

    @Override
    public int updateUserType(int type, int id) {
        return userDao.updateUserType(id, type);
    }

    @Override
    public int insertUser(User user) {
        user.setPassword(MD5Util.string2MD5(user.getPassword()));
        return userDao.insertUser(user);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByCode(String code) {
        return userDao.findByCode(code);
    }
}
