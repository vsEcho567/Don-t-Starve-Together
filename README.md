 Don-t-Starve-Together 服务端构建脚本
=======================================

包含文件:
---------------------------------------
* build_master_environment.sh &emsp; 构建陆地的服务器环境<br>
* build_cave_environment.sh &emsp; 构建洞穴的服务器环境（未实现）<br>
* check_update.sh &emsp; 从steam服务器获取主程序的更新<br>
* run_Master_servers.sh &emsp; 运行陆地的服务器程序<br>
* modlist &emsp; 服务端需要开启的mods，在每次run_Master_servers.sh之前会检测该文件并自动从steam下载本地没有的mod<br>

注意：
-----
所有文件都不要使用windows自带的文本编辑器来编辑，建议使用notepa++或者vscode来编辑。<br>
（因为linux检测回车符号与windows自带文本编辑器不相同，linux为\n，windows一般为\r\n）<br>

modlist格式为：<br>
mod_id &emsp; （可选）说明文字<br>
mod_id &emsp; （可选）说明文字<br>

取得mod_id方法：打开steam商店相应mod页面，在地址栏上显示id=xxxxxxx这一串数字就是了。<br>


简单开启服务器方式：
-----------------
* 1.安装需要的库（根据不同发行版安装命令不同，服务器建议安装的发行版为debian8 32bit）<br>
	* 32位DEB系的发行版（debian ubuntu）安装命令：<br>
		* sudo apt-get install libstdc++6 libgcc1 libcurl4-gnutls-dev<br>
	* 64位DEB系的发行版（debian ubuntu）安装命令：  <br>
		* sudo apt-get install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386<br>
	* 32位RPM系的发行版（redhat centos）安装命令（两条命令）： <br>
		* sudo yum install libstdc++ glibc libcurl <br>
		* sudo ln -s /usr/lib/libcurl.so.4 /usr/lib/libcurl-gnutls.so.4<br>
	* 不建议用64位RPM系发行版来安装<br>
    
* 2.运行build_master_environment.sh <br>

* 3.编辑modlist修改需要的mod，在build_master_environment.sh文件开头修改服务器名和描述，密码和steamkey<br>

* 4.运行run_Master_servers.sh <br>

* 5.等待运行完成客户端登陆后即可搜索到服务器<br>

最后：
-----
由于服务器把陆地和洞穴都启动至少需要2G内存，对于1G内存服务器来说只能用两个服务器分别启动，所以分别使用了两个脚本来构建。<br>