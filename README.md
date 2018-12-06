# 第一章 开启你的C++学习之旅

## No.1 概述--起源与面向对象

* 汇编语言直接操作硬件，访问寄存器和内存

* C语言采用自顶向下结构化编程思路

* 泛型编程

  * 重用代码，抽象通用概念
  * C++模板

* 编译步骤

  源代码 - 编译器 - 目标代码 - 链接程序 - 可执行代码

  ​                          |     |

  ​                      启动代码  代码库

* IDE和编译器

  * IDE可以使用户管理所有的编程过程
  * GUN等只能处理链接阶段和编译阶段

* 编译和链接

  * .o文件可以用来表示目标程序，你可以通过最终的a.out控制

## No.2 技巧复苏

* 简单书店系统
* 如果你的系统支持posix标准，那么0代表返回成功
* iostream istream表示输入流 ostream表示输出流
* std namespace 命名空间可以帮助我们避免不经意间重复命名导致的冲突，当然，当包含不同的命名空间且具有相同的名字，你需要显示说明
* 作用远算符 :: 表示成员包含在那个空间集合中
* ​

# 第二章 变量与基本类型

## No.1 基本变量类型

* 位与字节
  * 1 byte 字节  是  8 bit 位
  * 1KB = 1024字节(byte)
  * 1M = 1024K
  * sizeof返回字节数
* int 整型
  * short至少16位    系统内置 SHRT_MAX
  * int至少和short一样    系统内置 INT_MAX   #4个字节
  * long至少32位    系统内置  LONG_MAX
  * long long至少min(64位,long)    系统内置  LLONG_MAX
  * 系统中的 0代表8进制  0x代表16进制
  * dec hex oct 三种格式显示 10 16 8 进制的数字
  * 当你给无符号的数赋值一个超出范围的数据，它会对容量极值取模
* char 字符型
  * 字符一般不超过128个
  * A的ASCII是65  a为97  

## No.2 变量的声明与定义

* 几种初始化方式
  * int a = 0;
  * int a = {0};
  * int a{0};
  * int a(0);
* extern关键字，声明一个变量; 声明，使得name为程序所知，而定义是创建实体的过程。

## No.3 const关键字

* const常量     const int Varible = 100; 

* 便于进行类型检测

  * 相对于宏定义，const常量有数据类型，宏定义只是单纯替换文本，可能会出现意想不到的问题。

* 防止意外修改

* 为**函数重载**提供了参考

* const只为数据提供一次内存分配

* const通常保留在符号表中，这样在编译的过程没有存储和读内存的操作。

* ```c++
  C++中的const默认为内部连接，也就是说，const仅在const被定义过的文件里才是可见的，而在连接时不能被其他编译单元看到。当定义一个const时，必须赋一个值给它，除非用extern作出了清楚的说明。
  通常C++编译器并不为const创建存储空间，相反它把这个定义保存在它的符号表里。但是extern强制进行了存储空间分配（另外还有一些情况，如取一个const的地址，也要进行存储空间分配），由于extern意味着使用外部连接，因此必须分配存储空间，这也就是说有几个不同的编译单元应当能够引用它，所以它必须存储空间。
  ```

* const的使用

  * char* const p     指针指向不变
  * const char *p     指针内容不变
  * const char * const p    两者都不变
  * 函数中的const
    * 参数在函数体内不可变 void f(const int i)
    * 参数指针指向内容不可变 void f(const int *p)
    * void f(const Class& var) 以及 void f(const Type& var) 这样的const引用传递和普通的函数按值传递的效果是相同的，它会禁止引用的对象的修改，不同的是按值传递会建立类对象的副本，然后传递过去。但是const直接传递地址。
    * const与返回值; 通常不建议对象或者引用为const属性， 因为这样做返回的实例只能访问类中的共有/保护数据以及const成员函数，并且不允许对其进行赋值操作。
  * 类中的const
    * const修饰成员变量，那么该成员只能在初始化列表中初始化赋值，后面不可修改。
    * const修饰成员函数，则该方法不能调用其他任何非const方法，也不能改变对象的成员变量。 void f() const;
    * const修饰对象表示该对象的任何数据不能被修改。const对象的任何非const成员都不能被调用。

* const_cast

  * const_cast<type_id>(expression)

  * ```c++
    int &b = const_cast<int &>(a);
    p = const_cast<int*>(&a);
    ```

  * 注意，如果你直接在编译器里面用对已有数字的const_cast，原本的const a不会变化，但是如果你是悬而未决，例如const a = j  j需要cin，那么编译器不能像define那样优化，此时a就会变化。

## No.4 Static关键字

* 作用范围为一个文件内，程序开始的时候分配空间，结束的时候释放，默认初始化为0，使用的时候可以变更数值。静态变量或者静态函数具有隐藏效果，只有本文件内才能找到他们。

* 函数内部的static变量，可以作为对象之间的一种通信机制。这个对象将会仅在执行线程第一次到达它的定义对其初始化。

* 局部静态变量，第一次的定义被控制线程到达的时候会调用构造函数，程序结束时会依次逆序调用析构函数。

  * ```
    存储在静态数据区的变量会在程序刚开始运行时就完成初始化，也是唯一的一次初始化。共有两种变量存储在静态存储区：全局变量和static变量，只不过和全局变量比起来，static可以控制变量的可见范围，说到底static还是用来隐藏的。虽然这种用法不常见
    ```

* 静态成员和静态函数成员，一个static成员只有唯一的一份副本，而不像常规的非static成员那样在每个对象里各有一份副本。同理，一个需要访问类成员，而不需要针对特定对象去调用的函数，也被称为一个static成员函数。类的静态成员函数只能访问类的静态成员(变量或函数)。

  * static数据属性有点像类属性，而不是对象属性
  * static类方法而不是对象方法
  * 静态方法不包含this指针，因此它不能访问对象的费静态数据成员以及函数。
  * static成员函数不能被声明为const
  * 非静态函数可以任意访问静态函数和属性

## No.5 自定义数据类型

* 类型别名
  * typedef double wages; wages就是double的别名可以当做double使用
  * using SI = Salary  SI就是Salary的别名
  * auto说明符 auto a = 1 + 1.0; 但是一条语句只能包含一个声明类型。
  * decltype 你可能需要从表达式推测类型，但是你又不想这样初始化这个变量。
    * decltype() 就可以推算出一个类型
    * 于是decltype() a = 0; 就是 int a=0;
    * 注意 如果decltype(())，或者里面有更多层括号，都会被编译器认为是一个表达式。变量是一种可以作为左值的表达式，因此会的到引用类型。
* 自定义数据结构
  * 类的丁一结束要加 ; 
  * ​
* ​