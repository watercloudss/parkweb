package com.lly.dao;

import com.lly.po.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    public User selectUserById(@Param("id") int id);

    public User findUser(@Param("username") String username, @Param("password") String password);

    public User findByUsername(@Param("username") String username);

    public User findByCode(@Param("code") String code);

    public void updatePassword(@Param("id") int id, @Param("password") String password);

    public int updateUserInfo(User user);

    public void updateUserImg(@Param("headImg") String headImg, @Param("id") int id);

    public List<User> userList(@Param("start") int start, @Param("rows") int rows, @Param("code") String code,
                               @Param("username") String username, @Param("name") String name);

    public int userCount(@Param("code") String code, @Param("username") String username, @Param("name") String name);

    public int deleteUser(@Param("id") int id);

    public int updateUserState(@Param("id") int id, @Param("state") int state);

    public int updateUserType(@Param("id") int id, @Param("type") int type);

    public int insertUser(User user);
}
