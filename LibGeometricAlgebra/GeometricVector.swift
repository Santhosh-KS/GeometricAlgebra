//
//  GeometricVector.swift
//  GeometricAlgebra
//
//  Created by Santhosh K S on 01/08/21.
//

import Foundation

//protocol VectorRepresentable {
//  associatedtype Element
//  var x: Element { get }
//  var y: Element { get }
//}

/// A Scalar Vector in two dimension
/// - Parameter a:  a the coefficient corresponding to one, the unit scalar.
/// - Parameter x : x  the coefficient  correspoinding to  e1 basis unit vector
/// - Parameter y : y  the coefficient  correspoinding to  e2 basis unit vector
/// - Parameter b : b  the coefficient  correspoinding to  e1^e2 basis unit vector i.e Bivector!

// struct Vector<Element: Numeric> : VectorRepresentable {
public struct GeometricVector<Element: Numeric>: Equatable {
  let a: Element
  let x: Element
  let y: Element
  let b: Element
}

// MARK:- Initializers

public extension GeometricVector {
  init() {
    self.a = .zero
    self.x = .zero
    self.y = .zero
    self.b = .zero
  }
}

public extension GeometricVector {
  init(with value: Element) {
    self.a = value
    self.x = value
    self.y = value
    self.b = value
  }
}

public extension GeometricVector  {
  init(a : Element) {
    self.a = a
    self.x = .zero
    self.y = .zero
    self.b = .zero
  }
}

public extension GeometricVector  {
  init(x : Element) {
    self.a = .zero
    self.x = x
    self.y = .zero
    self.b = .zero
  }
}

public extension GeometricVector  {
  init(y : Element) {
    self.a = .zero
    self.x = .zero
    self.y = y
    self.b = .zero
  }
}

public extension GeometricVector {
  init(b : Element) {
    self.a = .zero
    self.x = .zero
    self.y = .zero
    self.b = b
  }
}

public extension GeometricVector  {
  init(x : Element, y : Element) {
    self.a = .zero
    self.x = x
    self.y = y
    self.b = .zero
  }
}

extension GeometricVector : CustomStringConvertible where Element : Comparable {
  public var description: String {
    var sv = [String]()
    if self.a != 0 {
      sv.append("\(self.a)")
    }
    if self.x != 0 {
      sv.append("\(self.x > 0 ? (sv.isEmpty ? "" : "+") : "")\(self.x)e1")
    }
    if self.y != 0 {
      sv.append("\(self.y > 0 ? (sv.isEmpty ? "" : "+") : "")\(self.y)e2")
    }
    if self.b != 0 {
      sv.append("\(self.b > 0 ? (sv.isEmpty ? "" : "+") : "")\(self.b)e1∧e2")
    }
    if sv.isEmpty {
      sv.append("0")
    }
    return sv.joined(separator: "")
    //    return "\(self.a) * e0 \(sign(self.x)) \(abs(self.x)) * e1 \(sign(self.y)) \(abs(self.y)) * e2 \(sign(self.b)) \(abs(self.b)) * e1^e2"
  }
}


// MARK:- e1, e2 ... basis vectors

public extension GeometricVector  where Element == Float {
  
  // Scalar
  static var e0: Self {
    .init(a: 1)
  }
  
  static var e1: Self {
    .init(x: 1)
  }
  
  static var e2: Self {
    .init(y: 1)
  }
  
  // Bivector
  static var e3: Self {
    .init(b: 1)
  }
  
}

// MARK:- Zero and One Vector
public extension GeometricVector where Element == Float {
  static var zero: Self  {
    GeometricVector(with: .zero)
  }
  static var one: Self  {
    GeometricVector(with: 1)
  }
}

// MARK:- Operator Overloading.
precedencegroup VectorOperationOverloads {
  associativity: left
}

infix operator ^*^: VectorOperationOverloads  // inner product.
infix operator ^^^: VectorOperationOverloads  // Exterior product.


public prefix func -<A:Numeric>(_ gv:GeometricVector<A>) -> GeometricVector<A> {
  //  GeometricVector<A>.init(a: gv.a * -1, x: gv.x * -1, y: gv.y * -1, b: gv.b * -1)
  gv.neg()
}
extension GeometricVector {
  static public func + (_ lhs:Self, _ rhs: Self )  -> Self  {
    .init(a: lhs.a + rhs.a,
          x: lhs.x + rhs.x,
          y: lhs.y + rhs.y,
          b: lhs.b + rhs.b)
  }
}

extension GeometricVector {
  static public func - (_ lhs:Self, _ rhs: Self )  -> Self  {
    .init(a: lhs.a - rhs.a,
          x: lhs.x - rhs.x,
          y: lhs.y - rhs.y,
          b: lhs.b - rhs.b)
  }
  
}

// MARK:- Scalar multiplication on a vector

extension GeometricVector {
//  static public func * (_ lhs:Self, _ rhs: Self )  -> Self  {
//    .init(a: lhs.a * rhs.a,
//          x: lhs.x * rhs.x,
//          y: lhs.y * rhs.y,
//          b: lhs.b * rhs.b)
//  }
  static public func * (_ a:Element, _ v:Self) -> Self  {
    .init(a: v.a * a, x: v.x * a, y: v.y * a, b: v.b * a)
  }
  
  static public func *  (_ v:Self , _ a:Element ) -> Self {
    a * v
  }
}


// MARK:- Dot product
// Assuming orthogonal basis
// TODO: Need to find a better operator symbol
extension GeometricVector {
  static public func | (_ lhs:Self, _ rhs:Self) -> Self {
    let a1 = lhs.a * rhs.a + lhs.x * rhs.x
    let a = a1 + lhs.y * rhs.y + lhs.b * rhs.b
    return .init(a: a, x: 0, y:0, b:0)
  }
  public func scalarProduct (_ rhs:Self) -> Self {
    return self | rhs
  }
}

// MARK:- Reversion
extension GeometricVector {
  static public prefix func ~(_ gv:Self) -> Self {
    .init(a: gv.a, x: gv.x, y: gv.y, b: -1 * gv.b)
  }
  
  public func reverse() -> Self {
    ~self
  }
  
  func rev() -> Self {
    reverse()
  }
  
}

// NOTE: This division is incorrect
//public func / (_ lhs:GeometricVector<Float>, _ rhs: GeometricVector<Float> ) -> GeometricVector<Float>?  {
//  if rhs.a == .zero, rhs.x == .zero, rhs.y == .zero {
//    return nil
//  }
//  return .init(a: lhs.a / rhs.a,
//               x: lhs.x / rhs.x,
//               y: lhs.y / rhs.y)
//}

extension GeometricVector where Element == Float{
//  TODO: Division operations are only supported on Float data types. make it generic.
  static public func / (_ lhs:Self, _ rhs: Self ) -> Self  {
    var a:Float = .zero
    if rhs.a != .zero {
      a += Float(lhs.a/rhs.a)
    }
    if rhs.x != .zero {
      a += Float(lhs.x/rhs.x)
    }
    if rhs.y != .zero {
      a += Float(lhs.y/rhs.y)
    }
    if rhs.b != .zero {
      a += Float(lhs.b/rhs.b)
    }
    return .init(a: a)
  }
}



// MARK:- Exterior product
// equation(ax * by - ay * bx) * e1 ^ e2
func exteriorProduct<A:Numeric>(_ a:GeometricVector<A>, _ b:GeometricVector<A>) -> GeometricVector<A> {
//  GeometricVector(b: (a.x * b.y) - (a.y * b.x))
  a ^ b
}

// Wedge operation
extension GeometricVector {
  static public func ^(_ a:Self, _ b:Self) -> Self {
    .init(b: (a.x * b.y) - (a.y * b.x))
  }
  
  func wedge( _ b:Self) -> Self {
    self ^ b
  }
}


// MARK:- Negation
public extension GeometricVector  {
  func negation() -> Self {
    -self
//    GeometricVector(a: self.a * -1, x: self.x * -1, y: self.y * -1, b: self.b * -1)
  }
  
  func neg() -> Self {
    negation()
  }
  
  static prefix func -(_ v:Self) -> Self {
    GeometricVector<Element>(a: -1 * v.a, x: -1 * v.x, y: -1 * v.y, b: -1 * v.b)
  }
}

// MARK:- Contraction
// MARK:- Left contraction
// e1 << e1 = 1
// e1 << e2 = 0
// e1 << (e1 ^ e2) = e2
// e1 << (e2 ^ e1) = e1 << (- e1 ^ e2) = -e2
// (e1 ^ e2) << (e1 ^ e2) =  e1 << (e2 << (e1 ^ e2)) = e1 << (e2 << -(e2 ^ e1)) = e1 << -e1 = -1

// if we take scalar out of a vector or scalar i.e the following case a = scalar quantity.
// a << rhs = a*rhs

// lhs << a = 0, if lhs is a not a scalar.

// Left Contraction Table
// |--------|--------|--------|--------|----------|
// |   <<   |   Ra   |  Rx*e1 |  Ry*e2 | Rb*e1^e2 |
// |--------|--------|--------|--------|----------|
// |   La   |  LaRa  | LaRx*e1| LaRy*e2|LaRb*e1^e2|
// |--------|--------|--------|--------|----------|
// |  Lxe1  |    0   |  LxRx  |    0   |  LxRb*e2 |
// |--------|--------|--------|--------|----------|
// |  Lye2  |    0   |    0   |  LyRy  | -LyRb*e1 |
// |--------|--------|--------|--------|----------|
// |Lbe1^e2 |    0   |    0   |    0   |  -LbRb   |
// |--------|--------|--------|--------|----------|

// Contraction on bivector is equivalent of rotation.

fileprivate func leftContraction<A:Numeric>(_ lhs:GeometricVector<A>,
                                            _ rhs: GeometricVector<A>) -> GeometricVector<A> {
  let La = lhs.a
  let Ra = rhs.a
  let Lx = lhs.x
  let Rx = rhs.x
  let Ly = lhs.y
  let Ry = rhs.y
  let Lb = lhs.b
  let Rb = rhs.b
  //  let a = (La * Ra) + (Lx * Rx) + (Ly * Ry) - (Lb * Rb)
  let a1 = (La * Ra) + (Lx * Rx) + (Ly * Ry)
  let a = a1 - (Lb * Rb)
  let x = (La * Rx) - (Ly * Rb)
  let y = (La * Ry) + (Lx * Rb)
  let b = La * Rb
  return GeometricVector<A>(a: a, x: x, y: y, b: b)
}

extension GeometricVector {
  static public func << (_ lhs:Self,_ rhs: Self) -> Self {
    leftContraction(lhs, rhs)
  }
}

// MARK:- Right Contraction Table
// |--------|----------|--------|--------|----------|
// |   <<   |    Ra    |  Rx*e1 |  Ry*e2 | Rb*e1^e2 |
// |--------|----------|--------|--------|----------|
// |   La   |   LaRa   |   0    |    0   |     0    |
// |--------|----------|--------|--------|----------|
// |  Lxe1  |  LaRx*e1 |  LxRx  |    0   |     0    |
// |--------|----------|--------|--------|----------|
// |  Lye2  |  LaRy*e2 |    0   |  LyRy  |     0    |
// |--------|----------|--------|--------|----------|
// |Lbe1^e2 |LaRb*e1^e2| LxRb*e2| LyRb*e1|  -LbRb   |
// |--------|----------|--------|--------|----------|


fileprivate func rightContraction<A:Numeric>(_ lhs:GeometricVector<A>,
                                             _ rhs: GeometricVector<A>) -> GeometricVector<A> {
  let La = lhs.a
  let Ra = rhs.a
  let Lx = lhs.x
  let Rx = rhs.x
  let Ly = lhs.y
  let Ry = rhs.y
  let Lb = lhs.b
  let Rb = rhs.b
  
  //  let a = (La * Ra) + (Lx * Rx) + (Ly * Ry) - (Lb * Rb)
  let a1 = (La * Ra) + (Lx * Rx) + (Ly * Ry)
  let a = a1 - (Lb * Rb)
  let x = (La * Rx) + (Ly * Rb)
  let y = (La * Ry) + (Lx * Rb)
  let b = La * Rb
  return GeometricVector<A>(a: a, x: x, y: y, b: b)
}

extension GeometricVector {
  static public func >>(_ lhs: Self,_ rhs: Self) -> Self {
    rightContraction(lhs, rhs)
  }
}


// MARK:- Geometric Product

// ab = 1/2 ab + 1/2 ab = 1/2(ab + ab)
//    = 1/2 (ab + ba + ab - ba) = 1/2(ab + ba) + 1/2(ab - ba)
//    = a · b + a ∧ b where a and b are vectors

// associative property: (ab)c = a(bc)
// Distributive property: a(b+c) = ab + ac , (a+b)c = ac + bc


// Continue to assume orthogonal basis and Euclidean space.
// e1e2 = e1 ∧ e2
// e1e1 = 1
// e1(e1e2) = (e1e1)e2 = 1*e2 = e2

// Table of Geometric Product
// |--------|---------|----------|-------- |----------|
// |    *   |    Ra   |    Rx*e1 |  Ry*e2  | Rb*e1^e2 |
// |--------|---------|----------|-------- |----------|
// |   La   |   LaRa  |  LaRx*e1 | LaRy*e2 |LaRb*e1^e2|
// |--------|---------|----------|-------- |----------|
// |  Lxe1  | LxRae1  |   LxRx   |LxRye1^e2|  LxRb*e2 |
// |--------|---------|----------|-------- |----------|
// |  Lye2  | LyRae2  |-LyRxe1^e2|   LyRy  | -LyRb*e1 |
// |--------|---------|----------|-------- |----------|
// |Lbe1^e2 |LbRae1^e2|  -LbRxe2 | LbRye1  |  -LbRb   |
// |--------|---------|----------|-------- |----------|


// MARK:- Geometric interior product

func geometricInteriorProduct<A:Numeric>(_ lhs:GeometricVector<A>,
                                         _ rhs:GeometricVector<A>) -> GeometricVector<A> {
  
  let La = lhs.a
  let Ra = rhs.a
  let Lx = lhs.x
  let Rx = rhs.x
  let Ly = lhs.y
  let Ry = rhs.y
  let Lb = lhs.b
  let Rb = rhs.b
  
  //  let a = (La * Ra) + (Lx * Rx) + (Ly * Ry) - (Lb * Rb)
  //  let x = (La * Rx) + (Lx * Ra) - (Ly * Rb) + (Lb * Ry)
  //  let y = (La * Ry) + (Lx * Rb) + (Ly * Ra) - (Lb * Rx)
  //  let b = (La * Rb) + (Lx * Ry) - (Ly * Rx) + (Lb * Ra)
  let a1 = (La * Ra)
  let a = a1 + (Lx * Rx) + (Ly * Ry) - (Lb * Rb)
  let x1 = (La * Rx)
  let x = x1 + (Lx * Ra) - (Ly * Rb) + (Lb * Ry)
  let y1 = (La * Ry)
  let y = y1 + (Lx * Rb) + (Ly * Ra) - (Lb * Rx)
  let b1 = (La * Rb)
  let b = b1 + (Lx * Ry) - (Ly * Rx) + (Lb * Ra)
  
  return GeometricVector<A>(a: a, x: x, y: y, b:b)
  
}

extension GeometricVector {
  static public func ^*^ (_ lhs:Self, _ rhs:Self) -> Self {
    geometricInteriorProduct(lhs, rhs)
  }
  
}


// MARK:- Exterior product

// a ∧ b = 1/2(ab - ba)

// a ∧ b ∧ c = 1/6(abc - bac + bca -cba +cab -acb)

// Table of Geometric Exterior Product
// |--------|---------|----------|-------- |----------|
// |    ∧   |    Ra   |    Rx*e1 |  Ry*e2  | Rb*e1^e2 |
// |--------|---------|----------|-------- |----------|
// |   La   |   LaRa  |  LaRx*e1 | LaRy*e2 |LaRb*e1^e2|
// |--------|---------|----------|-------- |----------|
// |  Lxe1  | LxRae1  |     0    |LxRye1^e2|     0    |
// |--------|---------|----------|-------- |----------|
// |  Lye2  | LyRae2  |-LyRxe1^e2|    0    |     0    |
// |--------|---------|----------|-------- |----------|
// |Lbe1^e2 |LbRae1^e2|     0    |    0    |     0    |
// |--------|---------|----------|-------- |----------|

func geometricExteriorProduct<A:Numeric>(_ lhs:GeometricVector<A>,
                                         _ rhs:GeometricVector<A>) -> GeometricVector<A> {
  
  let La = lhs.a
  let Ra = rhs.a
  let Lx = lhs.x
  let Rx = rhs.x
  let Ly = lhs.y
  let Ry = rhs.y
  let Lb = lhs.b
  let Rb = rhs.b
  
  let a = (La * Ra)
  let x = (La * Rx) + (Lx * Ra)
  let y = (La * Ry) + (Ly * Ra)
  let b1 = (La * Rb) + (Lx * Ry) - (Ly * Rx)
  let b = b1 + (Lb * Ra)
  
  return GeometricVector<A>(a: a, x: x, y: y, b:b)
  
}

extension GeometricVector {
  static public func ^^^ (_ lhs:Self, _ rhs:Self) -> Self {
    geometricExteriorProduct(lhs, rhs)
  }
}


// MARK:- Reflection of a vector
// Reflecting a 'vector a' in a line that is perpendicular to a 'unit vector n'.
// a is made up of a parallel component and a perpendicular component.
// i.e a = a∥ +  a⟘
// where : a∥ = (a.n)n
//         a⟘ = a - a∥

// The reflection of a is defined as follows.
// a' = a⟘ - a∥
//    = a - a∥ - a∥
//    = a - 2a∥
//    = a - 2(a.n)n
// Now some math trick to adjust the variables
// a' = a - 2(a.n)n
//    = ann - 2(a.n)n
//    = (an)n - 2(a.n)n
//    = (a·n + a∧n)n - 2(a.n)n
//    = (a·n)n + (a∧n)n - 2(a.n)n
//    = (a∧n)n - (a.n)n
//    = (a∧n - a.n)n
//    = -(n∧a + n.a)n
//    = -(na)n
// ∴ a' = -nan

public func reflection<A:Numeric>(onUnitVector n:GeometricVector<A>,
                                  vector a:GeometricVector<A>) -> GeometricVector<A> {
  return n.neg() ^*^ a ^*^ n
}

public extension GeometricVector {
  func reflection(onUnitVector n:Self) -> Self {
    return n.neg() ^*^ self ^*^ n
  }
}

// MARK:- Unit vector for 2D.
extension GeometricVector where Element == Float {
  static func unit2D(angle d:Float) -> Self {
    let r:Float =  Float(d) * Float.pi/180
    let ret1 =  (cos(r) * GeometricVector<Float>(x: r))
    let ret2 = (sin(r) * GeometricVector<Float>(y: r))
    let ret = ret1 + ret2
    return ret
  }
}


// MARK:- Rotor
// wkt a' = -nan
// a" = mnanm
//        ~       ~
// a" = RaR where R = nm is the reverse of R = mn

func rotor<A:Numeric>(m:GeometricVector<A>,
                      n:GeometricVector<A>,
                      a:GeometricVector<A>) -> GeometricVector<A> {
  let R = m ^*^ n
  return R ^*^ a ^*^ ~R
  //  return (m ^*^ n ^*^ a ^*^ n ^*^ m)
}


