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
import GoogleMobileAds

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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //interstitial広告用
    // Interstitial AdMob ID を入れてください
    let AdMobID = "ca-app-pub-2571146153853390/9841155648"
    // Simulator ID
    let SIMULSTOR_ID = kGADSimulatorID
    // 実機テスト用 ID を入れる
    let DEVICE_TEST_ID = "aaaaaaaaaaaaaaaaa0123456789"
    let DeviceTest:Bool = false
    let SimulatorTest:Bool = true
    // delay sec
    let delayTime = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //BGMスタート
       
        BgmSound()
        
        //interstitial広告
        let interstitial = GADInterstitial(adUnitID: AdMobID)
        //interstitial.delegate = self
        let request = GADRequest()
        if(DeviceTest){
            request.testDevices = [DEVICE_TEST_ID]
        }
        else if SimulatorTest {
            request.testDevices = [SIMULSTOR_ID]
            print("AdMobシミュレーター")
        }
        else{
            // AdMob
            print("AdMob本番")
        }
        interstitial.load(request);
        if appDelegate.InterstitialFlug == false {
        }else{
            // 3秒間待たせる
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.showAdMob(interstitial: interstitial)
            }
        }
        
    // アニメーションのviewを生成
        let colud = LOTAnimationView(name: "cloud.json")
        colud.frame = CGRect(x: 0, y: 100, width: view.bounds.width/4.0, height: view.bounds.height/5)
        colud.contentMode = .scaleAspectFit
        colud.loopAnimation = true
        
        let sun = LOTAnimationView(name: "sun_burst_weather_icon.json")
        sun.frame = CGRect(x: view.bounds.width-120, y: 20, width: view.bounds.width/3, height: view.bounds.height/6)
        sun.contentMode = .scaleAspectFit
        sun.loopAnimation = true
        
        let Airplane = LOTAnimationView(name: "airplane.json")
        Airplane.frame = CGRect(x: view.bounds.width-120, y: 20, width: view.bounds.width/3, height: view.bounds.height/7)
        Airplane.loopAnimation = true
        Airplane.contentMode = .scaleAspectFit
        Airplane.animationSpeed = 0.3
        
        let WatermelonAni = LOTAnimationView(name: "Watermelon.json")
        WatermelonAni.frame = CGRect(x: 0, y: view.bounds.height-110, width: view.bounds.width/2, height: view.bounds.height/4)
        WatermelonAni.contentMode = .scaleAspectFit
        WatermelonAni.loopAnimation = true
        
        let WhaleAni = LOTAnimationView(name: "Whale.json")
        WhaleAni.frame = CGRect(x: view.bounds.width-100, y: view.bounds.height/4, width: view.bounds.width/5, height: view.bounds.height/4)
        WhaleAni.contentMode = .scaleAspectFill
        WhaleAni.loopAnimation = true
       
        //let CloudAni = LOTAnimationView(name: "cloud.json")
       // CloudAni.frame = CGRect(x: view.bounds.width-100, y: 170, width: view.bounds.width/4, height: view.bounds.height/7)
       // CloudAni.contentMode = .scaleAspectFit
        //CloudAni.loopAnimation = true
        
        
        //Add view
        self.view.addSubview(colud)
        self.view.addSubview(sun)
       // self.view.addSubview(CloudAni)
        self.view.addSubview(Airplane)
        self.view.addSubview(WatermelonAni)
        self.view.addSubview(WhaleAni)
        // アニメーションを開始
        colud.play()
        sun.play()
       // CloudAni.play()
        Airplane.play()
        WatermelonAni.play()
        WhaleAni.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.TitleAnimation()
        }
        startTimer()
    }
    
    @IBAction func FruitsBtn(_ sender: Any) {
        
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
    
    //インタースティシャル用
    func showAdMob(interstitial: GADInterstitial){
        if (interstitial.isReady)
        {
            interstitial.present(fromRootViewController: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //画面から非表示になる瞬間
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        StartSound()
        Bgm.stop()
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
