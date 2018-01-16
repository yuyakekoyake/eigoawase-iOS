//
//  ViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2017/12/12.
//  Copyright © 2017年 english-society. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie
import GoogleMobileAds
import RealmSwift

class ViewController: UIViewController, CardControlDelegate {

    var OpSound:AVAudioPlayer!
    var path = Bundle.main.bundleURL.appendingPathComponent("")
    var CrSound:AVAudioPlayer!
    var path2 = Bundle.main.bundleURL.appendingPathComponent("クイズ・正解.mp3")
    var WrSound:AVAudioPlayer!
    var path3 = Bundle.main.bundleURL.appendingPathComponent("blip03.mp3")
    var Bgm:AVAudioPlayer!
    
    var cards = [CardControl]()
    var cardSelected: CardControl?
    var canOpen = true
    
    var MondaiCount = 8
    
    //stopwatch
    var timer: Timer = Timer()
    var count: Int = 0
    
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var FinishBtn: UIButton!
    @IBOutlet weak var elapsedTime: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    
    //interstisialのフラグをONへ
        appDelegate.InterstitialFlug = true

    //realmのパス
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    //Bgm
        BgmSound()
        
    //banner adMob
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        //testID"ca-app-pub-3940256099942544/2934735716"
        //本番ID"ca-app-pub-2571146153853390/5479238805"
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    //countlabel
//        CountLabel.layer.shadowOpacity = 2.0
//        CountLabel.layer.shadowOffset = CGSize(width: 2,height: 2)
//        CountLabel.layer.cornerRadius = 5
//        CountLabel.layer.masksToBounds = true
        CountLabel.text = "のこり：\(MondaiCount)あわせ"
    //FinishBtn
        self.view.bringSubview(toFront: FinishBtn)
    //stopwatchi
        elapsedTime.layer.cornerRadius = 5
        elapsedTime.layer.shadowOpacity = 2.0
        elapsedTime.layer.shadowOffset = CGSize(width: 2,height: 2)
        elapsedTime.layer.masksToBounds = true
    //timerStart
        startTimer()
        var numArray = [Int]()
        for i in 0..<16 {
            numArray.append(i)
        }
        print(numArray)
        //var numArray: [String] = ["a", "b", "c", "d", "e", "f", "g", "h"]
        
        for i in 0..<16 {
            let idx = Int(arc4random_uniform(UInt32(numArray.count)))
            let card = CardControl(number: numArray[idx], frame: CGRect(x: 30 + (CardControl.sizeCard + 10) * (i % 4), y: 100 + (CardControl.sizeCard + 10) * (i / 4), width: CardControl.sizeCard, height: CardControl.sizeCard))
            card.delegate = self
            view.addSubview(card)
            cards.append(card)
            numArray.remove(at: idx)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Card Action
    func OnCardTapped(sender: CardControl) {
        if !canOpen {
            print("カードは現在めくれません")
            return
        }
        if sender.isOpen {
            print("カードは既に開いています")
        }
        else {
            let number = sender.OpenCard()!
            var AsrNum = 0
            switch number {
            case 0:
                AsrNum = 0
                path = Bundle.main.bundleURL.appendingPathComponent("apple.mp3")
            case 1:
                AsrNum = 1
                path = Bundle.main.bundleURL.appendingPathComponent("orange.mp3")
            case 2:
                AsrNum = 2
                path = Bundle.main.bundleURL.appendingPathComponent("cherry.mp3")
            case 3:
                AsrNum = 3
                path = Bundle.main.bundleURL.appendingPathComponent("banana.mp3")
            case 4:
                AsrNum = 4
                path = Bundle.main.bundleURL.appendingPathComponent("grape.mp3")
            case 5:
                AsrNum = 5
                path = Bundle.main.bundleURL.appendingPathComponent("lemon.mp3")
            case 6:
                AsrNum = 6
                path = Bundle.main.bundleURL.appendingPathComponent("peach.mp3")
            case 7:
                AsrNum = 7
                path = Bundle.main.bundleURL.appendingPathComponent("melon.mp3")
            case 8:
                AsrNum = 0
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 9:
                AsrNum = 1
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 10:
                AsrNum = 2
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 11:
                AsrNum = 3
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 12:
                AsrNum = 4
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 13:
                AsrNum = 5
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 14:
                AsrNum = 6
                path = Bundle.main.bundleURL.appendingPathComponent("")
            case 15:
                AsrNum = 7
                path = Bundle.main.bundleURL.appendingPathComponent("")
            default:
                print("Asrnumエラー")
            }
            
            if cardSelected == nil {
                cardSelected = sender
                Opensound ()
                print("1枚目のカードを開きました．: \(number)")
            }
            else {
                print("2枚目のカードを開きました．: \(number)")
                var AsrNum1 = 0
                switch cardSelected!.number {
                case 0:
                    AsrNum1 = 0
                    path = Bundle.main.bundleURL.appendingPathComponent("apple.mp3")
                case 1:
                    AsrNum1 = 1
                    path = Bundle.main.bundleURL.appendingPathComponent("orange.mp3")
                case 2:
                    AsrNum1 = 2
                    path = Bundle.main.bundleURL.appendingPathComponent("cherry.mp3")
                case 3:
                    AsrNum1 = 3
                    path = Bundle.main.bundleURL.appendingPathComponent("banana.mp3")
                case 4:
                    AsrNum1 = 4
                    path = Bundle.main.bundleURL.appendingPathComponent("grape.mp3")
                case 5:
                    AsrNum1 = 5
                    path = Bundle.main.bundleURL.appendingPathComponent("lemon.mp3")
                case 6:
                    AsrNum1 = 6
                    path = Bundle.main.bundleURL.appendingPathComponent("peach.mp3")
                case 7:
                    AsrNum1 = 7
                    path = Bundle.main.bundleURL.appendingPathComponent("melon.mp3")
                case 8:
                    AsrNum1 = 0
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 9:
                    AsrNum1 = 1
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 10:
                    AsrNum1 = 2
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 11:
                    AsrNum1 = 3
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 12:
                    AsrNum1 = 4
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 13:
                    AsrNum1 = 5
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 14:
                    AsrNum1 = 6
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 15:
                    AsrNum1 = 7
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                default:
                    print("Asrnum1エラー")
                }
                switch number {
                case 0:
                    path = Bundle.main.bundleURL.appendingPathComponent("apple.mp3")
                case 1:
                    path = Bundle.main.bundleURL.appendingPathComponent("orange.mp3")
                case 2:
                    path = Bundle.main.bundleURL.appendingPathComponent("cherry.mp3")
                case 3:
                    path = Bundle.main.bundleURL.appendingPathComponent("banana.mp3")
                case 4:
                    path = Bundle.main.bundleURL.appendingPathComponent("grape.mp3")
                case 5:
                    path = Bundle.main.bundleURL.appendingPathComponent("lemon.mp3")
                case 6:
                    path = Bundle.main.bundleURL.appendingPathComponent("peach.mp3")
                case 7:
                    path = Bundle.main.bundleURL.appendingPathComponent("melon.mp3")
                case 8:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 9:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 10:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 11:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 12:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 13:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 14:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                case 15:
                    path = Bundle.main.bundleURL.appendingPathComponent("")
                default:
                    print("Asrnum1エラー")
                }
                Opensound ()
                if AsrNum1 == AsrNum{
                    print("成功！")
                    CorrectSound()
                    MondaiCount -= 1
                    CountLabel.text = "のこり：\(MondaiCount)あわせ"
                    CorrectAnimation()
                    cardSelected?.DisableCard()
                    sender.DisableCard()
                    cardSelected = nil
                    for (_, obj) in cards.enumerated() {
                        if !obj.isOpen {
                            return
                        }
                    }
                    print("ALL CLEAR!!")
                    stopTimer()
                    SaveRanking()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.AllClearAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.performSegue(withIdentifier: "ToHome", sender: nil)
    
                        }
                    }
                }
                else {
                    print("失敗．．")
                    WrongSound()
                    WrongAnimation()
                    self.canOpen = false
                    DispatchQueue.global(qos: .userInitiated).async {
                        sleep(1)
                        DispatchQueue.main.async {
                            self.cardSelected?.CloseCard()
                            sender.CloseCard()
                            self.cardSelected = nil
                            self.canOpen = true
                        }
                    }
                }
            }
        }
    }
    //opensound
    func Opensound () {
        do{
            try OpSound = AVAudioPlayer(contentsOf: path)
            print("鳴りました")
            OpSound.volume = 5.0
            OpSound.play()
        }catch{
            print("エラーです")
        }
    }
    //correctsound
    func CorrectSound () {
        do{
            try CrSound = AVAudioPlayer(contentsOf: path2)
            print("鳴りました")
            CrSound.volume = 2.0
            CrSound.play()
        }catch{
            print("エラーです")
        }
    }
    //wrongsound
    func WrongSound () {
        do{
            try WrSound = AVAudioPlayer(contentsOf: path3)
            print("鳴りました")
            WrSound.volume = 3.0
            WrSound.play()
        }catch{
            print("エラーです")
        }
    }
    //Bgm
    func BgmSound () {
        let path = Bundle.main.bundleURL.appendingPathComponent("tw080.mp3")
        do{
            try Bgm = AVAudioPlayer(contentsOf: path)
            Bgm.numberOfLoops = -1
            Bgm.volume = 0.2
            Bgm.play()
        }catch{
            print("エラーです")
        }
    }
    //Animation
    func CorrectAnimation () {
        // アニメーションのviewを生成
        let animationView = LOTAnimationView(name: "star.json")
        // ViewControllerに配置
        animationView.frame = CGRect(x: 0, y: -120, width: view.bounds.width, height: view.bounds.height)
        //animationView.center = self.view.center
        animationView.loopAnimation = false
        animationView.contentMode = .scaleAspectFit
        self.view.addSubview(animationView)
        // アニメーションを開始
        animationView.play { finished in
            if finished {
                animationView.removeFromSuperview()
            }
        }
    }
    func WrongAnimation () {
        // アニメーションのviewを生成
        let animationView = LOTAnimationView(name: "x_pop.json")
        // ViewControllerに配置
        animationView.frame = CGRect(x: 0, y: -120, width: view.bounds.width, height: view.bounds.height)
        animationView.loopAnimation = false
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 2.0
        self.view.addSubview(animationView)
        // アニメーションを開始
        animationView.play { finished in
            if finished {
                animationView.removeFromSuperview()
            }
        }
    }
    
    func AllClearAnimation () {
        // アニメーションのviewを生成
        let animationView = LOTAnimationView(name: "trophy.json")
        // ViewControllerに配置
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        animationView.loopAnimation = false
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.7
        self.view.addSubview(animationView)
        // アニメーションを開始
        animationView.play()
    }
    
    func startTimer() {
        
        //タイマーが動いている状態で押されたら処理しない
        if timer.isValid == true {
            return
        }
        
        //タイマーを生成
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateElapsedTime), userInfo: nil, repeats: true)
    }
    
    //
    //  Stopボタンの処理
    //
    func stopTimer() {
        
        //タイマーを停止
        timer.invalidate()
    }
    
    //
    //  Resetボタンの処理
    //
    func resetTimer() {
        timer.invalidate()
        count = 0
        elapsedTime.text = "00:00"
    }
    
    //
    //  一定間隔で実行される処理
    //
    @objc func updateElapsedTime() {
        count += 1
        let min: Int = count / 60
        let sec: Int = count % 60
        elapsedTime.text = String(format:"%02d:%02d",min, sec)
    }

    //Realmへ保存
    func SaveRanking () {
        let realm = try! Realm()
        let RankigData = RankingRealm()
        let date = Date()
        RankigData.Category = "くだもの"
        RankigData.Time = count
        RankigData.Date = date
        try! realm.write {
            realm.add(RankigData)
        }
    }
    
    //画面から非表示になる瞬間
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Bgm.stop()
    }
    
}
