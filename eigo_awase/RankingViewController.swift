//
//  RankingViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/01/15.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class RankingViewController: UIViewController {
    @IBOutlet weak var TimeLabel0: UILabel!
    @IBOutlet weak var TimeLabel1: UILabel!
    @IBOutlet weak var TimeLabel2: UILabel!
    @IBOutlet weak var TimeLabel3: UILabel!
    @IBOutlet weak var TimeLabel4: UILabel!
    
    @IBOutlet weak var Category0: UILabel!
    @IBOutlet weak var Category1: UILabel!
    @IBOutlet weak var Category2: UILabel!
    @IBOutlet weak var Category3: UILabel!
    @IBOutlet weak var Category4: UILabel!
    
    @IBOutlet weak var DayLavel0: UILabel!
    @IBOutlet weak var DayLavel1: UILabel!
    @IBOutlet weak var DayLavel2: UILabel!
    @IBOutlet weak var DayLavel3: UILabel!
    @IBOutlet weak var DayLavel4: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var BackEffect:AVAudioPlayer!
    var Bgm:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BgmSound()
        
        //interstisialのフラグをOFFへ
        appDelegate.InterstitialFlug = false
        

        let realm = try! Realm()
        let Rankresults = realm.objects(RankingRealm.self).sorted(byKeyPath: "Time", ascending: true)
        print(Rankresults)
        
        var RankDataCount = 0
        switch Rankresults.count {
        case 0:
            RankDataCount = 0
        case 1:
            RankDataCount = 1
        case 2:
            RankDataCount = 2
        case 3:
            RankDataCount = 3
        case 4:
            RankDataCount = 4
        case 5...:
            RankDataCount = 5
        default:
            break
        }
        
        for i in 0 ..< RankDataCount{
            let min: Int = Rankresults[i].Time / 60
            let sec: Int = Rankresults[i].Time % 60
            let formatter = DateFormatter()
            formatter.dateFormat = "MM月dd日"
            (value(forKey: "TimeLabel\(i)") as! UILabel).text = String(format:"%02d:%02d",min, sec)
            (value(forKey: "Category\(i)") as! UILabel).text = Rankresults[i].Category
            (value(forKey: "DayLavel\(i)") as! UILabel).text = formatter.string(from: Rankresults[i].Date!)
            
        }
        let date = Date()
        print("\(date)")
        let df = DateFormatter()
        df.dateFormat = "MM/dd"
        print(df.string(from: date))
        
    }

    func BgmSound () {
        let path = Bundle.main.bundleURL.appendingPathComponent("famipop3.mp3")
        do{
            try Bgm = AVAudioPlayer(contentsOf: path)
            Bgm.numberOfLoops = -1
            Bgm.play()
        }catch{
            print("エラーです")
        }
    }
    
    
    func BackSound () {
        let path = Bundle.main.bundleURL.appendingPathComponent("save-02.wav")
        do{
            try BackEffect = AVAudioPlayer(contentsOf: path)
            BackEffect.play()
        }catch{
            print("エラーです")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //画面から非表示になる瞬間
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Bgm.stop()
        BackSound()
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
