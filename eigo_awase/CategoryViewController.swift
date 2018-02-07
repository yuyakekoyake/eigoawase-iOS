//
//  CategoryViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/02/06.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    
    let category:[String] = ["くだもの","のりもの","どうぶつ","どうぶつ2","スポーツ","たべもの","たべもの2","てんき/きせつ","ものの名前","ものの名前2"]
    let cellimage = ["apple","train","dog","rabbit","football","carrot","cake","sunny","pen","desk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableviewのdelegate
        TableView.dataSource = self
        TableView.delegate = self
        
        TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
        
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
        
        //iv.image = UIImage(named: cellimage[indexPath.row])
        //cell.contentView.addSubview(iv)
        cell.imageView?.image = UIImage(named:cellimage[indexPath.row])
        
        //backimage
        let imageView = UIImageView(frame: CGRect(x:10, y:5, width:cell.frame.width - 20, height:cell.frame.height - 5))
        let image = UIImage(named: "banner12")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)

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
