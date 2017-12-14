//
//  FirstSplashViewController.swift
//  TOEIC
//
//  Created by y.okoshi on 2017/10/29.
//

import UIKit

class FirstSplashViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "washi2.jpg")!)


         DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
                self.performSegue(withIdentifier: "ToMain", sender: nil)
    
            
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
