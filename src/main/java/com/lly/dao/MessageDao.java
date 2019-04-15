package com.lly.dao;

import com.lly.po.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageDao {
    public int insertMessage(Message message);

    public int deleteMessage(@Param("id") int id);

    public List<Message> messageList();
}
