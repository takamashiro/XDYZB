# XDYZB

##环境：
Xcode 8 + Swift 3.0 <br/>
ios 9.0 <br/>
cocoaPods集成的第三方类库：<br/>
Alamofire (4.0.1) <br/>
Kingfisher (3.1.1) <br/>
MJRefresh<br/>
LFLiveKit #直播推流<br>



##如何使用
git clone 项目地址 <br/>
cd Podfile所在目录 <br/>
pod install <br/>
<br/><br/>
如果提示转换Alamofire 到swift3.0 允许，next,...就完成了。
<br/>
<br/>
分支说明：
master        -- 分支为“玩转【斗鱼直播APP】系列”视频系列进度<br/>
selfExplore2  -- 为提前视频进度完成的预先成品。<br/>
<br/>
PS:暂时一点点集成，壮大APP，尽力保证代码质量。本打算直播拉流使用DouYu直播rtmpUrl，悲剧发现他们加密了，找资料，以前有人破解出安卓端的，很快就换了加密算法，遗迹在此<br/>
auth值：room/522387?aid=ios&client_sys=ios&time=1478084400
md5(room/522387/?aid=android&clientsys=android&time="+1231) 
地址：http://430.io/-xie-dou-yu-tv-web-api-some-douyutv-api/
