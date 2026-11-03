package com.test.dl.dao;

import com.test.dl.model.BorrowRecord;
import com.test.dl.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BorrowDAO {

    public boolean insert(BorrowRecord r) {
        String sql = "INSERT INTO t_borrow_record (user_id, device_id, borrow_time, due_time, status, remark) " +
                     "VALUES (?, ?, NOW(), ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getDeviceId());
            ps.setTimestamp(3, new Timestamp(r.getDueTime().getTime()));
            ps.setString(4, BorrowRecord.STATUS_BORROWED);
            ps.setString(5, r.getRemark());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) r.setId(rs.getInt(1));
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<BorrowRecord> findByUserId(int userId) {
        List<BorrowRecord> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.real_name, d.device_code, d.device_name " +
                     "FROM t_borrow_record r " +
                     "LEFT JOIN t_user   u ON r.user_id   = u.id " +
                     "LEFT JOIN t_device d ON r.device_id = d.id " +
                     "WHERE r.user_id = ? ORDER BY r.borrow_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BorrowRecord> findAll() {
        List<BorrowRecord> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.real_name, d.device_code, d.device_name " +
                     "FROM t_borrow_record r " +
                     "LEFT JOIN t_user   u ON r.user_id   = u.id " +
                     "LEFT JOIN t_device d ON r.device_id = d.id " +
                     "ORDER BY r.borrow_time DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BorrowRecord> findOverdue() {
        List<BorrowRecord> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.real_name, d.device_code, d.device_name " +
                     "FROM t_borrow_record r " +
                     "LEFT JOIN t_user   u ON r.user_id   = u.id " +
                     "LEFT JOIN t_device d ON r.device_id = d.id " +
                     "WHERE r.status = 'OVERDUE' OR (r.status = 'BORROWED' AND r.due_time < NOW()) " +
                     "ORDER BY r.due_time ASC";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean returnRecord(int recordId) {
        String sql = "UPDATE t_borrow_record SET return_time = NOW(), status = 'RETURNED' WHERE id = ? AND status IN ('BORROWED','OVERDUE')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, recordId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int updateOverdueStatus() {
        String sql = "UPDATE t_borrow_record SET status = 'OVERDUE' WHERE status = 'BORROWED' AND due_time < NOW()";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement()) {
            return st.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    private BorrowRecord mapRow(ResultSet rs) throws SQLException {
        BorrowRecord r = new BorrowRecord();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("user_id"));
        r.setDeviceId(rs.getInt("device_id"));
        Timestamp bt = rs.getTimestamp("borrow_time");
        r.setBorrowTime(bt == null ? null : new Date(bt.getTime()));
        Timestamp dt = rs.getTimestamp("due_time");
        r.setDueTime(dt == null ? null : new Date(dt.getTime()));
        Timestamp rt = rs.getTimestamp("return_time");
        r.setReturnTime(rt == null ? null : new Date(rt.getTime()));
        r.setStatus(rs.getString("status"));
        r.setRemark(rs.getString("remark"));
        r.setUsername(rs.getString("username"));
        r.setRealName(rs.getString("real_name"));
        r.setDeviceCode(rs.getString("device_code"));
        r.setDeviceName(rs.getString("device_name"));
        return r;
    }
}
