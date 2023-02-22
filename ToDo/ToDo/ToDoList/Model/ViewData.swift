//
//  ViewData.swift
//  ToDo
//
//  Created by Alex Smith on 19.02.2023.
//

import Foundation

/// View model for tableView
struct ViewData {
	let sections: [String]
	var completedTasks: [TaskViewModel]
	var uncompletedTasks: [TaskViewModel]
}

struct TaskViewModel {
	var isExpired: Bool
	var isCompleted: Bool
	let isImportantTask: Bool
	let title: String
	let deadline: String
	let priorityTag: String?
	let priority: Priority?
	
	mutating func checkTask() {
		isCompleted.toggle()
	}
}

enum Priority {
	case low
	case medium
	case high
}
