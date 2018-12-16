//
//  StudentDetail.swift
//  HR
//
//  Created by lipeng on 2018/12/3.
//  Copyright © 2018 lipeng. All rights reserved.
//

import Foundation

// 继承
class StudentDetail{
    var mark1:Int
    var mark2:Int
    init(stm1:Int,results stm2:Int) {
        mark1 = stm1
        mark2 = stm2
    }
    func show() {
        print("Mark1:\(self.mark1),Mark2:\(self.mark2)")
    }
}


class Tom: StudentDetail {
    init() {
        super.init(stm1: 93, results: 89)
    }
}



// 重写方法和属性

class SupperClass {
    func show() {
        print("这是超类 SuperClass")
    }
}


class SubClass: SupperClass {
    override func show() {
        print("这是子类")
    }
}

// 重写属性
class Circle {
    var radius = 12.5
    var area:String {
        return "矩形半径\(radius)"
    }
}

class Rectangle: Circle {
    var print = 7
    override var area: String {
        return super.area + ".但现在被重写为\(print)"
    }
}


// 重写属性观察器

/// 你可以在属性重写中为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会监测到。
/// 注意：你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。
class Square: Rectangle {
    override var radius: Double{
        didSet{
            print = Int(radius/5.0) * 1
        }
    }
}


// 防止重写 改写上面Circle中的radius

/// 我们可以使用 final 关键字防止它们被重写。
// 如果你重写了final方法，属性或下标脚本，在编译时会报错。
// 你可以通过在关键字class前添加final特性（final class）来将整个类标记为 final 的，这样的类是不可被继承的，否则会报编译错误。

class NewCicle {
    final var radius = 12.5
    var area:String {
        return "矩形\(radius)"
    }
}
