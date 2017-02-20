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

class MatrixSpec: QuickSpec {
    override func spec() {
        describe("Matrix") {
            var aMatrix: Matrix<Double>!
            beforeEach {
                aMatrix = Matrix<Double>(rows: 3, columns: 2)
            }
            describe("row count") {
                it("should match the constructor") {
                    expect(aMatrix.rows) == 3
                }
            }
            describe("column count") {
                it("should match the constructor") {
                    expect(aMatrix.columns) == 2
                }
            }
        }
    }
}
