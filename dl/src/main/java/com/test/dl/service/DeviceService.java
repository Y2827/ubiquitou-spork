package com.test.dl.service;

import com.test.dl.dao.DeviceDAO;
import com.test.dl.model.Device;

import java.util.List;

public class DeviceService {

    private DeviceDAO dao = new DeviceDAO();

    public List<Device> listAll() {
        return dao.findAll();
    }

    public List<Device> search(String keyword) {
        return dao.search(keyword);
    }

    public Device findById(int id) {
        return dao.findById(id);
    }

    public boolean add(Device d) {
        return dao.insert(d);
    }

    public boolean update(Device d) {
        return dao.update(d);
    }

    public boolean delete(int id) {
        return dao.delete(id);
    }
}
