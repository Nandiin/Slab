//
//  MatrixSpec.swift
//  Slab
//
//  Created by 南丁 on 2017/2/9.
//  Copyright © 2017年 nandiin. All rights reserved.
//

import Nimble
import Quick
@testable import Slab


fileprivate func allPass<T, U>(_ matcher: T) -> NonNilMatcherFunc<Matrix<U>>
    where T: Matcher, U == T.ValueType {
        return NonNilMatcherFunc {
            actualExpression, failureMessage in
            failureMessage.actualValue = nil
            if let actualValue = try actualExpression.evaluate() {
                for row in 1...actualValue.rows {
                    for column in 1...actualValue.columns {
                        let currentElement = actualValue[row, column]
                        let exp = Expression(expression: { currentElement }, location: actualExpression.location)
                        if try !matcher.matches(exp, failureMessage: failureMessage) {
                            failureMessage.postfixMessage =
                                "all \(failureMessage.postfixMessage),"
                                + " but failed first at (\(row), \(column)), got <\(stringify(currentElement))>"
                            return false
                        }
                    }
                }
                failureMessage.postfixMessage = "all \(failureMessage.postfixMessage)"
            } else {
                failureMessage.postfixMessage = "all pass (use beNil() to match nils)"
                return false
            }
            
            return true
        }
}

fileprivate func equal<T>(_ expectedValue: [T]) -> NonNilMatcherFunc<Matrix<T>> {
    return NonNilMatcherFunc {
        actualExpression, failureMessage in
        failureMessage.postfixMessage = "equal <\(stringify(expectedValue))>"
        let actualValue = try actualExpression.evaluate()
        return actualValue! == expectedValue
    }
}

fileprivate extension Matrix {
    static func ==<T>(lhs: Matrix<T>, rhs: [T]) -> Bool {
        guard rhs.count == lhs.columns * lhs.rows else { return false }
        for row in 0..<lhs.rows {
            for column in 0..<lhs.columns {
                if rhs[row * lhs.columns + column] != lhs[row + 1, column + 1] {
                    return false
                }
            }
        }
        return true
    }
}

class MatrixSpec: QuickSpec {
    override func spec() {
        describe("Matrix") {
            var aMatrix: Matrix<Double>!
            beforeEach {
                aMatrix = Matrix<Double>(rows: 3, columns: 2)
            }
            
            context("when created") {
                typealias ItShouldClosure = () -> Void
                func itShouldMatchPassedArg<T>(_ actual: @autoclosure @escaping () -> T, _ expected: T) -> ItShouldClosure
                where T: Equatable {
                    return {
                       it("should match passed argument") {
                           expect(actual()) == expected
                       }
                    }
                }

                describe("row count", itShouldMatchPassedArg(aMatrix.rows, 3))
                describe("column count", itShouldMatchPassedArg(aMatrix.columns, 2))

            }

            describe("repeating constructor") {
                context("by default") {
                    it("should set all elements to zero") {
                        expect(aMatrix).to(allPass(equal(0)))
                    }
                }
                context("when a value provided") {
                    it("should set all elements to that value") {
                        let aMatrix = Matrix<Double>(rows: 3, columns: 2, repeating: 1)
                        expect(aMatrix).to(allPass(equal(1)))
                    }
                }
            }

            describe("array copying constructor") {
                var array: [Double]!
                var matrixCopyingArray: Matrix<Double>!
                beforeEach {
                    array = [1, 2, 3, 4, 5, 6]
                    matrixCopyingArray = Matrix<Double>(rows: 3, columns: 2, copying: array)
                }
                it("should accept elements in row major order") {
                    expect(matrixCopyingArray).to(equal(array))
                }
                it("should copy the array") {
                    array[1] = 10
                    expect(matrixCopyingArray).toNot(equal(array))
                }
            }

            describe("subscript") {
                let itShouldThrowAssertion = {
                    (row: Int, column: Int) -> () -> Void in
                    let description = "expected accessing (\(row), \(column)) would throw an assertion"
                    return {
                        it("should throw assertion") {
                            expect {
                                let _ = aMatrix[row, column]
                                return ()
                            }.to(throwAssertion(), description: description)
                            expect {
                                aMatrix[row, column] = 1
                                return ()
                            }.to(throwAssertion(), description: description)
                        }
                    }
                }
                context("when passed a non-positive row index", itShouldThrowAssertion(0, 1))
                context("when passed a non-positive column index", itShouldThrowAssertion(1, 0))
                context("when passed a exceeding row index", itShouldThrowAssertion(4, 1))
                context("when passed a exceeding column index", itShouldThrowAssertion(1, 3))
                context("when passed valid indices") {
                    it("should return correct value of the element") {
                        let aMatrix = Matrix<Double>(rows: 3, columns: 2, copying: [1, 2, 3, 4, 5, 6])
                        expect(aMatrix[1, 1]) == 1
                        expect(aMatrix[1, 2]) == 2
                        expect(aMatrix[2, 1]) == 3
                        expect(aMatrix[2, 2]) == 4
                        expect(aMatrix[3, 1]) == 5
                        expect(aMatrix[3, 2]) == 6
                    }

                    it("should correctly assign element") {
                        aMatrix[1, 1] = 10
                        aMatrix[2, 2] = 5
                        expect(aMatrix).to(equal([10, 0, 0, 5, 0, 0]))
                    }
                }
            }
            
            itIsValueObject {
                () -> [String:[Matrix<Double>]] in
                [ "base": [ aMatrix ],
                  "same": [ Matrix<Double>(rows: 3, columns: 2) ],
                  "different": [
                          Matrix<Double>(rows: 4, columns: 2),
                          Matrix<Double>(rows: 3, columns: 3),
                          Matrix<Double>(rows: 3, columns: 2, repeating: 1)
                  ]
                ]
            }
        }
    }
}
