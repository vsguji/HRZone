1.基于原生开发

RN (react native)

编程思想:Learn once ,write anywhere.

官网地址：https://reactnative.cn

开发文档地址：https://reactnative.cn/docs/0.51/getting-started.html版本 0.51

                  优点：文档齐全、ios | android 组件库丰富

                  缺点: 开发成本高（比如 node.js 、npm 包管理、Bridge桥接原理;   web支持力度不足,随着淘宝镜像不再维护,组件库不再维护，目前可以用twitter组件库；

Flutter

编程思想:write once ,run anywhere.

官网地址：https://flutter.io

开发文档：https://flutter.io/setup-macos/

中文网https://flutterchina.club

优点:解决了移动开发中的两个重要问题，一是原生应用程序的性能与平台的集成;二是提供多平台、可移植的UI工具包支持高效应用开发，对RN开发做了优化.

缺点:Dart 语言。(Dart是一种现代化的静态类型的编程语言，可以编译成JavaScript在手机上运行。Dart是一个优雅的全堆栈语言，所以Google以自己的语言发布移动SDK并不奇怪。）

2.基于TypeScript抽象语言

ionic 

官网地址:https://ionicframework.com/docs/

     优点：AngluarJS + Cordova

     缺点:   占用内存, 比较耗性能的地方如复杂交互、动画均不合适。

  week

官网地址：http://weex.apache.org/cn/guide/

优点：多平台兼容开发；支持多个前端框架（内置 Vue.js 和 Rax）；

缺点：仅作为原生应用解决跨平台框架（app壳子）；只能使用内置组件和自定义组件。

3.中间件方式

unity是什么？

一句话概括，主要原因在于Unity通过Mono使用了一种叫CIL（Common Intermediate Language，也叫MSIL）通用中间语言的基于堆栈的代码指令集,它属于CLR的一个子集。

实现原理：

Unity的跨平台，就是通过Mono将C#脚本代码编译成CLI，然后Mono运行时利用JIT或者AOT将CLI编译成目标平台的原生代码实现的。


[简书](!https://www.jianshu.com/p/19bebfc78dfe)
