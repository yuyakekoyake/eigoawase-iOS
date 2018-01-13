//
//  RankingRealm.swift
//  eigo_awase
//
//  Created by y.okoshi on 2018/01/14.
//  Copyright © 2018年 english-society. All rights reserved.
//

import UIKit
import RealmSwift

class RankingRealm: Object {
    @objc dynamic var Category = ""
    @objc dynamic var Time = 0
}
