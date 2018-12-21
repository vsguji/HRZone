//
//  ViewController.swift
//  HR
//
//  Created by lipeng on 2018/11/29.
//  Copyright © 2018 lipeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 继承
        let tom = Tom()
        tom.show()
        
        // 重写 方法
        let superClass = SupperClass()
        superClass.show()
        
        let subClass = SubClass()
        subClass.show()
        
        // 重写属性
        let rectangle = Rectangle()
        rectangle.radius = 25.0
        rectangle.print = 3
        print("Radius\(rectangle.area)")
    }
    
    
    func typeTranslate() {
       let sa = [
        Chemistry(physics: "固体物理", equations: "赫兹"),
        Maths(physic: "流体动力学", formulae: "千兆赫")
        ]
        let samplechem = Chemistry(physics: "固体物理", equations: "赫兹")
        print("实例物理学是\(samplechem.physics)")
        print("实例方程式:\(samplechem.equations)")
        
        let sampleMatchs = Maths(physic: "流体动力学", formulae: "千兆赫")
        print("实例物理学是:\(sampleMatchs.physics)")
        print("实例公式是:\(sampleMatchs.formulae)")
        
        
//        检查类型
//        类型转换用于检测实例类型是否属于特定的实例类型。
//        你可以将它用在类和子类的层次结构上，检查特定类实例的类型并且转换这个类实例的类型成为这个层次结构中的其他类型。
//        类型检查使用 is 关键字。
//            操作符 is 来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。
        var chemCount = 0;
        var mathsCount = 0;
        
        for item  in sa {
            if item is Chemistry {
                chemCount += 1
            }
            else if item is Maths {
                mathsCount += 1
            }
        }
        
//        向下转型
//        向下转型，用类型转换操作符(as? 或 as!)
//        当你不确定向下转型可以成功时，用类型转换的条件形式(as?)。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。
//        只有你可以确定向下转型一定会成功时，才使用强制形式(as!)。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
        for item  in sa {
            if let show = item as? Chemistry {
                print("化学主题是:'\(show.physics)',\(show.equations)");
            }
            else if let example = item as? Maths {
                print("数学主题是:'\(example.physics)',\(example.formulae)")
            }
        }
        
        
//        Any和AnyObject的类型转换
//        Swift为不确定类型提供了两种特殊类型别名：
//        AnyObject可以代表任何class类型的实例。
//        Any可以表示任何类型，包括方法类型（function types）。
//        注意：
//        只有当你明确的需要它的行为和功能时才使用Any和AnyObject。在你的代码里使用你期望的明确的类型总是更好的。
        
//        Any 实例
        var exampleAny = [Any]()
        exampleAny.append(12)
        exampleAny.append(3.14159)
        exampleAny.append("Any 实例")
        exampleAny.append(Chemistry(physics: "固体物理", equations:"兆赫"))
        
        for item  in exampleAny {
            switch item {
                case let someInt as Int:
                 print("整数值为\(someInt)")
            case let someDouble as Double where someDouble > 0 :
                print("PI为\(someDouble)")
            case let someString as String:
                print("\(someString)")
            case let phy as Chemistry :
                print("print 主题为\(phy.physics)")
            default:
                print("none")
            }
        }
        
        //    AnyObject 实例
        //    AnyObject 可以代表任何class类型的实例
        let saprint : [AnyObject] = [
            Chemistry(physics: "固体物理", equations: "赫兹"),
            Maths(physic: "流体动力学", formulae: "千兆赫"),
            Chemistry(physics: "热物理学", equations: "分贝"),
            Maths(physic: "天体物理学", formulae: "兆赫"),
            Maths(physic: "微分方程", formulae: "余弦级数")
        ]
        
        for item in saprint {
            if let show = item as? Chemistry {
                print("化学主题是:'\(show.physics)',\(show.equations)")
            }
            else if let example = item as? Maths {
                print("数学主题是:'\(example.physics)',\(example.formulae)")
            }
        }
    }

    // 扩展
    func showExtension() {
//        计算型属性
//        扩展可以向已有类型添加计算型实例属性和计算型类型属性。
        let addition = 3.add
        print("加法运算后的值：\(addition)")
        
        let subtraction = 120.sub
        print("减法运算后的值：\(subtraction)")
        
        let multiplication = 39.mul
        print("乘法运算后的值：\(multiplication)")
        
        let division = 55.div
        print("除法运算后的值: \(division)")
        
        let mix = 30.add + 34.sub
        print("混合运算结果：\(mix)")
        
        
//        构造器
//        扩展可以向已有类型添加新的构造器。
//        这可以让你扩展其它类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项。
//        扩展可以向类中添加新的便利构造器 init()，但是它们不能向类中添加新的指定构造器或析构函数 deinit() 。
        let a = sum(num1: 100, num2: 200)
        let b = diff(no1: 200, no2: 100)
        
        let getMult = mult(x: a, y: b)
        print("getMult sum\(getMult.a.num1, getMult.a.num2)")
        print("getMult diff\(getMult.b.no1, getMult.b.no2)")
        
//        扩展可以向已有类型添加新的实例方法和类型方法。
//        4.topics({
//            print("扩展模块内")
//        })
//
//        3.topics({
//            print("内型转换模块内")
//        })
        
        
//        可变实例方法
//        通过扩展添加的实例方法也可以修改该实例本身。
//        结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样。
        
        var Trial1 = 3.3
        Trial1.square()
        print("圆的面积为: \(Trial1)")
        
        
        var Trial2 = 5.8
        Trial2.square()
        print("圆的面积为: \(Trial2)")
        
        
        var Trial3 = 120.3
        Trial3.square()
        print("圆的面积为: \(Trial3)")

        
        //下标
        //扩展可以向一个已有类型添加新下标。
//        print(12[0])
//        print(7869[1])
//        print(786543[2])
        
        
//        嵌套类型
//        扩展可以向已有的类、结构体和枚举添加新的嵌套类型：
        result(numb:[0, 1, 2, 3, 4, 7])
    }
    
    
    
    // APNS
    func apnsPush() {
       // let push = ServerPush();
    }
}

