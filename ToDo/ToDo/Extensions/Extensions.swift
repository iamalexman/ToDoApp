//
//  Extensions.swift
//  ToDo
//
//  Created by Alex Smith on 14.02.2023.
//

import UIKit

extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
