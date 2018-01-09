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
    
    static let sizeCard = 70
    
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
        
        var cardstr = ""
        
        switch number {
        case 0:
            cardstr = "apple"
            buttonImageSelect = UIImage(named:"clear")
        case 1:
            cardstr = "orange"
            buttonImageSelect = UIImage(named:"clear")
        case 2:
            cardstr = "cherry"
            buttonImageSelect = UIImage(named:"clear")
        case 3:
            cardstr = "banana"
            buttonImageSelect = UIImage(named:"clear")
        case 4:
            cardstr = "grape"
            buttonImageSelect = UIImage(named:"clear")
        case 5:
            cardstr = "lemon"
            buttonImageSelect = UIImage(named:"clear")
        case 6:
            cardstr = "peach"
            buttonImageSelect = UIImage(named:"clear")
        case 7:
            cardstr = "melon"
            buttonImageSelect = UIImage(named:"clear")
        case 8:
            buttonImageSelect = UIImage(named:"apple")
        case 9:
            buttonImageSelect = UIImage(named:"orange")
        case 10:
            buttonImageSelect = UIImage(named:"cherry")
        case 11:
            buttonImageSelect = UIImage(named:"banana")
        case 12:
            buttonImageSelect = UIImage(named:"grape")
        case 13:
            buttonImageSelect = UIImage(named:"lemon")
        case 14:
            buttonImageSelect = UIImage(named:"peach")
        case 15:
            buttonImageSelect = UIImage(named:"melon")
        default:
            cardstr = "test"
        }
        buttonCard.setTitleColor(UIColor.black, for: .selected)
        buttonCard.setBackgroundImage(buttonImageSelect, for: .selected)
        buttonCard.setTitle(cardstr, for: .selected)
        buttonCard.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonCard.layer.cornerRadius = 10
        buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.7)
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
        buttonCard.backgroundColor = UIColor(red: 249/255, green: 244/255, blue: 178/255, alpha: 1.0)//UIColor(red: 0.2, green: 0.6, blue: 0.6, alpha: 0.3)
    }
}

