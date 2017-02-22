//
// Created by Nandiin Borjigin on 22/02/2017.
// Copyright (c) 2017 nandiin. All rights reserved.
//

import Nimble
import Quick
@testable import Slab

class MatrixOperationSpec: QuickSpec {
    override func spec() {
        describe("Matrix Operation") {
            describe("Addition") {
                it("should do addition element-wise") {
                    let aMatrix = Matrix<Double>(rows: 3, columns: 2, copying: [1, 2, 3, 4, 5, 6]);
                    let anotherMatrix = Matrix<Double>(rows: 3, columns: 2, copying: [10, 20, 30, 40, 50, 60]);
                    expect(aMatrix + anotherMatrix) == Matrix<Double>(rows: 3, columns: 2, copying: [11, 22, 33, 44, 55, 66]);
                }
            }
        }
    }
}
