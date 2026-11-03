package com.test.dl.model;

import java.io.Serializable;
import java.util.Date;

public class Device implements Serializable {

    private Integer id;
    private String deviceCode;
    private String deviceName;
    private String category;
    private String model;
    private String location;
    private Integer totalNum;
    private Integer borrowNum;
    private Integer status;
    private String description;
    private Date createTime;

    public Device() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getDeviceCode() { return deviceCode; }
    public void setDeviceCode(String deviceCode) { this.deviceCode = deviceCode; }
    public String getDeviceName() { return deviceName; }
    public void setDeviceName(String deviceName) { this.deviceName = deviceName; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Integer getTotalNum() { return totalNum; }
    public void setTotalNum(Integer totalNum) { this.totalNum = totalNum; }
    public Integer getBorrowNum() { return borrowNum; }
    public void setBorrowNum(Integer borrowNum) { this.borrowNum = borrowNum; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public int getAvailableNum() {
        return (totalNum == null ? 0 : totalNum) - (borrowNum == null ? 0 : borrowNum);
    }
}
