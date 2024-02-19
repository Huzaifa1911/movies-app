//
//  String+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 13/02/2024.
//

import Foundation

extension String {
    func formatDate(inputFormat: String? = "yyyy-mm-dd", outputFormat: String? = "dd-MM-yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
