//
//  Repository.swift
//  ToDo
//
//  Created by Alex Smith on 14.02.2023.
//

import Foundation

protocol ITaskRepository {
	func getTasks() -> [Task]
}

final class TaskRepositoryStub: ITaskRepository {
	
	private var tasks = [
		ImportantTask(title: "Buy coffee", taskPriority: .low),
		ImportantTask(title: "Read book", taskPriority: .medium),
		RegularTask(title: "Go to the gym", completed: true),
		ImportantTask(title: "Do homework", taskPriority: .low),
		RegularTask(title: "Play football"),
		ImportantTask(title: "Call to mom", taskPriority: .medium),
		ImportantTask(title: "Drink water", taskPriority: .high),
		RegularTask(title: "Buy fruits"),
		RegularTask(title: "Go sleep")
	]
	
	func getTasks() -> [Task] {
		tasks
	}
}

