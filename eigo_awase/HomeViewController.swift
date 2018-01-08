//
//  HomeViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/01/06.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import Lottie
import Spring
import AVFoundation

class HomeViewController: UIViewController {
    @IBOutlet weak var TitleE: SpringImageView!
    @IBOutlet weak var TitleI: SpringImageView!
    @IBOutlet weak var TitleGo: SpringImageView!
    @IBOutlet weak var TitleA: SpringImageView!
    @IBOutlet weak var TitleWa: SpringImageView!
    @IBOutlet weak var TitleSe: SpringImageView!
    
    var timer:Timer?
    
    var StartEffect:AVAudioPlayer!
    var Bgm:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //BGMスタート
        BgmSound()
//        let bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        bg.image = UIImage(named: "SkyBg")
//        bg.layer.zPosition = -1
//        self.view.addSubview(bg)
        // アニメーションのviewを生成
        let animationView = LOTAnimationView(name: "Watermelon.json")
        // ViewControllerに配置
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2, height: view.bounds.height/2)
        //animationView.center = self.view.center
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFit
        self.view.addSubview(animationView)
        // アニメーションを開始
        animationView.play()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.TitleAnimation()
        }
        startTimer()
    }
    
    @IBAction func FruitsBtn(_ sender: Any) {
        StartSound()
        Bgm.stop()
    }
    

    @objc func  TitleAnimation(){
        TitleE.animation = "swing"
        TitleE.duration = 1.0
        TitleE.animate()
        TitleI.animation = "swing"
        TitleI.duration = 1.0
        TitleI.delay = 1.0
        TitleI.animate()
        TitleGo.animation = "swing"
        TitleGo.duration = 1.0
        TitleGo.delay = 2.0
        TitleGo.animate()
        TitleA.animation = "swing"
        TitleA.duration = 1.0
        TitleA.delay = 3.0
        TitleA.animate()
        TitleWa.animation = "swing"
        TitleWa.duration = 1.0
        TitleWa.delay = 4.0
        TitleWa.animate()
        TitleSe.animation = "wobble"
        TitleSe.duration = 1.0
        TitleSe.delay = 5.0
        TitleSe.force = 1.0
        TitleSe.animate()
        
    }
    
    func startTimer(){
        if timer == nil {
    // 5毎にTemporalEventを呼び出す
            timer = Timer.scheduledTimer(timeInterval: 12.0, target: self, selector:#selector(TitleAnimation), userInfo: nil,repeats: true)
        }
    }
    
    func BgmSound () {
        let path = Bundle.main.bundleURL.appendingPathComponent("retrogamecenter2.mp3")
        do{
            try Bgm = AVAudioPlayer(contentsOf: path)
            Bgm.numberOfLoops = -1
            Bgm.play()
        }catch{
            print("エラーです")
        }
    }
    func StartSound () {
        let path = Bundle.main.bundleURL.appendingPathComponent("save-02.wav")
        do{
            try StartEffect = AVAudioPlayer(contentsOf: path)
            StartEffect.play()
        }catch{
            print("エラーです")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
