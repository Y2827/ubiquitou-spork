package com.test.dl.model;

import java.io.Serializable;
import java.util.Date;

public class BorrowRecord implements Serializable {

    public static final String STATUS_BORROWED = "BORROWED";
    public static final String STATUS_RETURNED  = "RETURNED";
    public static final String STATUS_OVERDUE   = "OVERDUE";

    private Integer id;
    private Integer userId;
    private Integer deviceId;
    private Date borrowTime;
    private Date dueTime;
    private Date returnTime;
    private String status;
    private String remark;

    private String username;
    private String realName;
    private String deviceCode;
    private String deviceName;

    public BorrowRecord() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getDeviceId() { return deviceId; }
    public void setDeviceId(Integer deviceId) { this.deviceId = deviceId; }
    public Date getBorrowTime() { return borrowTime; }
    public void setBorrowTime(Date borrowTime) { this.borrowTime = borrowTime; }
    public Date getDueTime() { return dueTime; }
    public void setDueTime(Date dueTime) { this.dueTime = dueTime; }
    public Date getReturnTime() { return returnTime; }
    public void setReturnTime(Date returnTime) { this.returnTime = returnTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getDeviceCode() { return deviceCode; }
    public void setDeviceCode(String deviceCode) { this.deviceCode = deviceCode; }
    public String getDeviceName() { return deviceName; }
    public void setDeviceName(String deviceName) { this.deviceName = deviceName; }

    public boolean isOverdue() {
        return STATUS_BORROWED.equals(status) && dueTime != null && dueTime.before(new Date());
    }
}
