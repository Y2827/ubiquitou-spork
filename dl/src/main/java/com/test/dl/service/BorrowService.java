package com.test.dl.service;

import com.test.dl.dao.BorrowDAO;
import com.test.dl.dao.DeviceDAO;
import com.test.dl.model.BorrowRecord;
import com.test.dl.model.Device;
import com.test.dl.util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class BorrowService {

    private BorrowDAO borrowDAO = new BorrowDAO();
    private DeviceDAO  deviceDAO = new DeviceDAO();

    public boolean borrow(int userId, int deviceId, int days, String remark) {
        Device d = deviceDAO.findById(deviceId);
        if (d == null) return false;
        if (d.getAvailableNum() <= 0) return false;

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            BorrowRecord r = new BorrowRecord();
            r.setUserId(userId);
            r.setDeviceId(deviceId);
            r.setBorrowTime(new Date());
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, days <= 0 ? 7 : days);
            r.setDueTime(cal.getTime());
            r.setRemark(remark);

            boolean ok = borrowDAO.insert(r);
            if (!ok) { conn.rollback(); return false; }

            ok = deviceDAO.increaseBorrow(deviceId);
            if (!ok) { conn.rollback(); return false; }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ignored) {} }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {} }
        }
    }

    public boolean returnDevice(int recordId, int deviceId) {
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            boolean ok = borrowDAO.returnRecord(recordId);
            if (!ok) { conn.rollback(); return false; }

            ok = deviceDAO.decreaseBorrow(deviceId);
            if (!ok) { conn.rollback(); return false; }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ignored) {} }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {} }
        }
    }

    public List<BorrowRecord> myBorrows(int userId) {
        borrowDAO.updateOverdueStatus();
        return borrowDAO.findByUserId(userId);
    }

    public List<BorrowRecord> allBorrows() {
        borrowDAO.updateOverdueStatus();
        return borrowDAO.findAll();
    }

    public List<BorrowRecord> overdueList() {
        borrowDAO.updateOverdueStatus();
        return borrowDAO.findOverdue();
    }

    public int refreshOverdue() {
        return borrowDAO.updateOverdueStatus();
    }
}
