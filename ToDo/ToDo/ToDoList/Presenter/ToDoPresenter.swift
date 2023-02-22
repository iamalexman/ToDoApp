//
//  ToDoPresenter.swift
//  ToDo
//
//  Created by Alex Smith on 19.02.2023.
//

import Foundation

/// Input View protocol
protocol IToDoView: AnyObject {
	func render(viewData: ViewData)
}

/// Output view protocol
protocol IToDoViewPresenter: AnyObject {
	func showToDoList()
	func getSectionsTitles() -> [String]
	func getTasksForSections(section: Int) -> [TaskViewModel]
	func checkTask(section: Int, index: Int)
	init(view: IToDoView, data: ViewData)
}

/// Presenter
class ToDoPresenter: IToDoViewPresenter {
	let view: IToDoView
	var data: ViewData
	
	required init(view: IToDoView,
				  data: ViewData) {
		self.view = view
		self.data = data
	}
	
	func getSectionsTitles() -> [String] {
		data.sections
	}
	
	func getTasksForSections(section: Int) -> [TaskViewModel] {
		section == .zero ? data.uncompletedTasks : data.completedTasks
	}
	/// Showing ViewController
	func showToDoList() {
		let data = self.data
		self.view.render(viewData: data)
	}
	
	/// Checking selected task
	func checkTask(section: Int, index: Int) {
		if section == .zero {
			data.uncompletedTasks[index].checkTask()
			data.completedTasks.append(data.uncompletedTasks[index])
			data.uncompletedTasks.remove(at: index)
		} else {
			data.completedTasks[index].checkTask()
			data.uncompletedTasks.append(data.completedTasks[index])
			data.completedTasks.remove(at: index)
		}
		data.uncompletedTasks = sortTasks(tasks: data.uncompletedTasks)
		data.completedTasks = sortTasks(tasks: data.completedTasks)
	}
	/// Sorted by priority
	private func sortTasks(tasks: [TaskViewModel]) -> [TaskViewModel] {
		sort(tasks, by: .high) + sort(tasks, by: .medium) +
		sort(tasks, by: .low) + sort(tasks, by: nil)
	}
	
	private func sort(_ tasks: [TaskViewModel], by priority: Priority?) -> [TaskViewModel] {
		switch priority {
		case .high:
			return tasks.filter { $0.priority == .high }
		case .medium:
			return tasks.filter { $0.priority == .medium }
		case .low:
			return tasks.filter { $0.priority == .low }
		case nil:
			return tasks.filter { $0.priority == nil }
		}
	}
}
