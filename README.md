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
* 作用运算符 :: 表示成员包含在那个空间集合中

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
  * 类的定义结束要加 ;


# 第三章 复合类型

## No.1 数组

### 1.0 数组基础

* 创建一个数组，你需要 类型; 数组名; 数组的元素个数

* 声明数组里面元素的个数的时候，你需要const或者整型常数, 也可以是常量表达式, 总之必须是编译的时候已知的。

* 你可以在声明的时候初始化你的数组: int a[2] = {0,1};

* sizeof数组name你将会得到整个数组的内存占有

* 如果你初始化了一个元素，那么其他元素将会被初始化为0

* C++11 数组初始化可以省略=  int a[2]{0,1};  int a[2]{} int a[2]={} 都是将数组置0。

* 列表的初始化禁止缩窄操作，double->int

* 字符数组的特殊性: 

  * ```c++
    char a[] = {'A'};  //初始化后没有空字符
    char a2[] = {'A', '\0'};  //显示说明空
    char a3[] = "ABC";  //自动包含 \0
    char a[0] = "Hentai"  //没有存放空，且越界
    ```

* 复杂数组的声明

  * ```c++
    int *ptr[10];  //包含10个指针的数组
    int (*ptr)[10] = &arr;  //指向10个元素的数组
    int (&ptr)[10] = arr;  //10各元素的数组的别名
    ```

* 指针与数组, 实际上编译器会把数组名的位置替换成数组首元素的指针

  * ```c++
    int firstconfirm()
    {
        int a[10]{};
        auto b(a);    //认为b是指向a的指针
        cout<<(b==&a[0])<<endl;
        return 0;
    }
    输出: True
    ```

* begin(x) 与 end(x) 可以返回x的 首地址 和 尾地址+1  使用这两个libfuc你需要 import iterator头文件, 值得说明的是 end-begin就是元素的个数

* 如果你要使用C风格的字符串, 你必须保证这个字符串是 \0 结尾的

* strlen() strcmp() strcat() strcpy()

* string允许直接用"" 初始化  string a("ABC");

* 我们允许使用数组初始化vector<int> ivec(begin(arr), end(arr));

### 2.0 多维数组

* 列表嵌套形成的数组，也就是多维数组。这样 ([[A,B,C],[D,E,F]])

* ```C++
  int a[3][4] 实际上是大小为3的数组，每个数组里面包含一个大小为4的数组
  ```

* 第一个维度是行，第二个维度是列。也就是说(X,Y,Z)这样的列向量存储模式。

* 内存中 二维数组是按行存储 类似于列向量的转置 (X^T)

* 多维数组实际是数组的数组;

* C++ 逗号运算符 所有表达式中优先级最低的, 只需要按照逻辑以及优先级计算。整个表达式是最后一个表达式的结果。

## No.2 字符串

* C风格的字符串包含很多安全隐患，建议使用string
* "" 里面的内容叫做字符串常量，也叫作字符串面值
* '' 字符常量不能与字符串混用
* <cstring>里面包含strlen()函数, 他返回字符串长度而不是数组的长度, sizeof会返回整个数组的字节数
* 输入流
  * cin输入流使用空格，tab，enter来确定字符结束，假设你输入 "AA BB" 它会把AA读入，再把BB读入，并置于输入队列。
  * cin.getline() 这里将输入一行，并将结尾的换行丢弃 读取到指定数量的字符或者遇到换行停止读取; cin.getline(name, 20), 读取的时候不会超过19个
  * cin.get(), 会保留enter在你的队列中
  * 在你混合输入数字和字符串的时候很可能会遇到问题, cin>>10 意味着会在输入队列缓存一个enter, 那么你的下一个getline会自动丢弃一个行。在输入数字后使用cin.get()可以丢弃上一个换行。当然你也可以做一个拼接，丢弃那个换行。例如: (cin>>10).get();

## No.3 String

* 要使用string你需要使用<string>头文件，并且using namespace std; 

* 你可以

  * 使用C的字符串初始化string
  * cin到string
  * cout一个string
  * 数组法取第i个元素

* 赋值，拼接，附加

  * 允许将一个string赋值给另一个string
  * 允许使用+连接string
  * 允许使用一个string拼合c字符串和一个string
  * 你可以通过.size()确定string中的字符数
  * string s(n, 'A'); s是n个A
  * s.empty() 是否为空
  * 注意你不能把两个字面值直接相加， "A"+"B"

* string IO

  * getline(cin, string str);

  * ```c++
    while(cin >> word) cout<< word << endl;
    //反复读入直至遇到文件尾
    ```

* 字符处理

  * 类似于python的迭代

    ```c++
    for(char i: string_s)    xxx;
    for(auto &i: string_s)   xxx;
    ```

  * 如果你要直接修改里面的字符，你需要使用引用的方式，例如使用toupper()函数，返回大写字幕，可以将小写转化为大写

## No.4 指针基础

* *用于解除引用  &用于引用或取地址

* 一个有效的指针，应当保留对象的地址; 指向某个对象后面的另一个对象，或者是Null。可以是0值也就是空指针。

* C++在创建指针的时候并不会为指针指向的开辟内存

* 函数指针(P129-133)

  * 指向函数的指针

  * ```c++
    bool (*ptr)(const string&, const string&);
    typedef bool (*ptr_name)(const string&, const string&);  //使用typedef, 后面你就可以用ptr_name代表整个函数指针了。
    ```

  * 函数指针只能通过相同类型的函数或者函数指针或者0值进行初始化或者赋值。

  * 不同类型的函数指针之间不存在转换。

  * 通过函数指针你可以直接调用这个函数。

  * 返回指向函数的指针

  * ```c++
    int (*f(int))(int*, int);    // f有int参数, 返回一个int(*)(int*, int)的指针
    typedef int (*ptr)(int*, int);    //简化定义
    ptr f(int);    //这就和第一句的定义一模一样了
    ```

  * 你可以把函数指针的形参定义为函数类型，但是函数的返回类型必须是指向函数的指针，而不能是一个函数体。具有函数类型的形参所对应的实参将会被自动转换为指向相应函数类型的指针，但是当返回的是函数的时候，这样的转化将不会被实现。

  * 指针可以指向重载函数，但是如果这样，务必匹配每一个类型

* void*指针

  * 它可以保存任何类型对象的地址，但是也因此它只能进行有限的几个操作
    * 与另一个指针比较
    * 向函数体传递或者从函数体返回void*
    * 给另一个void*赋值
    * 你不能通过void*操作指向的对象
    * 你返回的void*并不类似于void类型的函数

* typedef与指针

  ```c++
  typedef string *ptr;
  const ptr cstr;        //ptr实质是string的指针
  ```

* 你并不能将一个数字直接赋值给一个指针，但是你可以强制类型转化 

  ```c++
  int *pt = (int*) 0xFFFF;
  ```

* 内存分配

  * int *p = new int; 

  * delete p;    //释放内存

  * 你不能使用delete释放声明的内存

  * 创建/删除动态数组

    ```C++
    int *arr_ptr = new int [10];
    delete [] arr_ptr;
    ```

  * 不要使用delete重复释放，也不要释放非new块，空指针来说delete是安全的。

  * 如果使用new[]为数组分配内存，你需要delete[]; 如果你new[]分配了一个实体，请delete; 

## No.5 指针、数组、指针算数

* 指针和数组基本等价的原因在于指针算数和C++内部的数组处理方式。指针变量+1之后，增量就是指向类型的字节数。同时C++将数组名解释为地址。
* sizeof指针得到的是指针的长度，数组名得到的是数组的长度

## No.6 引用

* 引用的实质是对象的别名 &A, 在定义的时候，会执行初始值和引用的绑定操作, 一旦初始化完成就会一直绑定，所以你必须保证引用的初始化。
* &处于左值为引用，并且不能让一个引用贴标签于0 1 2 这样的常亮，你需要贴到一个变量(对象)上去
* sizeof引用，你会得到对象的大小，而sizeof指针，你会得到指针本身(4)的大小
* 动态分配内存的时候，必须使用指针，引用可能引起内存泄漏
* 引用没有const

## No.7 struct union enum

### Struct

* 和C语言相比，你定义好结构体之后，声明的时候不需要在加struct关键字
* 你可以对一个结构体直接置零初始化 struct_name name{};
* 不允许缩窄转换
* 允许结构数组的存在
* 位字段: 
  * C++允许占用特定位的结构成员，这样可以令创建于某个硬件设备的寄存器的数据结构对应的非常方便
  * 字段类型为整型或者枚举类型，然后是一个冒号，然后是数字，数字即为指定的使用位数。
* 与class不同的是，class更多的是private属性，而struct是默认public属性
* 结构体不能定义递归; 结构体可以包含指向本身类型的指针; 结构体可以嵌套其他结构体; 结构体可以再定义的时候初始化。
* 注意结构体的位运算
* C结构体不能包含函数, c++可以包含函数
* 结构体与内存对齐
  * VC为了效率，会将各个变量存放的起始地址相对于结构体首地址的偏移量为该类型的倍数; 

### 共同体union

* 你只能同时存储相同的数据类型。共同体每次只能存储一个值。共同体的长度是最大成员的长度。你可以在如下场景使用，例如商品条码有的是string, 有的是数字。
* 匿名共同体没有名称，只有一个成员是当前成员。
* 节省空间
* 共同体的内存
  * 所有成员会从低地址开始存放(这与结构体相同)，于是这就会与小端存储格式与大端存储格式一起考察。
  * 大小端存储格式; 大端存储格式，低位保存在高地址，高位保存在低地址; 小端存储格式, 高位高地址，低位低地址。
  * X86小端模式, Sun的SPARC是大端模式。
  * printf函数是游策先入栈
  * longlong8字节  int4字节  char1  short2 尽管小于4字节，但也需要占用4字节

### 枚举enum

* 类似struct变量, 但是它只能有有限个可能, 你不能非法赋值; 枚举只有赋值运算符，没有定义算数运算符。
* 你可以让enum包含相同数值，如果你没有为enum全部显示赋值，默认初始位为0，后面与上一位增加1。
* 枚举的取值范围，枚举定义的取值范围即可。大于max的最小的2的n次幂，-1; 下限，取反+1

## No.8 new delete与动态数组

* 如果你创建一个未命名的动态类型

  * ```c++
    yourtype *ptr = new yourtype;
    ```

* 这个时候你可以使用 -> 来访问相关成员

* 自动存储、静态存储、动态存储

  * 自动变量的实质是局部变量, 它通常存储在栈中, 你在执行代码块的时候，里面的变量会依次入栈, 离开的时候按照相反的顺序释放变量, 这被称为LIFO后进先出。程序在执行过程中栈会不断地放大和缩小。
  * 静态存储是整个程序运行过程中都会保存的; 
  * 动态存储, 他们管理了一个内存池, 这叫做自由存储空间或者堆, 数据的周期不受程序或者函数的生存时间控制, 与常规的变量相比, 使用new和del会更灵活自由，但是管理也将更复杂。在栈中自动添加和删除机制确保占用的内存总是连续的, 但new和del相互影响导致自由区并不连续。

* 智能指针有助于在一定程度上帮助自动规避内存泄漏。

* 一个C++程序包含 栈 堆 静态存储区 文字常量区 代码段

* 栈和堆的区别

  * 栈是编译器自动分配和释放, 存放函数参数，局部变量等。结构类似数据结构里面的stack，速度快。
  * heap，堆; 程序猿分配和释放, 如果你不释放，则在程序结束之后会由操作系统回收。它的分配方式类似于链表，速度较慢，而且容易产生碎片, 不过用起来方便。

* ```C++
  int *ptr = new int[10]();    //默认初始化为0, 去掉()则不会初始化
  ```

* malloc free是标准库函数, 而new和del是运算符; new自动计算分配空间，malloc手动计算; new是类型安全的，malloc不是, malloc只会关心总的字符数; new会调用构造函数; malloc需要库文件支持; 

## No.9 Vector

* vector<your_type> name; 
* vector<your_type> name(name_c); 包含所有name_c的副本; 
* push_back() 方法类似于append  v.size() 返回元素个数

# 第四章 表达式

## No.1 基础概念与优先级

* 作用于一个对象的是一元运算符, 作用于两个对象的是二元运算符。
* 当运算符作用于类类型的运算对象的时候，用户可以自定义其含义。此过程的实质是对已存在的运算符赋予新的含义，于是被称之为重载。
* 左值与右值:
  * 对于一个C++表达式，它不是右值就是左值。
  * 当一个对象作为右值，用的是该数值; 当一个对象作为左值，用的是该标签; 

## No.2 算术表达式与赋值运算符

* % 求余, 也叫取模
* 逻辑运算中包含短路求值策略, 只有当左侧不能确定整个逻辑才会继续计算右边; 
* 赋值运算符满足右结合律; 赋值运算符的级别较低; 
* 三目运算符   a>b? a:b   a>b嘛？大于返回a, 否则返回b

## No.3 位运算

*  ~取反  <<左移  >>右移  &按位与  ^位异或  |按位或
* 左移 <<  int低位补0, unsign低位补0
* 右移 >>  int高位补符号, unsign高位补0
* 原码补码与反码:
  * 正数三码一致
  * 一个数的二进制表示就是它的原码; 你将它依次取反就是反码; 你在将反码+1就是补码
  * 那么符号位置1 +数字本身的补码, 那么就是一个负数的表示

## No.4 SizeOf()

* char 1    
* 对引用类型执行sizeof你会得到对象的大小
* 对指针sizeof你会得到指针的大小, 你对一个野指针sizeof是安全的, 因为你不需要解引用, 对解引用的指针sizeof你会得到对象的大小; 
* 对数组sizeof你会得到整个数组的大小; 
* 对string或者vector执行sizeof仅仅会返回该类型的固定不分大小, 不会计算对象中的元素的占用空间量。

## No.5 逗号运算符

* 依次运算，正常会丢弃左边的，直到最后一个；
* =的优先级高于,    a=3*4, a+1;  a=12  然后整个表达式的值为13, 但是a仍然是12

## No.6 类型转换

* bool char  signed char  short等类型, 如果相对运算存在int, 他们就会被提升为int; 否则提升成 usigned int; 

### 强制类型转换

* static_cast:

  * ```c++
    a = int(a);
    a = static_cast<int>(a);
    ```

  * 最常用的类型转化

* const_cast

  * 去除const属性, 把const指针转变为非const

  * ```C++
    int* Ptr = const_cast<int*>(*const_ptr)
    ```

* dynamic_const

  * 该操作符用于运行时检查该类型转化是否安全, 但是仅仅在多态类型时合法，该类至少具有一个虚拟方法。dunamic_cast语法上与static相同, 但是其应用于类层次的转化。同时, 它具备类型检查功能。

* reinterpret_cast

  * reinterpret为重新解释的意思，即为数据的二进制形式重新解释，但是不改变其值

  * ```C++
    char* ptr = "hello freind!";
    int i = reinterpret_cast<int>(ptr); 
    ```

# 第五章 语句

## No.1 基础概念

*  ; 空语句, 也就是占位符pass
* 多余的空语句并不总是无害的

## No.2 条件语句

* 基本结构

  ```c++
  if condition1{}
  else if condition2{}
  else{}
  ```

* 悬垂else, 就近原则

* 你可以使用花括号使得else与花括号前的if强制匹配; 

* switch语句方便的可以为我们提供对固定选项中做出选择

  ```c++
  switch (ch)
  {
      case 'a':
          statement;
          break;
      case 'b':
          statment2;
          break;
      default:
          ....
  }
  //一条语句与第一项匹配成功，它会一直执行到句子尾部或者与被退出
  ```

* 字符库函数cctype

  * isalpha, isdigit, islower, isupper

## No.3 循环语句

* 定义在while条件部分或者循环体内部的变量，每次循环都要经历创建和销毁

* 范围for语句

  ```C++
  vector<int> v(9);
  ...
  for(aotu &lable : v){}  //遍历迭代器
  ```

* do while是先执行循环体在检查循环条件; 

## No.4 跳转语句

* break终端当前距离它最近的语句
* continue停止当前最近的循环, 并立即进行下一次
* goto无条件跳转到同一条函数的另一条语句

## No.5 异常处理

* throw raise(抛出)一个异常

  ```C++
  throw runtime_error("this is a test"); 
  int a = 0;
      try
      {
          if(!a) throw runtime_error("this is test");
      }
      catch(runtime_error err)
      {
          cout<<err.what()<<' '<<a<<endl;
      }
  ```

* try 开始 catch子句结束。try抛出的异常会被某个catch处理掉, 因此这部分又叫做异常处理代码。

* exception class, 用于throw和相关的catch之间传递异常的具体信息

  ```c++
  try
      {
          throw runtime_error("this is test");
      }
  catch(exception)
      {
          cout<<a<<endl;
      }
  ```

# 第六章 函数

## No.1 函数基础

* 重载函数, 同一个函数名可以对应不同的几个函数; 
* 函数不能返回一个数组或者一个函数，但是它可以返回一个数组指针或者函数指针。
* 名字有作用域; 对象有生命周期。
* 自动对象是只存在于块的执行期间的对象。例如形参。
* 形参不含有初始值会被默认初始化。