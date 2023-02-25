//
//  ToDoPresenter.swift
//  ToDo
//
//  Created by Alex Smith on 19.02.2023.
//

import Foundation

/// Output view protocol
protocol IToDoPresenter: AnyObject {
	func viewIsReady()
	func didTaskSelected(at indexPath: IndexPath)
}

/// Presenter
class ToDoPresenter: IToDoPresenter {
	private var sectionManager: ITaskManagerSectionsAdapter!
	private weak var view: IToDoViewController!
	
	init(view: IToDoViewController,
		 sectionManager: ITaskManagerSectionsAdapter!) {
		
		self.view = view
		self.sectionManager = sectionManager
	}
	
	func viewIsReady() {
		view?.render(viewData: mapViewData())
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.completed.toggle()
		view.render(viewData: mapViewData())
	}
	
	private func mapViewData() -> ToDoModel.ViewData {
		var sections = [ToDoModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = ToDoModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section))
			)
			sections.append(sectionData)
		}
		return ToDoModel.ViewData(tasksBySections: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [ToDoModel.ViewData.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> ToDoModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "MM.dd.yy"
			let result = ToDoModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.completed,
				isOverdue: task.deadLine < Date(),
				deadline: "Deadline: \(dateFormatter.string(from: task.deadLine))",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(ToDoModel.ViewData.RegularTask(name: task.title,
															   isDone: task.completed))
		}
	}
}
