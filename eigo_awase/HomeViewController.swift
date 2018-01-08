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

    // アニメーションのviewを生成
        let MelonAni = LOTAnimationView(name: "Watermelon.json")
        let HeliAni = LOTAnimationView(name: "helicopter.json")
        let CloudAni = LOTAnimationView(name: "cloud.json")
        let StarAni = LOTAnimationView(name: "star.json")
        let FlightAni = LOTAnimationView(name: "flight_icon_interaction.json")
        //配置とサイズ
        MelonAni.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2.5, height: view.bounds.height/2)
        HeliAni.frame = CGRect(x: view.bounds.width-120, y: 0, width: view.bounds.width/2.8, height: view.bounds.height/5)
        CloudAni.frame = CGRect(x: view.bounds.width-100, y: 170, width: view.bounds.width/4, height: view.bounds.height/7)
        StarAni.frame = CGRect(x: view.bounds.width-100, y: view.bounds.height-100, width: view.bounds.width/4, height: view.bounds.height/7)
        FlightAni.frame = CGRect(x: 0, y: view.bounds.height-60, width: view.bounds.width, height: view.bounds.height/20)
        MelonAni.contentMode = .scaleAspectFit
        HeliAni.contentMode = .scaleAspectFit
        CloudAni.contentMode = .scaleAspectFit
        StarAni.contentMode = .scaleAspectFit
        FlightAni.contentMode = .scaleAspectFill
        //動作
        MelonAni.loopAnimation = true
        HeliAni.loopAnimation = true
        CloudAni.loopAnimation = true
        StarAni.loopAnimation = true
        FlightAni.loopAnimation = true
        FlightAni.animationSpeed = 0.7
        //Add view
        self.view.addSubview(MelonAni)
        self.view.addSubview(HeliAni)
        self.view.addSubview(CloudAni)
        self.view.addSubview(StarAni)
        self.view.addSubview(FlightAni)
        // アニメーションを開始
        MelonAni.play()
        HeliAni.play()
        CloudAni.play()
        StarAni.play()
        FlightAni.play()
        
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
