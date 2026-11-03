package com.test.dl.action;

import org.apache.struts2.ActionSupport;
import com.test.dl.model.BorrowRecord;
import com.test.dl.model.Device;
import com.test.dl.model.User;
import com.test.dl.service.BorrowService;
import com.test.dl.service.DeviceService;
import com.test.dl.service.UserService;
import org.apache.struts2.ServletActionContext;

import jakarta.servlet.http.HttpSession;

import java.util.List;

public class AdminAction extends ActionSupport {

    private UserService    userService    = new UserService();
    private DeviceService  deviceService  = new DeviceService();
    private BorrowService  borrowService  = new BorrowService();

    private List<User>          userList;
    private List<Device>        deviceList;
    private List<BorrowRecord>  borrowList;

    private Integer id;
    private Device  device;

    private Integer recordId;
    private Integer deviceId;
    private Integer days;
    private String  keyword;

    public boolean checkAdmin() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null) return false;
        User u = (User) session.getAttribute("loginUser");
        return u != null && u.isAdmin();
    }

    public String main() {
        if (!checkAdmin()) return "login";
        borrowService.refreshOverdue();
        userList   = userService.findAll();
        deviceList = deviceService.listAll();
        borrowList = borrowService.allBorrows();
        return SUCCESS;
    }

    public String deviceList() {
        if (!checkAdmin()) return "login";
        if (keyword != null && !keyword.trim().isEmpty()) {
            deviceList = deviceService.search(keyword.trim());
        } else {
            deviceList = deviceService.listAll();
        }
        return SUCCESS;
    }

    public String deviceForm() {
        if (!checkAdmin()) return "login";
        if (id != null) device = deviceService.findById(id);
        else device = new Device();
        return SUCCESS;
    }

    public String saveDevice() {
        if (!checkAdmin()) return "login";
        if (device == null) { addActionError("设备信息不能为空"); return INPUT; }
        if (device.getId() == null) {
            boolean ok = deviceService.add(device);
            if (ok) addActionMessage("新增设备成功");
            else { addActionError("新增设备失败"); return INPUT; }
        } else {
            boolean ok = deviceService.update(device);
            if (ok) addActionMessage("更新设备成功");
            else { addActionError("更新设备失败"); return INPUT; }
        }
        return SUCCESS;
    }

    public String deleteDevice() {
        if (!checkAdmin()) return "login";
        if (id == null) { addActionError("设备ID不能为空"); return INPUT; }
        boolean ok = deviceService.delete(id);
        if (ok) addActionMessage("删除设备成功");
        else addActionError("删除设备失败");
        return SUCCESS;
    }

    public String overdue() {
        if (!checkAdmin()) return "login";
        borrowList = borrowService.overdueList();
        return SUCCESS;
    }

    public String adminReturn() {
        if (!checkAdmin()) return "login";
        if (recordId == null || deviceId == null) {
            addActionError("参数错误"); return INPUT;
        }
        boolean ok = borrowService.returnDevice(recordId, deviceId);
        if (ok) addActionMessage("管理员归还成功");
        else addActionError("归还失败");
        return SUCCESS;
    }

    public String refreshOverdue() {
        if (!checkAdmin()) return "login";
        int n = borrowService.refreshOverdue();
        addActionMessage("已刷新逾期状态，更新 " + n + " 条记录");
        return SUCCESS;
    }

    public List<User> getUserList() { return userList; }
    public void setUserList(List<User> userList) { this.userList = userList; }
    public List<Device> getDeviceList() { return deviceList; }
    public void setDeviceList(List<Device> deviceList) { this.deviceList = deviceList; }
    public List<BorrowRecord> getBorrowList() { return borrowList; }
    public void setBorrowList(List<BorrowRecord> borrowList) { this.borrowList = borrowList; }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Device getDevice() { return device; }
    public void setDevice(Device device) { this.device = device; }
    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public Integer getDeviceId() { return deviceId; }
    public void setDeviceId(Integer deviceId) { this.deviceId = deviceId; }
    public Integer getDays() { return days; }
    public void setDays(Integer days) { this.days = days; }
    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }
}
