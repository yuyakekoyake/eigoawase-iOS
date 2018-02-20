//
//  CardControl.swift
//  eigo_awase
//
//  Created by y.okoshi on 2017/12/12.
//  Copyright © 2017年 english-society. All rights reserved.
//

import UIKit


protocol CardControlDelegate: class {
    func OnCardTapped(sender: CardControl)
}

class CardControl: UIView {
    //mondai
    let Fruit: [String] = ["apple","orange","cherry","banana","grape","lemon","peach","melon"]
    let vehicle: [String] = ["airplane","bicycle","boat","bus","car","rocket","ship","train"]
    let Animal: [String] = ["cat","dog","elephant","giraffe","horse","lion","pig","tiger"]
    let Animal2: [String] = ["duck","fox","mouse","penguin","rabbit","squirrel","zebra","crocodile"]
    let Sports: [String] = ["baseball","basketball","bowling","football","golf","rugby","tennis","volleyball"]
    let Food: [String] = ["bread","cake","candy","donut","egg","rice","tomato","rice ball"]
    let Food2: [String] = ["carrot","corn","eggplant","green pepper","mushroom","potato","broccoli","pumpkin"]
    let Weather: [String] = ["autumn","cloudy","rain","snow","spring","summer","sunny","winter"]
    let Supplies: [String] = ["door","bed","chair","desk","window","clock","piano","camera"]
    let Supplies2: [String] = ["calculator","computer","eraser","notebook","pen","scissors","stapler","picture"]
    let Color: [String] = ["red","green","blue","white","black","yellow","purple","grey"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: プロパティ
    var number:Int = 0 {
        didSet {
            buttonCard.setTitle(String(number), for: .selected)
        }
    }
    var isOpen = false {
        didSet {
            buttonCard.isSelected = isOpen
            if isOpen {
                buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//UIColor(red: 0.2, green: 0.8, blue: 0.8, alpha: 0.9)
            }
            else {
                buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//UIColor(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.7)
            }
        }
    }
    
    weak var delegate: CardControlDelegate?
    
    static var sizeCard = 70
    static var CardcornerRadius = 7
    
    var buttonCard = UIButton()
    
    // MARK: 初期化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonCard.setTitle("?", for: .normal)
        buttonCard.layer.cornerRadius = 10
        buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//UIColor(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.7)
        
        
    //ここをSwift4へ
        buttonCard.addTarget(self, action: #selector(CardControl.ButtonTapped(sender:)),for: .touchUpInside)
    
        addSubview(buttonCard)
    }
    
    init(number: Int, frame: CGRect) {
        super.init(frame: frame)
        
        self.number = number
        let buttonImage = UIImage(named:"ABC")
        var buttonImageSelect = UIImage(named:"buttonBack.jpg")
        //buttonCard.setTitle("⭐︎", for: .normal)
        buttonCard.setBackgroundImage(buttonImage, for: .normal)
        //buttonCard.setImage(buttonImage, for: .normal)
        
        
        
        var cardAryStr: [String] = []
        switch appDelegate.MondaiCategory {
        case "くだもの":
            cardAryStr = Fruit
        case "のりもの":
            cardAryStr = vehicle
        case "どうぶつ":
            cardAryStr = Animal
        case "どうぶつ2":
            cardAryStr = Animal2
        case "スポーツ":
            cardAryStr = Sports
        case "たべもの":
            cardAryStr = Food
        case "たべもの2":
            cardAryStr = Food2
        case "てんき/きせつ":
            cardAryStr = Weather
        case "ものの名前":
            cardAryStr = Supplies
        case "ものの名前2":
            cardAryStr = Supplies2
        case "いろ":
            cardAryStr = Color
        case "ランダム":
            cardAryStr = appDelegate.MondaiRandom
        default:
            break
        }
        var cardstr = ""
        
        switch number {
        case 0:
            cardstr = cardAryStr[0]
            buttonImageSelect = UIImage(named:"clear")
        case 1:
            cardstr = cardAryStr[1]
            buttonImageSelect = UIImage(named:"clear")
        case 2:
            cardstr = cardAryStr[2]
            buttonImageSelect = UIImage(named:"clear")
        case 3:
            cardstr = cardAryStr[3]
            buttonImageSelect = UIImage(named:"clear")
        case 4:
            cardstr = cardAryStr[4]
            buttonImageSelect = UIImage(named:"clear")
        case 5:
            cardstr = cardAryStr[5]
            buttonImageSelect = UIImage(named:"clear")
        case 6:
            cardstr = cardAryStr[6]
            buttonImageSelect = UIImage(named:"clear")
        case 7:
            cardstr = cardAryStr[7]
            buttonImageSelect = UIImage(named:"clear")
        case 8:
            buttonImageSelect = UIImage(named:cardAryStr[0])
        case 9:
            buttonImageSelect = UIImage(named:cardAryStr[1])
        case 10:
            buttonImageSelect = UIImage(named:cardAryStr[2])
        case 11:
            buttonImageSelect = UIImage(named:cardAryStr[3])
        case 12:
            buttonImageSelect = UIImage(named:cardAryStr[4])
        case 13:
            buttonImageSelect = UIImage(named:cardAryStr[5])
        case 14:
            buttonImageSelect = UIImage(named:cardAryStr[6])
        case 15:
            buttonImageSelect = UIImage(named:cardAryStr[7])
        default:
            cardstr = "test"
        }
        
        buttonCard.setTitleColor(UIColor.black, for: .selected)
        buttonCard.setBackgroundImage(buttonImageSelect, for: .selected)
        //buttonCard.setImage(buttonImageSelect, for: .selected)
        buttonCard.setTitle(cardstr, for: .selected)
        buttonCard.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        buttonCard.imageView?.contentMode = .scaleAspectFit
        //buttonCard.contentMode = .scaleAspectFit
        buttonCard.layer.cornerRadius = CGFloat(CardControl.CardcornerRadius)
        buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.7)
        //buttonのフォントサイズ可変
        
        buttonCard.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonCard.titleLabel?.minimumScaleFactor = 0.1
        buttonCard.titleLabel?.numberOfLines = 1
        buttonCard.titleLabel!.textAlignment = NSTextAlignment.center
        buttonCard.addTarget(self, action: #selector(CardControl.ButtonTapped(sender:)),for: .touchUpInside)
        
        addSubview(buttonCard)
    }
    
    override open var intrinsicContentSize: CGSize {
        //コンテンツサイズの設定
        return CGSize(width: CardControl.sizeCard, height: CardControl.sizeCard)
    }
    
    override func layoutSubviews() {
        //ボタンサイズの設定
        buttonCard.frame = CGRect(x: 0, y: 0, width: CardControl.sizeCard, height: CardControl.sizeCard)
    }
    
    // MARK: ボタンのタッチイベント
    @objc func ButtonTapped(sender: UIButton) {
        delegate?.OnCardTapped(sender: self)
    }
    
    // MARK: メソッド
    func OpenCard() -> Int? {
        if isOpen {
            return nil
        }
        else {
            isOpen = true
            return number
        }
    }
    
    func CloseCard() {
        isOpen = false
    }
    
    func DisableCard() {
        buttonCard.removeTarget(self, action: #selector(CardControl.ButtonTapped(sender:)),for: .touchUpInside)
        buttonCard.backgroundColor = UIColor.clear//UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//UIColor(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.3)
    }
}

