package com.test.dl.dao;

import com.test.dl.model.Device;
import com.test.dl.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeviceDAO {

    public List<Device> findAll() {
        List<Device> list = new ArrayList<>();
        String sql = "SELECT * FROM t_device WHERE status = 1 ORDER BY id";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Device> search(String keyword) {
        List<Device> list = new ArrayList<>();
        String sql = "SELECT * FROM t_device WHERE status = 1 " +
                     "AND (device_code LIKE ? OR device_name LIKE ? OR category LIKE ?) " +
                     "ORDER BY id";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + (keyword == null ? "" : keyword) + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Device findById(int id) {
        String sql = "SELECT * FROM t_device WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(Device d) {
        String sql = "INSERT INTO t_device (device_code, device_name, category, model, location, total_num, borrow_num, description) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.getDeviceCode());
            ps.setString(2, d.getDeviceName());
            ps.setString(3, d.getCategory());
            ps.setString(4, d.getModel());
            ps.setString(5, d.getLocation());
            ps.setInt(6, d.getTotalNum());
            ps.setInt(7, d.getBorrowNum() == null ? 0 : d.getBorrowNum());
            ps.setString(8, d.getDescription());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) d.setId(rs.getInt(1));
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Device d) {
        String sql = "UPDATE t_device SET device_code=?, device_name=?, category=?, model=?, " +
                     "location=?, total_num=?, borrow_num=?, description=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getDeviceCode());
            ps.setString(2, d.getDeviceName());
            ps.setString(3, d.getCategory());
            ps.setString(4, d.getModel());
            ps.setString(5, d.getLocation());
            ps.setInt(6, d.getTotalNum());
            ps.setInt(7, d.getBorrowNum());
            ps.setString(8, d.getDescription());
            ps.setInt(9, d.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "UPDATE t_device SET status = 0 WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean increaseBorrow(int id) {
        String sql = "UPDATE t_device SET borrow_num = borrow_num + 1 WHERE id = ? AND borrow_num < total_num";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean decreaseBorrow(int id) {
        String sql = "UPDATE t_device SET borrow_num = borrow_num - 1 WHERE id = ? AND borrow_num > 0";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Device mapRow(ResultSet rs) throws SQLException {
        Device d = new Device();
        d.setId(rs.getInt("id"));
        d.setDeviceCode(rs.getString("device_code"));
        d.setDeviceName(rs.getString("device_name"));
        d.setCategory(rs.getString("category"));
        d.setModel(rs.getString("model"));
        d.setLocation(rs.getString("location"));
        d.setTotalNum(rs.getInt("total_num"));
        d.setBorrowNum(rs.getInt("borrow_num"));
        d.setStatus(rs.getInt("status"));
        d.setDescription(rs.getString("description"));
        d.setCreateTime(rs.getTimestamp("create_time"));
        return d;
    }
}
