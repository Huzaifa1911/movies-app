//
//  Dictionary+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import Foundation

extension Dictionary {
    func get(at i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
