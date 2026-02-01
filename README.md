# PowerShell Tools for ANYTHING

## 使用 PowerShell 本身，或借助可使用命令行交互的第三方软件，进行各种规范化操作

### 待办事项🚩🚧✅🔧📂

| 对象 | 状态 | 方案 |
|---|---|---|
| Git | 🔧基本可用 | 对于已跟踪文件，根据 git log 给出的 author 时间，调整修改时间 |
| Zip | 🔧基本可用 | 根据 7-Zip 列出的压缩包内所有仅文件修改时间，调整压缩包本身的修改时间，规则参考自 Git |
| GitHub | 🔧基本可用 | 使用 GitHub CLI 从指定仓库获取 tagName 后批量下载指定名称的 Release Assets |
| Jpg | 🚧正在施工 | 使用 ExifTool 获取图片的实际拍摄时间，根据实际拍摄时间调整文件名 |
| Jpg | 🚧正在施工 | 使用 ExifTool 获取图片的各类信息，包括但不限于机型，拍摄参数，以及可以用于分辨该图片是否被编辑过的信息 |
| Iso | 🔧部分功能已实现 | 对于 Windows 安装镜像，计划使用 Mount-DiskImage 挂载镜像，使用 7-Zip 解析 install.wim/esd，获取该镜像的 Windows 版本信息以及可能存在的构建/修改日期，尝试调整文件名与修改日期 |
| Torrent | 📂新建文件夹 | 对于种子文件，计划尝试使用已有的 Torrent 客户端，以命令行形式调用并解析，根据解析结果调整文件名与修改日期，或者使用 PowerShell 直接解析文件本身 |
| Png | 📂新建文件夹 | 计划读取其文件头判断是否为 Png，根据文件尾的信息验证图片完整性 |
| Apk | 📂新建文件夹 | 计划使用 Android SDK 读取安装包中的 AndroidManifest.xml，根据获取到的信息调整文件名与修改日期 |
| Jar | 📂新建文件夹 | 对于 Minecraft Mods，计划使用 7-Zip 根据不同的加载器读取不同的模组信息，根据获取到的信息调整文件名与修改日期 |
| Jpg/Png | 📂新建文件夹 | 对于随机来源的图片，计划直接使用 PowerShell 计算出 MD5，然后使用该值命名文件，规则参考自 TencentQQ |
| HyperOS | 🔧部分功能已实现 | 通过特定的小米 API 获取官方渠道的线刷包与卡刷包 |