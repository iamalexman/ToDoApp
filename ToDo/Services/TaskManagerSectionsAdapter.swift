//
//  TaskManagerSectionsAdapter.swift
//  ToDo
//
//  Created by Alex Smith on 18.02.2023.
//

import Foundation

protocol ITaskManagerSectionsAdapter {
	func getSectionsTitles() -> [String]
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

final class TaskManagerSectionsAdapter: ITaskManagerSectionsAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionsTitles() -> [String] {
		return ["In progress", "Completed"]
	}
	
	func getTasksForSection(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 1:
			return taskManager.completedTasks()
		default:
			return taskManager.uncompletedTasks()
		}
	}
}
