package com.lly.service;

import com.lly.po.User;
import com.lly.utils.Page;

public interface UserService {
    public User findUser(String username, String password);

    public void updatePassword(int id, String password);

    public int updateUserInfo(User user);

    public void updateUserImg(String headImg, int id);

    public Page<User> userPage(int page, int rows, String code, String username, String name);

    public int deleteUser(int id);

    public int updateUserState(int state, int id);

    public int updateUserType(int type, int id);

    public int insertUser(User user);

    public User findByUsername(String username);

    public User findByCode(String code);
}
