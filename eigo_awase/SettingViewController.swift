//
//  SettingViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/01/23.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import AVFoundation

class SettingViewController: UIViewController {

    var BackEffect:AVAudioPlayer!
    var Bgm:AVAudioPlayer!
    
    @IBOutlet weak var versionLabel: UITextView!
    @IBOutlet weak var BackBtnBottom: NSLayoutConstraint!
    
    // appDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        BgmSound()
        // Do any additional setup after loading the view.
        
        //deviceSize
        switch view.frame.height {
        case 812: break
        case 736:
            BackBtnBottom.constant = 130
        case 568: break
        case 480:
            BackBtnBottom.constant = 7
        default:
            break
        }
        
        versionLabel.text = " Version   " + appDelegate.productionVersion!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
