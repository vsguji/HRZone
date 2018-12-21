#  访问权限关键字
open 


public 


private \ fileprivate \ fileprivate(set)





# typealias与associatedtype


typealias   :   是用来为已经存在的类型重新定义名字的，通过命名，可以是代码变得更加清晰。使用的语法也很简单，使用typealias 关键字像使用普通的赋值语句一样，可以将某个已经存在的类型赋值为新的名字。

例如:
typealias Success = (_ data: String) -> Void
typealias Failure = (_ error: String) -> Void

func request(_ url: String, success: Success, failure: Failure) {
// do request here .... 
}
--------------------- 

#### 特点:typealias 是单一的，也就是说你必须指定将某个特定的类型通过typealias赋值为新名字，而不能将整个泛型类型进行重命名。


另外一种使用场景是某个类型同时实现多个协议的组合是。我们可以使用 & 符号链接几个协议，然后给他们一个新的更符合上下文的名字，来增强代码可读性。

例如:
protocal Cat {}
protocal Dog {}

typealias Pat = Cat & Dog


associatedtype (关联类型)
#### 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。

例如:
// 创建模型
struct Model {
let age: Int
}

// 协议，使用关联类型
protocol TableViewCell {
associatedtype T
func updateCell(_ data: T)
}

// 遵循TableViewCell协议
class MyTableViewCell: UITableViewCell, TableViewCell {

typealias T = Model
func updateCell(_ data: Model) {
// do string ...
}
}
--------------------- 
