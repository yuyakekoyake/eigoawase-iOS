//
//  HomeViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/01/06.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAnalytics
import GoogleMobileAds
import RandomKit
import SwiftRater
import Lottie
import Spring
import IBAnimatable

class HomeViewController: UIViewController, GADInterstitialDelegate {
    @IBOutlet weak var TitleE: SpringImageView!
    @IBOutlet weak var TitleI: SpringImageView!
    @IBOutlet weak var TitleGo: SpringImageView!
    @IBOutlet weak var TitleA: SpringImageView!
    @IBOutlet weak var TitleWa: SpringImageView!
    @IBOutlet weak var TitleSe: SpringImageView!
    
    @IBOutlet weak var StartBtn: AnimatableButton!
    @IBOutlet weak var RandomBtn: AnimatableButton!
    @IBOutlet weak var AnimalBtn: UIButton!
    @IBOutlet weak var RankingBtn: AnimatableButton!
    @IBOutlet weak var CreditBtn: AnimatableButton!
    
    var colud = LOTAnimationView()
    var sun = LOTAnimationView()
    var Airplane = LOTAnimationView()
    var WatermelonAni = LOTAnimationView()
    var WhaleAni = LOTAnimationView()
    
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
    
    @IBOutlet weak var CreditBtnBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //SwiftRater
        SwiftRater.check()
        
    //BGMスタート
        BgmSound()
        
    // autolayout
        StartBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        StartBtn.titleLabel?.minimumScaleFactor = 0.1
        RandomBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        RandomBtn.titleLabel?.minimumScaleFactor = 0.1
        AnimalBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        AnimalBtn.titleLabel?.minimumScaleFactor = 0.1
        RankingBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        RankingBtn.titleLabel?.minimumScaleFactor = 0.1
        CreditBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        CreditBtn.titleLabel?.minimumScaleFactor = 0.1
        
        //deviceSize
        switch view.frame.height {
        case 736:
            CreditBtnBottom.constant = 110
        case 568:
            break
        case 480:
            CreditBtnBottom.constant = 70
        default:
            break
        }
        
        
    //animation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.TitleAnimation()
        }
        startTimer()
        
    //interstitial広告
        let interstitial = GADInterstitial(adUnitID: AdMobID)
        interstitial.delegate = self
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
        
        //randam
        appDelegate.MondaiRandom = ["apple","orange","cherry","banana","grape","lemon","peach","melon","airplane","bicycle","boat","bus","car","rocket","ship","train","cat","dog","elephant","giraffe","horse","lion","pig","tiger","duck","fox","mouse","penguin","rabbit","squirrel","zebra","crocodile","baseball","basketball","bowling","football","golf","rugby","tennis","volleyball","bread","cake","candy","donut","egg","rice","tomato","rice ball","carrot","corn","eggplant","green pepper","mushroom","potato","broccoli","pumpkin","autumn","cloudy","rain","snow","spring","summer","sunny","winter","door","bed","chair","desk","window","clock","piano","camera","calculator","computer","eraser","notebook","pen","scissors","stapler","picture","red","green","blue","white","black","yellow","purple","grey"]
        appDelegate.MondaiRandom = appDelegate.MondaiRandom.shuffled(using: &Xoroshiro.default)
        print(appDelegate.MondaiRandom)
    }
    
    @IBAction func StartBtn(_ sender: Any) {
        StartBtn.animate(.zoom(way: .out))
        StartSound()
        Bgm.stop()
        self.performSegue(withIdentifier: "ToCategory", sender: nil)
    }
    
    @IBAction func RandomBtn(_ sender: Any) {
        RandomBtn.animate(.zoom(way: .out))
        StartSound()
        Bgm.stop()
        appDelegate.MondaiCategory = "ランダム"
    }
    
    @IBAction func Animal(_ sender: Any) {
        appDelegate.MondaiCategory = "どうぶつ"
        StartSound()
        Bgm.stop()
    }
    
    @IBAction func CreditBtn(_ sender: Any) {
        StartSound()
        Bgm.stop()
        CreditBtn.animate(.zoom(way: .out))
    }
    @IBAction func RankingBTN(_ sender: Any) {
        StartSound()
        Bgm.stop()
        RankingBtn.animate(.zoom(way: .out))
    }
    
    func LottieAnimation (){
        // アニメーションのviewを生成
        colud = LOTAnimationView(name: "cloud.json")
        colud.frame = CGRect(x: 0, y: 100, width: view.bounds.width/4.0, height: view.bounds.height/5)
        colud.contentMode = .scaleAspectFit
        colud.loopAnimation = true
        
        sun = LOTAnimationView(name: "sun_burst_weather_icon.json")
        sun.frame = CGRect(x: view.bounds.width-120, y: 20, width: view.bounds.width/3, height: view.bounds.height/6)
        sun.contentMode = .scaleAspectFit
        sun.loopAnimation = true
        
        Airplane = LOTAnimationView(name: "airplane.json")
        Airplane.frame = CGRect(x: view.bounds.width-120, y: 20, width: view.bounds.width/3, height: view.bounds.height/7)
        Airplane.loopAnimation = true
        Airplane.contentMode = .scaleAspectFit
        Airplane.animationSpeed = 0.3
        
        WatermelonAni = LOTAnimationView(name: "Watermelon.json")
        WatermelonAni.frame = CGRect(x: 0, y: view.bounds.height-110, width: view.bounds.width/2, height: view.bounds.height/4)
        WatermelonAni.contentMode = .scaleAspectFit
        WatermelonAni.loopAnimation = true
        
        WhaleAni = LOTAnimationView(name: "Whale.json")
        WhaleAni.frame = CGRect(x: view.bounds.width-100, y: view.bounds.height/4, width: view.bounds.width/5, height: view.bounds.height/4)
        WhaleAni.contentMode = .scaleAspectFill
        WhaleAni.loopAnimation = true
        
        //let CloudAni = LOTAnimationView(name: "cloud.json")
        // CloudAni.frame = CGRect(x: view.bounds.width-100, y: 170, width: view.bounds.width/4, height: view.bounds.height/7)
        // CloudAni.contentMode = .scaleAspectFit
        //CloudAni.loopAnimation = true
    //deviceSize
        switch view.frame.height {
        case 812:
            WhaleAni.frame = CGRect(x: view.bounds.width-200, y: view.bounds.height/4, width: view.bounds.width/1.5, height: view.bounds.height/4)
            WhaleAni.contentMode = .scaleAspectFit
            WatermelonAni.frame = CGRect(x: 0, y: view.bounds.height-160, width: view.bounds.width/2, height: view.bounds.height/4)
        case 736:
            WatermelonAni.frame = CGRect(x: 0, y: view.bounds.height-120, width: view.bounds.width/2, height: view.bounds.height/4)
        case 568: break
        case 480:
            WhaleAni.frame = CGRect(x: view.bounds.width-70, y: view.bounds.height/3, width: view.bounds.width/5, height: view.bounds.height/4)
            Airplane.frame = CGRect(x: view.bounds.width-100, y: 40, width: view.bounds.width/3, height: view.bounds.height/7)
            WatermelonAni.frame = CGRect(x: 0, y: view.bounds.height-80, width: view.bounds.width/2, height: view.bounds.height/4)
        default:
            break
        }
        
        
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
    }
    
    func AnimationStop () {
        colud.stop()
        sun.stop()
        Airplane.stop()
        WatermelonAni.stop()
        WhaleAni.stop()
        
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
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    // インタースティシャルが消えた直後
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        AnimationStop()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LottieAnimation()
        print("FirstViewControllerのviewDidAppearが呼ばれた")
    }
    //画面から非表示になる瞬間
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
