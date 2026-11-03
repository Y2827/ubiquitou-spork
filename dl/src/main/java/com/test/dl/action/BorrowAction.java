package com.test.dl.action;

import org.apache.struts2.ActionSupport;
import com.test.dl.model.BorrowRecord;
import com.test.dl.model.User;
import com.test.dl.service.BorrowService;
import org.apache.struts2.ServletActionContext;

import jakarta.servlet.http.HttpSession;

import java.util.List;

public class BorrowAction extends ActionSupport {

    private BorrowService service = new BorrowService();

    private List<BorrowRecord> borrowList;
    private Integer recordId;
    private Integer deviceId;

    public String my() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        User u = (User) session.getAttribute("loginUser");
        borrowList = service.myBorrows(u.getId());
        return SUCCESS;
    }

    public String returnDevice() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        if (recordId == null || deviceId == null) {
            addActionError("参数错误"); return INPUT;
        }
        boolean ok = service.returnDevice(recordId, deviceId);
        if (ok) {
            addActionMessage("归还成功");
        } else {
            addActionError("归还失败，请联系管理员");
        }
        return SUCCESS;
    }

    public String overdueList() {
        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            return "login";
        }
        borrowList = service.overdueList();
        return SUCCESS;
    }

    public List<BorrowRecord> getBorrowList() { return borrowList; }
    public void setBorrowList(List<BorrowRecord> borrowList) { this.borrowList = borrowList; }
    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public Integer getDeviceId() { return deviceId; }
    public void setDeviceId(Integer deviceId) { this.deviceId = deviceId; }
}
