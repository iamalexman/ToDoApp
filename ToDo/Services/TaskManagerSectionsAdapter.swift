//
//  TaskManagerSectionsAdapter.swift
//  ToDo
//
//  Created by Alex Smith on 18.02.2023.
//

import Foundation

protocol ITaskManagerSectionsAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func getSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	func getSectionIndex(section: Section) -> Int
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

final class TaskManagerSectionsAdapter: ITaskManagerSectionsAdapter {
	private let sections: [Section] = [.uncompleted, .completed]
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func getSections() -> [Section] {
		sections
	}
	
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}
	
	func getSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex { task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
	
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}
	
	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}
}
