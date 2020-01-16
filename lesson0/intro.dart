// Read: https://dart.dev/samples
// Copy and paste the below sections separately into https://dartpad.dev

/// ### 1) hello world

import 'dart:math';

void main() {
  print('Hello, World!');
}

/// ### 2) Basic Types & Strict typing
///
/// Dart is strictly-typed: all variables, properties, and even return values all have a fixed type.
/// 
/// More info: https://dart.dev/guides/language/sound-dart

void two() {
  String name = 'hi';
  // name = 1; /// This will throw an error when uncommented
  print(name);

  int number = 1;
  print(number);

  double numberWithDecimalPoint = 1.0; // similar to floats in other languages
  print(numberWithDecimalPoint);

  num anyNumber = 1; // num can be both an int or a double
  print(anyNumber);

  bool yes = true;
  print(yes);

  List<int> numberList = [
    0,
    1,
    2
  ]; // Collections also need type definition for their children
  print(numberList);

  Map<String, int> map = {
    'one': 1,
    'two': 2,
  };
  print(map);

  /// `dynamic` is a type that encompasses all types. Not recommended to use when creating variables,
  /// but will be encountered when parsing data
  dynamic data = 'hi';
  // Type can still be checked correctly, but one must know beforehand what type this is
  assert(data is String); // the `is` keyword is only for type checking
}

/// ### 3) Type Inference
///
/// You can use the `var` keyword to assign variables, and the correct type is automatically inferred.
/// But for initially empty variables, the type inference will not work, so the type has to be defined.

void three() {
  var hello = 'hi';
  // asserts are using to test if the given condition is always true. An AssertionError is thrown otherwise
  assert(hello is String);
  hello = 'hello';
  // hello = 1; /// This will still throw an error, even if type is not defined, as it is inferred
  print(hello);

  var list = [0, 1, 2];
  assert(list is List<int>);
  // assert(list is List<double>); /// This will throw an error
  assert(list is List<num>);

  var something = {};
  assert(something is Map);

  var anotherThing = <String>{};
  assert(anotherThing is Set<String>); // Sets are unordered lists
}

/// ### 4) Other keywords
///
/// `final`: Used during program execution. Functionally same as `var`,
/// except the the variable can only be set once and once only.
///
/// `const`: Also cannot be changed, but the value is evaluated during compile time,
/// meaning before program execution.
///
/// Usually in Flutter you will be using `final` more than `var`.

void four() {
  final String hello = 'hello';
  // hello = 'hello'; /// This will throw an error
  final anotherHello = hello;
  print(anotherHello);

  /// Type inference also works using these keywords, do not need to use `var`
  final integer = 1;
  // integer += 1; /// This will throw an error
  assert(integer is int);
  print(integer);

  const hi = 'hi';
  assert(hi is String);

  // const anotherHi = hello; /// final variables cannot be const
  const anotherHi = hi;
  print(anotherHi);
}

/// ### 5) Functions
///
/// Format:
///
/// `[returnType] [functionName]() { /* contents */ }`
///
/// `void` as the return type means no return value
///
/// Functions can be defined within other functions,
/// and also within classes (to be learnt later).
///
/// Functions themselves also have a type, and the format of the type is:
///
/// `[returnType] Function([Type1], [Type2])`
///
/// `typedef` can be used as an alias to a function type

void five() {
  double multiplyBy2(double value) {
    return value * 2;
  }

  assert(multiplyBy2 is double Function(double));
  assert(multiplyBy2 is DoubleCallback);

  DoubleCallback anotherFunction;
  anotherFunction = multiplyBy2;
  print(anotherFunction(2.0));

  /// Assigning an anonymous function to a variable.
  /// Anonymous functions can be used directly in parameters that accept functions.
  final thirdFunction = (double value) => value * 2;
  assert(thirdFunction is DoubleCallback);
}

typedef DoubleCallback = double Function(double);

void fiverr() {
  /// Type inference also works for return types, but don't rely upon this too much.
  ///
  /// `=>`, shorthand syntax for functions, is for one-line return functions.
  /// Functionally speaking, this function is the exact same as the above
  multiplyBy2(double value) => value * 2;
  assert(multiplyBy2 is DoubleCallback);
}

/// ### 6) Function/Class Parameters
///
/// Functions can accept multiple parameters, and they can be
/// required, optional, named, or have default values
///
/// The rules here also apply for Classes, which will be covered later.

void six() {
  /// Standard function definition
  double multiply(double a, double b) => a * b;
  assert(multiply(2.0, 4.0) == 8.0);

  /// Optional parameters with default values. There are defined after compulsory ones first.
  /// If there are no predefined values, then the default value is `null`.
  double multiplyNumbers(double a, double b, [double c = 1, double d = 1]) {
    return a * b * c * d;
  }

  assert(multiplyNumbers(2.0, 4.0, 3.0) == 24.0);

  /// Named parameters. Note that named parameters by default are optional.
  /// In Flutter, there is a `@required` annotation to mark named parameters as required.
  /// However, in default dart, there is not.
  double pythagoras({double first, double second}) {
    return sqrt(pow(first, 2) + pow(second, 2));
  }

  final result = pythagoras(first: 3, second: 4);
  assert(result == 5);
}

/// ### 7) Basic Operators

void seven() {
  /// Math
  assert(5 ~/ 2 == 2); // Truncating division operator
  assert(5 % 2 == 1); // Modulo

  /// Assignment & Compound Assignment: https://dart.dev/guides/language/language-tour#assignment-operators
  int a;
  a = 1;
  a ??= 2;

  /// Null-aware assignment. Equivalent to `if (a == null) a = 2;`
  assert(a == 1);
  a += 1;

  /// Compound assignment. Equivalent to `a = a + 1`
  assert(a == 2);

  /// Boolean operators
  assert(false || true); // or
  assert(true && true); // and
  assert(!false); // not

  /// Conditional expressions
  final b = a == 2 ? 5 : 1; // Ternary operator. if (a == 2), b = 5, else b = 1
  assert(b == 5);
  int c;
  final d = c ?? 0; // if (c == null), d = 0, else d = c.
  assert(d == 0);

  c = 9;
  final e = c ?? 0;
  assert(e == 9);
}

/// 8) Basic Control Flow
void eight() {
  int i;
  // i = 0; /// Uncomment to test
  if (i == 0) {
    print('i = 0');
  } else if (i == 1) {
    print('i = 1');
  } else {
    print(i);
  }

  final numbers = [0, 1, 2, 3];
  for (int number in numbers) {
    print(number); // prints 0, 1, 2, and 3
  }
  // Functionally the same, but above code is more readable. Can be useful if index is needed
  for (int i = 0; i < numbers.length; i++) {
    print(numbers[i]);
  }
}
