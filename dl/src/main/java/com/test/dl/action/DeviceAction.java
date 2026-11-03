package com.test.dl.action;

import org.apache.struts2.ActionSupport;
import com.test.dl.model.Device;
import com.test.dl.model.User;
import com.test.dl.service.DeviceService;
import com.test.dl.service.BorrowService;
import org.apache.struts2.ServletActionContext;

import jakarta.servlet.http.HttpSession;

import java.util.List;

public class DeviceAction extends ActionSupport {

    private DeviceService service = new DeviceService();
    private BorrowService borrowService = new BorrowService();

    private List<Device> deviceList;
    private String keyword;
    private Integer id;
    private Device device;
    private Integer days = 7;
    private String remark;

    public String list() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            deviceList = service.search(keyword.trim());
        } else {
            deviceList = service.listAll();
        }
        return SUCCESS;
    }

    public String borrow() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        if (id == null) { addActionError("设备ID不能为空"); return INPUT; }
        device = service.findById(id);
        if (device == null) { addActionError("设备不存在"); return INPUT; }
        if (device.getAvailableNum() <= 0) {
            addActionError("该设备已全部借出"); return INPUT;
        }
        return SUCCESS;
    }

    public String confirmBorrow() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        User u = (User) session.getAttribute("loginUser");
        device = service.findById(id);
        if (device == null) { addActionError("设备不存在"); return INPUT; }

        boolean ok = borrowService.borrow(u.getId(), device.getId(), days == null ? 7 : days, remark);
        if (ok) {
            addActionMessage("借用成功！设备：" + device.getDeviceName());
            return SUCCESS;
        } else {
            addActionError("借用失败，设备可能已被全部借出");
            return INPUT;
        }
    }

    public List<Device> getDeviceList() { return deviceList; }
    public void setDeviceList(List<Device> deviceList) { this.deviceList = deviceList; }
    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Device getDevice() { return device; }
    public void setDevice(Device device) { this.device = device; }
    public Integer getDays() { return days; }
    public void setDays(Integer days) { this.days = days; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
}
