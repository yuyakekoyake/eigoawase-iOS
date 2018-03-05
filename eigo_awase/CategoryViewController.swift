//
//  CategoryViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/02/06.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie
import GoogleMobileAds

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADInterstitialDelegate {

    @IBOutlet weak var TableView: UITableView!
   // @IBOutlet weak var LoadingBackview: UIImageView!
    @IBOutlet weak var LoadingBackview: UIView!
    
    var Bgm:AVAudioPlayer!
    var StartEffect:AVAudioPlayer!
    
    let category:[String] = ["くだもの","のりもの","どうぶつ","どうぶつ2","スポーツ","たべもの","たべもの2","てんき/きせつ","ものの名前","ものの名前2","いろ"]
    let cellimage = ["apple","train","dog","rabbit","football","cake","carrot","sunny","camera","notebook","color"]
    
    var waiting = LOTAnimationView()
    var sun = LOTAnimationView()
    var Loding = LOTAnimationView()
    var Stars = LOTAnimationView()
    
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
    let delayTime = 4.0
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //BGMスタート
        BgmSound()
        
        //lottie
        LottieAnimation()
        
        
        //tableviewのdelegate
        TableView.dataSource = self
        TableView.delegate = self
        
        TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        //loadingview
       // LoadingBackview.isHidden = true
        
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
            LoadingBackview.isHidden = false
            // 4秒間待たせる
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.LoadingBackview.isHidden = true
                self.appDelegate.InterstitialFlug = false
                self.showAdMob(interstitial: interstitial)
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        ///let iv = UIImageView(frame: CGRect(x: 15, y: 0, width: 50, height: 50))
        // セルに表示する値を設定する
        cell.textLabel!.text = category[indexPath.row]
        //セル背景
        cell.backgroundColor = UIColor.clear
        // 選択された背景色を白に設定
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = UIColor(red: 245/255, green: 215/255, blue: 110/255, alpha: 0.7)
        cell.selectedBackgroundView = cellSelectedBgView
        
        //iv.image = UIImage(named: cellimage[indexPath.row])
        //cell.contentView.addSubview(iv)
        cell.imageView?.image = UIImage(named:cellimage[indexPath.row])
        
        //backimage
        let imageView = UIImageView(frame: CGRect(x:10, y:5, width:cell.frame.width - 20, height:cell.frame.height - 5))
        let image = UIImage(named: "banner18.png")
        imageView.image = image
        cell.backgroundView = UIView()
       // cell.backgroundView!.addSubview(imageView)

        // 文字サイズ変更
        cell.textLabel?.font = UIFont(name: "KodomoRounded", size: 28)
        cell.textLabel?.textColor = UIColor.red
        
        // テキストを中央寄せ
        //cell.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell
    }
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectData = tableView.cellForRow(at: indexPath as IndexPath)!.textLabel!.text
        
        print("タッブ後\(selectData!)")
        appDelegate.MondaiCategory = selectData!
        StartSound()
        Bgm.stop()
        performSegue(withIdentifier: "ToChallenge", sender: nil)
    }
    
    
    
    func LottieAnimation (){
        
        // アニメーションのviewを生成
        waiting = LOTAnimationView(name: "waiting.json")
        waiting.frame = CGRect(x: 10, y: 50, width: view.bounds.width/4.0, height: view.bounds.height/5)
        waiting.tintColor = UIColor.red
        waiting.contentMode = .scaleAspectFit
        waiting.loopAnimation = true
        
        sun = LOTAnimationView(name: "star.json")
        sun.frame = CGRect(x: view.bounds.width-140, y: 10, width: view.bounds.width/3, height: view.bounds.height/6)
        sun.contentMode = .scaleAspectFit
        sun.loopAnimation = true
        
        Loding = LOTAnimationView(name: "spinner.json")
        Loding.frame = CGRect(x: self.LoadingBackview.center.x, y: self.LoadingBackview.center.y ,width: 150, height: 150)
        Loding.center = self.LoadingBackview.center
        Loding.contentMode = .scaleAspectFill
        Loding.loopAnimation = true
        
        Stars = LOTAnimationView(name: "stars.json")
        Stars.frame = CGRect(x: self.LoadingBackview.center.x, y: self.LoadingBackview.center.y ,width:self.LoadingBackview.frame.width-20, height: self.LoadingBackview.frame.height-20)
        Stars.center = self.LoadingBackview.center
        Stars.contentMode = .scaleAspectFill
        Stars.loopAnimation = true
        
        
        //deviceSize
        switch view.frame.height {
        case 812:break
            
        case 736:
            Loding.frame = CGRect(x: self.LoadingBackview.frame.width/3, y: 270 ,width: 170, height: 170)
            
        case 568:
            Loding.frame = CGRect(x: self.LoadingBackview.frame.width/4.2, y: 200 ,width: 150, height: 150)
        case 480:
            Loding.frame = CGRect(x: self.LoadingBackview.frame.width/3.5, y: 200 ,width: 120, height: 120)
        default:
            break
        }
        
        //Add view
        self.LoadingBackview.addSubview(Stars)
        self.LoadingBackview.addSubview(waiting)
        self.LoadingBackview.addSubview(sun)
        self.LoadingBackview.addSubview(Loding)
        
        // アニメーションを開始
        waiting.play()
        sun.play()
        Loding.play()
        Stars.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //画面から非表示になる瞬間
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        Bgm.stop()
        StartSound()
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
