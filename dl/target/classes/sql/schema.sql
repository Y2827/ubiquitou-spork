-- 校园实验室设备借用归还系统 数据库脚本
CREATE DATABASE IF NOT EXISTS lab_device DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lab_device;

-- 用户表
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50) NOT NULL UNIQUE,
    password    VARCHAR(100) NOT NULL,
    real_name   VARCHAR(50) NOT NULL,
    student_no  VARCHAR(50),
    phone       VARCHAR(20),
    email       VARCHAR(100),
    role        VARCHAR(20) NOT NULL DEFAULT 'STUDENT',
    status      INT NOT NULL DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 设备表
DROP TABLE IF EXISTS t_device;
CREATE TABLE t_device (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    device_code  VARCHAR(50) NOT NULL UNIQUE,
    device_name  VARCHAR(100) NOT NULL,
    category     VARCHAR(50),
    model        VARCHAR(100),
    location     VARCHAR(100),
    total_num    INT NOT NULL DEFAULT 1,
    borrow_num   INT NOT NULL DEFAULT 0,
    status       INT NOT NULL DEFAULT 1,
    description  TEXT,
    create_time  DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 借用记录表
DROP TABLE IF EXISTS t_borrow_record;
CREATE TABLE t_borrow_record (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    device_id    INT NOT NULL,
    borrow_time  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_time     DATETIME NOT NULL,
    return_time  DATETIME,
    status       VARCHAR(20) NOT NULL DEFAULT 'BORROWED',
    remark       VARCHAR(500),
    FOREIGN KEY (user_id)   REFERENCES t_user(id),
    FOREIGN KEY (device_id) REFERENCES t_device(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 初始化用户 (密码均为 123456)
INSERT INTO t_user (username, password, real_name, student_no, phone, role) VALUES
('admin',    '123456', '系统管理员', NULL,        '13800000000', 'ADMIN'),
('zhangsan', '123456', '张三',       '2023001',   '13811112222', 'STUDENT'),
('lisi',     '123456', '李四',       '2023002',   '13811113333', 'STUDENT'),
('wangwu',   '123456', '王五',       '2023003',   '13811114444', 'STUDENT');

-- 初始化设备
INSERT INTO t_device (device_code, device_name, category, model, location, total_num, borrow_num, description) VALUES
('DEV-001', '示波器',     '电子仪器',  'Tektronix TBS1102C', 'A301-1', 3, 1, '数字存储示波器，带宽100MHz'),
('DEV-002', '万用表',     '电子仪器',  'Fluke 17B+',         'A301-2', 5, 2, '手持式数字万用表'),
('DEV-003', '笔记本电脑', '计算机',    'Dell OptiPlex 7090', 'B201-1', 4, 0, '配置：i7/16G/512G SSD'),
('DEV-004', '投影仪',     '多媒体设备','Epson CB-X05',       'B201-2', 2, 1, '3300流明，XGA分辨率'),
('DEV-005', '3D打印机',   '制造设备',  'Prusa i3 MK3S+',     'C101-1', 1, 0, 'FDM 3D打印机'),
('DEV-006', '激光切割机', '制造设备',  'Epilog Zing 16',     'C101-2', 1, 0, '二氧化碳激光切割机');

-- 初始化借用记录 (部分逾期示例)
INSERT INTO t_borrow_record (user_id, device_id, borrow_time, due_time, return_time, status, remark) VALUES
(2, 1, DATE_SUB(NOW(), INTERVAL 5 DAY),  DATE_SUB(NOW(), INTERVAL 2 DAY), NULL,                   'BORROWED', '张三借示波器做实验'),
(3, 4, DATE_SUB(NOW(), INTERVAL 7 DAY),  DATE_SUB(NOW(), INTERVAL 1 DAY), NULL,                   'OVERDUE',  '李四借投影仪逾期'),
(4, 2, DATE_SUB(NOW(), INTERVAL 3 DAY),  DATE_ADD(NOW(), INTERVAL 2 DAY), NULL,                   'BORROWED', '王五借万用表'),
(2, 3, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 'RETURNED', '张三已归还笔记本');
