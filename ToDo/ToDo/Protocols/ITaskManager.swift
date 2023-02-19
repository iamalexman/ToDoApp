//
//  ITaskManager.swift
//  ToDo
//
//  Created by Alex Smith on 18.02.2023.
//

/// Base protocol for working wiwth tasks
protocol ITaskManager {
	func addTask(task: Task)
	func addTasks(tasks: [Task])
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
}

extension TaskManager: ITaskManager { }
