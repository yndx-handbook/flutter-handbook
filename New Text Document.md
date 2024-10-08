<style>
iframe[src^="[https://dartpad.dev](https://dartpad.dev/)"] {
width: 100%;
height: 500px;
border: none;
}
</style>

<script type="text/javascript" src="https://dartpad.dev/inject_embed.dart.js" defer></script>

## ООП

Dart — объектно-ориентированный язык, так что данная парадигма здесь представлена схоже с другими языками. В данном параграфе мы обсудим особенности, которые могут показаться непонятными, но при внимательном рассмотрении помогают создавать лаконичный и структурированный код.

## Конструктор Const

В предыдущем параграфе мы научились создавать примитивные константы, но Dart позволяет создавать константные объекты с помощью конструктора `const`.

Давайте пробовать:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
const printer = Printer('Hello, World!');
}

class Printer {
final String _valueToPrint;

Printer(this._valueToPrint);

void printValue() {
print('Printing: $_valueToPrint');
}
}
</code>
</pre>

Запускаем и видим на этапе компиляции ошибку: ****`Cannot invoke a non-'const' constructor where a const expression is expected.`

Что она значит? На самом деле из неё мы можем почерпнуть два важных замечания:

1. в переменную `const` можно записать только «константное» выражение, то есть мы не сможем присвоить ей результат выполнения функции;
2. в переменную `const` можно записать только экземпляр класса, созданный с помощью конструктора`const`.

Давайте по порядку.

Для начала рассмотрим пример, объясняющий первый пункт. Здесь мы пытаемся записать в константную переменную результат вычисления функции, который будет известен только после запуска программы, даже если кажется, что результат будет всегда один:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
const printer = getInteger();
}

int getInteger() => 1;
</code>
</pre>

Получаем ошибку: `Const variables must be initialized with a constant value.`

Она появляется, потому что в константные переменные нельзя записать значения, которые не известны до начала выполнения программы.

Второе выражение нам говорит о необходимости использовать ключевое слово `const` при создании объекта.

Давайте пробовать:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
const printer = const Printer('some String value');
}

class Printer {
String valueToPrint;

Printer(this.valueToPrint);

void printValue() {
print('Printing: $valueToPrint');
}
}
</code>
</pre>

Ошибка никуда не ушла, потому что у класса `Printer` нет конструктора `const`.

Пробуем его добавить. Синтаксис данного типа конструктора отличается от обычного только наличием `const` в начале.

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
const printer = const Printer('some String value');
}

class Printer{
String valueToPrint;

const Printer(this.valueToPrint);

void printValue(){
print('Printing: $valueToPrint');
}
}
</code>
</pre>

Все условия выполнены: есть конструктор `const` и создаётся константный экземпляр. Однако возникает новая ошибка: `Constructor is marked 'const' so all fields must be final.`

<p-important>

Важно понимать, что в константную переменную нельзя записать значение, которое неизвестно до запуска программы или которое возможно изменить при исполнении программы.

</p-important>

Чтобы решить последнюю проблему, мы должны изменить код и затем проверить его.

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
const printer = const Printer('some String value');
printer.printValue();
}

class Printer {
final String _valueToPrint;

const Printer(this._valueToPrint);

void printValue() {
print('Printing: $_valueToPrint');
}
}
</code>
</pre>

И наконец мы добиваемся ожидаемого результата.

## Конструкторы factory

Ещё одна отличительная черта Dart — в нём нельзя переопределять функции, методы и конструкторы.

Следующий код просто не скомпилируется:

```dart
int foo() {
	return 5;
}

int foo(int value) {
	return value * 2;
}

```

Данное правило не позволяет разработчику создать огромное количество нечитаемых классов с перегруженными методами вроде:

```dart
class Mathematic {
  int compute() {
    return 5;
  }

  int compute(int value) {
    return value * value;
  }

  int compute(int left, int right) {
    return left * right;
  }

  String compute(int left, int right, String operator) {
    return '$left$operator$right';
  }
}

```

Поскольку конструктор тоже метод, для него правило такое же. Чтобы его соблюсти, в языке есть конструкторы `factory`.

Давайте ниже рассмотрим, где может пригодиться этот инструмент.

- Можно определить специфический интерфейс для создания экземпляров:

```dart
class Logger {
  String? _tag;

  Logger(this._tag);

  factory Logger.withBeautifulTag(String tag) => Logger('[$tag]');

  factory Logger.withDoubleTag(String tag) => Logger('$tag$tag');

  void log(Object? message) {
    print("$_tag:$message");
  }
}

```

- Делегировать создание экземпляров подтипов конструкторам `factory` , что позволяет в определённой степени реализовать Union-тип.

<p-important>

Union-тип — объединение нескольких типов под одним. В Dart нет полноценной поддержки Union-типов, но реализовать такую концепцию возможно и существующими средствами. Или вы можете воспользоваться сторонними пакетами — например, [Freezed](https://pub.dev/packages/freezed#union-types-and-sealed-classes).

</p-important>

Пример Union-типа на конструкторах `factory`:

```dart
// Тип A — это Union Type
class A {
	// Экземпляр A создать нельзя
  A._();

  // Но мы можем вместо этого с помощью конструкторов класса A
  // создать экземпляры классов B и C
  factory A.withB(int bValue) = B;
  factory A.withC(String cValue) = C;
}

class B extends A {
  final int bValue;

  B(this.bValue) : super._();
}

class C extends A {
  final String cValue;
  C._(this.cValue) : super._();

  factory C(String value) => C._(value);
}

```

- Можно использовать ключевое слово `const` для таких конструкторов.

```dart
class A {
  const A();
	// const factory-конструктор A.asConstFactory() вызывает конструктор const B()
	const factory A.asConstFactory() = B;
}

class B extends A {
  const B() : super();
}

```

## Интерфейсы

В отличие от большинства языков, в Dart нет ключевого слова `interface`.

Если быть точным, то изначально оно было, но в 2012 году разработчики его [удалили](https://news.dartlang.org/2012/06/proposal-to-eliminate-interface.html), и взамен каждый класс в Dart имеет [implicit interface](https://dart.dev/guides/language/language-tour#implicit-interfaces).

<p-important>

В Dart есть только классы и их разновидности: `mixin` и `abstract class`. При дальнейшем объяснении мы будем ссылаться на это знание.

</p-important>

Давайте попробуем доработать пример с `Printer`:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
Printer printer = Printer();
Printer taggedPrinter = TaggedPrinter('MyTag');

printer.print('some value');
taggedPrinter.print('some value');
}

class Printer{
void print(String value){
print('Printed: $value');
}
}

class TaggedPrinter implements Printer{
final String _tag;

const Printer(this._tag);

@override
void print(String value) {
print('$_tag: $value');
}
}
</code>
</pre>

Теперь `Printer` реализует интерфейс `PrinterInterface` с помощью ключевого слова `implements`. Оно позволяет реализовать интерфейс другого **класса** без наследования его реализации. `Implements` так же обязывает реализовать каждый элемент интерфейса суперкласса (родителя).

Dart позволяет реализовать множество интерфейсов в одном классе. Давайте попробуем добавить ещё один интерфейс FooInterface и реализовать его в Printer:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
PrinterInterface printer = Printer('Hello, world!');

printer.printValue();

// Ошибка появляется, потому что PrinterInterface "не знает" про метод foo()
printer.foo();

Printer correctPrinter = Printer('Hello, correct!');
correctPrinter.printValue();
correctPrinter.foo();
}

abstract class PrinterInterface{
void printValue();
}

abstract class FooInterface{
void foo();
}

class Printer implements PrinterInterface, FooInterface{
final String _valueToPrint;

const Printer(this._valueToPrint);

@override
void printValue() {
print('Printing: $_valueToPrint');
}

void foo() {
print('Fooing');
}
}
</code>
</pre>

Сейчас на 6-й строчке мы видим ошибку. Она возникает из-за того, что в предыдущем примере мы создали переменную `printer` типа `PrinterInterface`. В интерфейсе `PrinterInterface` нет метода `foo()`, поэтому компилятор не знает, что на самом деле `printer` умеет вызывать `foo()`.

Правильным будет использовать вычисление типа или явно указать тип переменной — `Printer`. В его интерфейсе уже есть и `printValue()`, и `foo()`.

## Наследование

Прежде чем мы поговорим про расширение классов, важно остановиться на наследовании в Dart. В документации сказано, что в языке реализовано [mixin-based](https://dart.dev/language/classes) наследование. Это значит, что каждый класс может иметь только один суперкласс. Это существенное ограничение, но язык предоставляет нам взамен способы расширять поведение класса, о которых пойдёт речь ниже.

## Extends

Ключевое слово `extends` позволяет расширить поведение класса через создание подкласса-наследника.

При этом наследник может переопределять части интерфейса родителя и обязан задать свою реализацию для каждой нереализованной части.

Рассмотрим пример с наследованием от абстрактного класса:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
void main() {
final myObject = MyClass('String value');

myObject.foo();
myObject.bar();
myObject.baz();
myObject.myPrint();
}

abstract class MyAbstractClass {
final String someValue;

MyAbstractClass(this.someValue);

void foo() {
print('MyAbstractClass foo: $someValue');
}

void bar();

void baz() {
print('MyAbstractClass baz: $someValue');
}
}

class MyClass extends MyAbstractClass {
MyClass(super.someValue);

@override
void bar() {
print('MyClass bar: $someValue');
}

@override
void baz() {
print('MyClass baz: $someValue');
}

void myPrint() {
print('My class print: $someValue');
}
}
</code>
</pre>

Данный пример работает и для расширения обычных классов, за исключением обязательной реализации абстрактных частей интерфейса — вы не сможете сделать обычный класс с нереализованными методами.

Давайте зафиксируем, что мы можем извлечь из этого примера:

1. подкласс наследует поведение суперкласса;
2. подкласс может переопределить поведение суперкласса;
3. если у суперкласса есть конструктор, подкласс должен иметь конструктор, который вызывает суперконструктор родителя;
4. интерфейс переменной определяет её тип, а реализацию определяет класс, который создаём.

Попробуем поменять тип переменной:

```dart
void main() {
	// Теперь тип myObject - MyAbstractClass
  final MyAbstractClass myObject = MyClass('String value');

  myObject.foo();
  myObject.bar();
  myObject.baz();
	// IDE и компилятор подсветят здесь ошибку, потому что у MyAbstracClass нет метода myPrint()
  myObject.myPrint();
}

```

## Extension

Методы расширения — очень полезный инструмент языка. Они позволяют расширять поведение классов без создания подклассов и Utils-классов.

Методы расширения имеют полный доступ к публичному интерфейсу класса, на который пишутся.

Ниже представлен пример использования Extension:

```dart
void main() {
  print('23'.hasOneSymbol()); //false
}

extension StringExt on String {
  bool hasOneSymbol() => length == 1;
}

// Тоже самое можно написать с помощью Utils-класса
class StringUtils {
	static bool hasOneSymbol(String value) => value.length == 1;
}

```

Таким образом, нам не придётся писать классы Utils со статическими методами для расширения поведения класса `String`.

А полные возможности extensions можно увидеть в [документации](https://dart.dev/language/extension-methods).

## `With` and `Mixin`

Выше мы сказали, что у класса не может быть больше одного родителя или суперкласса. Но ключевое слово `with` позволяет расширять функционал класса больше чем одним классом.

Команда Dart старается по максимуму защитить разработчика от совершения ошибок — такая схема спасает от проблем множественного наследования. Например, от [ромбовидного наследования](https://ru.wikipedia.org/wiki/%D0%A0%D0%BE%D0%BC%D0%B1%D0%BE%D0%B2%D0%B8%D0%B4%D0%BD%D0%BE%D0%B5_%D0%BD%D0%B0%D1%81%D0%BB%D0%B5%D0%B4%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5).

`Mixin` — любой класс без конструктора и не наследующийся от других классов.

Вот это `Mixin`:

```dart
class MyMixin {
  void foo() {
    print('Mixed foo');
  }
}

```

И это `Mixin`:

```dart
abstract class MyAbstractMixin {
  void bar();
}

```

Их можно подмешать в новый класс с помощью `with`:

```dart
class MyMixin {
  void foo() {
    print('Mixed foo');
  }
}

abstract class MyAbstractMixin {
  void bar();
}

class A with MyMixin, MyAbstractMixin {
  @override
	/// bar обязаны реализовать, потому что это абстрактный метод
  void bar() {
    // TODO: implement bar
  }

}

```

А теперь `MyMixin` уже не `Mixin`, а обычный класс:

```dart
class B {}

class MyMixin extends B {
  void foo() {
    print('Mixed foo');
  }
}

```

`MyMixin` уже подмешать не выйдет, так что ситуация с ромбовидным наследованием через примеси тоже исключена:

!https://yastatic.net/s3/ml-handbook/admin/fluttern_1_2_2_1_437289f0eb.svg

Поведение примеси не может быть расширено, но реализовывать другие интерфейсы `Mixin` может:

```dart
class MyMixin implements MyAbstractMixin {
  void foo() {
    print('Mixed foo');
  }

  @override
	// Мы обязаны реализовать абстрактный bar, т. к. MyMixin — это обычный класс
  void bar() {
    // TODO: implement bar
  }
}

// У интерфейса класса A появились два метода — foo(), bar()
// А реализацию он отнаследовал от примеси MyMixin
class A with MyMixin {

}

```

В примерах выше `MyMixin` можно по-прежнему использовать как обычный класс. Так, мы можем создавать его экземпляры и расширять.

Но задача `Mixin` — расширять поведение **без** создания новых классов. На помощь приходит ключевое слово `mixin`:

```dart

mixin MyMixin implements MyAbstractMixin {
  void foo() {
    print('Mixed foo');
  }
 // Реализовывать абстрактный bar уже не обязательно, потому что экземпляр mixin не может быть создан.
 // Следовательно, и гарантировать реализацию всех членов интерфейса не обязательно
}

// У интерфейса класса A появились два метода — foo(), bar()
// А реализацию он отнаследовал от примеси MyMixin
class A with MyMixin {
@override
  void bar() {
    // TODO: implement bar
  }
}

```

А ещё мы можем ограничить спектр классов, в которые `Mixin` можно подмешать с помощью ключевого слова `on`.

Оно разрешает расширять наследников суперкласса с помощью `Mixin`.

Чтобы лучше разобраться в этом, рассмотрим схему:

!https://yastatic.net/s3/ml-handbook/admin/fluttern_1_2_2_2_f16555005a.svg

```dart
class Super {
  final int a;

  Super(this.a);

  void foo() {
    print('Super foo');
  }
}

mixin MyMixin on Super {
  void baz() {
    print('Mixed baz');
  }
}

// Класс А —  наследник Super и подмешивает Mixin. MyMixin — тоже наследник Super.
class A extends Super with MyMixin {
  A(super.a);
}

// А вот уже в класс B подмешать MyMixin не получится.
class B with MyMixin {

}

```

В примере выше мы можем переопределить `foo()` внутри `MyMixin`, тогда становится не ясно, какую реализацию в итоге выберет язык.

Ещё непонятнее становится при следующей схеме наследования:

!https://yastatic.net/s3/ml-handbook/admin/fluttern_1_2_2_3_aae3527e0a.svg

Если в расширяемых классах встречаются разные реализации одного и того же метода, Dart считает верной ту, что была объявлена последней, — будь то переопределение в самом классе или последний подмешанный `Mixin`.

Теперь, когда мы познакомились со всем инструментарием ООП В Dart, попробуйте решить несколько задач.

Попробуйте угадать, что вызовет следующий код:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
class P {
String getMessage() => 'P';
}

mixin A {
String getMessage() => 'A';
}

mixin B {
String getMessage() => 'B';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

void main() {
String message = '';

AB ab = AB();

message += ab.getMessage();

BA ba = BA();

message += ba.getMessage();

print(message);
}
</code>
</pre>

<details>
<summary>Ответ</summary>

BA

</details>

Типы работают так же, как и при наследовании классов.

Попробуйте понять, что выведет следующий код:

<pre>
<code class="language-run-dartpad:theme-light:mode-inline">
class P {
String getMessage() => 'P';
}

mixin A {
String getMessage() => 'A';
}

mixin B {
String getMessage() => 'B';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

void main() {
AB ab = AB();
print(ab is P);
print(ab is A);
print(ab is B);

BA ba = BA();
print(ba is P);
print(ba is A);
print(ba is B);
}
</code>
</pre>

<details>
<summary>Ответ</summary>

6 true

</details>