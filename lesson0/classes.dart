import 'dart:math' as math;

/// Important concepts:
///
/// 1. Mutability & Immutability
/// 2. Instances
/// 3. Instance Variables & Methods
/// 4. Static Variables & Methods
/// 5. Constructors & Initialiser Lists
/// 6. Factory Constructors
/// 7. Getters & Setters
/// 8. Inheritance & Superclasses & Overriding
/// 9. Interfaces & Implementing
/// 10. Abstract Classes
/// 11. Enums
/// 12. Generics

// An example of a mutable class.
class Point {
  // Instance variables
  num x, y;

  // Standard initialisation constructor. This is syntactical sugar equivalent to:
  //   Point(num x, num y) {
  //     this.x = x;
  //     this.y = y;
  //   }
  Point(this.x, this.y);

  // Custom named constructor
  Point.origin() {
    x = 0;
    y = 0;
  }

  // Alternative constructor, using initialiser lists instead of a function body
  Point.anotherOrigin()
      : x = 0,
        y = 0;

  // instance method
  num distanceTo(Point otherPoint) {
    final xDiff = (otherPoint.x - x).abs();
    final yDiff = (otherPoint.y - y).abs();
    return math.pow(math.pow(xDiff, 2) + math.pow(yDiff, 2), 0.5);
  }

  // Getter without a setter
  num get distanceFromOrigin => distanceTo(Point.origin());

  // Override default constructors
  @override
  String toString() {
    return 'Point($x, $y)';
  }
}

void pointDemo() {
  final point = Point(6, 9);
  print(point);

  point.x = 3;
  point.y = 4;
  print(point.distanceFromOrigin); // 5

  final anotherPoint = Point(6, 8);
  print(point.distanceTo(anotherPoint)); // Also 5
}

//////////////////////////////////////////////////////////////////////////////////////////////////

/// An example of an immutable class. All the instance variables must be marked as final,
/// and the constructor must be marked as const
class ImmutablePoint {
  // Instance variables marked as final
  final num x, y;

  // Standard constructor with const keyword, making it a constant constructor evaluated at compile time.
  const ImmutablePoint(this.x, this.y);

  // Static variable. They are accessed without creating an instance of a class.
  static const origin = ImmutablePoint(0, 0);

  // Static method. They are accessed without creating an instance of a class.
  static num distanceBetween(ImmutablePoint a, ImmutablePoint b) {
    final xDiff = (a.x - b.x).abs();
    final yDiff = (a.y - b.y).abs();
    return math.sqrt(math.pow(xDiff, 2) + math.pow(yDiff, 2));
  }

  // Override default constructors
  @override
  String toString() {
    return 'ImmutablePoint($x, $y)';
  }
}

void immutablePointDemo() {
  const point = ImmutablePoint(6, 9);
  // point.x = 3; /// Will throw an error

  /// The `origin` variable is accessed without creating an instance of [ImmutablePoint],
  /// i.e. without calling the constructors, but just using the class name ImmutablePoint
  const origin = ImmutablePoint.origin;

  /// Similar for static methods
  final distance = ImmutablePoint.distanceBetween(point, origin);
  print(distance); // ~10.81665
}

//////////////////////////////////////////////////////////////////////////////////////////////////

/// An example of using getters and setters in class, as well as asserts
class PositivePoint {

  /// Private variable `_x` cannot be accessed outside the class
  num _x;
  /// Getters for `x`
  num get x => _x;
  /// Setters for `x`. An additional assert is used to prevent setting negative values.
  set x(num x) {
    assert(x >= 0);
    _x = x;
  }

  num _y;
  num get y => _y;
  set y(num y) {
    assert(y >= 0);
    _y = y;
  }

  /// Asserts can be used in initialiser lists
  PositivePoint(this._x, this._y)
      : assert(_x >= 0),
        assert(_y >= 0);

  // Override default constructors
  @override
  String toString() {
    return 'PositivePoint($_x, $_y)';
  }
}

void positivePointDemo() {
  final p = PositivePoint(1, 2);
  // p.x = -1; /// An AssertionError will be thrown
  p.x = 2;
  print(p);

  /// Private variables can still be accessed in classes within the same file.
  /// However, when importing the class from a different file, it cannot be accessed,
  /// and an error will be thrown.
  print(p._x);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Abstract classes cannot be created, but can be extended or implemented by other classes.
abstract class Vehicle {
  final String license, brand;
  const Vehicle({this.license, this.brand});

  // Abstract methods are defined with no function body.
  // Classes which implement or extend this class will need to implement this method.
  bool isHighClass();
}

// Inheritance. Constructors do not get inherited, only variables and methods.
class Car extends Vehicle {
  /// Addition of `model` variable for car
  final String model;

  /// Call the super class in the initialiser list to initialise the super class as well.
  const Car({this.model, String license, String brand})
      : super(
          license: license,
          brand: brand,
        );

  /// Factory constructors can basically be seen as 'static constructors'.
  factory Car.unbranded({String license}) {
    return Car(license: license);
  }

  /// Implement `isHighClass` from [Vehicle]
  @override
  bool isHighClass() {
    final highClassBrands = ['Tesla', 'Lexus', 'Rolls-Royce'];
    return highClassBrands.contains(brand);
  }
}

void carDemo() {
  // final vehicle = Vehicle(brand: 'Toyota', license: 'SGP1294O'); /// Will throw an error
  final car = Car(
    brand: 'Toyota',
    license: 'SGP1294O',
    model: 'Corolla',
  );
  print(car.isHighClass()); // false

  final anotherCar = Car(
    brand: 'Tesla',
    license: 'SGP1632J',
    model: 'Model X',
  );
  print(anotherCar.isHighClass()); // true

  final unbrandedCar = Car.unbranded(
    license: 'SEX2592Y',
  );
  print(unbrandedCar.isHighClass()); // false
}

//////////////////////////////////////////////////////////////////////////////////////////////////

/// ### Generics & enums + equality & hashCodes
///
/// Classes can also take in generic types, which can be used to apply to its instance variables.
class Tuple<A, B> {
  final A first;
  final B second;
  const Tuple(this.first, this.second);

  /// Operator methods
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (!other is Tuple<A, B>) return false;
    final Tuple<A, B> typedOther = other;
    return first == typedOther.first && second == typedOther.second;
  }

  @override
  String toString() {
    return '$runtimeType($first, $second)';
  }

  /// There is also a need to override the [hashCode] getter,
  /// after overriding the [==] operator, and vice versa.
  @override
  int get hashCode => 997 * first.hashCode ^ 991 * second.hashCode;
}

void tupleDemo() {
  final tupleList = [
    Tuple(0, 'one'),
    Tuple(1, 'two'),
    Tuple(2, 'three'),
  ];
  for (var tuple in tupleList) {
    print(tuple);
    assert(tuple is Tuple<int, String>);
  }
  final anotherTuple = Tuple(0, 'one');

  /// These 2 tuples are of different instances/references
  assert(!identical(tupleList.first, anotherTuple));
  /// Yet, there are equal because of the `==` override
  assert(tupleList.first == anotherTuple);
  print('${tupleList.first.hashCode}, ${anotherTuple.hashCode}');
}

//////////////////////////////////////////////////////////////////////////////////////////////////

void main() {
  pointDemo();
  printDivider();
  immutablePointDemo();
  printDivider();
  positivePointDemo();
  printDivider();
  carDemo();
  printDivider();
  tupleDemo();
}

void printDivider() {
  print('-----------------------------');
}