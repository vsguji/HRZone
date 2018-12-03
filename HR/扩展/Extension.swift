//
//  Extension.swift
//  HR
//
//  Created by lipeng on 2018/12/3.
//  Copyright © 2018 lipeng. All rights reserved.
//

import Foundation

//Swift 扩展
//扩展就是向一个已有的类、结构体或枚举类型添加新功能。
//扩展可以对一个类型添加新的功能，但是不能重写已有的功能。
//Swift 中的扩展可以：
//添加计算型属性和计算型静态属性
//定义实例方法和类型方法
//提供新的构造器
//定义下标
//定义和使用新的嵌套类型
//使一个已有类型符合某个协议

//已有的类、结构体、枚举类型添加新功能
// 可以对一个类添加新功能,但是不能重写已有的功能

//swift 中的扩展可以:
//添加计算型属性和计算型静态属性
//定义实例方法和类型方法
//提供新的构造器
//定义下标
//定义和使用新的嵌套类型
//是一个已有类型符合某个协议
struct SomeType {
    
}

extension SomeType {
    
}

protocol SomeProtocol {
    
}

protocol AnotherProtocol {
    
}

//一个扩展可以扩展一个已有类型,使其能够适配一个或多个协议,语法格式:
extension SomeType:SomeProtocol,AnotherProtocol {
    
}


//计算型属性
//扩展可以向已有类型添加计算型实例属性和计算型类型属性。

extension Int {
    var add: Int {return self + 100 }
    var sub: Int { return self - 10 }
    var mul: Int { return self * 10 }
    var div: Int { return self / 5 }
}



//构造器
//扩展可以向已有类型添加新的构造器。
//这可以让你扩展其它类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项。
//扩展可以向类中添加新的便利构造器 init()，但是它们不能向类中添加新的指定构造器或析构函数 deinit() 。

struct sum {
    var num1 = 100, num2 = 200
}

struct diff {
    var no1 = 200, no2 = 100
}

struct mult {
    var a = sum()
    var b = diff()
}


extension mult {
    init(x: sum, y: diff) {
        _ = x.num1 + x.num2
        _ = y.no1 + y.no2
    }
}


//方法
//扩展可以向已有类型添加新的实例方法和类型方法。
//下面的例子向Int类型添加一个名为 topics 的新实例方法：
extension Int {
    func topics(summation: () -> ()) {
        for _ in 0..<self {
            summation()
        }
    }
}


//可变实例方法
//通过扩展添加的实例方法也可以修改该实例本身。
//结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样。

extension Double {
    mutating func square() {
        let pi = 3.1415
        self = pi * self * self
    }
}

//下标
//扩展可以向一个已有类型添加新下标。

//extension Int {
//    subscript(var multtable: Int) -> Int {
//        var no1 = 1
//        while multtable > 0 {
//            no1 *= 10
//          multtable += 1
//        }
//        return (self / no1) % 10
//    }
//}


//嵌套类型
//扩展可以向已有的类、结构体和枚举添加新的嵌套类型：

extension Int {
    enum calc
    {
        case add
        case sub
        case mult
        case div
        case anything
    }
    
    var print: calc {
        switch self
        {
        case 0:
            return .add
        case 1:
            return .sub
        case 2:
            return .mult
        case 3:
            return .div
        default:
            return .anything
        }
    }
}

func result(numb: [Int]) {
    for i in numb {
        switch i.print {
        case .add:
            print(" 10 ")
        case .sub:
            print(" 20 ")
        case .mult:
            print(" 30 ")
        case .div:
            print(" 40 ")
        default:
            print(" 50 ")
        }
    }
}
