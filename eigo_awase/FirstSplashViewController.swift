//
//  FirstSplashViewController.swift
//  TOEIC
//
//  Created by y.okoshi on 2017/10/29.
//

import UIKit
import Lottie
import LTMorphingLabel
import SpriteKit

class FirstSplashViewController: UIViewController {

    @IBOutlet weak var TitleLabel: LTMorphingLabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "washi2.jpg")!)
        // アニメーションのviewを生成
        let WatermelonAni = LOTAnimationView(name: "Watermelon.json")
        WatermelonAni.frame = CGRect(x: 0, y: 20, width: view.bounds.width/2, height: view.bounds.height/4)
        WatermelonAni.contentMode = .scaleAspectFit
        self.view.addSubview(WatermelonAni)
        
        TitleLabel.morphingEffect = .scale
        // アニメーションを開始
        WatermelonAni.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.TitleLabel.text = "English Society"
        }
        
        
        
         DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
                self.performSegue(withIdentifier: "ToHome", sender: nil)
    
            
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
