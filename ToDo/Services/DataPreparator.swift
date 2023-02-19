//
//  DataPreparator.swift
//  ToDo
//
//  Created by Alex Smith on 19.02.2023.
//

import Foundation

/// Protocol for mapping Tasks to ViewModels
protocol IDataPreparator {
	func makeTaskViewModels(from tasks: [Task]) -> [TaskViewModel]
}

class DataPreparator: IDataPreparator {
	
	private func makeImportantTaskViewModel(from task: Task) -> TaskViewModel {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM.dd.yy"
		let importantTask = task as! ImportantTask
		let priority = importantTask.taskPriority
		let modelPriority: Priority
		
		if priority == .low {
			modelPriority = .low
		} else if priority == .medium {
			modelPriority = .medium
		} else {
			modelPriority = .high
		}
		return TaskViewModel(isExpired: importantTask.deadLine < Date(),
							 isCompleted: task.completed,
							 isImportantTask: true,
							 title: task.title,
							 deadline: dateFormatter.string(from: importantTask.deadLine),
							 priorityTag: importantTask.taskPriority.description,
							 priority: modelPriority)
	}
	
	func makeTaskViewModels(from tasks: [Task]) -> [TaskViewModel] {
		var models: [TaskViewModel] = []
		tasks.forEach { task in
			if task is ImportantTask {
				models.append(makeImportantTaskViewModel(from: task))
			} else {
				let model = TaskViewModel(isExpired: false,
										  isCompleted: task.completed,
										  isImportantTask: false,
										  title: task.title,
										  deadline: "",
										  priorityTag: "",
										  priority: nil)
				models.append(model)
			}
		}
		return models
	}
}
