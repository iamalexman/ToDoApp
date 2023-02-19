//
//  ToDoModuleBuilder.swift
//  ToDo
//
//  Created by Alex Smith on 19.02.2023.
//

import UIKit

protocol ModuleBuilder {
	static func build() -> UIViewController
}

class ToDoModuleBuilder: ModuleBuilder {
	
	static func build() -> UIViewController{
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		let sectionForTaskManager: ITaskManagerSectionsAdapter!
		let dataPreparator: IDataPreparator = DataPreparator()
		taskManager.addTasks(tasks: repository.getTasks())
		sectionForTaskManager = TaskManagerSectionsAdapter(taskManager: taskManager)
		
		let completedTasks = dataPreparator.makeTaskViewModels(from: taskManager.completedTasks())
		let uncompletedTasks = dataPreparator.makeTaskViewModels(from: taskManager.uncompletedTasks())
		let data = ViewData(sections: sectionForTaskManager.getSectionsTitles(), completedTasks: completedTasks, uncompletedTasks: uncompletedTasks)
		
		let view = ToDoTableViewController()
		let presenter = ToDoPresenter(view: view, data: data)
		view.presenter = presenter
		return view
	}
}

