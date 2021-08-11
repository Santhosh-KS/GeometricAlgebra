//
//  Tests.swift
//  Tests
//
//  Created by Santhosh K S on 01/08/21.
//

@testable import LibGeometricAlgebra
import XCTest

class Tests: XCTestCase {
  let zero = GeometricVector<Float>.zero
  let one = GeometricVector.one
  let e0 = GeometricVector<Float>.e0
  let e1 = GeometricVector<Float>.e1
  let e2 = GeometricVector<Float>.e2
  let e3 = GeometricVector<Float>.e3
  
  
  func testInitialization() {
    let defaultInit = GeometricVector<Float>()
    XCTAssert(defaultInit.a == 0)
    XCTAssert(defaultInit.x == 0)
    XCTAssert(defaultInit.y == 0)
    XCTAssert(defaultInit.b == 0)
    
    let onlyA = GeometricVector<Float>.init(a: 2)
    XCTAssert(onlyA.a == 2)
    XCTAssert(onlyA.x == 0)
    XCTAssert(onlyA.y == 0)
    XCTAssert(onlyA.b == 0)
    
    let onlyX = GeometricVector<Float>.init(x: -2)
    XCTAssert(onlyX.a == 0)
    XCTAssert(onlyX.x == -2)
    XCTAssert(onlyX.y == 0)
    XCTAssert(onlyX.b == 0)
    
    let onlyY = GeometricVector<Float>.init(y: -2)
    XCTAssert(onlyY.a == 0)
    XCTAssert(onlyY.x == 0)
    XCTAssert(onlyY.y == -2)
    XCTAssert(onlyY.b == 0)
    
    let onlyB = GeometricVector<Float>.init(b: -2)
    XCTAssert(onlyB.a == 0)
    XCTAssert(onlyB.x == 0)
    XCTAssert(onlyB.y == 0)
    XCTAssert(onlyB.b == -2)
    
    let XY = GeometricVector<Float>.init(x: -10, y: 20)
    XCTAssert(XY.a == 0)
    XCTAssert(XY.x == -10)
    XCTAssert(XY.y == 20)
    XCTAssert(XY.b == 0)
    
  }
  
  func testZeroOneVectors() {
    let a = GeometricVector.zero
    XCTAssert(a.a == 0)
    XCTAssert(a.x == 0)
    XCTAssert(a.y == 0)
    XCTAssert(a.b == 0)
    
    let defaultInit = GeometricVector<Float>()
    XCTAssert(a == defaultInit)
    
    let one = GeometricVector.one
    XCTAssert(one.a == 1.0)
    XCTAssert(one.x == 1.0)
    XCTAssert(one.y == 1.0)
    XCTAssert(one.b == 1.0)
    let oneWith = GeometricVector.init(with: Float(1.0))
    XCTAssert(one == oneWith)
  }
  
  func testBasisVectors() {
    // Test e0 basis vector
    XCTAssert(e0.a == 1)
    XCTAssert(e0.x == 0)
    XCTAssert(e0.y == 0)
    XCTAssert(e0.b == 0)
    
    // Test e1 basis vector
    XCTAssert(e1.a == 0)
    XCTAssert(e1.x == 1)
    XCTAssert(e1.y == 0)
    XCTAssert(e1.b == 0)
    
    // Test e2 basis vector
    XCTAssert(e2.a == 0)
    XCTAssert(e2.x == 0)
    XCTAssert(e2.y == 1)
    XCTAssert(e2.b == 0)
    
    // test e3 bivector
    XCTAssert( e3.a == 0)
    XCTAssert( e3.x == 0)
    XCTAssert( e3.y == 0)
    XCTAssert( e3.b == 1)
  }
  
  func testAdditionOperations() {
    XCTAssert(zero + zero == zero)
    XCTAssert(zero + one == one)
    XCTAssert(one + zero == one)
    XCTAssert(one + one == GeometricVector<Float>(with: 2))
    
    // Test Symmetric property
    let A = (2 * e1) + (3 * e2)
    let B = (3 * e2) + (2 * e1)
    XCTAssert( A == B)
    
    
    // Test associative property
    XCTAssert(one + one + GeometricVector<Float>(with: 2) ==
                GeometricVector<Float>(with: 4))
    XCTAssert(one  + GeometricVector<Float>(with: 2) + one ==
                GeometricVector<Float>(with: 4))
    XCTAssert(GeometricVector<Float>(with: 2) + one + one ==
                GeometricVector<Float>(with: 4))
    
  }
  
  func testSubtractionOperations() {
    XCTAssert(zero - zero == zero)
    XCTAssert(zero - one != one)
    XCTAssert(zero - one == -one)
    XCTAssert(one - zero == one)
    XCTAssert(one - one == zero)
    XCTAssert(GeometricVector<Float>(with: 2) - one == one)
    XCTAssert(one - GeometricVector<Float>(with: 2) != one)
    XCTAssert(one - GeometricVector<Float>(with: 2) == -one)
  }
  
  func testScalarMultiplicationOperations()  {
    let zero = GeometricVector<Float>.zero
    let one = GeometricVector.one
    let v = GeometricVector<Float>(with: -2)
    
    
    // Symmetric property.
    XCTAssert(0 * zero == zero * 0)
    XCTAssert(one.a * zero == zero * one.a)
    XCTAssert(0 * one == one * 0)
    XCTAssert(one.a * one == one.a * one)
    XCTAssert(one.a * v == v * one.a)
    XCTAssert(-2 * one == v)
  }
  
  func testDivisionOperationsOnFloats() {
    let v = GeometricVector<Float>(with: -2)
    
    
    XCTAssert(zero/zero == zero)
    XCTAssert(one/zero == zero)
    XCTAssert(v/zero == zero)
    XCTAssert(e0/e0 == GeometricVector<Float>(a: 1))
    XCTAssert(e0/e1 == zero)
    XCTAssert(e0/e2 == zero)
    XCTAssert(e0/e3 == zero)
    
    XCTAssert(e0/(e0 * v.a) == GeometricVector<Float>(a: (1/v.a)))
    XCTAssert((e0 * v.a)/e0 == GeometricVector<Float>(a: (v.a)))
    
    XCTAssert(e1/(e1 * v.a) == GeometricVector<Float>(a: (1/v.a)))
    XCTAssert((e1 * v.a)/e1 == GeometricVector<Float>(a: (v.a)))
    
    XCTAssert(e2/(e2 * v.a) == GeometricVector<Float>(a: (1/v.a)))
    XCTAssert((e2 * v.a)/e2 == GeometricVector<Float>(a: (v.a)))
    
    XCTAssert(e3/(e3 * v.a) == GeometricVector<Float>(a: (1/v.a)))
    XCTAssert((e3 * v.a)/e3 == GeometricVector<Float>(a: (v.a)))
    
    
    XCTAssert(e0/(e0 * 5) == GeometricVector<Float>(a: 0.2))
    XCTAssert((e0 * 5)/e0 == GeometricVector<Float>(a: 5))
    
    XCTAssert(e1/(e1 * 5) == GeometricVector<Float>(a: 0.2))
    XCTAssert((e1 * 5)/e1 == GeometricVector<Float>(a: 5))
    
    XCTAssert(e2/(e2 * 5) == GeometricVector<Float>(a: 0.2))
    XCTAssert((e2 * 5)/e2 == GeometricVector<Float>(a: 5))
    
    XCTAssert(e3/(e3 * 5) == GeometricVector<Float>(a: 0.2))
    XCTAssert((e3 * 5)/e3 == GeometricVector<Float>(a: 5))
    
    // A  = 10 + 5 e1 + 0.6 e2 + 8 e1 ∧ e2
    // B  = -3 - 7 e1 - 0.78 e2 + 4 e1 ∧ e2
    let A1 = 10 * e0 + (5 * e1) + (0.6 * e2)
    let A = A1 + (8 * e3)
    let B1 = -3 * e0 + (-7 * e1) + (0.78 * e2)
    let B  = B1 + (4 * e3)
    
    let aBybCoeff:Float = ((10 / -3) + (5 / -7))
    let aByb = aBybCoeff  + ((0.6 / 0.78) + (8 / 4))
    XCTAssert(A/B == GeometricVector<Float>(a: aByb))
    
    let bByaCoeff:Float = ((-3 / 10) + (-7 / 5))
    let bBya = bByaCoeff  + ((0.78 / 0.6) + (4 / 8))
    XCTAssert(B/A == GeometricVector<Float>(a: bBya))
    
    XCTAssert(A/B != B/A)
  }
  
  func testDotProductOperations() {
    let unitScalar = GeometricVector<Float>(a: 1)
    XCTAssert(e0 | e0 == unitScalar)
    XCTAssert(e1 | e1 == unitScalar)
    XCTAssert(e2 | e2 == unitScalar)
    XCTAssert(e3 | e3 == unitScalar)
    
    
    XCTAssert(e0 | e1 == zero)
    XCTAssert(e0 | e2 == zero)
    XCTAssert(e0 | e3 == zero)
    
    XCTAssert(e1 | e0 == zero)
    XCTAssert(e1 | e2 == zero)
    XCTAssert(e1 | e3 == zero)
    
    XCTAssert(e2 | e0 == zero)
    XCTAssert(e2 | e1 == zero)
    XCTAssert(e2 | e3 == zero)
    
    XCTAssert(e3 | e0 == zero)
    XCTAssert(e3 | e1 == zero)
    XCTAssert(e3 | e2 == zero)
    
    XCTAssert(one | one == GeometricVector<Float>(a: 4))
    XCTAssert(one | (2 * one) == GeometricVector<Float>(a: 8))
    XCTAssert((2 * one) | one == GeometricVector<Float>(a: 8))
    
    let A = 2 * e1
    let B = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    let C = 80 * e0 + 40 * e3
    
    // Symmetric property
    XCTAssert(one | (2 * one) == (2 * one) | one)
    XCTAssert(A | B == B | A)
    
    // Associative property
    //    e1 | (e2 | e3) = 0
    //    (e1 | e2) | e3 = 0
    // False friends.
    XCTAssert(e1 | (e2 | e3) == (e1 | e2) | e3)
    
    //    A | (B | C) = 0
    //    (A | B) | C = 320.0
    XCTAssert(A | (B | C) != (A | B) | C)
  }
  
  func testReverseOperation() {
    
    XCTAssert(~e0 == e0)
    XCTAssert(~e1 == e1)
    XCTAssert(~e2 == e2)
    
    // Reverse operations affect only bivectors and negates the sign of its co-efficients.
    XCTAssert(~e3 == (e3 * Float(-1.0)))
    
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    XCTAssert(~R == GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: -10))
  }
  
  func testLeftContraction() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    
    let res = L << R
    
    XCTAssert(res.a == (L.a * R.a) + (L.x * R.x) + (L.y * R.y) - (L.b * R.b))
    XCTAssert(res.x == (L.a * R.x) - (L.y * R.b))
    XCTAssert(res.y == (L.a * R.y) + (L.x * R.b))
    XCTAssert(res.b == (L.a * R.b))

  }
  
  func testRightContraction() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    
    let res = L >> R
    XCTAssert(res.a == (L.a * R.a) + (L.x * R.x) + (L.y * R.y) - (L.b * R.b))
    
    XCTAssert(res.x == (L.a * R.x) + (L.y * R.b))
    XCTAssert(res.y == (L.a * R.y) + (L.x * R.b))
    XCTAssert(res.b == (L.a * R.b))
  }
  
  func testWedgeOperation() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    
    let res = (L.x * R.y) - (L.y * R.x)
    XCTAssert((L ^ R).b == res)
    XCTAssert((L ^ R) == GeometricVector(b: res))
  }
  
  func testNegationOperation() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    
    XCTAssert(-L == GeometricVector<Float>(a: -1 * L.a,
                                           x: -1 * L.x,
                                           y: -1 * L.y,
                                           b: -1 * L.b))
    
    XCTAssert(-L == L.neg())
    XCTAssert(L.negation() == L.neg())
  }
  
  func testGeometricInteriorProduct() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    
    let a1 = (L.a * R.a)
    let a = a1 + (L.x * R.x) + (L.y * R.y) - (L.b * R.b)
    let x1 = (L.a * R.x)
    let x = x1 + (L.x * R.a) - (L.y * R.b) + (L.b * R.y)
    let y1 = (L.a * R.y)
    let y = y1 + (L.x * R.b) + (L.y * R.a) - (L.b * R.x)
    let b1 = (L.a * R.b)
    let b = b1 + (L.x * R.y) - (L.y * R.x) + (L.b * R.a)
    
    let res  = L ^*^ R
    
    XCTAssert(res.a == a)
    XCTAssert(res.x == x)
    XCTAssert(res.y == y)
    XCTAssert(res.b == b)
  }
  
  func testGeometricExteriorPrduct() {
    let L = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
    let R = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
    
    let a = (L.a * R.a)
    let x = (L.a * R.x) + (L.x * R.a)
    let y = (L.a * R.y) + (L.y * R.a)
    let b1 = (L.a * R.b) + (L.x * R.y) - (L.y * R.x)
    let b = b1 + (L.b * R.a)
    
    let res  = L ^^^ R
    
    XCTAssert(res.a == a)
    XCTAssert(res.x == x)
    XCTAssert(res.y == y)
    XCTAssert(res.b == b)
  }
  
  func testUnitVector() {
    let angle:Float = 30
    let A = GeometricVector.unit2D(angle: angle)
    let r:Float =  Float(angle) * Float.pi/180
    
    XCTAssert(A.x == cos(r) * r)
    XCTAssert(A.y == sin(r) * r)
  }
  
}
