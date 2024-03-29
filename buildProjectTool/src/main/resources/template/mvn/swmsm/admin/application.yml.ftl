# application.yml


spring:
profiles:
active: dev
application:
name: ${projectName}
datasource:
type: com.alibaba.druid.pool.DruidDataSource
druid:
# 设置访问druid监控页的账号和密码,默认没有
stat-view-servlet:
login-username: admin
login-password: admin

# 配置扩展插件,配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙
filters: stat,wall
# 通过connectProperties属性来打开mergeSql功能；慢SQL记录
connection-properties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000
# 合并多个DruidDataSource的监控数据
use-global-data-source-stat: true

# 连接池配置
#连接池建立时创建的初始化连接数
initial-size: 5
#连接池中最大的活跃连接数
max-active: 20
#连接池中最小的活跃连接数
min-idle: 5
#获取连接时最大等待时间，单位毫秒
max-wait: 60000
# 打开PSCache，并且指定每个连接上PSCache的大小
pool-prepared-statements: true
max-open-prepared-statements: 20

#在空闲连接回收器线程运行期间休眠的时间值,以毫秒为单位，一般比minEvictableIdleTimeMillis小
time-between-eviction-runs-millis: 60000
#连接池中连接，在时间段内一直空闲，被逐出连接池的时间(1000*60*60)，以毫秒为单位
min-evictable-idle-time-millis: 300000

# 连接有效性检测
#是否在连接空闲一段时间后检测其可用性
test-while-idle: true
#是否在获得连接后检测其可用性
test-on-borrow: false
#是否在连接放回连接池后检测其可用性
test-on-return: false
#mysql中为 select 'x'
#oracle中为 select 1 from dual
validation-query: SELECT 'x'

mybatis:
configuration:
map-underscore-to-camel-case: true
mapper-locations: mybatis/**/*Mapper.xml
typeAliasesPackage: ${basePackageName}.${projectName}.**.entity


