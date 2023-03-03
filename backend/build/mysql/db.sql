create database if not exists bookstore;

use bookstore;

create table book
(
    id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title    VARCHAR(500),
    author   VARCHAR(200),
    sales    INT UNSIGNED,
    covers   VARCHAR(500),
    price    INT UNSIGNED,
    orgPrice INT UNSIGNED,
    INDEX (id)
) default charset = utf8;

create table user_auth
(
    id       int unsigned auto_increment primary key,
    name     varchar(15) not null,
    password varchar(16) not null,
    email    varchar(25) not null,
    constraint name
        unique (name)
);

create index name_2
    on user_auth (name);

insert into user_auth (name, password, email) VALUE ('okabe', '123', '');

create table user
(
    id       int unsigned auto_increment primary key,
    auth     int unsigned not null,
    username varchar(15)  not null,
    nickname varchar(15)  not null,
    avatar   varchar(200) not null,
    constraint user_ibfk_1 foreign key (auth) references user_auth (id)
);

create index auth
    on user (auth);

create index username
    on user (username);

create table like_tbl
(
    id         int unsigned auto_increment primary key,
    username   varchar(15) not null,
    comment_id varchar(24) not null
);
create index username
    on like_tbl (username);

create index comment_id
    on like_tbl (comment_id);

create table cart_item
(
    id      int unsigned auto_increment primary key,
    book_id int unsigned not null,
    number  int unsigned not null,
    constraint foreign key (book_id) references book (id)
);

create table user_cart_record
(
    id           int unsigned auto_increment primary key,
    cart_item_id int unsigned not null,
    user_id      int unsigned not null,
    constraint foreign key (user_id) references user (id),
    constraint foreign key (cart_item_id) references cart_item (id)
);

create table address_tbl
(
    id         int unsigned auto_increment primary key,
    address    varchar(500),
    name       varchar(50),
    tel        varchar(20),
    is_default bool
);

create table user_address_record
(
    id      int unsigned auto_increment primary key,
    user_id int unsigned not null,
    addr_id int unsigned not null,
    constraint foreign key (user_id) references user (id),
    constraint foreign key (addr_id) references address_tbl (id)
);

create index user_id on user_cart_record (user_id);

insert into user (auth, username, nickname, avatar) VALUE (1, 'okabe', '冈部伦太郎', '/static/avatar.png');

insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter内核源码剖析（Flutter内核源码深入剖析，从组件开发到技术综合应用，多角度介绍 Flutter项目开发的方方面面', '赵裕', 0,
        'https://images-cn.ssl-images-amazon.cn/images/I/51EFk+PPTJL.jpg', 5754, 5754);

insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter App开发 从入门到实战 移动开发教程书籍，系统讲解使用Flutter跨平台开发核心内容，包含丰富代码示例、两个完整APP实战项目，赠送配套代码，快速入门并掌握跨平台开发。', '李元静', 0,
        'http://img3m0.ddimg.cn/56/11/29301680-1_b_2.jpg', 7490, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter内核源码剖析 涉及源码的获取与构建，功能模块的实现以及Flutter应用的性能探测，监控和调优，横跨Java、C++、Dart这3种编程语言，覆盖Flutter 1.0 和 2.0 版本。', '赵裕',
        0, 'http://img3m4.ddimg.cn/63/14/29355444-1_b_4.jpg', 4490, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter跨平台移动开发实战 40个示例源代码，730分钟视频讲解!手把手教你从零基础学习Flutter开发技术', '董运成', 0,
        'http://img3m4.ddimg.cn/52/15/29465224-1_b_2.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深度探索Flutter――企业应用开发实战 从Dart语言基础到App架构开发，逐步深入讲解！配套两个大型项目的快速基础开发模板', '赵龙', 0,
        'http://img3m0.ddimg.cn/7/9/29462110-1_b_2.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter组件详解与实战', '[加]王浩然（Bradley Wang）', 0, 'http://img3m9.ddimg.cn/0/24/29373399-1_b_1.jpg', 8170, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter入门经典 Flutter零基础入门书!使用Flutter来开发出色的移动应用。', '[美] 马可・纳波利(Marco L. Napoli) 著 蒲成 译', 0,
        'http://img3m6.ddimg.cn/24/11/29193936-1_b_3.jpg', 8850, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter技术解析与实战――闲鱼技术演进与创新 阿里巴巴闲鱼Flutter大规模线上经验，全面的Flutter企业级实践指南，揭秘亿级流量背后的技术秘籍', '闲鱼技术部', 0,
        'http://img3m4.ddimg.cn/57/19/28527204-1_b_6.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter2开发实例精解 利用Flutter2构建强大、可靠的Web应用程序', '[美]西蒙・亚历山大 等著 于鑫睿 译', 0,
        'http://img3m1.ddimg.cn/47/36/29399681-1_b_2.jpg', 11920, 15900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter基础与实战 从入门到APP跨平台开发 百余个小型功能案例，两个大型综合开发案例，二维码配套资源', '赵龙 编著', 0,
        'http://img3m7.ddimg.cn/70/23/29334067-1_b_3.jpg', 8900, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter跨平台开发入门与实战 web前端开发技术解析入门到进阶开发实战详解，基于*的Flutter 1.17.0版本进行编写，一本书带你在实战中全方位掌握Flutter开发框架。', '向治洪', 0,
        'http://img3m9.ddimg.cn/14/22/29170859-1_b_4.jpg', 3950, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter实战 机械工业出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '杜文', 0,
        'http://img3m2.ddimg.cn/62/30/1585659302-1_b_3.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter实战 “Flutter中文网”社区创始人杜文倾力撰写网红书。从0基础入门、进阶到Flutter技术解析与实战，详细阐述阿里巴巴咸鱼技术等大厂都在用的Flutter跨平台开发技术', '杜文', 0,
        'http://img3m7.ddimg.cn/6/24/28521807-1_b_9.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Flutter实战|8067391', '杜文', 0, 'http://img3m5.ddimg.cn/33/14/1709278395-1_b_1.jpg', 6930, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter内核源码剖析 Flutter开发实战详解Dart/java/C++前端开发Androi', '赵裕', 0,
        'http://img3m4.ddimg.cn/72/33/11067138594-1_b_1.jpg', 7009, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter App开发 从入门到实战 Android开发 iOS APP开发实战 跨平台开发', '李元静', 0,
        'http://img3m4.ddimg.cn/96/18/695573304-1_b_1.jpg', 7790, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter跨平台开发入门与实战 web前端开发技术解析入门到进阶开发实战详解Dart编程语言前端', '向治洪', 0,
        'http://img3m0.ddimg.cn/10/11/1823701780-1_b_1.jpg', 6160, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter组件精讲与实战 全面讲解Flutter组件核心知识与案例项目！Flutter开发工具书，内容翔实，由浅入深，实用性强', '赵龙', 0,
        'http://img3m2.ddimg.cn/3/4/29318952-1_b_3.jpg', 22350, 29800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter：从0到1构建大前端应用 谷歌全平台框架，Flutter技术入门、进阶实战 ，大前端构建，移动开发，Dart语言学习，新版疑点、难点解析，从基础学习到上架App', '何瑞君', 0,
        'http://img3m9.ddimg.cn/28/19/27902089-1_b_5.jpg', 6240, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Dart语言实战――基于Flutter框架的程序开发', '亢少军', 0, 'http://img3m2.ddimg.cn/82/9/29344672-1_b_1.jpg', 8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter企业级应用开发实战――闲鱼技术发展与创新', '闲鱼技术团队', 0, 'http://img3m0.ddimg.cn/72/26/29253780-1_b_13.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter开发实战详解', '郭树煜', 0, 'http://img3m9.ddimg.cn/88/32/28558519-1_b_6.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter技术入门与实战 第2版 从实战角度出发，手把手教会Flutter，案例丰富， 实操性强。', '亢少军', 0,
        'http://img3m7.ddimg.cn/72/18/28485837-1_b_3.jpg', 6140, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter从0基础到App上线 一套代码通杀移动端，全面面向零基础读者，易学、易实践，人人都是开发者；从零开始，手把手教你开发出一款自己的APP，适用于Android和iOS双平台', '萧文翰', 0,
        'http://img3m0.ddimg.cn/27/33/28525590-1_b_6.jpg', 9320, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter实战入门 资深开发者撰写的Flutter入门教程，以“介绍+示例”的形式讲解，从实战角度出发，手把手教你学Flutter。双色印刷，阅读体验更佳', '老孟', 0,
        'http://img3m9.ddimg.cn/32/32/28970699-1_b_3.jpg', 6140, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter开发实例解析 一线移动跨端工程师，一手实战经验，通过7个完整实战项目手把手教你快速入门Flutter', '王睿 著', 0,
        'http://img3m7.ddimg.cn/34/25/29272057-1_b_11.jpg', 8210, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('大前端三剑客――Vue+React+Flutter 全面解析大前端核心技术！带领读者掌握从移动互联应用开发到万物互联应用开发的技术和实战技巧', '徐礼文', 0,
        'http://img3m3.ddimg.cn/35/22/29494313-1_b_1.jpg', 15669, 20900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter 开发之旅从南到北 web前端开发从入门的基础知识、前端开发的利器到前端开发实战，从初级到高级的进阶，系统讲述Flutter开发技术，提供源代码。', '杨加康', 0,
        'http://img3m3.ddimg.cn/10/8/29153233-1_b_2.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【包邮特价】Flutter技术入门与实战 第2版|232895', '亢少军', 0, 'http://img3m8.ddimg.cn/96/20/1898136798-1_b_2.jpg', 3827, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter开发零基础入门(微课版） 1．2019年――谷歌产学合作协同育人项目资助； 2．实用性的案例拓宽开发者的项目开发能力；详细的源代码解析提高开发者的项目分析能力；层次性的技术介绍提升开发者的项目解决能力。',
        '倪红军', 0, 'http://img3m3.ddimg.cn/97/6/29280733-1_b_4.jpg', 5230, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter技术入门与实战 本书由资深架构师撰写，从实战角度讲解Flutter,从基础组件到综合案例，从工具使用到插件开发，包含大量精选案例和详细实操步骤', '亢少军', 0,
        'http://img3m3.ddimg.cn/46/29/26485813-1_b_2.jpg', 5450, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter开发入门与实践', '周群一', 0, 'http://img3m1.ddimg.cn/73/12/29267641-1_b_3.jpg', 3710, 3900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter实战 使用Flutter构建可以直接安装在自己移动设备上的实用应用。', '[荷兰]弗兰克・扎米蒂(Frank Zammetti) 著；贡国栋 任强 译', 0,
        'http://img3m5.ddimg.cn/67/2/28995385-1_b_5.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【包邮特价】Flutter实战入门|233835', '老孟', 0, 'http://img3m2.ddimg.cn/38/14/698505032-1_b_1.jpg', 3827, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter之旅 全彩色、全方位展示Flutter基本概念与操作方式', '张德立', 0, 'http://img3m3.ddimg.cn/44/13/29119013-1_b_5.jpg', 8210,
        11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter入门与实践 好用、方便、跨平台、开源、免费！嗯，Flutter真香！', '[美]亚历山德罗・比萨克 著 李强 译', 0,
        'http://img3m5.ddimg.cn/10/11/28996615-1_b_6.jpg', 9670, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Flutter by 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Thorne, Sheena', 0,
        'http://img3m1.ddimg.cn/94/36/26543281-1_b_1.jpg', 17399, 17399);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter开发之旅从南到北 Flutter技术入门与实战web前端开发设计教程书籍Dart语言实', '杨加康', 0,
        'http://img3m6.ddimg.cn/70/3/1764612106-1_b_1.jpg', 6160, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Flutter实战指南 资深全栈架构师手把手教你掌握Flutter跨平台移动开发！配套丰富学习资源助力快速动手实践！', '李楠', 0,
        'http://img3m0.ddimg.cn/96/9/28549320-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【包邮特价】Flutter之旅|233875', '张德立', 0, 'http://img3m2.ddimg.cn/20/34/633659222-1_b_2.jpg', 5712, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Flutter by Butterfly 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Centers, Sharon', 0,
        'http://img3m8.ddimg.cn/78/18/26502378-1_b_1.jpg', 26505, 26505);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('有趣的Flutter 从0到1构建跨平台App', '任宇杰 王志宇 魏国梁 臧成威', 0, 'http://img3m6.ddimg.cn/28/16/29351746-1_b_1.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('用Flutter极速构建原生应用 从0到1，资深软件工程师教你快速构建Flutter应用程序', '张益珲', 0, 'http://img3m2.ddimg.cn/77/21/28477922-1_b_3.jpg',
        5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('WebRTC音视频开发：React Flutter Go实战 系统全面地讲解WebRTC音视频开发技术，从基本原理到实际操作步骤，可帮助读者快速上手。 结合一对一视频通话案例，让读者深入理解WebRTC的各种功能，并快速搭建自己的应用。',
        '亢少军', 0, 'http://img3m8.ddimg.cn/73/15/29129338-1_b_2.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Flutter技术入门与实战|8055550', '亢少军', 0, 'http://img3m6.ddimg.cn/19/17/1373247136-1_b_1.jpg', 5530, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Flutter之旅|8071763', '张德立', 0, 'http://img3m5.ddimg.cn/88/22/1727205865-1_b_1.jpg', 8330, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]Flutter实战入门+Flutter实战（2册）|8070599', '老孟 杜文', 0, 'http://img3m5.ddimg.cn/49/22/1709276035-1_b_1.jpg',
        12784, 18800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]Flutter实战+Flutter技术入门与实战 第2版+And|8068402', '杜文 亢少军 包建强', 0,
        'http://img3m5.ddimg.cn/69/24/1709278035-1_b_1.jpg', 18156, 26700);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Flutter技术入门与实战 第2版|8064981', '亢少军', 0, 'http://img3m5.ddimg.cn/66/1/1546308885-1_b_1.jpg', 6230, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('有趣的Flutter 从0到*构建跨平台App 移动应用开发技术移动开发web开发Dart语言项目实', '任宇杰等', 0,
        'http://img3m4.ddimg.cn/46/11/11062985914-1_b_1.jpg', 7780, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]Flutter实战+Flutter技术入门与实战 第2版（2册）|8068400', '杜文 亢少军', 0,
        'http://img3m5.ddimg.cn/21/10/1598189295-1_b_1.jpg', 12784, 18800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]Flutter技术入门与实战 第2版+Android插件化开发指|8065731', '亢少军包建强', 0,
        'http://img3m5.ddimg.cn/83/9/1709280425-1_b_1.jpg', 11424, 16800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]Flutter实战+React Native 精解与实战（2册）|8068401', '杜文 邱鹏源', 0,
        'http://img3m5.ddimg.cn/41/30/1598189315-1_b_1.jpg', 12104, 17800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Flutter实战入门|8070490', '老孟', 0, 'http://img3m5.ddimg.cn/89/25/1709276075-1_b_1.jpg', 6230, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('从零开始学Flutter开发 基础知识 + 设计思想 + 实战技巧！基于Flutter新版本，技能点全面详细、案例丰富，手把手带领零基础开发者快速入门，完整实战代码全盘奉送！', '谭东', 0,
        'http://img3m8.ddimg.cn/43/19/29117428-1_b_5.jpg', 8530, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程 从入门到实践 第2版 零基础学Python编程教程书籍，数据分析、网络爬虫、深度学习技能，畅销经典蟒蛇书升级版，附赠源代码、练习答案、学习视频、学习速查地图读者交流群等资源。',
        '[美]埃里克・马瑟斯（Eric Matthes）', 0, 'http://img3m2.ddimg.cn/65/23/29280602-1_b_10.jpg', 6980, 10980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学Python（Python3.10全彩版）编程入门 项目实践 同步视频 Python3.10全新升级！超20万读者认可的彩色书，从基本概念到完整项目开发，助您快速掌握Python编程。全程视频+完整源码+215道课后题+实物挂图+海量资源',
        '明日科技(Mingri Soft)', 0, 'http://img3m0.ddimg.cn/47/6/28486010-1_b_71.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python+Office：轻松实现Python办公自动化 零基础Python办公自动化，迅速掌握Office（Word、PPT、Excel）自动化、数据处理', '王国平', 0,
        'http://img3m7.ddimg.cn/81/7/29274777-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python爬虫技术――深入理解原理、技术与开发 网红技术专家！JetBrains大中华区市场部经理赵磊作序！超过300个实战案例，10万行源代码，22个综合实战项目，海量学习资料！', '李宁', 0,
        'http://img3m7.ddimg.cn/7/10/28510027-1_b_6.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python青少年趣味编程全彩版 独家配备71集视频教学课程 手机扫码看视频 少儿编程 小学生趣味编程 教孩子学编程 少', '张彦 编著', 0,
        'http://img3m0.ddimg.cn/95/23/28524470-1_b_4.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程从入门到实践第二版 编程入门零基础自学核心编程教程书籍 数据分析网络爬虫深度学习 官方正版 出版社直发', '埃里克・马瑟斯', 0,
        'http://img3m2.ddimg.cn/44/31/673852652-1_b_6.jpg', 5490, 10980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程三剑客新版：Python编程从入门到实践第2版+快速上手第2版+极客编程（当当套装共3册） Python编程自学套装，Python入门零基础自学教程书籍，Python项目案例开发实战，一套书轻松学习Python编程。',
        '[美]埃里克・马瑟斯（Eric Matthes） [美]阿尔・斯维加特（Al Sweigart） [美] Mahesh Venkitachalam', 0,
        'http://img3m7.ddimg.cn/26/19/29301947-1_b_2.jpg', 14980, 26780);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python数据分析从入门到实践（全彩版）Python Excel高效办公常备工具 零基础入门数据分析师，利用Python进行数据处理、数据分析简单高效，送数据分析专属魔卡150+方法随身查',
        '明日科技 高春艳 刘志铭', 0, 'http://img3m6.ddimg.cn/80/18/29249036-1_b_43.jpg', 4900, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程快速上手 让繁琐工作自动化 第2版 Python编程从入门到实践姊妹篇，零基础自学Python教程书籍，提供配套同步教学视频、在线编程环境，初版译著豆瓣评分9.6分！针对Python3.X版本更新，海量学习资源随书送',
        '[美]阿尔・斯维加特（Al Sweigart）', 0, 'http://img3m4.ddimg.cn/26/5/29206214-1_b_31.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('利用Python进行数据分析（原书第2版） Python数据分析经典畅销书全新升级，第1版中文版累计销售100000册 Python pandas创始人亲自执笔，Python语言的核心开发人员鼎立推荐 针对Python 3.6进行全面修订和更新',
        '[美]韦斯・麦金尼（Wes McKinney）', 0, 'http://img3m7.ddimg.cn/3/33/25312917-1_b_9.jpg', 7740, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('程序员数学 用Python学透线性代数和微积分 500余幅图片+300余个练习，图文结合，边学边练，通过写代码，重新发现数学之美，提供配套源代码和本书彩色图片下载', '[美]保罗・奥兰德（Paul Orland）',
        0, 'http://img3m4.ddimg.cn/91/35/29342404-1_b_6.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python从入门到精通（第2版）（软件开发视频大讲堂） Python入门经典，10万Python程序员的入门书，243集教学视频+102个精彩案例+在线答疑，Python编程从入门到实践，Python数据分析，Python爬虫，丛书连续销售12年，累计销量',
        '明日科技', 0, 'http://img3m7.ddimg.cn/42/24/29251077-1_b_11.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('O\'Reilly：Python文本分析 本书全面介绍了当今生产系统中常用的文本分析与自然语言处理的各种方法与技术。', '[美]延斯・阿尔布雷希特,[美]西达尔特・拉马钱德兰,[美]克里斯蒂安・温克勒', 0,
        'http://img3m0.ddimg.cn/97/5/29456260-1_b_3.jpg', 5380, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python网络爬虫从入门到实践（全彩版）自动化数据采集，入门知识，项目实践 Python3爬虫开发图书（彩色版）：详解自动化获取数据、数据解析、数据清洗、反爬以及数据可视化等知识，125个示例+2个综合案例+1个项目',
        '明日科技 李磊 陈风', 0, 'http://img3m5.ddimg.cn/79/17/29249035-1_b_33.jpg', 4900, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python学习手册（原书第5版） 零基础学Python3，Python编程从入门到实践，详解利用Python进行数据分析、机器学习、网络爬虫的Python编程语言基础，完整覆盖Python核心技术，助你快速入门并进行项目开发实战',
        '[美]马克・卢茨', 0, 'http://img3m8.ddimg.cn/27/32/25576578-1_b_10.jpg', 14240, 21900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python项目开发案例集锦（全彩版）数据分析、爬虫、人工智能、游戏开发、Web网站...... Python3，涵盖8大开发方向，23个主流项目，扫码看项目开发流程，附赠电子书、技术答疑、全部源码、项目配置说明，Pyhton开发高手案头常用书',
        '明日科技(Mingri Soft)', 0, 'http://img3m9.ddimg.cn/56/15/28486019-1_b_1655.jpg', 6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('看漫画学Python：有趣、有料、好玩、好用（全彩版） 看漫画学Python，有趣、简单！提供配套视频、定期答疑，小灰、大胡子、臧秀涛等力赞！关东升、赵大羽力作', '关东升 赵大羽', 0,
        'http://img3m4.ddimg.cn/36/6/28547874-1_b_14.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python实效编程百例・综合卷（102个实例练习 送全部源码）（Python3全彩版） 百战编程，锤炼编程技能，提升编程思维―102个实例：数据分析、游戏开发、爬虫开发、Web项目等8大开发方向，赠完整源代码，208个素材，百日编程大作战从这里开始',
        '明日科技(Mingri Soft)', 0, 'http://img3m8.ddimg.cn/0/33/28980468-1_b_39.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python语言程序设计基础（第2版） 新形态Mooc教材带你玩转Python，轻松编程！原创实例激发学习者热情！', '嵩天、礼欣、黄天羽', 0,
        'http://img3m4.ddimg.cn/6/4/24189864-1_b_6.jpg', 3900, 3900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('流畅的Python 【图灵程序设计丛书】PSF研究员 知名PyCon演讲者心血之作 全面深入 对Python语言关键特性剖析到位 兼顾Python 3和Python 2', '[巴西]卢西亚诺', 0,
        'http://img3m1.ddimg.cn/64/32/25071121-1_b_9.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('日系图书用Python编程和实践！区块链教科书 从零创建简单区块链程序 比特币 元宇宙 数字货币 新金融底层技术 p2p 一本新型的、能看懂的区块链、比特币入门书 从零基础到创建简单区块链程序 图解区块链技术',
        '[日] FLOC 著', 0, 'http://img3m6.ddimg.cn/85/2/29257456-1_b_11.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Django + Vue.js实战派――Python Web开发与运维 Django/Vue.js/Python/前后端分离/单元自动化测试/Postma/Redis/MySQL/Docker/Prometheus',
        '杨永刚', 0, 'http://img3m4.ddimg.cn/47/32/29387504-1_b_5.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python数据分析与机器学习（微课视频版） 从Python基础、数据分析与可视化到机器学习，循序讲解、案例丰富。配套微课视频、源码、课件等。', '杨年华', 0,
        'http://img3m9.ddimg.cn/21/16/29489349-1_b_3.jpg', 8250, 11000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('DK编程真好玩：9岁开始学Python DK经典少儿编程启蒙书，从图形化编程进阶正式编程语言，通过创编游戏，轻松掌握人工智能时代编程语言Python，锻炼逻辑思维，培养解决问题的能力。教育大V“憨爸在美国”，知名科普作家徐来鼎力推荐。',
        '[英]克雷格・斯蒂尔等 著，爱心树童书 出品', 0, 'http://img3m2.ddimg.cn/85/19/27940162-1_b_7.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程轻松进阶 官方正版 出版社直发', '阿尔・斯维加特', 0, 'http://img3m4.ddimg.cn/61/24/11183728804-1_b_2.jpg', 7780, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程快速上手 让繁琐工作自动化 第2版 官方正版 出版社直发', '[美]阿尔?斯维加特（AlSweigart）', 0,
        'http://img3m8.ddimg.cn/28/34/1817970688-1_b_5.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python3网络爬虫开发实战 第2二版 崔庆才网络数据采集抓取处理分析书籍教程网络爬虫项目开发动态', '崔庆才', 0,
        'http://img3m8.ddimg.cn/28/19/597875878-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('数据分析原理与实践 基于经典算法及Python编程实现 数据分析经典算法python编程实现 朝乐门老师新作 配套资源丰富', '朝乐门 主编', 0,
        'http://img3m0.ddimg.cn/24/1/29440050-1_b_8.jpg', 6200, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python数据结构与算法分析第二2版 数据结构算法入门 python语言实现 Python编程入门进阶图书 官方正版 出版社直发', '布拉德利・米勒 等', 0,
        'http://img3m5.ddimg.cn/85/20/1527177055-1_b_2.jpg', 3950, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('用Python编程和实践！数学教科书 机器学习 深度学习中必要的基础知识 人工智能 数学基础书 用python学数学 线', '[日] 我妻 幸长 著', 0,
        'http://img3m9.ddimg.cn/88/5/29257459-1_b_15.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python游戏趣味编程 少儿编程入门教程书籍青少年编程真好玩中小学编程自学Python少儿趣味编程', '童晶', 0,
        'http://img3m5.ddimg.cn/50/1/1656965525-1_b_1.jpg', 4830, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python和Dask数据科学 详尽介绍使用Dask进行数据准备、数据清理、探索性数据分析和数据可视化，使用Dask进行机器学习。',
        '[美] 杰西・丹尼尔（Jesse C. Daniel）著 王颖、周致成、王龙江 译 田礼悦 审校', 0, 'http://img3m3.ddimg.cn/78/24/28998663-1_b_5.jpg', 5980,
        7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础入门学习Python（第2版）-微课视频版 Python 3.7编程轻松入门 小甲鱼畅销图书 实例贯穿全书 30小时视频讲解 轻松学会Python 累计销售13万册', '小甲鱼', 0,
        'http://img3m1.ddimg.cn/38/16/27865271-1_b_3.jpg', 7030, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('时间序列预测：基于机器学习和Python实现 本书为没有或几乎没有时间序列或机器学习经验的读者提供了创建和评估时间序列模型所需的基本工具。', '[美]弗朗西斯卡・拉泽里(Francesca Lazzeri)', 0,
        'http://img3m1.ddimg.cn/65/4/29362871-1_b_1.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python网络爬虫权威指南 第2版 Python 3网络爬虫开发实战入门教程 数据采集数据爬取数 官方正版 出版社直发', '瑞安・米切尔', 0,
        'http://img3m6.ddimg.cn/68/3/1417089236-1_b_1.jpg', 5925, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python数学编程 Python编程从入门到实践 Python基础教程 Python数据分析数据科 官方正版 出版社直发', '阿米特・萨哈', 0,
        'http://img3m5.ddimg.cn/10/33/1562049235-1_b_2.jpg', 4130, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('笨办法学Python 3 编程从入门到实践教程书 Python基础教程自学书籍 代码基于Python3.6 官方正版 出版社直发', '泽德 A.肖', 0,
        'http://img3m9.ddimg.cn/53/3/1333617569-1_b_1.jpg', 2950, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('用图形学Python 3 Python少儿编程入门教程，儿童视频学Python程序设计从入门到精通，教孩子学Python编程书籍，青少年Python编程入门，配套教学视频', '佘友军', 0,
        'http://img3m8.ddimg.cn/46/31/29222668-1_b_5.jpg', 2990, 5990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python GUI设计PyQt5从入门到实践（Qt5编程入门 数据可视化 Python3全彩版） 零基础入门PyQt5，基于Python3，手把手教你使用PyQt5设计PythonGUI窗体项目，更好的展现数据分析、爬虫、自动化测试、游戏等项目效果',
        '明日科技 王小科 李艳', 0, 'http://img3m2.ddimg.cn/32/3/29225822-1_b_27.jpg', 4900, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('超简单：用Python让Excel飞起来 让excel化繁为简，零基础学python，用python实现办公自动化，减少重复工作。一书在手，数据不愁，用Python操控Excel让工作更高效，办公自动化典型场景应用，零基础办公人士学编程的不二',
        '王秀文 郭明鑫 王宇韬 等', 0, 'http://img3m6.ddimg.cn/29/27/28999406-1_b_13.jpg', 4820, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python Qt GUI与数据可视化编程 PyQt5教程书籍 pyqt5快速开发实例教程 Python Qt5 GUI快速编程 示例丰富的Python GUI编程和数据可视化编程的实用指南',
        '王维波 栗宝鹃 张晓东', 0, 'http://img3m4.ddimg.cn/35/6/27918134-1_b_21.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python股票量化交易从入门到实践 股票炒股趋势技术分析书籍，量化投资金融科技教程，量化交易不神秘，Python教你必杀技，本书教你从0到1构建量化交易平台，零基础快速入门Python股票量化交易', '袁霄', 0,
        'http://img3m0.ddimg.cn/28/18/29279080-1_b_6.jpg', 4990, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python数据结构与算法（视频教学版） 同步微课视频讲解，助您掌握Python数据结构与算法，精通Python语言编程', '孙玉胜 陈锐 张志锋', 0,
        'http://img3m8.ddimg.cn/28/3/29498068-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程入门与算法进阶', '中国电子学会', 0, 'http://img3m4.ddimg.cn/6/1/11115485574-1_b_2.jpg', 4950, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('ROS 2机器人编程实战：基于现代C++和Python 3 从设计思想到应用技巧，从基础概念到工程实战，一线机器人工程师带你玩转ROS 2', '徐海望 高佳丽 著', 0,
        'http://img3m8.ddimg.cn/74/29/29484848-1_b_7.jpg', 8210, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python机器学习基础教程 基于Python3的机器学习入门教程 以机器学习算法实践为重点 使用scikit-learn库从头构建机器学习应用 涵盖模型评估调参方法 交差验证网格搜索 管道概念及文本数据处理方法等内容',
        '[德]安德里亚斯', 0, 'http://img3m7.ddimg.cn/75/5/25232007-1_b_4.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python玩转数学问题――轻松学习NumPy、SciPy和Matplotlib 全面讲解如何使用Python处理数学问题! 30多个示例源代码，手把手教你掌握Python第三方可扩展库的使用!', '张骞', 0,
        'http://img3m0.ddimg.cn/83/2/29419220-1_b_3.jpg', 7500, 10000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Excel+Python：飞速搞定数据分析与处理 xlwings数据处理分析Python编程 Exc 官方正版 出版社直发', '费利克斯・朱姆斯坦', 0,
        'http://img3m4.ddimg.cn/0/14/11132491194-1_b_2.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python股票量化交易从入门到实践 股票炒股书籍趋势技术分析入门基础知识 量化投资金融大数据风控金', '袁霄', 0,
        'http://img3m5.ddimg.cn/69/7/1644925065-1_b_2.jpg', 4990, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程从数据分析到机器学习实践（微课视频版）利用python进行数据分析 精益数据分析 深入浅出数据分析 py 手机扫码看608分钟同步视频讲解+全书源代码+PPT课件+习题实验，Python3.7编程进阶图书，人工智能、机器学习、数据处理、科学计算、云开发、网络爬虫',
        '刘瑜 著', 0, 'http://img3m8.ddimg.cn/8/13/28517948-1_b_9.jpg', 4990, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python深度学习（第2版） 流行深度学习框架Keras之父执笔，涵盖Transformer架构等进展，文字生，简单方式解释复杂概念，不用一个数学公式，利用直觉自然入门深度学习',
        '[美] 弗朗索瓦・肖莱（Franc?ois Chollet）', 0, 'http://img3m9.ddimg.cn/75/14/29458119-1_b_5.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python预测分析实战 python数据分析挖掘数据结构与算法分析 python自学零基础从入门到 官方正版 出版社直发', '阿尔瓦罗・富恩特斯', 0,
        'http://img3m4.ddimg.cn/7/6/11211153334-1_b_2.jpg', 6220, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python Qt GUI与数据可视化编程 pyqt5教程书籍 pyqt5快速开发与实战Qt5 GU', '王维波 等', 0,
        'http://img3m5.ddimg.cn/12/8/1521341625-1_b_1.jpg', 6930, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【正版特价】Python人工智能项目实战|232879', '[印度] 桑塔努・帕塔纳亚克（Santanu Pattanayak）', 0,
        'http://img3m8.ddimg.cn/68/4/1810623938-1_b_2.jpg', 3792, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python深度学习第2二版 机器学习自然语言处理python人工智能入门书籍 keras运算kag 官方正版 出版社直发', '弗朗索瓦・肖莱', 0,
        'http://img3m4.ddimg.cn/88/22/11254460074-1_b_2.jpg', 6490, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('程序员的数学基础 Python实战 帮助读者在计算机世界里如何利用数学解决算法问题，通过具体的案例与实践讲解，帮助读者用计算机思维理解数学，内容通俗易懂、图解丰富，即使是数学基础非常薄弱的读者也可以看懂', '谷尻香织',
        0, 'http://img3m0.ddimg.cn/75/30/29473860-1_b_4.jpg', 3740, 4990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python算法从入门到实践（全彩版）适用C++、C#、Java等编程语言 28种算法全方位讲解、81个算法示例、13个数学经典算法助您快速掌握算法思想', '明日科技 李菁菁 张鑫', 0,
        'http://img3m7.ddimg.cn/81/19/29249037-1_b_29.jpg', 4900, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Python编程实战100例 100个编程实例 1390分钟视频讲解 核心编程应用 项目开发 python进阶 pyth 核心编程应用实例 图形界面编程 自动化编程 网络爬虫 数据库开发 多媒体处理 数据分析 人工智能编程',
        '张晓', 0, 'http://img3m5.ddimg.cn/88/25/29307355-1_b_6.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('pandas数据预处理详解日系图书 python机器学习 深度学习 大数据处理 数据分析 数据之道 人工智能 深入浅出p Pandas数据预处理详解：机器学习和数据分析中高效的预处理方法（日系图书+双色印刷）',
        '日本Lombard 增田 秀人 著', 0, 'http://img3m2.ddimg.cn/70/14/29316742-1_b_8.jpg', 6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Excel+Python 飞速搞定数据分析与处理 零基础Python编程数据分析，Excel办公自动化处理，手把手教学，告别烦琐公式和VBA代码，办公人士也能轻松学习Python数据处理自动化，让你的Excel快得飞起来！',
        '[瑞士]费利克斯', 0, 'http://img3m9.ddimg.cn/89/36/29387249-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Go Programming Language 预订商品，需要1-3个月发货，非质量问题不接受退换货。', 'Donovan, Alan A. a.,Kernighan, Brian W.', 0,
        'http://img3m0.ddimg.cn/88/3/27407050-1_b_1.jpg', 46785, 46785);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Go Programming Language For Dummies 9781119786191 国外库房发货，通常付款后3-5周到货！', 'Wei-Meng Lee', 0,
        'http://img3m9.ddimg.cn/53/14/11089585439-1_b_2.jpg', 24400, 24400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('预订 Go Programming Language 预订，预计下单后3-4周左右发货！', 'Donovan, Alan A. A."', 0,
        'http://img3m5.ddimg.cn/12/6/1760271195-1_b_1.jpg', 45080, 45080);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订GO Programming Language: Complete Guide For Beginners To', 'Berger, Matthew', 0,
        'http://img3m6.ddimg.cn/62/26/11133611936-1_b_1.jpg', 24800, 24800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Go Programming Language 美国库房发货，通常付款后3-5周到货！', 'Kernighan, Brian W.(作者)', 0,
        'http://img3m6.ddimg.cn/64/34/1490187466-1_b_2.jpg', 36800, 36800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('预订 Go Programming Language For Dummies 预订，预计下单后3-4周左右发货！', 'Lee, Wei-Meng', 0,
        'http://img3m9.ddimg.cn/78/13/591049779-1_b_1.jpg', 36156, 36156);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go Programming Language for Dummies 围棋程序设计语言的傻瓜', 'Lee, Wei-Meng', 0,
        'http://img3m6.ddimg.cn/48/12/11312798556-1_b_1.jpg', 33400, 33400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Go Programming Language Phrasebook 美国库房发货，通常付款后3-5周到货！', 'Chisnall, David(作者)', 0,
        'http://img3m6.ddimg.cn/32/33/1454940266-1_b_2.jpg', 38300, 38300);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go Programming Language: Easy Guide Book GO编程语言：简易指南', 'Keller, Steven', 0,
        'http://img3m3.ddimg.cn/47/18/1561099763-1_b_1.jpg', 14319, 14319);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('预订 Go Programming Language 9781539380474 海外仓库发货,通常付款后4-9周到货！', 'Steven Keller', 0,
        'http://img3m5.ddimg.cn/52/35/11022489475-1_b_1.jpg', 10300, 10300);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Way to Go: A Thorough Introduction to the Go Program 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。',
        'Balbaert, Ivo', 0, 'http://img3m2.ddimg.cn/58/10/27787972-1_b_1.jpg', 31076, 31076);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m2.ddimg.cn/83/26/11264499362-1_b_1.jpg', 6200, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '艾伦', 0,
        'http://img3m6.ddimg.cn/93/29/11313804936-1_b_2.jpg', 8800, 10300);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m3.ddimg.cn/75/2/11333311383-1_b_1.jpg', 6375, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 Go程序设计语言', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m7.ddimg.cn/34/29/1309652917-1_b_1.jpg', 12800, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m3.ddimg.cn/41/15/11125028813-1_b_1.jpg', 6700, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m2.ddimg.cn/61/27/11329366912-1_b_1.jpg', 6500, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m4.ddimg.cn/63/11/11301346944-1_b_1.jpg', 5200, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m2.ddimg.cn/3/7/11262066852-1_b_1.jpg', 6500, 8000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m8.ddimg.cn/3/24/11319613968-1_b_1.jpg', 6500, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '艾伦', 0,
        'http://img3m0.ddimg.cn/10/15/11137078270-1_b_1.jpg', 6800, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m4.ddimg.cn/10/21/11288339974-1_b_1.jpg', 6120, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 近期诈骗电话频发，骗子冒充快递客服人员已快递丢件进行诈骗，不要相信陌生人加好友转账，给予几倍赔偿都是诈骗',
        '【美】艾伦', 0, 'http://img3m2.ddimg.cn/60/17/666180762-1_b_1.jpg', 5010, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m3.ddimg.cn/97/20/11348628883-1_b_1.jpg', 6500, 8000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m2.ddimg.cn/9/3/11261470482-1_b_1.jpg', 6700, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m2.ddimg.cn/4/16/11218190152-1_b_1.jpg', 6800, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m0.ddimg.cn/60/26/11322674610-1_b_2.jpg', 6100, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m6.ddimg.cn/75/15/11336003886-1_b_1.jpg', 8180, 9910);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m2.ddimg.cn/69/6/11382490122-1_b_2.jpg', 8100, 12500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m6.ddimg.cn/44/24/11162305286-1_b_1.jpg', 7650, 8137);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m1.ddimg.cn/11/29/11325224801-1_b_2.jpg', 6200, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('任选Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程', '【美】艾伦', 0,
        'http://img3m0.ddimg.cn/97/1/11187927430-1_b_1.jpg', 6200, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m8.ddimg.cn/17/35/11023345988-1_b_1.jpg', 6865, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m9.ddimg.cn/63/0/11322347319-1_b_1.jpg', 6600, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m0.ddimg.cn/4/13/11374940020-1_b_2.jpg', 8058, 12482);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m6.ddimg.cn/35/0/11161597526-1_b_1.jpg', 6620, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m2.ddimg.cn/7/11/11374455022-1_b_2.jpg', 8058, 12482);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m7.ddimg.cn/60/12/1740976737-1_b_1.jpg', 8666, 8666);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m3.ddimg.cn/96/36/1707705843-1_b_1.jpg', 8666, 8666);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 部分书籍卖价高于定价，介者慎拍。', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m2.ddimg.cn/7/32/11199300262-1_b_1.jpg', 6770, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '艾伦', 0,
        'http://img3m2.ddimg.cn/41/4/11276461292-1_b_1.jpg', 6500, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 万卷图书10701', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m3.ddimg.cn/91/16/679424023-1_b_1.jpg', 7890, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦', 0,
        'http://img3m4.ddimg.cn/70/8/11372483104-1_b_2.jpg', 8058, 12482);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('任选Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程', '【美】艾伦', 0,
        'http://img3m1.ddimg.cn/38/27/11315113661-1_b_2.jpg', 6200, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m7.ddimg.cn/30/0/11311954167-1_b_1.jpg', 4900, 7873);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m8.ddimg.cn/62/17/11382235388-1_b_1.jpg', 7803, 10005);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 全新正版', '艾伦 A.A.多诺万', 0,
        'http://img3m6.ddimg.cn/57/15/11067709116-1_b_1.jpg', 7089, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m0.ddimg.cn/10/6/1604231650-1_b_1.jpg', 7801, 7893);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设', '【美】艾伦 A.A.多诺万', 0,
        'http://img3m2.ddimg.cn/67/29/1590708802-1_b_1.jpg', 7940, 7941);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 The Go Programming Language 谷歌的C语言编程教程 C程序设计语言 新华书店正版 英文原版书 文轩网', '艾伦 A.A.多诺万', 0,
        'http://img3m3.ddimg.cn/14/36/1697568953-1_b_1.jpg', 6998, 6998);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语言编程教程 C程序设 全新正版，如需发票，请联系本店客服索取', '艾伦 A.A.多诺万', 0,
        'http://img3m1.ddimg.cn/63/16/11023964091-1_b_1.jpg', 7850, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go Programming for Beginners: An Introduction to Learn t', 'Metzler, Nathan', 0,
        'http://img3m6.ddimg.cn/52/22/11203672246-1_b_1.jpg', 9760, 9760);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go Mini Reference: A Quick Guide to the Go Programming L', 'Yoon, Harry', 0,
        'http://img3m6.ddimg.cn/54/28/11341768536-1_b_1.jpg', 18700, 18700);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订The Way to Go: A Thorough Introduction to the Go Program', 'Balbaert, Ivo', 0,
        'http://img3m6.ddimg.cn/25/16/11130528346-1_b_1.jpg', 27800, 27800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('81【书煊图书】正版Go程序设计语言 英文版 多诺万 The Go Programming Language 谷歌的C语', '【美】艾伦', 0,
        'http://img3m0.ddimg.cn/26/4/11314656170-1_b_2.jpg', 8100, 12500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('预订GO Programming in easy steps:Learn coding with Google\'s Go 预订，预计下单后2-3周左右发货！', 'McGrath, Mike', 0,
        'http://img3m4.ddimg.cn/31/16/11296269994-1_b_1.jpg', 18500, 18500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go Programming in Easy Steps: Learn Coding with Google\'s', 'McGrath, Mike', 0,
        'http://img3m6.ddimg.cn/17/4/11312805356-1_b_1.jpg', 16160, 16160);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('预订Network Programming with Go Language:Essential Skills for 预订，预计下单后3-6周左右发货！', 'Newmarch, Jan,Petty, Ronald',
        0, 'http://img3m0.ddimg.cn/93/23/11368059510-1_b_1.jpg', 66400, 66400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Network Programming with Go Language 9781484280942 国外库房发货，通常付款后3-5周到货！', 'Newmarch Jan', 0,
        'http://img3m9.ddimg.cn/15/28/11193732609-1_b_1.jpg', 40100, 40100);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('海外直订Go for beginners: It\'s not the latest trend in programmi', 'Mohmmed, Moaml', 0,
        'http://img3m6.ddimg.cn/67/27/11203724236-1_b_1.jpg', 12240, 12240);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版 C++程序设计经典教程，畅销30年的C++大百科全书全新升级，经典C++入门教程十年新版再现，孟岩、高博倾力推荐，赠送价值99元的e读版电子书及在线实验环境，赠送大尺寸全书思维导图，赠199元训练营',
        '[美] 史蒂芬・普拉达', 0, 'http://img3m9.ddimg.cn/31/36/28979509-1_b_20.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#从入门到精通（第6版） C#入门经典，销售12年，50万C#程序员、数百所高校选择，164集微课视频+236个应用示例+129个编程训练+97个实践练习', '明日科技', 0,
        'http://img3m9.ddimg.cn/57/29/29317719-1_b_2.jpg', 7880, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C++（全彩版） 零基础自学编程的入门图书，由浅入深，详解C++语言的编程思想和核心技术，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m2.ddimg.cn/59/18/28486022-1_b_35.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++从入门到精通（第5版） C++入门经典，销售12年，50万C++程序员、数百所高校的选择，97集微课视频+178个应用示例+122个编程训练+53个实践练习+项目案例+海量开发资源库+在线答疑', '明日科技',
        0, 'http://img3m8.ddimg.cn/41/13/29336018-1_b_3.jpg', 7090, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版（第5版） C++学习头牌 全球读者千万 全面采用新标 技术影响力图书冠军', '(美)李普曼 等', 0,
        'http://img3m2.ddimg.cn/33/18/23321562-1_b_24.jpg', 8320, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C#开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码，海量资源免费赠送',
        '明日科技(Mingri Soft)', 0, 'http://img3m0.ddimg.cn/37/33/28486000-1_b_17.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#精彩编程200例（全彩版） 汇集了与C#开发相关的200个实例及源代码，每个实例都按实例说明、关键技术、实现过程、扩展学习的顺序进行分析解读。', '明日科技(Mingri Soft)', 0,
        'http://img3m5.ddimg.cn/52/11/28486015-1_b_20.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典（第9版） 屡获殊荣的C#名著和优秀畅销书，更新至 C# 9.x 和 .NET 5.x。随书赠送源代码和习题答案，获取地址见书封底二维码。',
        '[德] 本杰明・帕金斯(Benjamin Perkins)，乔恩・D. 里德(Jon D. Reid) 著 齐立博 译', 0,
        'http://img3m4.ddimg.cn/37/25/29399374-1_b_2.jpg', 9320, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C++开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/34/30/28485997-1_b_25.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程无师自通――信息学奥赛零基础教程', '严开明，葛阳，徐景全', 0, 'http://img3m0.ddimg.cn/45/7/28512540-1_b_1.jpg', 3500, 5000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础轻松学C++：青少年趣味编程（全彩版）', '快学习教育', 0, 'http://img3m8.ddimg.cn/6/28/28526658-1_b_2.jpg', 4820, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（第5版） C语言入门经典，销售12年，60万C语言程序员、数百所高校选择，215集微课视频+178个应用示例+134个编程训练+128个综合训练+海量开发资源库+在线答疑。', '明日科技', 0,
        'http://img3m1.ddimg.cn/59/15/29290991-1_b_5.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#码农笔记――从第一行代码到项目实战 微软资深MVP 、C#知名专家力作 全面论述C# 语法基础、程序结构、编程技巧及项目实战', '周家安', 0,
        'http://img3m7.ddimg.cn/77/21/29448617-1_b_5.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程 全国青少年信息学奥林匹克普及组竞赛教材一本真正适合小学生的信息学竞赛培训教材，赠配套教学资源，素材下载地址为：https://pan.baidu.com/s/1i7mvF6H', '潘洪波', 0,
        'http://img3m0.ddimg.cn/68/18/25201310-1_b_6.jpg', 4480, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C Primer Plus 第6版 中文版 C语言入门经典教程 C语言入门经典教程，畅销30余年的C语言编程入门书籍，近百万程序员的C语言编程启蒙教材，技术大牛案头常备的工具书，被誉为C语言百科全书，购书赠送价值99元的e读版电子书+在线编程环境',
        '[美]史蒂芬・普拉达（Stephen Prata）', 0, 'http://img3m8.ddimg.cn/74/7/28518608-1_b_15.jpg', 5400, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++高性能编程 本书涉及C++高性能编程的5个重要因素，包括计算硬件、高效使用编程语言、编译器、良好的设计和程序员自身。', '[美]费多尔・G.皮克斯 著 刘鹏 译', 0,
        'http://img3m9.ddimg.cn/98/2/29499029-1_b_1.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版习题解答 经典畅销图书《C++ Primer Plus（第6版）中文版》的学习伴侣，北京师范大学名师详细剖析所有题目，全面提升C++编程能力的优选编程练习册',
        '[美] 史蒂芬', 0, 'http://img3m7.ddimg.cn/59/15/28968647-1_b_7.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C C++代码调试的艺术 全面剖析C/C++代码的调试技巧与方法，注重理论与实战，所选示例通俗易懂，提供源代码', '张海洋', 0,
        'http://img3m5.ddimg.cn/41/25/29196725-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20高级编程 详解C++20的概念约束 协程 Ranges 模块等新特征 重点讲述库 框架开发的高级编程技术', '罗能', 0,
        'http://img3m1.ddimg.cn/63/13/29421081-1_b_4.jpg', 7520, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第12版) Microsoft MVP - Christian Nagel C#新作，内部专家的C#指南，为你带来关于新特性的高级提示。',
        '[奥]克里斯琴・内格尔(Chrisitian Nagel) 著 李铭译', 0, 'http://img3m1.ddimg.cn/29/7/29487971-1_b_4.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第11版) C# 7 & .NET Core 2.0 C#专家级指南，是经验丰富的程序员提高效率的更快捷方式！ 连续畅销20年，累计销售超30万册， 第11次全新升级，更新至C# 7 和 .NET Core 2.0， C# 7内幕指南。',
        '[美]克里斯琴・内格尔（Christian Nagel）著 李 铭 译', 0, 'http://img3m4.ddimg.cn/73/33/27852634-1_b_6.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程入门 C++程序设计 零基础学C++ 极简C++自学案例视频教程教材 电脑编程 计算机书籍 c语言 C++项目', '杨国兴 编著', 0,
        'http://img3m6.ddimg.cn/35/32/29244536-1_b_8.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++算法从菜鸟到达人 涵盖所有程序员必须掌握的50余种算法，从易到难逐级提升，满足编程菜鸟向达人转变的一切需求', '猿媛之家 组编 郭晶晶 刘志全 楚秦 等编著', 0,
        'http://img3m1.ddimg.cn/10/24/29128681-1_b_11.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战（第2版） C++并发编程深度指南，C++标准委员会成员编写，囊括C++并发编程多个方面，代码附有中文注释简洁易懂，附赠配套代码文件。', '[英]安东尼', 0,
        'http://img3m7.ddimg.cn/61/29/29331187-1_b_6.jpg', 10480, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发手册：基础・案例・应用 轻松入门 ，快速进阶，上百个经典案例，快速提升实战能力！', '明日科技 编著', 0, 'http://img3m4.ddimg.cn/21/18/29369064-1_b_2.jpg',
        6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：Linux C++通信架构实战 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m8.ddimg.cn/73/13/29158048-1_b_8.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++实战笔记 C++20年老兵实战经验总结，精选C++实用特性，代码演示实战技巧，深入浅出讲解C++实战技能，分享开发心得和工作经验，帮助读者拓宽编程思路。', '罗剑锋', 0,
        'http://img3m1.ddimg.cn/30/1/29324721-1_b_2.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('从C到C++精通面向对象编程 深入浅出地讲解C++的各个知识点、编程思想与核心技术', '曾凡锋 孙晶 肖珂 李源', 0,
        'http://img3m4.ddimg.cn/70/5/29478904-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典：更新至C# 9和.NET 5 掌握使用C# 9.0和.NET 5创建网站、服务和移动应用所需的所有技能。随书赠送学习资源，获取地址见书封底二维码。',
        '[英]马克・J.普赖斯(Mark J.Price) 著；叶伟民 译', 0, 'http://img3m2.ddimg.cn/38/24/29277902-1_b_8.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++程序设计竞赛真题实战特训教程（图解版）蓝桥杯官方备赛教程 蓝桥杯官方备赛指南！算法编程程序设计软件开发竞赛指导书，全栈指导拿分关键点，提供在线测评系统，并附赠例题源代码及PPT课件，实现精准备赛、有效刷题！',
        '蓝桥杯大赛组委会', 0, 'http://img3m7.ddimg.cn/60/8/29497407-1_b_7.jpg', 6280, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Easy C++（第5版）日系简洁系列书籍 wpf c语言程序设计教材 c++ primer plus 数据结构与算法分 日本经典C++图书 c++程序设计经典教程 4次改版，持续畅销20年，日本全国学校图书馆协会选定图书 187个图形图示+131段示例代码解析+44道课后练习 涵盖编程基础、软件开发核心技术、编程思想',
        '高桥麻奈', 0, 'http://img3m7.ddimg.cn/6/5/29362317-1_b_4.jpg', 4990, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【领券立减100】C语言入门到精通+Python从入门到精通编程入门全2册 零基础自学从入门到实战数据分析程序爬虫精通教', '许东平，王博 著', 0,
        'http://img3m3.ddimg.cn/38/11/11081805113-1_b_1.jpg', 14780, 19600);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（全新版实用教程）', '许东平', 0, 'http://img3m5.ddimg.cn/57/4/29226045-1_b_3.jpg', 3140, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战(第2版) 人民邮电出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(英)安东尼・威廉姆斯', 0,
        'http://img3m7.ddimg.cn/6/28/593042577-1_b_9.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版 第5版 C++编程从入门到精通C++11标准 C++经典教程语言程序设计软件计算机开发书籍c 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！',
        '(美)李普曼(Lippman,S.B.),(美)拉乔伊(Lajoie,J.),(', 0, 'http://img3m6.ddimg.cn/97/14/1155358906-1_b_48.jpg', 6400,
        12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战 第2版 多线程编程深度指南 C++语言编程自学 C++**计算机程序设计入门教程 官方正版 出版社直发', '安东尼・威廉姆斯', 0,
        'http://img3m8.ddimg.cn/29/3/595988048-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus中文版第六6版 C++程序设计从入门到*通 零基础自学C++编程语言教 官方正版 出版社直发', '[美] 史蒂芬・普拉达（Stephen Prata）', 0,
        'http://img3m5.ddimg.cn/3/6/1666691535-1_b_4.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C#（全彩版） 10万读者认可的编程图书，零基础自学编程的入门图书，由浅入深，循序渐进，助您轻松领会C#程序开发精髓，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m9.ddimg.cn/46/5/28486009-1_b_46.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C语言（全彩版）C语言入门经典教程 双系统；双开发环境（VisualStudio和VisualC++6.0）;15小时视频；168个实例；168个练一练；从基础知识到完整项目！',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/44/3/28486007-1_b_70.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：设计模式 本书将以一个实际的游戏案例贯穿始终，针对每个设计模式都会举出一到多个来自于实践并且有针对性的范例。阅读本书读者可以学到两方面知识：①某个设计模式对应的代码怎样编写；②该设计模式解决了什么样的问题。这两',
        '王健伟', 0, 'http://img3m5.ddimg.cn/92/16/29446355-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Qt 6 C++开发指南 基于Qt 6.2版本，《Qt 5.9 C++开发指南》版本内容重大升级，涵盖新的功能模块和开发技术，附赠大量示例演示程序和示例源代码，轻松开发GUI程序！', '王维波', 0,
        'http://img3m7.ddimg.cn/48/5/29511057-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：模板与泛型编程 C++在线课程 C++完美自学教程！二十年磨一剑：新高度、新方法、新经典', '王健伟', 0,
        'http://img3m4.ddimg.cn/24/19/29394114-1_b_4.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言精彩编程200例（全彩版） 涵盖C语言开发相关的200个实例，包含常用算法、指针与链表操作、文件操作、系统相关、图形图像、游戏开发等方面的内容。超强的实用性，快速提升C语言开发技能',
        '明日科技(Mingri Soft)', 0, 'http://img3m4.ddimg.cn/51/10/28486014-1_b_17.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：对象模型 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m7.ddimg.cn/4/31/28975027-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言典藏版套装（套装共2册 讲义+习题解答） 本套装含《C程序设计语言（第2版新版）（典藏版）》及配套《习题解答》各1册。C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4。',
        '[美]布莱恩? W.克尼汉，丹尼斯? M.里奇，克洛维斯? L.汤多，斯科特? E.吉姆佩尔 著', 0, 'http://img3m5.ddimg.cn/32/36/28481045-1_b_9.jpg', 8100,
        10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++嵌入式开发实例精解 利用C++语言构建高效的嵌入式程序！', '[美]艾格尔・威亚契克 著 刘?J 译', 0, 'http://img3m9.ddimg.cn/9/4/29430729-1_b_5.jpg',
        8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20实践入门（第6版） C++入门从Beginning C++20开始，讲解如何使用新推出的C++20编写程序',
        '[比] 艾弗・霍尔顿(Ivor Horton)，彼得・范・维尔特(Peter Van Weert) 著 周百顺 译', 0,
        'http://img3m4.ddimg.cn/78/13/29383674-1_b_5.jpg', 11850, 15800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程（第二版） 全新升级！全彩印刷，还原真实编程环境；视频讲解，培养自主学习能力。', '潘洪波', 0,
        'http://img3m9.ddimg.cn/81/30/29490399-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('高级C/C++编译技术（典藏版） 多维度讲解多任务操作系统中编译、链接、装载与库的内幕与技术细节，为深入理解和掌握系统底层技术提供参考', '米兰・斯特瓦诺维奇（Milan Stevanovic）', 0,
        'http://img3m9.ddimg.cn/45/3/29496699-1_b_5.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#完全自学教程 一本让初学者通过案例项目实战开发入门C#语言的书，81个实例教学，22小时视频教程，提供源码、视频课程、课后练习题等配套资源', '明日科技', 0,
        'http://img3m3.ddimg.cn/98/3/29459033-1_b_3.jpg', 6310, 7990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('现代C++语言核心特性解析 C++核心特性精讲，理论实践相结合，由浅入深探讨 C++11到 C++20新增核心特性，C++语言进阶版教程，附赠同步语音讲解、PPT、示例代码。', '谢丙��', 0,
        'http://img3m3.ddimg.cn/59/14/29301683-1_b_5.jpg', 8990, 11990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++函数与算法速查宝典 本书系统地讲解了C和C++中的常用函数及算法，结构清晰、范例具体、讲解详细，是一本内容丰富的案头工具书，内容通俗易懂，初学者也能轻松理解', '陈锐', 0,
        'http://img3m7.ddimg.cn/88/16/29469517-1_b_2.jpg', 7100, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言（原书第2版・新版）典藏版 C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4，全球数千万程序员学习C语言的选择。让你从语言设计者的角度理解C语言。',
        '[美]布莱恩・克尼汉(Brian W. Kernighan),丹尼斯・里奇(Dennis', 0, 'http://img3m6.ddimg.cn/31/29/27849226-1_b_8.jpg', 5460,
        6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++语言的设计和演化 C++语言之父经典著作、思想集锦，一本描述C++语言的发展历史、设计理念及技术细节的综合性著作，裘宗燕译', '[美]本贾尼・斯特劳斯特卢普 ( Bjarne Stroustrup )', 0,
        'http://img3m0.ddimg.cn/59/17/29126750-1_b_2.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到项目实践（全彩版） 从入门学习者的角度出发，通过简洁有趣的语言、丰富多彩的实例、挑战大脑的任务、贴近开发实战的项目', '明日科技 周佳星 李菁菁', 0,
        'http://img3m3.ddimg.cn/33/4/29225823-1_b_25.jpg', 2430, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#函数式编程 编写更优质的C#代码', '[美] 恩里科・博南诺（Enrico，Buonanno）著', 0, 'http://img3m1.ddimg.cn/30/32/29300961-1_b_1.jpg',
        9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言入门经典（第6版） C语言入门从Beginning C开始！著名作家lvor Horton和编程专家German Gonzalez -Morris联袂奉献。',
        '[智利] 杰曼・冈萨雷斯・莫里斯（German Gonzalez-Morris）、[英]艾弗・霍顿（Ivor Horton）著 童晶、李天', 0,
        'http://img3m4.ddimg.cn/49/29/29353054-1_b_3.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言程序设计 现代方法 第2版・修订版 C语言入门零基础自学教程新升级，增加C1X相关内容，讲述C的所有特性，国外诸多名校的C语言课程教材，C开发人员的参考书。', '[美]K.N.金（K.N.King）', 0,
        'http://img3m1.ddimg.cn/81/17/29270421-1_b_6.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('玩转C语言程序设计（全彩版） 10万读者认可的编程图书，知识点贴近生活通俗易懂，引领读者快速入门，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m1.ddimg.cn/58/17/28486021-1_b_19.jpg', 3429, 4980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发实战1200例（第Ⅰ卷）', '王小科 王军 等编著', 0, 'http://img3m9.ddimg.cn/75/18/29254179-1_b_1.jpg', 11100, 14800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版 C++程序设计经典教程，畅销30年的C++大百科全书全新升级，经典C++入门教程十年新版再现，孟岩、高博倾力推荐，赠送价值99元的e读版电子书及在线实验环境，赠送大尺寸全书思维导图，赠199元训练营',
        '[美] 史蒂芬・普拉达', 0, 'http://img3m9.ddimg.cn/31/36/28979509-1_b_20.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#从入门到精通（第6版） C#入门经典，销售12年，50万C#程序员、数百所高校选择，164集微课视频+236个应用示例+129个编程训练+97个实践练习', '明日科技', 0,
        'http://img3m9.ddimg.cn/57/29/29317719-1_b_2.jpg', 7880, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C++（全彩版） 零基础自学编程的入门图书，由浅入深，详解C++语言的编程思想和核心技术，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m2.ddimg.cn/59/18/28486022-1_b_35.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++从入门到精通（第5版） C++入门经典，销售12年，50万C++程序员、数百所高校的选择，97集微课视频+178个应用示例+122个编程训练+53个实践练习+项目案例+海量开发资源库+在线答疑', '明日科技',
        0, 'http://img3m8.ddimg.cn/41/13/29336018-1_b_3.jpg', 7090, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版（第5版） C++学习头牌 全球读者千万 全面采用新标 技术影响力图书冠军', '(美)李普曼 等', 0,
        'http://img3m2.ddimg.cn/33/18/23321562-1_b_24.jpg', 8320, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C#开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码，海量资源免费赠送',
        '明日科技(Mingri Soft)', 0, 'http://img3m0.ddimg.cn/37/33/28486000-1_b_17.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#精彩编程200例（全彩版） 汇集了与C#开发相关的200个实例及源代码，每个实例都按实例说明、关键技术、实现过程、扩展学习的顺序进行分析解读。', '明日科技(Mingri Soft)', 0,
        'http://img3m5.ddimg.cn/52/11/28486015-1_b_20.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典（第9版） 屡获殊荣的C#名著和优秀畅销书，更新至 C# 9.x 和 .NET 5.x。随书赠送源代码和习题答案，获取地址见书封底二维码。',
        '[德] 本杰明・帕金斯(Benjamin Perkins)，乔恩・D. 里德(Jon D. Reid) 著 齐立博 译', 0,
        'http://img3m4.ddimg.cn/37/25/29399374-1_b_2.jpg', 9320, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C++开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/34/30/28485997-1_b_25.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程无师自通――信息学奥赛零基础教程', '严开明，葛阳，徐景全', 0, 'http://img3m0.ddimg.cn/45/7/28512540-1_b_1.jpg', 3500, 5000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础轻松学C++：青少年趣味编程（全彩版）', '快学习教育', 0, 'http://img3m8.ddimg.cn/6/28/28526658-1_b_2.jpg', 4820, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（第5版） C语言入门经典，销售12年，60万C语言程序员、数百所高校选择，215集微课视频+178个应用示例+134个编程训练+128个综合训练+海量开发资源库+在线答疑。', '明日科技', 0,
        'http://img3m1.ddimg.cn/59/15/29290991-1_b_5.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#码农笔记――从第一行代码到项目实战 微软资深MVP 、C#知名专家力作 全面论述C# 语法基础、程序结构、编程技巧及项目实战', '周家安', 0,
        'http://img3m7.ddimg.cn/77/21/29448617-1_b_5.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程 全国青少年信息学奥林匹克普及组竞赛教材一本真正适合小学生的信息学竞赛培训教材，赠配套教学资源，素材下载地址为：https://pan.baidu.com/s/1i7mvF6H', '潘洪波', 0,
        'http://img3m0.ddimg.cn/68/18/25201310-1_b_6.jpg', 4480, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C Primer Plus 第6版 中文版 C语言入门经典教程 C语言入门经典教程，畅销30余年的C语言编程入门书籍，近百万程序员的C语言编程启蒙教材，技术大牛案头常备的工具书，被誉为C语言百科全书，购书赠送价值99元的e读版电子书+在线编程环境',
        '[美]史蒂芬・普拉达（Stephen Prata）', 0, 'http://img3m8.ddimg.cn/74/7/28518608-1_b_15.jpg', 5400, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++高性能编程 本书涉及C++高性能编程的5个重要因素，包括计算硬件、高效使用编程语言、编译器、良好的设计和程序员自身。', '[美]费多尔・G.皮克斯 著 刘鹏 译', 0,
        'http://img3m9.ddimg.cn/98/2/29499029-1_b_1.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版习题解答 经典畅销图书《C++ Primer Plus（第6版）中文版》的学习伴侣，北京师范大学名师详细剖析所有题目，全面提升C++编程能力的优选编程练习册',
        '[美] 史蒂芬', 0, 'http://img3m7.ddimg.cn/59/15/28968647-1_b_7.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C C++代码调试的艺术 全面剖析C/C++代码的调试技巧与方法，注重理论与实战，所选示例通俗易懂，提供源代码', '张海洋', 0,
        'http://img3m5.ddimg.cn/41/25/29196725-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20高级编程 详解C++20的概念约束 协程 Ranges 模块等新特征 重点讲述库 框架开发的高级编程技术', '罗能', 0,
        'http://img3m1.ddimg.cn/63/13/29421081-1_b_4.jpg', 7520, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第12版) Microsoft MVP - Christian Nagel C#新作，内部专家的C#指南，为你带来关于新特性的高级提示。',
        '[奥]克里斯琴・内格尔(Chrisitian Nagel) 著 李铭译', 0, 'http://img3m1.ddimg.cn/29/7/29487971-1_b_4.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第11版) C# 7 & .NET Core 2.0 C#专家级指南，是经验丰富的程序员提高效率的更快捷方式！ 连续畅销20年，累计销售超30万册， 第11次全新升级，更新至C# 7 和 .NET Core 2.0， C# 7内幕指南。',
        '[美]克里斯琴・内格尔（Christian Nagel）著 李 铭 译', 0, 'http://img3m4.ddimg.cn/73/33/27852634-1_b_6.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程入门 C++程序设计 零基础学C++ 极简C++自学案例视频教程教材 电脑编程 计算机书籍 c语言 C++项目', '杨国兴 编著', 0,
        'http://img3m6.ddimg.cn/35/32/29244536-1_b_8.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++算法从菜鸟到达人 涵盖所有程序员必须掌握的50余种算法，从易到难逐级提升，满足编程菜鸟向达人转变的一切需求', '猿媛之家 组编 郭晶晶 刘志全 楚秦 等编著', 0,
        'http://img3m1.ddimg.cn/10/24/29128681-1_b_11.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战（第2版） C++并发编程深度指南，C++标准委员会成员编写，囊括C++并发编程多个方面，代码附有中文注释简洁易懂，附赠配套代码文件。', '[英]安东尼', 0,
        'http://img3m7.ddimg.cn/61/29/29331187-1_b_6.jpg', 10480, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发手册：基础・案例・应用 轻松入门 ，快速进阶，上百个经典案例，快速提升实战能力！', '明日科技 编著', 0, 'http://img3m4.ddimg.cn/21/18/29369064-1_b_2.jpg',
        6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：Linux C++通信架构实战 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m8.ddimg.cn/73/13/29158048-1_b_8.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++实战笔记 C++20年老兵实战经验总结，精选C++实用特性，代码演示实战技巧，深入浅出讲解C++实战技能，分享开发心得和工作经验，帮助读者拓宽编程思路。', '罗剑锋', 0,
        'http://img3m1.ddimg.cn/30/1/29324721-1_b_2.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('从C到C++精通面向对象编程 深入浅出地讲解C++的各个知识点、编程思想与核心技术', '曾凡锋 孙晶 肖珂 李源', 0,
        'http://img3m4.ddimg.cn/70/5/29478904-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典：更新至C# 9和.NET 5 掌握使用C# 9.0和.NET 5创建网站、服务和移动应用所需的所有技能。随书赠送学习资源，获取地址见书封底二维码。',
        '[英]马克・J.普赖斯(Mark J.Price) 著；叶伟民 译', 0, 'http://img3m2.ddimg.cn/38/24/29277902-1_b_8.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++程序设计竞赛真题实战特训教程（图解版）蓝桥杯官方备赛教程 蓝桥杯官方备赛指南！算法编程程序设计软件开发竞赛指导书，全栈指导拿分关键点，提供在线测评系统，并附赠例题源代码及PPT课件，实现精准备赛、有效刷题！',
        '蓝桥杯大赛组委会', 0, 'http://img3m7.ddimg.cn/60/8/29497407-1_b_7.jpg', 6280, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Easy C++（第5版）日系简洁系列书籍 wpf c语言程序设计教材 c++ primer plus 数据结构与算法分 日本经典C++图书 c++程序设计经典教程 4次改版，持续畅销20年，日本全国学校图书馆协会选定图书 187个图形图示+131段示例代码解析+44道课后练习 涵盖编程基础、软件开发核心技术、编程思想',
        '高桥麻奈', 0, 'http://img3m7.ddimg.cn/6/5/29362317-1_b_4.jpg', 4990, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【领券立减100】C语言入门到精通+Python从入门到精通编程入门全2册 零基础自学从入门到实战数据分析程序爬虫精通教', '许东平，王博 著', 0,
        'http://img3m3.ddimg.cn/38/11/11081805113-1_b_1.jpg', 14780, 19600);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（全新版实用教程）', '许东平', 0, 'http://img3m5.ddimg.cn/57/4/29226045-1_b_3.jpg', 3140, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战(第2版) 人民邮电出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(英)安东尼・威廉姆斯', 0,
        'http://img3m7.ddimg.cn/6/28/593042577-1_b_9.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版 第5版 C++编程从入门到精通C++11标准 C++经典教程语言程序设计软件计算机开发书籍c 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！',
        '(美)李普曼(Lippman,S.B.),(美)拉乔伊(Lajoie,J.),(', 0, 'http://img3m6.ddimg.cn/97/14/1155358906-1_b_48.jpg', 6400,
        12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战 第2版 多线程编程深度指南 C++语言编程自学 C++**计算机程序设计入门教程 官方正版 出版社直发', '安东尼・威廉姆斯', 0,
        'http://img3m8.ddimg.cn/29/3/595988048-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus中文版第六6版 C++程序设计从入门到*通 零基础自学C++编程语言教 官方正版 出版社直发', '[美] 史蒂芬・普拉达（Stephen Prata）', 0,
        'http://img3m5.ddimg.cn/3/6/1666691535-1_b_4.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C#（全彩版） 10万读者认可的编程图书，零基础自学编程的入门图书，由浅入深，循序渐进，助您轻松领会C#程序开发精髓，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m9.ddimg.cn/46/5/28486009-1_b_46.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C语言（全彩版）C语言入门经典教程 双系统；双开发环境（VisualStudio和VisualC++6.0）;15小时视频；168个实例；168个练一练；从基础知识到完整项目！',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/44/3/28486007-1_b_70.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：设计模式 本书将以一个实际的游戏案例贯穿始终，针对每个设计模式都会举出一到多个来自于实践并且有针对性的范例。阅读本书读者可以学到两方面知识：①某个设计模式对应的代码怎样编写；②该设计模式解决了什么样的问题。这两',
        '王健伟', 0, 'http://img3m5.ddimg.cn/92/16/29446355-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Qt 6 C++开发指南 基于Qt 6.2版本，《Qt 5.9 C++开发指南》版本内容重大升级，涵盖新的功能模块和开发技术，附赠大量示例演示程序和示例源代码，轻松开发GUI程序！', '王维波', 0,
        'http://img3m7.ddimg.cn/48/5/29511057-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：模板与泛型编程 C++在线课程 C++完美自学教程！二十年磨一剑：新高度、新方法、新经典', '王健伟', 0,
        'http://img3m4.ddimg.cn/24/19/29394114-1_b_4.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言精彩编程200例（全彩版） 涵盖C语言开发相关的200个实例，包含常用算法、指针与链表操作、文件操作、系统相关、图形图像、游戏开发等方面的内容。超强的实用性，快速提升C语言开发技能',
        '明日科技(Mingri Soft)', 0, 'http://img3m4.ddimg.cn/51/10/28486014-1_b_17.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：对象模型 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m7.ddimg.cn/4/31/28975027-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言典藏版套装（套装共2册 讲义+习题解答） 本套装含《C程序设计语言（第2版新版）（典藏版）》及配套《习题解答》各1册。C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4。',
        '[美]布莱恩? W.克尼汉，丹尼斯? M.里奇，克洛维斯? L.汤多，斯科特? E.吉姆佩尔 著', 0, 'http://img3m5.ddimg.cn/32/36/28481045-1_b_9.jpg', 8100,
        10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++嵌入式开发实例精解 利用C++语言构建高效的嵌入式程序！', '[美]艾格尔・威亚契克 著 刘?J 译', 0, 'http://img3m9.ddimg.cn/9/4/29430729-1_b_5.jpg',
        8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20实践入门（第6版） C++入门从Beginning C++20开始，讲解如何使用新推出的C++20编写程序',
        '[比] 艾弗・霍尔顿(Ivor Horton)，彼得・范・维尔特(Peter Van Weert) 著 周百顺 译', 0,
        'http://img3m4.ddimg.cn/78/13/29383674-1_b_5.jpg', 11850, 15800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程（第二版） 全新升级！全彩印刷，还原真实编程环境；视频讲解，培养自主学习能力。', '潘洪波', 0,
        'http://img3m9.ddimg.cn/81/30/29490399-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('高级C/C++编译技术（典藏版） 多维度讲解多任务操作系统中编译、链接、装载与库的内幕与技术细节，为深入理解和掌握系统底层技术提供参考', '米兰・斯特瓦诺维奇（Milan Stevanovic）', 0,
        'http://img3m9.ddimg.cn/45/3/29496699-1_b_5.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#完全自学教程 一本让初学者通过案例项目实战开发入门C#语言的书，81个实例教学，22小时视频教程，提供源码、视频课程、课后练习题等配套资源', '明日科技', 0,
        'http://img3m3.ddimg.cn/98/3/29459033-1_b_3.jpg', 6310, 7990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('现代C++语言核心特性解析 C++核心特性精讲，理论实践相结合，由浅入深探讨 C++11到 C++20新增核心特性，C++语言进阶版教程，附赠同步语音讲解、PPT、示例代码。', '谢丙��', 0,
        'http://img3m3.ddimg.cn/59/14/29301683-1_b_5.jpg', 8990, 11990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++函数与算法速查宝典 本书系统地讲解了C和C++中的常用函数及算法，结构清晰、范例具体、讲解详细，是一本内容丰富的案头工具书，内容通俗易懂，初学者也能轻松理解', '陈锐', 0,
        'http://img3m7.ddimg.cn/88/16/29469517-1_b_2.jpg', 7100, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言（原书第2版・新版）典藏版 C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4，全球数千万程序员学习C语言的选择。让你从语言设计者的角度理解C语言。',
        '[美]布莱恩・克尼汉(Brian W. Kernighan),丹尼斯・里奇(Dennis', 0, 'http://img3m6.ddimg.cn/31/29/27849226-1_b_8.jpg', 5460,
        6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++语言的设计和演化 C++语言之父经典著作、思想集锦，一本描述C++语言的发展历史、设计理念及技术细节的综合性著作，裘宗燕译', '[美]本贾尼・斯特劳斯特卢普 ( Bjarne Stroustrup )', 0,
        'http://img3m0.ddimg.cn/59/17/29126750-1_b_2.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到项目实践（全彩版） 从入门学习者的角度出发，通过简洁有趣的语言、丰富多彩的实例、挑战大脑的任务、贴近开发实战的项目', '明日科技 周佳星 李菁菁', 0,
        'http://img3m3.ddimg.cn/33/4/29225823-1_b_25.jpg', 2430, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#函数式编程 编写更优质的C#代码', '[美] 恩里科・博南诺（Enrico，Buonanno）著', 0, 'http://img3m1.ddimg.cn/30/32/29300961-1_b_1.jpg',
        9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言入门经典（第6版） C语言入门从Beginning C开始！著名作家lvor Horton和编程专家German Gonzalez -Morris联袂奉献。',
        '[智利] 杰曼・冈萨雷斯・莫里斯（German Gonzalez-Morris）、[英]艾弗・霍顿（Ivor Horton）著 童晶、李天', 0,
        'http://img3m4.ddimg.cn/49/29/29353054-1_b_3.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言程序设计 现代方法 第2版・修订版 C语言入门零基础自学教程新升级，增加C1X相关内容，讲述C的所有特性，国外诸多名校的C语言课程教材，C开发人员的参考书。', '[美]K.N.金（K.N.King）', 0,
        'http://img3m1.ddimg.cn/81/17/29270421-1_b_6.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('玩转C语言程序设计（全彩版） 10万读者认可的编程图书，知识点贴近生活通俗易懂，引领读者快速入门，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m1.ddimg.cn/58/17/28486021-1_b_19.jpg', 3429, 4980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发实战1200例（第Ⅰ卷）', '王小科 王军 等编著', 0, 'http://img3m9.ddimg.cn/75/18/29254179-1_b_1.jpg', 11100, 14800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust实战 由浅入深介绍Rust系统编程知识，涵盖数十个有趣的示例，简洁易懂，帮你了解Rust语法和Rust的实际运用，赠送示例源代码', '蒂姆・麦克纳马拉（Tim McNamara）', 0,
        'http://img3m3.ddimg.cn/96/32/29449923-1_b_5.jpg', 10250, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust权威指南', '（美）Steve Klabnik（史蒂夫・克拉伯尼克），Carol Nichols（卡罗尔・尼科尔斯）', 0,
        'http://img3m2.ddimg.cn/79/0/28555342-1_b_8.jpg', 11920, 15900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust系统编程 利用Rust语言实现系统编程', '[印]普拉布・艾什沃拉 著 刘君 译', 0, 'http://img3m7.ddimg.cn/94/33/29469127-1_b_3.jpg', 8920,
        11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust编程之道 Rust官方作序力荐 | 基于Rust 2018大版本 | 从设计理念出发讲解，降低Rust学习曲线！', '张汉东', 0,
        'http://img3m8.ddimg.cn/97/33/26475568-1_b_5.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust编程 第2版（影印版）', 'Jim Blandy', 0, 'http://img3m2.ddimg.cn/36/11/29468772-1_b_1.jpg', 12969, 18800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust项目开发实战 Rust项目开发，本书涵盖前端和后端Web应用程序、游戏、解释器、编译器、计算机模拟器和Linux可加载的模块，理论结合实战，有趣实用。', '[美] 卡洛・米兰内西 著 程晓磊 译', 0,
        'http://img3m6.ddimg.cn/40/18/29444026-1_b_4.jpg', 8170, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust程序设计 Rust系统编程指南，深入浅出编程之道，Rust开发者案头书，理论与实战相结合', '[美]吉姆・布兰迪（Jim Blandy），贾森・奥伦多夫（Jason Oren', 0,
        'http://img3m5.ddimg.cn/76/1/29127955-1_b_3.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('精通Rust 第2版 Rust系统编程指南自学教程书籍，学习Rust编程语言基础，掌握更高端的编程范式，成就高段位的编程极客。', '[印]拉胡尔・沙玛（Rahul Sharma）[芬]韦萨・凯拉维塔', 0,
        'http://img3m9.ddimg.cn/11/0/29172539-1_b_7.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust语言编程实战 学习这本书之后，你将了解如何使用Rust构建快速而安全的应用和服务。', '[英]克劳斯・马特辛格', 0,
        'http://img3m0.ddimg.cn/97/2/29187970-1_b_5.jpg', 4160, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust实战 人民邮电出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(新西兰)蒂姆・麦克纳马拉', 0,
        'http://img3m7.ddimg.cn/52/7/11233565197-1_b_2.jpg', 6490, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust权威指南 电子工业出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(美)史蒂夫・克拉伯尼克(Steve Klabnik),(美)卡罗尔・尼科尔斯(', 0,
        'http://img3m2.ddimg.cn/79/22/1637139022-1_b_3.jpg', 7950, 15900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust实战 系统编程linux曼宁系列书籍 语言与程序设计编程基础教程 赠送示例源代码 官方正版 出版社直发', '蒂姆・麦克纳马拉', 0,
        'http://img3m4.ddimg.cn/64/1/11239519564-1_b_2.jpg', 10120, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust程序设计 Rust系统编程指南自学Rust编程之道深入浅出Rust编程语言基础教程书籍从入门', '吉姆・布兰迪等', 0,
        'http://img3m5.ddimg.cn/74/0/1748668655-1_b_3.jpg', 10840, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('精通Rust*二2版 Rust系统编程指南自学教程书籍Rust编程之道程序设 官方正版 出版社直发', '拉胡尔・沙玛 等', 0,
        'http://img3m0.ddimg.cn/65/12/1829220590-1_b_2.jpg', 10840, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust系程 普拉布艾什沃拉 Rust系程指南自学深入浅出Rust编程之道语言基础教程编程开发书籍从入门到精通Rust实', '普拉布・艾什沃拉', 0,
        'http://img3m9.ddimg.cn/37/2/11306384929-1_b_1.jpg', 10300, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('RUST编程之道 电子工业出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '张汉东', 0,
        'http://img3m7.ddimg.cn/6/4/1475290977-1_b_3.jpg', 6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust实战：从入门到精通 Rust开发社区贡献者编写；通过大量代码示例详细解析Rust语言的各种特性，带你轻松入门到精通Rust编程', '[意]卡洛・米拉内西(Carlo Milanesi) 著，卢涛 李颖 译;',
        0, 'http://img3m5.ddimg.cn/47/12/29260685-1_b_8.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust编程从入门到实战 菜鸟教程网站专栏作者,丰富编程实例,51CTO学院|开发者头条|编程狮网站等联袂推荐', '樊少冰、孟祥莲', 0,
        'http://img3m1.ddimg.cn/76/3/29436241-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Rust编程：入门 实战与进阶 Web3meta Labs创始人兼CTO/Polkadot大使撰写，语法与编码能力训练并重，精选39道LeetCode高频算法面试真题。精通Rust编程程序设计', '朱春雷', 0,
        'http://img3m1.ddimg.cn/21/31/29233731-1_b_8.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('[图书]深入浅出Rust|8051164', '范长春', 0, 'http://img3m6.ddimg.cn/97/15/1373274736-1_b_1.jpg', 8009, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Rust编程：入门、实战与进阶|8079868', '朱春雷', 0, 'http://img3m2.ddimg.cn/2/33/607155122-1_b_1.jpg', 6230, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】50 Easy Business Hacks to Increase Your Sales Today 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Michael', 0,
        'http://img3m7.ddimg.cn/13/22/27793867-1_b_1.jpg', 10952, 10952);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Double Double Time & Trouble 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Angelika', 0,
        'http://img3m4.ddimg.cn/75/35/26848974-1_b_1.jpg', 15221, 15221);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】My Name Is Not Alice 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Angelika', 0,
        'http://img3m4.ddimg.cn/26/14/26531234-1_b_1.jpg', 16365, 16365);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Watched Girl 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Rachel', 0,
        'http://img3m9.ddimg.cn/81/13/26565939-1_b_1.jpg', 14025, 14025);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Layman\'s Guide to a Growing Income Stream for Life 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Kevin',
        0, 'http://img3m6.ddimg.cn/9/35/27791586-1_b_1.jpg', 39765, 39765);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】It Never Rains 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Angelika', 0,
        'http://img3m6.ddimg.cn/92/1/26848496-1_b_1.jpg', 16365, 16365);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Sorry, I Have to Take This: Breaking Free from Digital D 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。',
        'Rust, David B.,Kramer, Bradley J.', 0, 'http://img3m3.ddimg.cn/82/34/27637813-1_b_1.jpg', 19064, 19064);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】In Vitro Embryo Production in Cattle 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Johannes Matthias', 0,
        'http://img3m9.ddimg.cn/70/15/26899459-1_b_1.jpg', 94427, 94427);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Sudden Wealth 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, David,Moore, Shane,Monday, Pam,Arnette, Dianne', 0,
        'http://img3m1.ddimg.cn/11/26/27788321-1_b_1.jpg', 22839, 22839);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】The Knight in the Tiger Skin 预订商品，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust', 0,
        'http://img3m1.ddimg.cn/87/24/27508821-1_b_1.jpg', 43305, 43305);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Or the Girl Dies 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Rachel', 0,
        'http://img3m7.ddimg.cn/4/24/26566357-1_b_1.jpg', 14025, 14025);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】All Kinds of Bad 预订商品，平装，按需印刷，需要1-3个月发货，非质量问题不接受退换货。', 'Rust, Rachel', 0,
        'http://img3m4.ddimg.cn/11/31/26566364-1_b_1.jpg', 14976, 14976);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【预订】Megadeth - Rust in Peace 预订商品，需要1-3个月发货，非质量问题不接受退换货。', 'Rodgers', 0,
        'http://img3m3.ddimg.cn/50/16/27707873-1_b_1.jpg', 24882, 24882);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('营销学精选教材译丛―顾客资产管理', '拉斯特（Rust，R.T.） 等著，汪涛 译', 0, 'http://img3m2.ddimg.cn/98/15/20469932-1_b_0.jpg', 6500, 6500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java从入门到精通（第6版）（软件开发视频大讲堂） Java入门经典，销售12年，80万Java程序员、数百所高校选择，210集教学视频+211个应用示例+151个编程训练+94个综合训练+海量开发资源库+在线答疑，Java核心技术，Java编程思想。',
        '明日科技', 0, 'http://img3m9.ddimg.cn/34/16/29251069-1_b_14.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术 卷I 基础知识（原书第11版） Core Java 第11版，Jolt大奖获奖作品，针对Java SE9、10、11全面更新，与Java编程思想、Effective Java、深入理解Java虚拟机 堪称：Java四大名著',
        '[美],凯・S.霍斯特曼（Cay,S.Horstmann）', 0, 'http://img3m2.ddimg.cn/1/1/28487152-1_b_10.jpg', 9690, 14900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Head First Java（中文版）（JAVA经典畅销书 生动有趣 轻松学好JAVA） 10年畅销经典，累计印刷30多次，畅销近30万册，计算机图书十大好书之一。',
        '（美）塞若（Sierra，K.），（美）贝茨（Bates，B.） 著，O’Reilly Taiwan公司 译，张然 等改编', 0,
        'http://img3m9.ddimg.cn/56/36/9265169-1_b_5.jpg', 3320, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术 卷I：开发基础（原书第12版） 豆瓣高分，全球百万Java开发者认可，Java入门畅销书CoreJava，根据Java17新特性全面升级！系统全面、深入理解Java核心技术与编程思想。',
        '(美) 凯・ S. 霍斯特曼（Cay S. Horstmann）', 0, 'http://img3m8.ddimg.cn/7/0/29411818-1_b_23.jpg', 11170, 14900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('On Java 中文版套装：基础卷+进阶卷（当当套装共2册）', '[美]布鲁斯・埃克尔（Bruce Eckel）', 0,
        'http://img3m3.ddimg.cn/96/16/29386563-1_b_9.jpg', 12980, 25960);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术第11版基础知识+高级特性套装 套装共2册 Core Java第11版，与Java编程思想、EffectiveJava、深入理解Java虚拟机合称Java四大名著。卷I介绍Java语言基础知识的专业级详解；卷II介绍软件开发需要了解的高级主题',
        '[美] 凯・S・霍斯特曼（Cay，S，Horstmann）', 0, 'http://img3m0.ddimg.cn/27/33/29001780-1_b_12.jpg', 22350, 29800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java编程思想（第4版） Java学习经典,殿堂级著作！赢得了全球程序员的广泛赞誉。', '[美] Bruce Eckel', 0,
        'http://img3m0.ddimg.cn/4/24/9317290-1_b_5.jpg', 7020, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java完全自学教程 一本让初学者通过案例项目实战开发入门java书，170个实例教学，24小时配套视频教程，加赠150道面试题，三大实战项目，提供源码、视频课程、课后练习题等配套资源', '明日科技', 0,
        'http://img3m3.ddimg.cn/20/16/29365103-1_b_4.jpg', 3990, 7990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java高并发核心编程 卷2（加强版）：多线程、锁、JMM、JUC、高并发设计模式 深入浅出地讲解Java高并发应用开发核心技术', '尼恩', 0,
        'http://img3m6.ddimg.cn/80/30/29479706-1_b_7.jpg', 8850, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java高并发核心编程：加强版. 卷3, 亿级用户Web应用架构与实战 深入浅出地讲解Java高并发应用开发核心技术', '尼恩、德鲁、李鹏举、尤里乌斯', 0,
        'http://img3m7.ddimg.cn/56/2/29482157-1_b_13.jpg', 8850, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深入理解Java核心技术：写给Java工程师的干货笔记（基础篇） 全网阅读量千万的Java工程师成神之路学习笔记，Java基础知识点查漏补缺，Java程序员案头宝典，面试笔记干货大全，随书附赠一份惊喜彩蛋',
        '张洪亮（@Hollis）', 0, 'http://img3m8.ddimg.cn/44/24/29400668-1_b_4.jpg', 10350, 13800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java性能权威指南(第2版) java语言程序设计，从入门到实践基础教程，涵盖Java 8和Java 11等常用版本，Java性能团队前核心成员心血之作，附赠JVM调优标志速查表和示例代码',
        '[美] 斯科特・奥克斯（Scott Oaks）', 0, 'http://img3m5.ddimg.cn/9/31/29398455-1_b_11.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java EE的轻量级开发利剑：Spring Boot实战 springboot算法编程入门零基础自学，java核心技术，Spring Boot框架综合实战，搭配企业级开发示例，全程项目驱动，帮助读者成长为出色的全栈工程师、架构师',
        '王波', 0, 'http://img3m8.ddimg.cn/90/34/29397348-1_b_3.jpg', 8170, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Effective Java中文版（原书第3版） Java之父鼎力推荐；Jolt大奖获奖作品升级更新；豆瓣评分9.3。与 Java核心技术、Java编程思想、深入理解Java虚拟机 齐名，堪称：Java四大名著。正版图书双色印刷，阅读体验更佳',
        '[美] 约书亚 布洛克 （Joshua Bloch）著, 俞黎敏 译', 0, 'http://img3m5.ddimg.cn/83/3/26437835-1_b_9.jpg', 7740, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深入理解Java虚拟机：JVM高级特性与实践（第3版） 周志明虚拟机新作，第3版新增内容近50%，5个维度全面剖析JVM，大厂面试知识点全覆盖。与 Java编程思想、Effective Java、Java核心技术 堪称：Java四大名著',
        '周志明', 0, 'http://img3m5.ddimg.cn/55/8/28495225-1_b_11.jpg', 11060, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java高并发核心编程 卷1（加强版）：NIO、Netty、Redis、ZooKeeper 深入浅出地讲解Java高并发应用开发核心技术', '尼恩、陈健、徐明冠、岳阳博', 0,
        'http://img3m3.ddimg.cn/18/27/29504493-1_b_1.jpg', 10350, 13800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('阿里巴巴Java开发手册（第2版） 全球Java开发设计权威指南', '杨冠宝', 0, 'http://img3m0.ddimg.cn/28/10/29137510-1_b_3.jpg', 3370, 4500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('On Java 中文版 基础卷', '[美]布鲁斯・埃克尔（Bruce Eckel）', 0, 'http://img3m2.ddimg.cn/95/15/29386562-1_b_4.jpg', 6490,
        12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('On Java 中文版 进阶卷', '[美]布鲁斯・埃克尔（Bruce Eckel）', 0, 'http://img3m1.ddimg.cn/94/14/29386561-1_b_5.jpg', 6490,
        12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java编程入门与项目应用（零基础入门 程序员必看） 从零开始学Java，本书学练结合,手把手教你掌握Java编程语言，培养编程思维，提高编程能力。', '黎明，丁洁，张雪英 著； 清泉静读 出品', 0,
        'http://img3m6.ddimg.cn/92/17/29512586-1_b_2.jpg', 4029, 8400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('疯狂Java讲义（第6版）（上册）', '李刚', 0, 'http://img3m1.ddimg.cn/42/35/29507091-1_b_1.jpg', 10350, 13800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术 卷I 基础知识 第11版 英文版 上下册 Java领域经典著作 全面体现Java SE 9、Java SE 10和Java SE 11的新变化',
        '[美]凯・S. 霍斯特曼（Cay S. Horstmann）', 0, 'http://img3m5.ddimg.cn/83/10/27857495-1_b_3.jpg', 11170, 14900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java无难事――详解Java编程核心思想与技术（第2版）', '孙鑫', 0, 'http://img3m8.ddimg.cn/55/31/29505718-1_b_1.jpg', 12600, 16800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java图解创意编程：从菜鸟到互联网大厂之路 10位大厂大咖推荐 10个精致项目实践 10万行代码之路', '胡东锋', 0,
        'http://img3m4.ddimg.cn/19/28/29504494-1_b_1.jpg', 11170, 14900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java开发手册（码出高效Java开发手册+阿里巴巴Java开发手册）（套装共2册） 引爆技术圈，全球瞩目的中国计算机民族图书，中国人自己原创的Java编程规范，希望未来社会发展的每一行代码都规范、合理、高效，马云、行癫、鲁肃亲笔推荐！',
        '杨宝冠（孤尽） 高海慧（鸣莎）', 0, 'http://img3m6.ddimg.cn/41/8/29264936-1_b_3.jpg', 10800, 14400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【正版全新】Java从入门到精通(第6六版) java语言程序设计电脑编程基础计算机软件开发教程JAVA编程入门零基础自', '明日科技', 0,
        'http://img3m7.ddimg.cn/56/7/11117512847-1_b_2.jpg', 3679, 8000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java项目开发实战入门（全彩版） 一本让初学者通过项目实战开发学会编程的图书，精选实用项目，采用主流Java开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码，海量资源免费赠送',
        '明日科技(Mingri Soft)', 0, 'http://img3m3.ddimg.cn/30/26/28485993-1_b_17.jpg', 2990, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java并发编程实战（第16届Jolt大奖提名图书，Java并发编程必读佳作） 豆瓣评分9.1，Java并发编程里程碑著作！10年畅销100000册！', '[美] Brian Goetz 等', 0,
        'http://img3m5.ddimg.cn/86/20/22606835-1_b_3.jpg', 4490, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术 卷II 高级特性（原书第11版） Core Java 第11版，Jolt大奖获奖作品，针对Java SE9、10、11全面更新，与Java编程思想、Effective Java、深入理解Java虚拟机 堪称：Java四大名著',
        '（美）凯 S.霍斯特曼（Cay S. Horstmann）', 0, 'http://img3m7.ddimg.cn/88/13/28505257-1_b_8.jpg', 11170, 14900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java编程超级魔卡', '明日科技', 0, 'http://img3m9.ddimg.cn/55/10/29448199-1_b_6.jpg', 1490, 2980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java多线程与线程池技术详解 51CTO金牌讲师，CSDN学院总监高山和中软国际教育集团副总裁王晓华联袂推荐， 案例贴合实际，配套视频', '肖海鹏 牟东旭', 0,
        'http://img3m8.ddimg.cn/4/1/29248168-1_b_6.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java程序员面试笔试宝典 第2版 Java程序员面试笔试宝典经典再版，畅销8年，重印10余次，销量突破50000册的经典好书，获得数十万IT求职者认可推荐', '何昊 郭晶晶 薛鹏 等编著', 0,
        'http://img3m2.ddimg.cn/91/32/29315872-1_b_7.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java精彩编程200例（全彩版） 全彩图书，精选200个场景应用实例，快学快用，5大开发方向，轻松提升Java编程技能，附赠Java入门基础视频，400+代码片段，更有任务训练库、资源库',
        '明日科技(Mingri Soft)', 0, 'http://img3m3.ddimg.cn/50/9/28486013-1_b_14.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java高并发与集合框架：JCF和JUC源码分析与实现 掌握Java集合框架和Java并发工具包，轻松应对80%的工作场景', '银文杰', 0,
        'http://img3m4.ddimg.cn/79/29/29344174-1_b_3.jpg', 8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java代码审计 入门篇 Java代码审计入门手册，Java代码审计初学者指南，系统介绍Java代码安全审计入门技术，丰富详细案例讲解，理论与实践结合入门Java代码审计', '徐焱 陈俊杰 李柯俊 章宇 蔡国宝', 0,
        'http://img3m7.ddimg.cn/41/13/29273747-1_b_6.jpg', 6490, 12990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java Web从入门到精通（第3版） 286个应用实例+49个实践练习+19小时教学视频+海量开发资源库，丛书累计销量200多万册', '明日科技', 0,
        'http://img3m5.ddimg.cn/60/7/27903705-1_b_3.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java开发详解（全彩版） 全彩图书，快学、快用、快查，囊括Java程序开发的基础知识和各种开发技术，突破工作中技术难点，实例丰富讲解精炼，进阶提升宝典！', '明日科技(Mingri Soft)', 0,
        'http://img3m0.ddimg.cn/57/16/28486020-1_b_19.jpg', 3450, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java网络编程实战', '李建英 编著', 0, 'http://img3m1.ddimg.cn/96/28/29382801-1_b_4.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java核心技术 卷II：高级特性 第11版・英文版 上下册 Java领域极具影响力和参考价值的著作，Java UI和企业级特性的权威指南，针对Java 11全面更新',
        '[美] 凯・S. 霍斯特曼（Cay S. Horstmann）', 0, 'http://img3m9.ddimg.cn/66/25/28522659-1_b_6.jpg', 11920, 15900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java Web 项目开发案例实战―Spring Boot+Mybatis+Hibernate+Spring Cloud', '尹有海', 0,
        'http://img3m9.ddimg.cn/90/9/29323989-1_b_2.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java算法从菜鸟到达人', '猿媛之家', 0, 'http://img3m7.ddimg.cn/36/5/29426697-1_b_1.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java并发编程的艺术 阿里技术专家/Java并发编程领域领军人物撰写，从JDK源码、JVM、CPU多角度剖析并发编程原理和Java核心技术', '方腾飞，魏鹏，程晓明 著', 0,
        'http://img3m1.ddimg.cn/25/7/23745571-1_b_1.jpg', 4420, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java性能优化实践 JVM调优策略 工具与技巧 JAVA程序设计书籍入门零基础自学核心技术，深入理解jvm虚拟机高级特性，*实践网络维护理论与方法相结合，全面阐释JVM领域新知识和一线生产调优经验。',
        '[英]本杰明・J. 埃文斯（Benjamin J. Evans），[英]詹姆斯・', 0, 'http://img3m1.ddimg.cn/45/27/29166831-1_b_9.jpg', 8170, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java 8函数式编程', '[英]沃伯顿（Richard Warburton）', 0, 'http://img3m7.ddimg.cn/68/20/1230369197-1_b_1.jpg', 2925, 3900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java 从入门到项目实践（超值版） 886套求职资源库、200个案例资源库、500学时在线课程、454节同步微视频、328个实例源代码、8套电子书资源库、7个大型项目案例、10套8大行业Java项目开发文档模板库。 微信+APP+网站+',
        '聚慕课教育研发中心', 0, 'http://img3m2.ddimg.cn/19/30/25321942-1_b_4.jpg', 6740, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java编程讲义 15年Java培训机构内部教材，10年开发经验、5年授课经验集成，符合软件开发专业教学大纲，217集教学视频+238个经典案例+精美PPT课件+案例源码+电子图书+教学资源+在线答疑。',
        '荣锐锋、张晨光、殷晋、王向南、尹成', 0, 'http://img3m5.ddimg.cn/6/7/29318955-1_b_2.jpg', 5230, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java从入门到项目实战（全程视频版） java从入门到精通 java语言程序设计 java核心技术 java编程思想 65小时3900分钟全程视频教学，著名软件技术讲师20年Java经验集成之作，配套源代码、课件、自测题、面试题，赠送Java工程师学习路线、职业规划、自我修养视频课，让Java学习不再迷茫！',
        '李兴华 著', 0, 'http://img3m4.ddimg.cn/27/16/27864864-1_b_3.jpg', 4990, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java从入门到精通（实例版）（第2版） 新版上市 java入门经典 持续八年畅销 20000读者口碑相传 14小时视频讲解 413个经典实例 369项面试真题 616项测试 ppt电子课件 范例 案例 视频教程 零基础学 java 编程 从',
        '明日科技', 0, 'http://img3m0.ddimg.cn/9/35/25146900-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java多线程编程核心技术（第3版） 畅销书作者撰写，全新升级，新增适合微服务与分布式开发的并发集合框架与Java线程池知识|Java核心技术系列', '高洪岩', 0,
        'http://img3m1.ddimg.cn/10/25/29352421-1_b_5.jpg', 9670, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('数据结构与算法分析：Java语言描述（原书第3版） 国际著名计算机教育专家Weiss数据结构与算法Java描述经典教材新版，把算法分析与高效率的Java程序的开发有机地结合起来，深入分析每种算法。',
        '[美]马克・艾伦・维斯', 0, 'http://img3m1.ddimg.cn/44/17/23918741-1_b_4.jpg', 4490, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java程序员面试笔试通关宝典 程序员刷题之宝典，编程能力提升之秘籍！超值赠送“职业成长”资源库、“面试、求职”资源库、本书全部源代码、编程水平测试系统、软件学习工具及电子书资源库等。', '聚慕课教育研发中心', 0,
        'http://img3m0.ddimg.cn/72/29/29119140-1_b_5.jpg', 4480, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java Web入门很轻松（微课超值版） 全方位微课教学，零基础轻松入门，超值赠送教学微视频、教学PPT、案例及项目源码、教学大纲、求职资源库、面试资源库、笔试题库和小白项目实战手册。', '云尚科技', 0,
        'http://img3m9.ddimg.cn/56/0/29378999-1_b_1.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Easy Java (第7版）深入理解java核心技术从入门到精通 java项目开发手册 java并发编程实战 on j 日本经典java图书 6次改版，持续畅销20年，日本市场Java类图书累计销量排行NO.1 100个图形图示+121段示例代码解析+67道课后练习 涵盖编程基础、软件开发核心技术、编程思想',
        '[日] 高桥麻奈', 0, 'http://img3m5.ddimg.cn/4/3/29362315-1_b_4.jpg', 4990, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java项目开发全程实录（第4版） Java畅销书，重磅升级进阶版，累计重印96次，单书畅销50万册，160小时在线课程', '明日科技', 0,
        'http://img3m0.ddimg.cn/42/27/25273950-1_b_6.jpg', 5230, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java并发编程之美 阿里巴巴技术专家力作，用代码说话、用实例验证，并发编程没有这么难！《Java并发编程的艺术》*作者方腾飞老师好评推荐！', '翟陆续 薛宾田', 0,
        'http://img3m4.ddimg.cn/37/30/25536394-1_b_8.jpg', 7030, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('疯狂Java讲义（第5版）（含DVD光盘一张） 覆盖Java稳定版本Java11，渗透Java编程思想，李刚作品成为海峡两岸读者之选，本书赠送20+小时视频、源代码、课件、面试题，提供微信答疑群，配套学习网站。',
        '李刚', 0, 'http://img3m2.ddimg.cn/55/24/27858952-1_b_3.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('剑指Java――核心原理与应用实践', '尚硅谷教育', 0, 'http://img3m9.ddimg.cn/1/35/29423989-1_b_8.jpg', 18000, 18000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java设计模式及实践 精选Java实用设计模式，帮你有效解决开发应用程序过程中的常见问题，轻松应对各种规模项目的扩展和维护', '[印度]卡马尔米特・辛格（Kamalmeet Singh） 等', 0,
        'http://img3m3.ddimg.cn/50/26/27893993-1_b_3.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java实战 第2版', '[英]拉乌尔?C加布里埃尔・乌尔玛 [意]马里奥・富斯科 [英]艾伦・米克罗夫特', 0, 'http://img3m8.ddimg.cn/45/15/28492938-1_b_4.jpg',
        8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java高级程序员面试笔试宝典 覆盖了近3年程序员面试笔试中超过98%的高频考点难点及真题解析 助力获取高薪', '猿媛之家 蔡羽 楚秦 等', 0,
        'http://img3m3.ddimg.cn/53/5/28491263-1_b_3.jpg', 5450, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript高级程序设计 第4版 web前端开发经典教程，JS“红宝书”全新升级，入门+实战，涵盖ECMAScript 2019，提供教学视频+配套编程环境，可直接在线运行随书代码',
        '[美]马特・弗里斯比（Matt Frisbie）', 0, 'http://img3m7.ddimg.cn/64/26/29120617-1_b_10.jpg', 6450, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript权威指南（第7版） 全球畅销25年JS犀牛书全新升级，涵盖ECMAScript2020|JavaScript高级程序设计从入门到精通，全体前端开发者案头手册',
        '(美)David Flanagan（弗兰纳根）', 0, 'http://img3m0.ddimg.cn/13/17/22722790-1_b_33.jpg', 9040, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('现代JavaScript库开发：原理、技术与实战 前端圈众多大咖联袂力荐，作者十年开源经验沉淀输出，内含前沿前端技术，精心挑选9个实战示例，提供真实示例代码', '颜海镜 侯策 著', 0,
        'http://img3m5.ddimg.cn/72/36/29494845-1_b_3.jpg', 8100, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('HTML5+CSS3+JavaScript从入门到精通（标准版）基础视频讲解与案例实战，8大素材库，源代码配套学习更轻松 10万读者检验 扫一扫随时随地看视频 412节同步视频 661个案例分析 1000习题面试题 4396个案例 47部参考手册 1636个模版 17类素材库 623项配色 508项欣赏库 网页制作 网页',
        '未来科技', 0, 'http://img3m3.ddimg.cn/22/29/25108303-1_b_9.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深入理解现代JavaScript 蒲松洋、程劭非、桑世龙、付强、吴成忠、时磊和马剑竹国内7位大咖联袂推荐！随书送源代码，获取地址见书封底二维码。',
        '[美]T. J. 克罗德(T. J. Crowder)著 赵永、卢贤泼 译', 0, 'http://img3m0.ddimg.cn/9/26/29396970-1_b_2.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学JavaScript（全彩版） 零基础自学Web前端开发的入门图书，详解JavaScript语言的编程思想和核心技术，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m4.ddimg.cn/41/0/28486004-1_b_21.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript 基础语法详解 30多个示例源代码，100多分钟视频讲解!全面讲解JavaScript基础语法及ES6~ES2021新特性', '张旭乾', 0,
        'http://img3m4.ddimg.cn/88/8/29397544-1_b_1.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('轻松学会JavaScript JavaScript很好学，一本很好看的编程书。三段式JavaScript学练结合，修炼成为快乐的前端工程师', '[英] 罗伯・迈尔斯（Rob Miles）著 周子衿 陈子鸥 译', 0,
        'http://img3m2.ddimg.cn/46/24/29444032-1_b_1.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('HTML5+CSS3+JavaScript前端开发从零开始学（视频教学版） 快速掌握Web前端开发基础 示例源码、PPT课件、同步教学视频', '王英英', 0,
        'http://img3m5.ddimg.cn/20/31/29475785-1_b_3.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript高级程序设计 第4版 [美]马特・弗里斯比(MattFrisbie) 人民邮电出版社【正版书】 全国三仓发货，物流便捷，下单秒杀，欢迎选购！', '[美]马特・弗里斯比(MattFrisbie)',
        0, 'http://img3m0.ddimg.cn/63/29/11301095880-1_b_2.jpg', 5290, 11137);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript高级程序设计第四4版 web前端开发书籍 网页制作 视频教学 配套编程环境', '马特・弗里斯比', 0,
        'http://img3m5.ddimg.cn/98/4/1734311105-1_b_3.jpg', 6450, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 JavaScript权威指南(第6版) 限购|199271', '(美)David Flanagan', 0, 'http://img3m5.ddimg.cn/4/35/1518095605-1_b_1.jpg',
        9730, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript高级程序设计 第4版 [美]马特・弗里斯比(MattFrisbie) 人民邮电出版社【正版书】 全国三仓发货，物流便捷，下单秒杀，欢迎选购！', '[美]马特・弗里斯比(MattFrisbie)',
        0, 'http://img3m3.ddimg.cn/76/4/11229883213-1_b_3.jpg', 4890, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript高级程序设计 第4版 [美]马特・弗里斯比(MattFrisbie) 人民邮电出版社【正版】 全国三仓发货，物流便捷，下单秒杀，欢迎选购！', '[美]马特・弗里斯比(MattFrisbie)', 0,
        'http://img3m0.ddimg.cn/10/17/11226463390-1_b_7.jpg', 4890, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript设计模式', '张容铭', 0, 'http://img3m7.ddimg.cn/11/12/1230046697-1_b_1.jpg', 4602, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript从入门到精通（微课视频版）（第2版） web前端开发网页设计丛书 10万册畅销书重磅升级！JavaScript高级程序设计视频教程，31小时1860分钟全程视频，880个全程实例开发，赠网页模板库、素材库、配色库、习题库、面试题',
        '未来科技', 0, 'http://img3m8.ddimg.cn/77/34/27914018-1_b_3.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript+Vue+React全程实例 通过JavaScript实例掌握Web前端开发技术', '郑均辉 薛?D', 0,
        'http://img3m2.ddimg.cn/75/27/27901542-1_b_3.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript物联网硬件编程 一本组装设计机器人的电子电路速成教程，如何用电线连接传感器、安装电机、传送数据以及处理用户输入。',
        '[美] 丽萨・丹吉・加德纳（Lyza Danger Gardner）著 戢礼晋 谭少辉 许琛 译', 0, 'http://img3m0.ddimg.cn/59/2/27931820-1_b_3.jpg', 7350,
        9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript编程精解（原书第3版） 基于ES6,JS之父BrendanEich强力推荐，在游戏式开发中快速掌握JavaScript语言精髓与编程实践，系统介绍如何编写高效的代码。零基础入门并快速进阶JavaScript高级程序设计',
        '[美]马尔奇・哈弗贝克（Marijn Haverbeke）', 0, 'http://img3m6.ddimg.cn/0/6/28529226-1_b_4.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript从入门到精通（第4版） JavaScript入门经典，25万JavaScript程序员的选择，220集微课视频+176个应用示例+96个编程训练+54个实践练习+项目案例+开发资源库+在线答疑。',
        '明日科技', 0, 'http://img3m6.ddimg.cn/50/28/29334146-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('趣学JavaScript――教孩子学编程 官方正版 出版社直发', '[美] Nick Morgan 摩根', 0, 'http://img3m7.ddimg.cn/49/7/1230000997-1_b_2.jpg',
        4425, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('[北京发货] JavaScript数据可视化编程 js书 Java编程', 'Stephen A.Thomas', 0,
        'http://img3m7.ddimg.cn/37/30/1231692697-1_b_2.jpg', 7722, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript设计模式', '[美]Addy Osmani 著', 0, 'http://img3m7.ddimg.cn/97/6/1231579897-1_b_1.jpg', 3675, 4900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('区块链开发实战：基于JavaScript 的公链与DApp 开发 区块链应用开发从零到一', '梁培利 曹帅 吴延毅', 0,
        'http://img3m6.ddimg.cn/2/33/27917606-1_b_3.jpg', 6140, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript程序设计基础教程（慕课版）', '刘刚', 0, 'http://img3m7.ddimg.cn/21/5/27892677-1_b_1.jpg', 4190, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript前端开发实用技术教程', '岳学军 主编', 0, 'http://img3m7.ddimg.cn/3/27/1229976597-1_b_1.jpg', 3360, 4200);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript学习指南 第3版 js教程书', '[美]Ethan Brown 布朗', 0, 'http://img3m7.ddimg.cn/11/12/1229680397-1_b_1.jpg', 4602,
        5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript构建Web和ArcGIS Server应用实战', '[美]派普勒(Eric Pimpler)', 0,
        'http://img3m7.ddimg.cn/58/22/1230160297-1_b_1.jpg', 3822, 4900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('学习JavaScript数据结构与算法 第3版 数据结构与算法教程书籍 用JavaScript深度学习常用的数据结构与算法核心技术 高效解决计算机网络编程常见问题',
        '[巴西]洛伊安妮・格罗纳（Loiane Groner）', 0, 'http://img3m2.ddimg.cn/53/31/27872612-1_b_16.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('你不知道的JavaScript（中卷）深入挖掘JavaScript语言本质，简练形象地解释抽象', 'Kyle Simpson', 0,
        'http://img3m7.ddimg.cn/60/31/1229843697-1_b_1.jpg', 5925, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('精通JavaScript开发', '[英]奥德尔（Den Odell）', 0, 'http://img3m7.ddimg.cn/1/16/1230065497-1_b_1.jpg', 6162, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('HTML+CSS+JavaScript编程超级魔卡', '明日科技', 0, 'http://img3m6.ddimg.cn/52/7/29448196-1_b_5.jpg', 1490, 2980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript前端开发与实例教程（微课视频版） 详解JavaScript语言基础，通过众多案例快速提高前端开发能力', '崔仲远 王宁 林新然 张梦飞', 0,
        'http://img3m7.ddimg.cn/78/0/29445747-1_b_9.jpg', 4420, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript百炼成仙 如果你厌倦了厚厚的如同字典般的编程书籍，不妨尝试一下这种新的口味！通过本书，你可以领悟到JavaScript的函数七重关秘籍！通过本书，你可以轻松学会使用jQuery去操作DOM对象！通过本书，你可以',
        '杨逸飞', 0, 'http://img3m0.ddimg.cn/90/13/29255580-1_b_4.jpg', 4950, 6600);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('编写可维护的JavaScript', '[美]Nicholas C. Zakas 著', 0, 'http://img3m7.ddimg.cn/51/0/1230060597-1_b_1.jpg', 4290,
        5500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Java编程从入门到实践（微课视频版）java进阶 javascript dom编程艺术 java程序设计教程 java', '沐言科技 李兴华', 0,
        'http://img3m7.ddimg.cn/19/27/29394307-1_b_2.jpg', 3350, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript从入门到精通（标准版） JavaScript高级程序设计视频讲解，web开发核心技术案例实战，8大素 扫一扫随时随地看视频 512节同步视频 1016个案例分析 1000道习题面试题 4396个案例 47部参考手册 1636个模版 17类素材库 623项配色 508项欣赏库 10年经验 网页制作 网页',
        '未来科技', 0, 'http://img3m4.ddimg.cn/23/30/25108304-1_b_5.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript忍者秘籍 第2版 jQuery之父经典力作 JavaScript高手修炼指南 全面修订以涵盖ES6和ES7的概念 掌握跨浏览器开发教程书',
        '[美]John Resig 莱西格 Bear Bibeault 贝比奥特 Jo', 0, 'http://img3m0.ddimg.cn/6/7/25234710-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('数据结构与算法JavaScript描述', '[美]Michael McMillan 著', 0, 'http://img3m7.ddimg.cn/84/34/1230390597-1_b_1.jpg', 3675,
        4900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('众妙之门――JavaScript与jQuery技术精粹', '[德]Smashing Magazine 著', 0, 'http://img3m7.ddimg.cn/90/32/1229985297-1_b_1.jpg',
        2730, 3500);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript语言精髓与编程实践（第3版） Hax|玉伯|winter三大前端领军人物联合作序力荐 超烧脑超难啃超深邃超本质的JS绿皮书传奇登场', '周爱民', 0,
        'http://img3m5.ddimg.cn/3/33/28558335-1_b_7.jpg', 11380, 14400);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript面向对象精要 JavaScript高级程序设计 Ajax高级程序设计 高性能JavaScript 编写可维护的JavaScript作者Nicholas Zakas力作',
        '[美]尼古拉斯（Nicholas C.Zakas） 著，胡世杰 译', 0, 'http://img3m1.ddimg.cn/38/31/23675591-1_b_1.jpg', 2920, 3900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript悟道 理解JavaScript的运行与设计逻辑，体会开发大牛道格拉斯的思维方式及代码风格，深度Q&A，趣读大量JavaScript奇闻轶事，带您重识JavaScript',
        '[美]道格拉斯・克罗克福德（Douglas Crockford）', 0, 'http://img3m9.ddimg.cn/50/29/29268509-1_b_2.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript设计模式与开发实践', '曾探', 0, 'http://img3m4.ddimg.cn/57/6/29244954-1_b_6.jpg', 5230, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Web前端开发精品课 HTML CSS JavaScript基础教程 网页制作 网页设计书籍', '莫振杰', 0, 'http://img3m7.ddimg.cn/2/19/1230194297-1_b_1.jpg',
        5175, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript DOM编程艺术 第2版 畅销书升级版 详解开发Web应用的基石 W3C的DOM标准 国际知名web设计师 倡导Web标准的领军人物执笔 揭示了前端开发的真谛',
        '[英]Jeremy Keith [加]Jeffrey Sambells 著', 0, 'http://img3m8.ddimg.cn/89/13/29197268-1_b_8.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript DOM编程艺术*二2版 JavaScript*级程序设计JS设计模式基础教程入', 'Jeremy Keith等', 0,
        'http://img3m0.ddimg.cn/55/28/1890532270-1_b_1.jpg', 3450, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('学习JavaScript数据结构与算法 第三3版 数据结构与算法教程书籍 算法导论入门 web前端', '洛伊安妮・格罗纳', 0,
        'http://img3m4.ddimg.cn/72/5/1430224164-1_b_1.jpg', 3450, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Web前端开发 HTML5+CSS3+JavaScript+Vue.js+jQuery 网页设计 网页制作 网站建设自学 名师力作、彩色印刷，手机扫码看272集（52小时）同步视频讲解+235个实例源码分析+16个综合实验+2个项目实战+30个思维导图，手把手教你轻松学会Web前端开发，赠课后习题及答案等。',
        '刘兵 编著', 0, 'http://img3m3.ddimg.cn/80/4/29116673-1_b_7.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript网页程序设计与实践 唯有概念清楚，才能灵活运用，零基础也能轻松上手', '陈婉凌', 0, 'http://img3m0.ddimg.cn/90/33/28968480-1_b_6.jpg',
        5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript设计模式与开发实践 注明前端工程师曾探著 剖析面向对象设计原则代码重构 软件开发', '曾探', 0,
        'http://img3m2.ddimg.cn/24/11/626636562-1_b_4.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('前端跨界开发指南：JavaScript工具库原理解析与实战', '史文强 著', 0, 'http://img3m9.ddimg.cn/95/28/29434379-1_b_9.jpg', 9670, 12900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript+jQuery动态网站开发（全案例微课版） 精选热点案例和流行技术，案例易学，有趣，容易快速入门。支持扫码看视频，方便读者学习。提供了流行项目开发的全程操作，读者可以快速积累行业经验。', '裴雨龙',
        0, 'http://img3m9.ddimg.cn/5/10/29279849-1_b_4.jpg', 5850, 7800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript程序设计 javascript编程入门零基础自学，程序设计web前端技术，校企双元合作，以碎片化', '卢淑萍 陈玲', 0,
        'http://img3m5.ddimg.cn/28/16/29399365-1_b_7.jpg', 4480, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript语言精粹（修订版）', 'Douglas Crockford（道格拉斯?克罗克福德）', 0, 'http://img3m9.ddimg.cn/4/3/29208469-1_b_6.jpg',
        5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('ArcGIS API for JavaScript开发 带你搭建创意无限、制图精美、交互方便的Web地理信息系统', '刘光、李雷、刘增良', 0,
        'http://img3m9.ddimg.cn/5/29/29501609-1_b_3.jpg', 8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('JavaScript设计模式 百度前端专家力作 百度前端高级工程师鼎力推荐 web前端开发人员参考书 Web前端设计模式指南', '张容铭', 0,
        'http://img3m7.ddimg.cn/84/32/23753847-1_b_1.jpg', 4420, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript编程 是深入学习TypeScript的不二之选。通过本书可以快速有效地掌握TypeScript的工具和生态系统。', '[美]鲍里斯切尔尼', 0,
        'http://img3m9.ddimg.cn/80/33/28982429-1_b_3.jpg', 3700, 8800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Vue3.x+TypeScript实践指南', '邹琼俊 著', 0, 'http://img3m7.ddimg.cn/51/25/29464827-1_b_2.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript入门与实战 零基础学TypeScript,系统、全面介绍TypeScript编程语言的基础知识及应用，从基本语法到类型系统，从参数配置到工具集成，包含大量示例代码。|TS,前端开发，JavaScript',
        '钟胜平', 0, 'http://img3m2.ddimg.cn/2/25/29175302-1_b_9.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Effective TypeScript：精进TypeScript代码的62个实践方法 Sidewalk Labs的首席工程师，也是TypeScript NYC Meetup的联合创始人Dan Vanderkam创作，这本实用的指南提供了62个实践方法，给出了包括什么该做，什么不该做',
        '[美]丹・范德卡姆(Dan Vanderkam),王瑞鹏,董强', 0, 'http://img3m0.ddimg.cn/24/21/29336100-1_b_1.jpg', 4120, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript实战', '汪明', 0, 'http://img3m8.ddimg.cn/27/12/28501038-1_b_3.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 TypeScript入门与实战|8077121', '钟胜平', 0, 'http://img3m0.ddimg.cn/59/27/1816160900-1_b_1.jpg', 6930, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]编程与类型系统+TypeScript项目开发实战（2册）|8078285', '弗拉德・里斯库迪亚', 0,
        'http://img3m0.ddimg.cn/60/36/1883822550-1_b_1.jpg', 14144, 20800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Effective TypeScript 精进TypeScript代码的62个实践方法 中国电力出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(美)丹・范德卡姆', 0,
        'http://img3m7.ddimg.cn/62/6/11065976027-1_b_3.jpg', 4900, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Learning TypeScript中文版 (西班牙)Remo H. Jansen(雷莫 H. 詹森 ) 著,龙逸楠 全国三仓发货，物流便捷，下单秒杀，欢迎选购！',
        '(西班牙)Remo H. Jansen(雷莫 H. 詹森 )', 0, 'http://img3m1.ddimg.cn/76/13/11233640461-1_b_2.jpg', 1789, 4137);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript入门与实战+TypeScript项目开发实战|8077239', '钟胜平', 0,
        'http://img3m0.ddimg.cn/14/33/1826710790-1_b_1.jpg', 12784, 18800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript入门与实战+TypeScript实战指南（2|8077245', '钟胜平 胡桓铭', 0,
        'http://img3m0.ddimg.cn/74/19/1826710850-1_b_2.jpg', 12784, 18800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]编程与类型系统+TypeScript入门与实战（2册）|8078284', '弗拉德・里斯库迪亚 钟胜平', 0,
        'http://img3m0.ddimg.cn/82/34/1883822770-1_b_1.jpg', 14824, 21800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript编程 中国电力出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(美)鲍里斯・切尔尼', 0,
        'http://img3m2.ddimg.cn/47/2/1667713952-1_b_3.jpg', 4400, 8800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript编程【新华集团】', '[美]鲍里斯切尔尼', 0, 'http://img3m2.ddimg.cn/35/18/11265375662-1_b_1.jpg', 5250, 8800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript入门与区块链项目实战 用区块链实战项目快速入门TypeScript',
        '[美] 雅科夫・法因(Yakov Fain)、[俄] 安东・莫伊谢耶夫（Anton Moiseev）著 王红滨 王勇 何鸣 译', 0,
        'http://img3m1.ddimg.cn/45/14/29261871-1_b_7.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript项目开发实战 TypeScript编程实战指南，通过9个实用项目，详细讲解如何使用TypeScript 3.0和不同的JavaScript框架来开发高质量的应用程序',
        '（美）彼得・欧汉龙（Peter O', 0, 'http://img3m7.ddimg.cn/64/33/29001817-1_b_3.jpg', 6140, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript图形渲染实战：基于WebGL的3D架构与实现 【凝聚15年图形编程经验！7位大咖力荐！详解TypeScript及基于WebGL的3D架构与实现；精讲8个图形编程案例,涵盖数据结构、3D图形数学基础、多视口渲染、文字绘制、场景渲染、骨骼蒙皮动画…】',
        '步磊峰', 0, 'http://img3m6.ddimg.cn/78/8/28499406-1_b_3.jpg', 7520, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('TypeScript图形渲染实战：2D架构设计与实现 【凝聚作者15年图形编程经验！业内7位专家推荐！详解TypeScript语言及2D图形架构和算法实现；精讲55个实例，涵盖词法解析、设计模式、图形变换、渲染状态机等；涉及动画、UI和游戏等领域】',
        '步磊峰', 0, 'http://img3m7.ddimg.cn/4/29/26915827-1_b_1.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066561', '步磊峰胡桓铭', 0,
        'http://img3m5.ddimg.cn/35/25/1568603555-1_b_1.jpg', 13463, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('新程序员.004 新程序员杂志 CSDN官方出品 48位专家分享程序人生故事 C++ C# TypeScript MyS 新程序员.004 我们的技术时代，我们的程序人生', '《新程序员》编辑部', 0,
        'http://img3m3.ddimg.cn/3/34/29426763-1_b_2.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 TypeScript图形渲染实战：基于WebGL的3D架构与实现|8065986', '步磊峰', 0, 'http://img3m5.ddimg.cn/31/18/1709280175-1_b_1.jpg',
        7630, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066564', '步磊峰张帆', 0,
        'http://img3m5.ddimg.cn/25/10/1709279575-1_b_1.jpg', 13463, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 TypeScript图形渲染实战：2D架构设计与实现|8057259', '步磊峰', 0, 'http://img3m6.ddimg.cn/76/35/1373242936-1_b_1.jpg', 6930,
        9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066560', '步磊峰', 0,
        'http://img3m5.ddimg.cn/62/14/1568603285-1_b_1.jpg', 14144, 20800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066562', '步磊峰钱游', 0,
        'http://img3m5.ddimg.cn/55/3/1709279605-1_b_1.jpg', 14144, 20800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066563', '步磊峰徐顺发', 0,
        'http://img3m5.ddimg.cn/35/20/1709279585-1_b_1.jpg', 12104, 17800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 TypeScript实战指南|8059532', '胡桓铭', 0, 'http://img3m4.ddimg.cn/9/24/1422713664-1_b_1.jpg', 6230, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 TypeScript项目开发实战|8071677', '（英）彼得・欧汉龙（Peter O’Hanlon）', 0,
        'http://img3m4.ddimg.cn/5/32/11172597584-1_b_1.jpg', 6230, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript项目开发实战+TypeScript实战指南（|8071716', '胡桓铭', 0,
        'http://img3m5.ddimg.cn/55/27/1720766575-1_b_1.jpg', 12104, 17800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript项目开发实战+TypeScript图形渲染实|8071717', '步磊峰', 0,
        'http://img3m5.ddimg.cn/76/36/1720766695-1_b_1.jpg', 13463, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]TypeScript图形渲染实战：基于WebGL的3D架构与实现|8066565', '步磊峰王静逸 刘岵', 0,
        'http://img3m5.ddimg.cn/94/17/1709279545-1_b_1.jpg', 16864, 24800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('迈向Angular 2：基于TypeScript的高性能SPA框架', '（保加利亚）Minko Gechev（明科・基彻） 著，大漠穷秋 熊三 译', 0,
        'http://img3m8.ddimg.cn/70/5/24013708-1_b_6.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版 C++程序设计经典教程，畅销30年的C++大百科全书全新升级，经典C++入门教程十年新版再现，孟岩、高博倾力推荐，赠送价值99元的e读版电子书及在线实验环境，赠送大尺寸全书思维导图，赠199元训练营',
        '[美] 史蒂芬・普拉达', 0, 'http://img3m9.ddimg.cn/31/36/28979509-1_b_20.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#从入门到精通（第6版） C#入门经典，销售12年，50万C#程序员、数百所高校选择，164集微课视频+236个应用示例+129个编程训练+97个实践练习', '明日科技', 0,
        'http://img3m9.ddimg.cn/57/29/29317719-1_b_2.jpg', 7880, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C++（全彩版） 零基础自学编程的入门图书，由浅入深，详解C++语言的编程思想和核心技术，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m2.ddimg.cn/59/18/28486022-1_b_35.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++从入门到精通（第5版） C++入门经典，销售12年，50万C++程序员、数百所高校的选择，97集微课视频+178个应用示例+122个编程训练+53个实践练习+项目案例+海量开发资源库+在线答疑', '明日科技',
        0, 'http://img3m8.ddimg.cn/41/13/29336018-1_b_3.jpg', 7090, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版（第5版） C++学习头牌 全球读者千万 全面采用新标 技术影响力图书冠军', '(美)李普曼 等', 0,
        'http://img3m2.ddimg.cn/33/18/23321562-1_b_24.jpg', 8320, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C#开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码，海量资源免费赠送',
        '明日科技(Mingri Soft)', 0, 'http://img3m0.ddimg.cn/37/33/28486000-1_b_17.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#精彩编程200例（全彩版） 汇集了与C#开发相关的200个实例及源代码，每个实例都按实例说明、关键技术、实现过程、扩展学习的顺序进行分析解读。', '明日科技(Mingri Soft)', 0,
        'http://img3m5.ddimg.cn/52/11/28486015-1_b_20.jpg', 4490, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典（第9版） 屡获殊荣的C#名著和优秀畅销书，更新至 C# 9.x 和 .NET 5.x。随书赠送源代码和习题答案，获取地址见书封底二维码。',
        '[德] 本杰明・帕金斯(Benjamin Perkins)，乔恩・D. 里德(Jon D. Reid) 著 齐立博 译', 0,
        'http://img3m4.ddimg.cn/37/25/29399374-1_b_2.jpg', 9320, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++项目开发实战入门（全彩版） 一本能让初学者通过项目实战开发学会编程的超值图书，精选实用项目，采用主流C++开发技术，让读者体验编程乐趣、获得实战经验，配同步视频教程和源代码',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/34/30/28485997-1_b_25.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程无师自通――信息学奥赛零基础教程', '严开明，葛阳，徐景全', 0, 'http://img3m0.ddimg.cn/45/7/28512540-1_b_1.jpg', 3500, 5000);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础轻松学C++：青少年趣味编程（全彩版）', '快学习教育', 0, 'http://img3m8.ddimg.cn/6/28/28526658-1_b_2.jpg', 4820, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（第5版） C语言入门经典，销售12年，60万C语言程序员、数百所高校选择，215集微课视频+178个应用示例+134个编程训练+128个综合训练+海量开发资源库+在线答疑。', '明日科技', 0,
        'http://img3m1.ddimg.cn/59/15/29290991-1_b_5.jpg', 5980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#码农笔记――从第一行代码到项目实战 微软资深MVP 、C#知名专家力作 全面论述C# 语法基础、程序结构、编程技巧及项目实战', '周家安', 0,
        'http://img3m7.ddimg.cn/77/21/29448617-1_b_5.jpg', 9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程 全国青少年信息学奥林匹克普及组竞赛教材一本真正适合小学生的信息学竞赛培训教材，赠配套教学资源，素材下载地址为：https://pan.baidu.com/s/1i7mvF6H', '潘洪波', 0,
        'http://img3m0.ddimg.cn/68/18/25201310-1_b_6.jpg', 4480, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C Primer Plus 第6版 中文版 C语言入门经典教程 C语言入门经典教程，畅销30余年的C语言编程入门书籍，近百万程序员的C语言编程启蒙教材，技术大牛案头常备的工具书，被誉为C语言百科全书，购书赠送价值99元的e读版电子书+在线编程环境',
        '[美]史蒂芬・普拉达（Stephen Prata）', 0, 'http://img3m8.ddimg.cn/74/7/28518608-1_b_15.jpg', 5400, 10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++高性能编程 本书涉及C++高性能编程的5个重要因素，包括计算硬件、高效使用编程语言、编译器、良好的设计和程序员自身。', '[美]费多尔・G.皮克斯 著 刘鹏 译', 0,
        'http://img3m9.ddimg.cn/98/2/29499029-1_b_1.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus 第6版 中文版习题解答 经典畅销图书《C++ Primer Plus（第6版）中文版》的学习伴侣，北京师范大学名师详细剖析所有题目，全面提升C++编程能力的优选编程练习册',
        '[美] 史蒂芬', 0, 'http://img3m7.ddimg.cn/59/15/28968647-1_b_7.jpg', 4450, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C C++代码调试的艺术 全面剖析C/C++代码的调试技巧与方法，注重理论与实战，所选示例通俗易懂，提供源代码', '张海洋', 0,
        'http://img3m5.ddimg.cn/41/25/29196725-1_b_3.jpg', 6730, 8980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20高级编程 详解C++20的概念约束 协程 Ranges 模块等新特征 重点讲述库 框架开发的高级编程技术', '罗能', 0,
        'http://img3m1.ddimg.cn/63/13/29421081-1_b_4.jpg', 7520, 10900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第12版) Microsoft MVP - Christian Nagel C#新作，内部专家的C#指南，为你带来关于新特性的高级提示。',
        '[奥]克里斯琴・内格尔(Chrisitian Nagel) 著 李铭译', 0, 'http://img3m1.ddimg.cn/29/7/29487971-1_b_4.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#高级编程(第11版) C# 7 & .NET Core 2.0 C#专家级指南，是经验丰富的程序员提高效率的更快捷方式！ 连续畅销20年，累计销售超30万册， 第11次全新升级，更新至C# 7 和 .NET Core 2.0， C# 7内幕指南。',
        '[美]克里斯琴・内格尔（Christian Nagel）著 李 铭 译', 0, 'http://img3m4.ddimg.cn/73/33/27852634-1_b_6.jpg', 14850, 19800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++编程入门 C++程序设计 零基础学C++ 极简C++自学案例视频教程教材 电脑编程 计算机书籍 c语言 C++项目', '杨国兴 编著', 0,
        'http://img3m6.ddimg.cn/35/32/29244536-1_b_8.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++算法从菜鸟到达人 涵盖所有程序员必须掌握的50余种算法，从易到难逐级提升，满足编程菜鸟向达人转变的一切需求', '猿媛之家 组编 郭晶晶 刘志全 楚秦 等编著', 0,
        'http://img3m1.ddimg.cn/10/24/29128681-1_b_11.jpg', 6830, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战（第2版） C++并发编程深度指南，C++标准委员会成员编写，囊括C++并发编程多个方面，代码附有中文注释简洁易懂，附赠配套代码文件。', '[英]安东尼', 0,
        'http://img3m7.ddimg.cn/61/29/29331187-1_b_6.jpg', 10480, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发手册：基础・案例・应用 轻松入门 ，快速进阶，上百个经典案例，快速提升实战能力！', '明日科技 编著', 0, 'http://img3m4.ddimg.cn/21/18/29369064-1_b_2.jpg',
        6400, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：Linux C++通信架构实战 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m8.ddimg.cn/73/13/29158048-1_b_8.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++实战笔记 C++20年老兵实战经验总结，精选C++实用特性，代码演示实战技巧，深入浅出讲解C++实战技能，分享开发心得和工作经验，帮助读者拓宽编程思路。', '罗剑锋', 0,
        'http://img3m1.ddimg.cn/30/1/29324721-1_b_2.jpg', 7480, 9980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('从C到C++精通面向对象编程 深入浅出地讲解C++的各个知识点、编程思想与核心技术', '曾凡锋 孙晶 肖珂 李源', 0,
        'http://img3m4.ddimg.cn/70/5/29478904-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#入门经典：更新至C# 9和.NET 5 掌握使用C# 9.0和.NET 5创建网站、服务和移动应用所需的所有技能。随书赠送学习资源，获取地址见书封底二维码。',
        '[英]马克・J.普赖斯(Mark J.Price) 著；叶伟民 译', 0, 'http://img3m2.ddimg.cn/38/24/29277902-1_b_8.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++程序设计竞赛真题实战特训教程（图解版）蓝桥杯官方备赛教程 蓝桥杯官方备赛指南！算法编程程序设计软件开发竞赛指导书，全栈指导拿分关键点，提供在线测评系统，并附赠例题源代码及PPT课件，实现精准备赛、有效刷题！',
        '蓝桥杯大赛组委会', 0, 'http://img3m7.ddimg.cn/60/8/29497407-1_b_7.jpg', 6280, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Easy C++（第5版）日系简洁系列书籍 wpf c语言程序设计教材 c++ primer plus 数据结构与算法分 日本经典C++图书 c++程序设计经典教程 4次改版，持续畅销20年，日本全国学校图书馆协会选定图书 187个图形图示+131段示例代码解析+44道课后练习 涵盖编程基础、软件开发核心技术、编程思想',
        '高桥麻奈', 0, 'http://img3m7.ddimg.cn/6/5/29362317-1_b_4.jpg', 4990, 9990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('【领券立减100】C语言入门到精通+Python从入门到精通编程入门全2册 零基础自学从入门到实战数据分析程序爬虫精通教', '许东平，王博 著', 0,
        'http://img3m3.ddimg.cn/38/11/11081805113-1_b_1.jpg', 14780, 19600);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到精通（全新版实用教程）', '许东平', 0, 'http://img3m5.ddimg.cn/57/4/29226045-1_b_3.jpg', 3140, 9800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战(第2版) 人民邮电出版社 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！', '(英)安东尼・威廉姆斯', 0,
        'http://img3m7.ddimg.cn/6/28/593042577-1_b_9.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer中文版 第5版 C++编程从入门到精通C++11标准 C++经典教程语言程序设计软件计算机开发书籍c 新华书店正版，关注店铺成为会员可享店铺专属优惠，团购客户请咨询在线客服！',
        '(美)李普曼(Lippman,S.B.),(美)拉乔伊(Lajoie,J.),(', 0, 'http://img3m6.ddimg.cn/97/14/1155358906-1_b_48.jpg', 6400,
        12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++并发编程实战 第2版 多线程编程深度指南 C++语言编程自学 C++**计算机程序设计入门教程 官方正版 出版社直发', '安东尼・威廉姆斯', 0,
        'http://img3m8.ddimg.cn/29/3/595988048-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++ Primer Plus中文版第六6版 C++程序设计从入门到*通 零基础自学C++编程语言教 官方正版 出版社直发', '[美] 史蒂芬・普拉达（Stephen Prata）', 0,
        'http://img3m5.ddimg.cn/3/6/1666691535-1_b_4.jpg', 5900, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C#（全彩版） 10万读者认可的编程图书，零基础自学编程的入门图书，由浅入深，循序渐进，助您轻松领会C#程序开发精髓，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m9.ddimg.cn/46/5/28486009-1_b_46.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('零基础学C语言（全彩版）C语言入门经典教程 双系统；双开发环境（VisualStudio和VisualC++6.0）;15小时视频；168个实例；168个练一练；从基础知识到完整项目！',
        '明日科技(Mingri Soft)', 0, 'http://img3m7.ddimg.cn/44/3/28486007-1_b_70.jpg', 3490, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：设计模式 本书将以一个实际的游戏案例贯穿始终，针对每个设计模式都会举出一到多个来自于实践并且有针对性的范例。阅读本书读者可以学到两方面知识：①某个设计模式对应的代码怎样编写；②该设计模式解决了什么样的问题。这两',
        '王健伟', 0, 'http://img3m5.ddimg.cn/92/16/29446355-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Qt 6 C++开发指南 基于Qt 6.2版本，《Qt 5.9 C++开发指南》版本内容重大升级，涵盖新的功能模块和开发技术，附赠大量示例演示程序和示例源代码，轻松开发GUI程序！', '王维波', 0,
        'http://img3m7.ddimg.cn/48/5/29511057-1_b_2.jpg', 6990, 13980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：模板与泛型编程 C++在线课程 C++完美自学教程！二十年磨一剑：新高度、新方法、新经典', '王健伟', 0,
        'http://img3m4.ddimg.cn/24/19/29394114-1_b_4.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言精彩编程200例（全彩版） 涵盖C语言开发相关的200个实例，包含常用算法、指针与链表操作、文件操作、系统相关、图形图像、游戏开发等方面的内容。超强的实用性，快速提升C语言开发技能',
        '明日科技(Mingri Soft)', 0, 'http://img3m4.ddimg.cn/51/10/28486014-1_b_17.jpg', 3990, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++新经典：对象模型 C++在线课程*教材！二十年磨一剑，好评如潮，C++新高度、新方法、新经典！', '王健伟', 0,
        'http://img3m7.ddimg.cn/4/31/28975027-1_b_7.jpg', 5920, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言典藏版套装（套装共2册 讲义+习题解答） 本套装含《C程序设计语言（第2版新版）（典藏版）》及配套《习题解答》各1册。C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4。',
        '[美]布莱恩? W.克尼汉，丹尼斯? M.里奇，克洛维斯? L.汤多，斯科特? E.吉姆佩尔 著', 0, 'http://img3m5.ddimg.cn/32/36/28481045-1_b_9.jpg', 8100,
        10800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++嵌入式开发实例精解 利用C++语言构建高效的嵌入式程序！', '[美]艾格尔・威亚契克 著 刘?J 译', 0, 'http://img3m9.ddimg.cn/9/4/29430729-1_b_5.jpg',
        8920, 11900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++20实践入门（第6版） C++入门从Beginning C++20开始，讲解如何使用新推出的C++20编写程序',
        '[比] 艾弗・霍尔顿(Ivor Horton)，彼得・范・维尔特(Peter Van Weert) 著 周百顺 译', 0,
        'http://img3m4.ddimg.cn/78/13/29383674-1_b_5.jpg', 11850, 15800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('小学生C++趣味编程（第二版） 全新升级！全彩印刷，还原真实编程环境；视频讲解，培养自主学习能力。', '潘洪波', 0,
        'http://img3m9.ddimg.cn/81/30/29490399-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('高级C/C++编译技术（典藏版） 多维度讲解多任务操作系统中编译、链接、装载与库的内幕与技术细节，为深入理解和掌握系统底层技术提供参考', '米兰・斯特瓦诺维奇（Milan Stevanovic）', 0,
        'http://img3m9.ddimg.cn/45/3/29496699-1_b_5.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#完全自学教程 一本让初学者通过案例项目实战开发入门C#语言的书，81个实例教学，22小时视频教程，提供源码、视频课程、课后练习题等配套资源', '明日科技', 0,
        'http://img3m3.ddimg.cn/98/3/29459033-1_b_3.jpg', 6310, 7990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('现代C++语言核心特性解析 C++核心特性精讲，理论实践相结合，由浅入深探讨 C++11到 C++20新增核心特性，C++语言进阶版教程，附赠同步语音讲解、PPT、示例代码。', '谢丙��', 0,
        'http://img3m3.ddimg.cn/59/14/29301683-1_b_5.jpg', 8990, 11990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C/C++函数与算法速查宝典 本书系统地讲解了C和C++中的常用函数及算法，结构清晰、范例具体、讲解详细，是一本内容丰富的案头工具书，内容通俗易懂，初学者也能轻松理解', '陈锐', 0,
        'http://img3m7.ddimg.cn/88/16/29469517-1_b_2.jpg', 7100, 8990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C程序设计语言（原书第2版・新版）典藏版 C语言之父&图灵奖得主作品，K&R的TCPL新版典藏版，豆瓣评分9.4，全球数千万程序员学习C语言的选择。让你从语言设计者的角度理解C语言。',
        '[美]布莱恩・克尼汉(Brian W. Kernighan),丹尼斯・里奇(Dennis', 0, 'http://img3m6.ddimg.cn/31/29/27849226-1_b_8.jpg', 5460,
        6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C++语言的设计和演化 C++语言之父经典著作、思想集锦，一本描述C++语言的发展历史、设计理念及技术细节的综合性著作，裘宗燕译', '[美]本贾尼・斯特劳斯特卢普 ( Bjarne Stroustrup )', 0,
        'http://img3m0.ddimg.cn/59/17/29126750-1_b_2.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言从入门到项目实践（全彩版） 从入门学习者的角度出发，通过简洁有趣的语言、丰富多彩的实例、挑战大脑的任务、贴近开发实战的项目', '明日科技 周佳星 李菁菁', 0,
        'http://img3m3.ddimg.cn/33/4/29225823-1_b_25.jpg', 2430, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#函数式编程 编写更优质的C#代码', '[美] 恩里科・博南诺（Enrico，Buonanno）著', 0, 'http://img3m1.ddimg.cn/30/32/29300961-1_b_1.jpg',
        9600, 12800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言入门经典（第6版） C语言入门从Beginning C开始！著名作家lvor Horton和编程专家German Gonzalez -Morris联袂奉献。',
        '[智利] 杰曼・冈萨雷斯・莫里斯（German Gonzalez-Morris）、[英]艾弗・霍顿（Ivor Horton）著 童晶、李天', 0,
        'http://img3m4.ddimg.cn/49/29/29353054-1_b_3.jpg', 10420, 13900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C语言程序设计 现代方法 第2版・修订版 C语言入门零基础自学教程新升级，增加C1X相关内容，讲述C的所有特性，国外诸多名校的C语言课程教材，C开发人员的参考书。', '[美]K.N.金（K.N.King）', 0,
        'http://img3m1.ddimg.cn/81/17/29270421-1_b_6.jpg', 9730, 12980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('玩转C语言程序设计（全彩版） 10万读者认可的编程图书，知识点贴近生活通俗易懂，引领读者快速入门，配同步视频教程和源代码，海量资源免费赠送', '明日科技(Mingri Soft)', 0,
        'http://img3m1.ddimg.cn/58/17/28486021-1_b_19.jpg', 3429, 4980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('C#开发实战1200例（第Ⅰ卷）', '王小科 王军 等编著', 0, 'http://img3m9.ddimg.cn/75/18/29254179-1_b_1.jpg', 11100, 14800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深入浅出Docker Docker技术入门与实践指南教程 容器与容器云解析 帮助您快速建立Docker技术知识体系 Docker认证工程师实用指南', '[英] Nigel Poulton', 0,
        'http://img3m6.ddimg.cn/70/2/26917576-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker实战派――容器入门七步法 Vue.js/Kafka/Dubbo/Redis/SpringBoot/Go语言/Django/自动化测试/Jenkins/Kubernetes/Istio', '王嘉涛', 0,
        'http://img3m9.ddimg.cn/13/14/29388559-1_b_2.jpg', 8850, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker+Kubernetes容器实战派 Springboot、Springcloud、Django、Harbor、Jenkins、Consul、ELK、Nginx、Tomcat、Jenkins', '赵渝强', 0,
        'http://img3m6.ddimg.cn/80/13/29412386-1_b_4.jpg', 8850, 11800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker实战(第2版) 升级软件和实现架构虚拟化的案头书，一书掌握从开发和测试机器到实现全面云部署的各种技术。',
        '[美]杰夫・尼克罗夫(Jeff Nickoloff),[美]斯蒂芬・库恩斯利(Stephen Kuenzli) 著；耿苏宁译', 0,
        'http://img3m3.ddimg.cn/80/25/29236463-1_b_3.jpg', 7980, 7980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker 容器与容器云 第2版 一本书讲透Docker和Kubernetes！从内核知识到容器原理，容器云技术深度揭秘！全面理解Docker源码实现与高级使用技巧、深入解读Kubernetes源码分析和实践',
        '浙江大学SEL实验室', 0, 'http://img3m9.ddimg.cn/53/19/24048539-1_b_8.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker技术入门与实战 第3版 入门Docker的首本书，系统化掌握容器技术栈', '杨保华 戴王剑 曹亚仑', 0,
        'http://img3m3.ddimg.cn/10/28/25349653-1_b_2.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker与Kubernetes容器虚拟化技术与应用 围绕容器生态体系核心组件Docker与Kubernetes展开，赠送教学大纲、教学PPT课件、实验手册、习题和试卷、授课视频。',
        '倪振松 刘宏嘉 陈建平 主编 谢岳富 副主编', 0, 'http://img3m3.ddimg.cn/33/17/29497083-1_b_1.jpg', 5230, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('深入浅出Docker Docker 技术入门与实践指南入门手册技术学习指南图书籍容器与容器云工程师实用指南 官方正版 出版社直发', '[英] Nigel Poulton（奈吉尔・波尔顿）', 0,
        'http://img3m6.ddimg.cn/49/33/1351103836-1_b_1.jpg', 3450, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Docker技术入门与实战 第3版 限购|8052127', '杨保华 戴王剑 曹亚仑', 0, 'http://img3m5.ddimg.cn/72/16/1518095475-1_b_1.jpg', 6230,
        8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker 容器与容器云（第2版）IT源码解读软件工程云计算 Kubernetes 官方正版 出版社直发', '浙江大学SEL实验室', 0,
        'http://img3m7.ddimg.cn/11/34/1229987297-1_b_1.jpg', 6675, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker技术入门与实战 杨保华,戴王剑,曹亚仑 著 机械工业出版社，【正版保证】 全国三仓发货，物流便捷，下单秒杀，欢迎选购！', '杨保华,戴王剑,曹亚仑 著', 0,
        'http://img3m1.ddimg.cn/25/23/11233138381-1_b_1.jpg', 1889, 4337);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker+Kubernetes容器实战派【出版集团自营】 全店电子发票', '赵渝强', 0, 'http://img3m2.ddimg.cn/7/33/11251392082-1_b_1.jpg', 6900,
        12810);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('KVM+Docker+OpenStack实战――虚拟化与云计算配置、管理与运维（微课视频版） 本书全面反映现在*的开源技术，包括传统虚拟化技术KVM、轻量虚拟化技术Docker、云计算技术OpenStack，里面既介绍了相关技术的原理、也有大量的实践，让学生动手去体验*技术，从而获取*的',
        '王金恒、刘卓华、王煜林、钱宏武', 0, 'http://img3m8.ddimg.cn/42/4/29160888-1_b_2.jpg', 3729, 4980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('从Docker到Kubernetes入门与实战 世界上主要的云服务商和IT供应商都选择了Docker和K8s。所有运维人员都要理解Docker，学会K8s。', '罗利民', 0,
        'http://img3m8.ddimg.cn/38/17/27938828-1_b_2.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker+Kubernetes应用开发与快速上云 Docker+Kubernetes应用开发', '李文强', 0, 'http://img3m8.ddimg.cn/42/20/28528278-1_b_3.jpg',
        5450, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('CKA/CKAD应试指南：从Docker到Kubernetes完全攻略 官方作序推荐材：一本书剖析CKA/CKAD两门考试所有要点、难点，实操“模拟考场+上机+考题+答案详解”，轻松过关取证！', '段超飞', 0,
        'http://img3m3.ddimg.cn/2/19/29287073-1_b_16.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('第一本Docker书 修订版 Docker技术入门与实战 基于Docker 1.9及以上版本 Docker公司前副总裁力作的Docker技术图书', '[澳] 詹姆斯・特恩布尔（James Turnbull）', 0,
        'http://img3m3.ddimg.cn/77/16/23941643-1_b_15.jpg', 4420, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('基于Docker的Redis入门与实战 分布式缓存组件Redis的基本语法、核心技术和实战技能', '金华,胡书敏', 0,
        'http://img3m2.ddimg.cn/80/33/29279132-1_b_6.jpg', 5450, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('第一本Docker书 修订版 现代企业数字化转型 官方正版 出版社直发', '詹姆斯・特恩布尔', 0, 'http://img3m7.ddimg.cn/79/33/1229875297-1_b_1.jpg', 4602,
        5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Kubernetes权威指南：从Docker到Kubernetes实践全接触（第5版） 人手一本、内容超详尽的Kubernetes权威指南全新升级至K8s 1.19，提供源码下载、勘误及读者群答疑，CNCF、阿里巴巴、华为、腾讯、字节跳动、VMware众咖力荐，学、用K8s的神器',
        '龚正 等', 0, 'http://img3m0.ddimg.cn/42/20/29238900-1_b_6.jpg', 17980, 23980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器与虚拟化技术（云计算工程师系列）', '肖睿 著', 0, 'http://img3m6.ddimg.cn/98/31/25141346-1_b_1.jpg', 1950, 3900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker实践 第2版 深入浅出Docker源码分析，畅销容器与容器云实践教程升级版，基于Docker1.13，114个实战技巧，帮助读者解决Docker的应用问题，实现持续集成交付，并提供源代码。',
        '[英]伊恩・米尔（Ian Miell）', 0, 'http://img3m5.ddimg.cn/19/21/29136115-1_b_3.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker数据中心及其内核技术 Docker大数据，200多个工程实例，让读者快速提高核心竞争力', '马献章', 0,
        'http://img3m5.ddimg.cn/18/22/28473705-1_b_6.jpg', 7420, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker实践 *2版 容器管理DevOps流水线Kubernetes*威指南微服务架构1.13', '[英]伊恩・米尔（Ian Miell）', 0,
        'http://img3m5.ddimg.cn/6/31/1760950725-1_b_1.jpg', 7720, 9900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('[图书]Docker进阶与实战|4907510', '华为Docker实践小组', 0, 'http://img3m6.ddimg.cn/38/33/1373407436-1_b_1.jpg', 7900, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker开发实践', '曾金龙 肖新华 刘清', 0, 'http://img3m7.ddimg.cn/34/20/1231741897-1_b_1.jpg', 4602, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker即学即用（第二版）', 'Sean P.Kane，Karl Matthias', 0, 'http://img3m3.ddimg.cn/74/36/27919163-1_b_2.jpg', 3700,
        8800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 Docker源码分析[按需印刷]|4731470', '孙宏亮', 0, 'http://img3m6.ddimg.cn/62/2/1373013836-1_b_1.jpg', 5900, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 基于Docker的Redis入门与实战|8082548', '金华 胡书敏', 0, 'http://img3m2.ddimg.cn/51/25/677907402-1_b_1.jpg', 5530, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Kubernetes修炼手册 深入浅出docker作者新作 技术精讲秘笈云计算教程书籍 官方正版 出版社直发', '奈吉尔・波尔顿', 0,
        'http://img3m2.ddimg.cn/91/35/624382102-1_b_2.jpg', 5450, 6990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]基于Docker的Redis入门与实战+Redis 5设计与源码|8082634', '金华 胡书敏 陈雷 内封：陈雷 方波 黄桃 李乐 施洪宝 熊浩含 闫昌 张仕华', 0,
        'http://img3m2.ddimg.cn/75/29/678934452-1_b_1.jpg', 14824, 21800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]基于Docker的Redis入门与实战+Redis使用手册（2册|8082635', '金华 胡书敏 黄健宏', 0,
        'http://img3m2.ddimg.cn/85/2/678934462-1_b_2.jpg', 14824, 21800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]基于Docker的Redis入门与实战+Docker技术入门与实|8082631', '金华 胡书敏 杨保华 戴王剑 曹亚仑', 0,
        'http://img3m2.ddimg.cn/35/26/678934412-1_b_1.jpg', 11424, 16800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]基于Docker的Redis入门与实战+Docker从入门到实战|8082632', '金华 胡书敏 黄靖钧', 0,
        'http://img3m2.ddimg.cn/45/36/678934422-1_b_1.jpg', 10064, 14800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('包邮 [套装书]基于Docker的Redis入门与实战+Redis设计与实现（2|8082633', '金华 胡书敏 黄健宏', 0,
        'http://img3m2.ddimg.cn/65/19/678934442-1_b_1.jpg', 10744, 15800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Kubernetes从入门到实践 系统开发运维书籍 Kubernetes*威指南 Docker技术', '赵卓', 0,
        'http://img3m5.ddimg.cn/86/20/1655389085-1_b_1.jpg', 6160, 7900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Kubernetes快速入门 深入浅出Docker作者新作Kubernetes修炼手册云计算操作系统', '奈吉尔・波尔顿', 0,
        'http://img3m4.ddimg.cn/73/4/11068935544-1_b_1.jpg', 4600, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('（预售）虚拟化高性能NoSQL存储案例精粹 Redis Docker NoSQL数据库入门与实践Redis设计实战', '高洪岩', 0,
        'http://img3m0.ddimg.cn/84/1/1887991860-1_b_2.jpg', 13100, 16800);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器技术与运维', '李树峰 钟小平', 0, 'http://img3m8.ddimg.cn/42/19/1896104868-1_b_1.jpg', 5440, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('微服务实战 微服务架构设计实践教程书籍 微服务与容器部署开发运维指南Docker Kubernete', '[英]摩根・布鲁斯（Morgan Bruce） 保罗・A.佩雷拉（Paulo A', 0,
        'http://img3m5.ddimg.cn/12/25/1607306295-1_b_1.jpg', 6940, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('容器云运维实战――Docker与Kubernetes集群 囊括容器云的主流运维开发生态，详细讲解基于容器云的集群运维解决方案', '黄靖钧', 0,
        'http://img3m7.ddimg.cn/60/2/26909547-1_b_2.jpg', 6670, 8900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器管理与应用项目教程', '吴进 杨运强', 0, 'http://img3m1.ddimg.cn/86/2/29429321-1_b_3.jpg', 5900, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器技术与应用项目教程（微课版）', '崔升广', 0, 'http://img3m1.ddimg.cn/93/21/29370621-1_b_1.jpg', 5980, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('如何启动黄金圈思维 苹果和微软都在用的“思维模型” 排名第3的TED演讲人、2019年排名第11的全球商业思想家西蒙?斯涅克重磅新书 张瑞敏、毛大庆、杨壮、康志军、孙贺影联袂推荐',
        '[英]西蒙?斯涅克(Simon Sinek)戴维?米德（David Mead） 彼得?多克尔（Peter Docker） 著 石雨晴 译 湛庐文', 0,
        'http://img3m3.ddimg.cn/40/10/28492933-1_b_3.jpg', 5640, 7990);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器技术 配置、部署与应用', '戴远泉，王勇，钟小平', 0, 'http://img3m6.ddimg.cn/50/32/29166836-1_b_6.jpg', 5980, 5980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker虚拟化技术入门与实战', '天津滨海迅腾科技集团有限公司 编', 0, 'http://img3m8.ddimg.cn/77/22/27939758-1_b_2.jpg', 4070, 5900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker容器技术与运维', '李树峰 钟小平', 0, 'http://img3m0.ddimg.cn/91/3/29223010-1_b_6.jpg', 6980, 6980);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker微服务架构实战 深入解析微服务、容器技术、Service Mesh原理，帮助读者快速建立微服务生态圈的全局知识体系', '蒋彪', 0,
        'http://img3m8.ddimg.cn/88/8/25580698-1_b_3.jpg', 5170, 6900);
insert into book (title, author, sales, covers, price, orgPrice)
VALUES ('Docker全攻略', '张涛 编著', 0, 'http://img3m7.ddimg.cn/38/30/23935367-1_b_11.jpg', 6670, 8900);




