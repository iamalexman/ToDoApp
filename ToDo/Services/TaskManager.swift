//
//  TaskManager.swift
//  ToDo
//
//  Created by Alex Smith on 11.02.2023.
//

import Foundation

class Task {
	var title: String
	var completed = false
	
	init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

final class RegularTask: Task { }

final class ImportantTask: Task {
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}
	
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}
	
	var taskPriority: TaskPriority
	
	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}

final class TaskManager {
	
	private var taskList = [Task]()
	
	func allTasks() -> [Task] {
		taskList
	}
	
	func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}
	
	func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}
	
	func addTask(task: Task) {
		taskList.append(task)
	}
	
	func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
