
-- 纪念日
-- 100见小事
-- 日记
-- 相册
-- 打卡
-- 闹钟
-- 助手
-- 每日一句
-- 心情

-- 商城
-- 货物，酒店等

-- 账单
-- 收获地址
-- 所有信息都要有创建者，修改者，信息属于谁

-- ----------------------------
-- 1、用户信息表
-- 用户账号用来匹配，每个用户的唯一ID
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
  user_id           bigint(20)      not null auto_increment    comment '用户ID',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  birthday          datetime                                   comment '生日',
  avatar            varchar(100)    default ''                 comment '头像地址',
  password          varchar(100)    default ''                 comment '密码',
  status            char(1)         default '0'                comment '帐号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录IP',
  login_date        datetime                                   comment '最后登录时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values(1,  'admin','哼哼', '00', 'ry@163.com', '15888888888', '1',null, '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '管理员');
insert into sys_user values(2,  'zy', '哈哈', '00', 'ry@qq.com',  '15666666666', '1', null, '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '测试员');
insert into sys_user values(3,  'vip', '会员', '00', 'ry@qq.com',  '15666666666', '1',null,  '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '会员测试员');

-- ----------------------------
-- 1、会员用户信息表
-- 用户账号用来匹配，每个用户的唯一ID
-- 配对账号唯一，过期时间以服务器时间为准
-- 配对账号生成时要查重
-- ----------------------------
drop table if exists sys_vip;
create table sys_vip (
  user_id           bigint(20)      not null                   comment '用户ID',
  pair_id           bigint(20)      not null                   comment '配对账号',
  diamond           bigint(20)      default  0                 comment '钻石余额',
  pair_status       char(1)         default '1'                comment '配对状态（0正常 1停用）',
  status            char(1)         default '0'                comment '会员状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '会员标志（0代表存在 1代表删除）',
  vip_outdate       datetime                                   comment '会员过期时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id),
  unique key (pair_id) 
) engine=innodb  comment = '会员用户信息表';

-- ----------------------------
-- 初始化-会员用户信息数据
-- ----------------------------
insert into sys_vip values(1,  123,  0,'1', '0', '0', sysdate(),  'admin', sysdate(), '', null, null);
insert into sys_vip values(2,  456,  15,'1', '0', '0', sysdate(),  'admin', sysdate(), '', null, null);
insert into sys_vip values(3,  555,  456,'1', '0', '0', sysdate(),  'admin', sysdate(), '', null, null);

-- ----------------------------
-- 1、配对信息表
-- 共有信息
-- ----------------------------
drop table if exists sys_pair;
create table sys_pair (
  pair_id           bigint(20)      not null                   comment '配对账号',
  nick_name         varchar(30)     not null                   comment '配对昵称',
  love              varchar(128)    default null               comment '恋爱宣言',
  avatar            varchar(100)    default ''                 comment '头像地址',
  pair_time         datetime                                   comment '配对时间',
  status            char(1)         default '0'                comment '配对状态（0正常 1停用）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (pair_id)
) engine=innodb  comment = '配对信息表';

-- ----------------------------
-- 初始化-配对信息表数据
-- ----------------------------
insert into sys_pair values(123,  "123", 'sysdate(456)', '',sysdate(), '0',  'admin', sysdate(), '', null, null);
insert into sys_pair values(555,  "456", null, '',sysdate(), '0',  'admin', sysdate(), '', null, null);

-- ----------------------------
-- 2、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id              bigint(20)      not null auto_increment    comment '角色ID',
  role_name            varchar(30)     not null                   comment '角色名称',
  role_key             varchar(100)    not null                   comment '角色权限字符串',
  data_scope           char(1)         default '5'                comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  status               char(1)         not null                   comment '角色状态（0正常 1停用）',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  remark               varchar(500)    default null               comment '备注',
  primary key (role_id)
) engine=innodb auto_increment=100 comment = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '超级管理员',  'admin',  1, '0', '0', 'admin', sysdate(), '', null, '超级管理员');
insert into sys_role values('2', '普通角色',    'common', 5, '0', '0', 'admin', sysdate(), '', null, '普通角色');
insert into sys_role values('3', '会员',        'vip',    5, '0', '0', 'admin', sysdate(), '', null, '会员');


-- ----------------------------
-- 3、接口权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id           bigint(20)      not null auto_increment    comment '接口ID',
  menu_name         varchar(50)     not null                   comment '接口名称',
  is_frame          int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache          int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  path              varchar(200)    default ''                 comment '外链地址',
  menu_type         char(1)         default ''                 comment '接口类型（暂留）',
  status            char(1)         default 0                  comment '接口状态（0正常 1隐藏 2停用）',
  perms             varchar(100)    default null               comment '权限标识',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=100 comment = '接口权限表';

-- ----------------------------
-- 初始化-接口权限表数据
-- ----------------------------
insert into sys_menu values('1', '系统管理', '1', '1', '',               '', '0','',                 'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values('2', '系统监控', '1', '1', '',               '', '1','',                 'admin', sysdate(), '', null, '系统监控目录');
insert into sys_menu values('3', '若依官网', '0', '1', 'http://ruoyi.vip','','0','',                 'admin', sysdate(), '', null, '若依官网地址');
insert into sys_menu values('4', '用户管理', '1', '1', '',                '','0','system:user:list', 'admin', sysdate(), '', null, '用户管理菜单');
insert into sys_menu values('5', '角色修改', '1', '1', '' ,               '','0','system:role:edit', 'admin', sysdate(), '', null, '');

-- ----------------------------
-- 4、用户和角色关联表  用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户ID',
  role_id   bigint(20) not null comment '角色ID',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');
insert into sys_user_role values ('2', '2');
insert into sys_user_role values ('3', '3');


-- ----------------------------
-- 5、角色和菜单关联表  角色1-N菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色ID',
  menu_id   bigint(20) not null comment '菜单ID',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';

insert into sys_role_menu values ('2', '3');
insert into sys_role_menu values ('3', '2');
insert into sys_role_menu values ('3', '4');
insert into sys_role_menu values ('3', '5');