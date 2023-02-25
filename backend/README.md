# 后端配置说明

+ 数据库：Mysql, MongoDB
+ 内存数据库/缓存：Redis
+ 全文搜索：Elasticsearch

## 环境

+ Mysql
+ MongoDb
+ Redis
+ Elasticsearch 8.6.1

### Elasticsearch(8.6.1) 在 Windows 下的安装和配置

+ 生成证书

    在 `bin` 目录下找到工具 `elasticsearch-certgen.bat`，按照步骤生成证书即可。
    生成的证书位于 `config/certs` 目录之下，将 `http_ca.crt` 文件复制到本项目的
    `cert` 目录下即可。
    
+ 修改密码

    在 `bin` 目录下找到工具 `elasticsearch-setup-passwords.bat`，输入：

    ```bash
    elasticsearch-setup-passwords.bat interactive  
    ```
  
    即可按照步骤进行密码修改。

+ 中文分词

  由于兼容性问题，必须下载和 Elasticsearch 相同版本的 [IK 分词器]( https://github.com/medcl/elasticsearch-analysis-ik )。

  下载完成后，将解压的文件夹放入 `plugin` 目录下即可。