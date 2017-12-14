//
//  ViewController.swift
//  eigo_awase
//
//  Created by y.okoshi on 2017/12/12.
//  Copyright © 2017年 english-society. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, CardControlDelegate {

    var Sound:AVAudioPlayer!
    var path = Bundle.main.bundleURL.appendingPathComponent("")
    
    var cards = [CardControl]()
    var cardSelected: CardControl?
    var canOpen = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var numArray = [Int]()
        for i in 0..<16 {
            numArray.append(i)
        }
        print(numArray)
        //var numArray: [String] = ["a", "b", "c", "d", "e", "f", "g", "h"]
        
        for i in 0..<16 {
            let idx = Int(arc4random_uniform(UInt32(numArray.count)))
            let card = CardControl(number: numArray[idx], frame: CGRect(x: 30 + (CardControl.sizeCard + 10) * (i % 4), y: 30 + (CardControl.sizeCard + 10) * (i / 4), width: CardControl.sizeCard, height: CardControl.sizeCard))
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
                Opensound ()
                if AsrNum1 == AsrNum{
                    print("成功！")
                    cardSelected?.DisableCard()
                    sender.DisableCard()
                    cardSelected = nil
                    for (_, obj) in cards.enumerated() {
                        if !obj.isOpen {
                            return
                        }
                    }
                    print("ALL CLEAR!!")
                }
                else {
                    print("失敗．．")
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
            try Sound = AVAudioPlayer(contentsOf: path)
            Sound.play()
        }catch{
            print("エラーです")
        }
    }
}
