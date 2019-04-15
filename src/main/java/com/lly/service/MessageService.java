package com.lly.service;

import com.lly.po.Message;

import java.util.List;

public interface MessageService {
    public int insertMessage(Message message);

    public int deleteMessage(int id);

    public List<Message> messageList();
}
