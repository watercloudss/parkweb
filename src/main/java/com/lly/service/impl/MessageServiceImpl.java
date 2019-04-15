package com.lly.service.impl;

import com.lly.dao.MessageDao;
import com.lly.po.Message;
import com.lly.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageDao messageDao;

    @Override
    public int insertMessage(Message message) {
        return messageDao.insertMessage(message);
    }

    @Override
    public int deleteMessage(int id) {
        return messageDao.deleteMessage(id);
    }

    @Override
    public List<Message> messageList() {
        return messageDao.messageList();
    }

}
