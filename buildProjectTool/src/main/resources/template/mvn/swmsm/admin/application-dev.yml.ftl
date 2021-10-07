server:
session-timeout: 1800
port: ${serverPort}

spring:
cache:
type: redis
servlet:
multipart:
file-size-threshold: 30MB
thymeleaf:
mode: LEGACYHTML5
cache: false
jackson:
time-zone: GMT+8
date-format: yyyy-MM-dd HH:mm:ss
devtools:
restart:
enabled: true
datasource:
driver-class-name: ${driverClassName}
url: ${url}
username: ${username}
password: ${password}
initialSize: 1
minIdle: 3
maxActive: 20
# 配置获取连接等待超时的时间
maxWait: 60000
# 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
timeBetweenEvictionRunsMillis: 60000
# 配置一个连接在池中最小生存的时间，单位是毫秒
minEvictableIdleTimeMillis: 30000
validationQuery: select 'x'
testWhileIdle: true
testOnBorrow: false
testOnReturn: false
# 打开PSCache，并且指定每个连接上PSCache的大小
poolPreparedStatements: true
maxPoolPreparedStatementPerConnectionSize: 20
# 配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙
filters: stat,wall,slf4j
# 通过connectProperties属性来打开mergeSql功能；慢SQL记录
connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000
# 合并多个DruidDataSource的监控数据
druid:
test-on-borrow: true
# Redis配置
redis:
database: 0
# 连接超时时间（毫秒）
timeout: 10000
host: 127.0.0.1
password:
port: 6379
jedis:
pool:
# 连接池中的最大空闲连接
max-idle: 8
# 连接池中的最小空闲连接
min-idle: 10
# 连接池最大连接数（使用负值表示没有限制）
max-active: 100
# 连接池最大阻塞等待时间（使用负值表示没有限制）
max-wait: -1

## 缓存key前缀
cache:
key:
prefix: dev_


## 自定义配置
myconfig:
uploadPath: /tmp/uploaded_files/
username: test
password: 111111
logging:
level:
root: error
com.guyi: debug
