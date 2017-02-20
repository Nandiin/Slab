//
//  SlabTests.swift
//  SlabTests
//
//  Created by 南丁 on 2017/2/9.
//  Copyright © 2017年 nandiin. All rights reserved.
//

import Nimble
import Quick

class SimpleSpec: QuickSpec {
    override func spec() {
        describe("simple") {
            it("should pass") {
                expect(1 + 1) == 2
            }
        }
    }
}
