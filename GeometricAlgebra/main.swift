//
//  main.swift
//  GeometricAlgebra
//
//  Created by Santhosh K S on 01/08/21.
//

import Foundation

import LibGeometricAlgebra

print("Hello, World!")

let a = GeometricVector.zero

print(a)

let one = GeometricVector<Float>.one
print(one)
let any = GeometricVector<Float>.init(with: 10)
print(any)

let sum = a + one
print(a + one)
print(GeometricVector.e0/GeometricVector.e1)

let e0 = GeometricVector<Float>.e0
let e1 = GeometricVector<Float>.e1
let e2 = GeometricVector<Float>.e2
let e3 = GeometricVector<Float>.e3

let A1 = 10 * e0 + (5 * e1) + (0.6 * e2)
let A = A1 + (8 * e3)
let B1 = -3 * e0 + (-7 * e1) + (0.78 * e2)
let B  = B1 + (4 * e3)
print("A = \(A)")
print("B = \(B)")
let aBybCoeff:Float = ((10 / -3) + (5 / -7))
let aByb = aBybCoeff  + ((0.6 / 0.78) + (8 / 4))

print("aByb = \(aByb)")
print("A/B = \(A/B)")

print("Scalar product = \(GeometricVector.one | (2 * GeometricVector.one))")

let A2 = 2 * e1
let B2 = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)
let C2 = 80 * e0 + 40 * e3

print(" A | (B | C) = \(A2 | (B2 | C2))")
print(" (A | B) | C = \((A2 | B2 ) | C2))")

print("e1 | (e2 | e3) = \(e1 | (e2 | e3))")
print("(e1 | e2) | e3 = \((e1 | e2) | e3)")

print("Left contraction = \((2 * e1) << (3 * e1))")
print("Left contraction = \((2 * e0) << (3 * e0))")


let A3 = GeometricVector<Float>(a: 5, x: 4, y: 3, b: 2)
let B3 = GeometricVector<Float>(a: -10, x: 2, y: 0.314, b: 10)

let L = A3 << B3
print("L = \(L)")
