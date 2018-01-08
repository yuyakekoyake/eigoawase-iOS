//
//  FirstSplashViewController.swift
//  TOEIC
//
//  Created by y.okoshi on 2017/10/29.
//

import UIKit
import Lottie

class FirstSplashViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "washi2.jpg")!)
        // アニメーションのviewを生成
        let animationView = LOTAnimationView(name: "Watermelon.json")
        
        // ViewControllerに配置
        self.view.addSubview(animationView)
        
        // アニメーションを開始
        animationView.play()

         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
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
