#基础镜像使用daocloud.io/library/mysql:8
FROM daocloud.io/library/mysql:8

#定义工作目录
ENV WORK_PATH /usr/local/work

#定义会被容器自动执行的目录
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

#定义sql文件名
ENV SQL_FILE db.sql

#定义shell文件名
ENV SETUP_SCRIPT mysql_setup.sh

RUN chmod 644 /etc/mysql/my.cnf

#创建文件夹
RUN mkdir -p $WORK_PATH

#把数据库初始化数据的文件复制到工作目录下
COPY ./$SQL_FILE $WORK_PATH/

#把要执行的shell文件放到/docker-entrypoint-initdb.d/目录下，容器会自动执行这个shell
COPY ./$SETUP_SCRIPT $AUTO_RUN_DIR/

#给执行文件增加可执行权限
RUN chmod a+x $AUTO_RUN_DIR/$SETUP_SCRIPT
