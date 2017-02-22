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

extension Matrix : Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
        return lhs.rows == rhs.rows && lhs.columns == rhs.columns
    }
}

