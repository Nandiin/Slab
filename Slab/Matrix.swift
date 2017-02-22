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
    var data: [Element]
    public init(rows: Int, columns: Int, repeating: Element = 0) {
        self.rows = rows
        self.columns = columns
        self.data = [Element](repeating: repeating, count: rows * columns)
    }

    public init(rows: Int, columns: Int, copying array: [Element]) {
        precondition(array.count == rows * columns)
        self.rows = rows
        self.columns = columns
        self.data = array
    }

    public subscript(_ row: Int, _ column: Int) -> Element {
        get {
            precondition(row > 0 && column > 0 && row <= rows && column <= columns)
            return data[(row - 1) * columns + (column - 1)]
        }
        set {
            precondition(row > 0 && column > 0 && row <= rows && column <= columns)
            data[(row - 1) * columns + (column - 1)] = newValue
        }
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
        return lhs.rows == rhs.rows && lhs.columns == rhs.columns && lhs.data == rhs.data
    }
}
