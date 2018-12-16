//
//  File.swift
//  HR
//
//  Created by lipeng on 2018/12/3.
//  Copyright © 2018 lipeng. All rights reserved.
//

import Foundation


//Swift 类型转换
//Swift 语言类型转换可以判断实例的类型。也可以用于检测实例类型是否属于其父类或者子类的实例。
//Swift 中类型转换使用 is 和 as 操作符实现，is 用于检测值的类型，as 用于转换类型。
//类型转换也可以用来检查一个类是否实现了某个协议。

class Subjects {
    var physics:String
    init(physics:String) {
        self.physics = physics
    }
}

class Chemistry: Subjects {
    var equations:String
    init(physics:String,equations:String) {
        self.equations = equations;
        super.init(physics: physics)
    }
}

class Maths: Subjects {
    var formulae:String
    init(physic:String,formulae:String) {
        self.formulae = formulae
        super.init(physics: physic)
    }
}

