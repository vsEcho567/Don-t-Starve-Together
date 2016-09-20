# Don-t-Starve-Together

build_master_environment.sh     构建陆地的服务器环境
build_cave_environment.sh       构建洞穴的服务器环境（暂未实现）
check_update.sh                 从steam服务器获取主程序的更新
run_Master_servers.sh           运行陆地的服务器程序
modlist                         服务端需要开启的mods，在每次run_Master_servers.sh之前会检测该文件并自动从steam下载本地没有的mod


注意：
所有文件都不要使用windows自带的文本编辑器来编辑，建议使用notepa++或者vscode来编辑。
（因为linux检测回车符号与windows自带文本编辑器不相同，linux为\n，windows一般为\r\n）

modlist格式为：
mod_id    （可选）说明文字
mod_id    （可选）说明文字

取得mod_id方法：打开steam商店相应mod页面，在地址栏上显示id=xxxxxxx这一串数字就是了。


简单开启服务器方式：
1.安装需要的库（根据不同发行版安装命令不同，服务器建议安装的发行版为debian8 32bit）
    32位DEB系的发行版（debian ubuntu）安装命令：  sudo apt-get install libstdc++6 libgcc1 libcurl4-gnutls-dev
    64位DEB系的发行版（debian ubuntu）安装命令：  sudo apt-get install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386
    32位RPM系的发行版（redhat centos）安装命令（两条命令）： sudo yum install libstdc++ glibc libcurl 
                                                         sudo ln -s /usr/lib/libcurl.so.4 /usr/lib/libcurl-gnutls.so.4
    不建议用64位RPM系发行版来安装
    
2.运行build_master_environment.sh 

3.编辑modlist修改需要的mod，在build_master_environment.sh文件开头修改服务器名和描述，密码和steamkey

4.运行run_Master_servers.sh 

5.等待运行完成客户端登陆后即可搜索到服务器

最后：
由于服务器把陆地和洞穴都启动至少需要2G内存，对于1G内存服务器来说只能用两个服务器分别启动，所以分别使用了两个脚本来构建。