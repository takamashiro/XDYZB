//
//  RoomNormalViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/15.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
import IJKMediaFramework

class RoomNormalViewController: UIViewController {

    var room_id : Int = 0
    var backgroundImage : String = "" //封面背景
    var liveUrl : String = "" //直播流地址
    
    var player : IJKMediaPlayback! = nil
    var PlayerView : UIView = UIView()
    var url : URL? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        goPlaying()
        //installMovieNotificationObservers()
        //setupBackgroundImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        player.prepareToPlay()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.shutdown()
        navigationController?.setNavigationBarHidden(false , animated: true)
    }
    
    func setupBackgroundImage() {
        let width  = UIScreen.main.bounds.size.width;
        let length = UIScreen.main.bounds.size.height;
        let imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: length))
        let data = NSData(contentsOf: NSURL(string: backgroundImage) as! URL)
        imgView.image = UIImage(data: data as! Data)
        //加高斯模糊
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = imgView.bounds
        imgView.addSubview(visualEffectView)
        view.addSubview(imgView)
    }
    
    func goPlaying() {
        let tempLiveString = "rtmp://ams.studytv.cn/livepkgr/264"
        self.url = URL.init(string: tempLiveString)  //真实情况是使用liveUrl
         //初始化播放器，播放在线视频或直播（RTMP）
        let options = IJKFFOptions.byDefault()
        player = IJKFFMoviePlayerController(contentURL: url, with: options)
        //播放页面视图宽高自适应
        let playerview = player.view
        let displayerView = UIView(frame: view.bounds)
        
        PlayerView = displayerView
        view.addSubview(PlayerView)
        
        playerview?.frame = PlayerView.bounds
        let autoresize = UIViewAutoresizing.flexibleWidth.rawValue |
            UIViewAutoresizing.flexibleHeight.rawValue
        playerview?.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
        
        PlayerView.insertSubview(playerview!, at: 1)
        player.scalingMode = .aspectFit
    }
    
    func goBack(){
        player.shutdown()
        
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func play_btn(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if(!player.isPlaying()) {
            player.play()
        } else {
            player.pause()
        }
    }
    
    func installMovieNotificationObservers() {
        //NotificationCenter.default.addObserver(self, selector: #selector(loadStateDidChange), name: IJKMPMoviePlayerLoadStateDidChangeNotification, object: player)
    }
}

extension RoomShowViewController {
    func loadStateDidChange(notification:Notification) {
        //let loadState = player.
    }
}


