# 爱宠社API说明

## 文档说明：

### 状态栏：

+：待添加

-：待删除，实际最好不删除，注释或者禁止访问即可

=：待测试

？：测试有问题，待联调

√：已完成

\*:  搁置

## 系统权限

```java
///系统权限分为下面几种类型
///其中authenticated类型根据权限字符串进行细分

/**
     * anyRequest          |   匹配所有请求路径
     * anonymous           |   匿名可以访问
     * permitAll           |   用户可以任意访问
     * authenticated       |   用户登录后可访问
     */
```

## 一、用户模块

### 模块说明

- 用户信息模块
- 目前仅支持手机号验证码登录注册，集成运营商的SDK，做好扩展微信开放SDK的接入的准备
- 用户鉴权使用Token加权限字符串的方式，Token有效期为7\*24\*60\*60,可自动刷新有效期
- 登录、注册需要后台实时开关，后台主动下线用户（删token即可）
- 

接口表

| 路径      | 参数 | 权限          | 描述 | 状态 |
| --------- | ---- | ------------- | ---- | ---- |
| /login    |      | anonymous     |      | +    |
| /register |      | anonymous     |      | +    |
| /logout   |      | authenticated |      | +    |

## 二、后台管理功能

### 模块说明

- 后台管理模块
- 后台登录人员，token有效期为10*60
- 本模块权限均为admin（暂定）

| 路径                | 参数 | 权限 | 描述                           | 状态 |
| ------------------- | ---- | ---- | ------------------------------ | ---- |
| /server             |      |      | 实时查看服务器资源（参考框架） | +    |
| /getalluser         |      |      | 获取所有用户，分页查询         |      |
| /getuserbyid/{id}   |      |      | 根据id查找用户信息             |      |
| /getuserbytel/{tel} |      |      | 根据tel查找用户信息            |      |
| /deluser/{id}       |      |      |                                |      |
| /                   |      |      |                                |      |
|                     |      |      |                                |      |
|                     |      |      |                                |      |
|                     |      |      |                                |      |





































## 附录一 错误码

除200为操作成功外，其余可根据需要自定义，定义后添加在下方



## 附录二 参考项目

[一款社交应用]: https://gitee.com/firstime/community-client-beta
[仿微博客户端]: https://github.com/huangruiLearn/flutter_hrlweibo
[仿斗鱼]: https://github.com/yukilzw/dy_flutter
[仿抖音]: https://github.com/mjl0602/flutter_tiktok

## 附录三 数据库表

```sql
-- ----------------------------
-- 1、用户登录表 手机+验证码，用户名+密码
-- ----------------------------
drop table if exists user_login;
create table user_login (
  user_id           bigint(20)      not null auto_increment    comment '用户唯一ID',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  password          varchar(100)    default ''                 comment '密码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  avatar            varchar(100)    default ''                 comment '头像地址',
  status            char(1)         default '0'                comment '帐号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录IP',
  login_date        datetime                                   comment '最后登录时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(128)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户登录表';

-- ----------------------------
-- 2、用户详情表，查询此表前先查1表确定用户状态
-- ----------------------------
drop table if exists user_detail;
create table user_detail (
  detail_id			bigint(20)      not null auto_increment    comment '详情ID',
  user_id           bigint(20)      not null 			       comment '用户唯一ID',
  signature			varchar(128)	default ''				   comment '个性签名',
  address			varchar(64)  	default ''				   comment '所在地址',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(128)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户详情表';
-- ----------------------------
-- 3、会员表
-- ----------------------------
-- ----------------------------
-- 4、投食表，云吸宠物表
-- ----------------------------
-- ----------------------------
-- 5、收货地址表
-- ----------------------------
-- ----------------------------
-- 6、宠物信息表（有主）
-- ----------------------------
-- ----------------------------
-- 7、应用参数配置表
-- ----------------------------
-- ----------------------------
-- 8、操作日志表（仅系统用户） 系统访问记录
-- ----------------------------
-- ----------------------------
-- 9、大事件表，记录用户一些事件
-- ----------------------------
-- ----------------------------
-- 10、文章表
-- ----------------------------
-- ----------------------------
-- 11、评价表
-- ----------------------------
-- ----------------------------
-- 12、收藏表
-- ----------------------------
-- ----------------------------
-- 13、点赞表
-- ----------------------------
-- ----------------------------
-- 14、转发表
-- ----------------------------
-- ----------------------------
-- 15、订单表
-- ----------------------------
-- ----------------------------
-- 16、账单表
-- ----------------------------
-- ----------------------------
-- 17、商品表
-- ----------------------------
-- ----------------------------
-- 18、商品详情表
-- ----------------------------
-- ----------------------------
-- 19、通知公告表
-- ----------------------------
-- ----------------------------
-- 20、合作与反馈表
-- ----------------------------
-- ----------------------------
-- 21、备忘录表
-- ----------------------------
-- ----------------------------
-- 22、信息发布表  转卖、配种、领养、约旅
-- ----------------------------
-- ----------------------------
-- 23、定时任务表
-- ----------------------------
-- ----------------------------
-- 24、粉丝关注表
-- ----------------------------
CREATE TABLE `tb_vip_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vip_id` bigint DEFAULT '0' COMMENT '用户ID(粉丝ID)',
  `followed_vip_id` bigint DEFAULT '0' COMMENT '关注的用户ID',
  `status` tinyint(1) DEFAULT '0' COMMENT '关注状态(0关注 1取消)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vip_followed_indx` (`vip_id`,`followed_vip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 COMMENT='粉丝关注表';
-- ----------------------------
-- 25、角色信息表   
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id              bigint(20)      not null auto_increment    comment '角色ID',
  role_name            varchar(30)     not null                   comment '角色名称',
  role_key             varchar(100)    not null                   comment '角色权限字符串',
  role_sort            int(4)          not null                   comment '显示顺序',
  data_scope           char(1)         default '1'                comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  menu_check_strictly  tinyint(1)      default 1                  comment '菜单树选择项是否关联显示',
  dept_check_strictly  tinyint(1)      default 1                  comment '部门树选择项是否关联显示',
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
-- 26、用户和角色关联表 用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户ID',
  role_id   bigint(20) not null comment '角色ID',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';
-- ----------------------------
-- ----------------------------
-- 27、接口权限表 角色和接口绑定
-- ----------------------------
-- ----------------------------
-- 28、角色和接口关联表  角色1-N菜单 APP使用
-- ----------------------------
-- ----------------------------
-- 29、菜单权限表 后台使用
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id           bigint(20)      not null auto_increment    comment '菜单ID',
  menu_name         varchar(50)     not null                   comment '菜单名称',
  parent_id         bigint(20)      default 0                  comment '父菜单ID',
  order_num         int(4)          default 0                  comment '显示顺序',
  path              varchar(200)    default ''                 comment '路由地址',
  component         varchar(255)    default null               comment '组件路径',
  is_frame          int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache          int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  menu_type         char(1)         default ''                 comment '菜单类型（M目录 C菜单 F按钮）',
  visible           char(1)         default 0                  comment '菜单状态（0显示 1隐藏）',
  status            char(1)         default 0                  comment '菜单状态（0正常 1停用）',
  perms             varchar(100)    default null               comment '权限标识',
  icon              varchar(100)    default '#'                comment '菜单图标',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=2000 comment = '菜单权限表';

-- 30、角色和菜单关联表  角色1-N菜单 后台使用
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色ID',
  menu_id   bigint(20) not null comment '菜单ID',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';


-- ----------------------------
-- 以下为扩展表，临时想到了先记录这
-- ----------------------------

-- ----------------------------
-- 0、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
  dict_id          bigint(20)      not null auto_increment    comment '字典主键',
  dict_name        varchar(100)    default ''                 comment '字典名称',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_id),
  unique (dict_type)
) engine=innodb auto_increment=100 comment = '字典类型表';

insert into sys_dict_type values(1,  '用户性别', 'sys_user_sex',        '0', 'admin', sysdate(), '', null, '用户性别列表');
insert into sys_dict_type values(2,  '菜单状态', 'sys_show_hide',       '0', 'admin', sysdate(), '', null, '菜单状态列表');
insert into sys_dict_type values(3,  '系统开关', 'sys_normal_disable',  '0', 'admin', sysdate(), '', null, '系统开关列表');
insert into sys_dict_type values(4,  '任务状态', 'sys_job_status',      '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values(5,  '任务分组', 'sys_job_group',       '0', 'admin', sysdate(), '', null, '任务分组列表');
insert into sys_dict_type values(6,  '系统是否', 'sys_yes_no',          '0', 'admin', sysdate(), '', null, '系统是否列表');
insert into sys_dict_type values(7,  '通知类型', 'sys_notice_type',     '0', 'admin', sysdate(), '', null, '通知类型列表');
insert into sys_dict_type values(8,  '通知状态', 'sys_notice_status',   '0', 'admin', sysdate(), '', null, '通知状态列表');
insert into sys_dict_type values(9,  '操作类型', 'sys_oper_type',       '0', 'admin', sysdate(), '', null, '操作类型列表');
insert into sys_dict_type values(10, '系统状态', 'sys_common_status',   '0', 'admin', sysdate(), '', null, '登录状态列表');


-- ----------------------------
-- 0、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
  dict_code        bigint(20)      not null auto_increment    comment '字典编码',
  dict_sort        int(4)          default 0                  comment '字典排序',
  dict_label       varchar(100)    default ''                 comment '字典标签',
  dict_value       varchar(100)    default ''                 comment '字典键值',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  css_class        varchar(100)    default null               comment '样式属性（其他样式扩展）',
  list_class       varchar(100)    default null               comment '表格回显样式',
  is_default       char(1)         default 'N'                comment '是否默认（Y是 N否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_code)
) engine=innodb auto_increment=100 comment = '字典数据表';
-- ----------------------------
-- 0、公益事业表
-- ----------------------------
-- ----------------------------
-- 0、流浪宠物信息表
-- ----------------------------
-- ----------------------------
-- 0、开放登录表
-- ----------------------------
```

