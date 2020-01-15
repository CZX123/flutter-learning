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

  // instance method
  num distanceFrom(Point otherPoint) {
    final xDiff = (otherPoint.x - x).abs();
    final yDiff = (otherPoint.y - y).abs();
    return math.pow(math.pow(xDiff, 2) + math.pow(yDiff, 2), 0.5);
  }

  // Getter without a setter
  num get distanceFromOrigin => distanceFrom(Point.origin());

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
  print(point.distanceFrom(anotherPoint)); // Also 5
}

// An example of an immutable class. All the instance variables must be marked as final,
// and the constructor must be marked as const
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
    return 'Point($x, $y)';
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
    license: 
  );
}

void main() {
  pointDemo();
  immutablePointDemo();
}
