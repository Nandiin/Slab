//
//  Matrix.swift
//  Slab
//
//  Created by 南丁 on 2017/2/9.
//  Copyright © 2017年 nandiin. All rights reserved.
//

public struct Matrix<T> where T: FloatingPoint, T: ExpressibleByFloatLiteral {
    public typealias Element = T
    public let rows: Int
    public let columns: Int
    public init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
    }
}
