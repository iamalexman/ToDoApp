//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Alex Smith on 18.02.2023.
//

import UIKit

protocol IToDoViewController: AnyObject {
	func render(viewData: ToDoModel.ViewData)
}

final class ToDoTableViewController: UITableViewController {
	var viewData: ToDoModel.ViewData = ToDoModel.ViewData(tasksBySections: [])
	var presenter: IToDoPresenter?

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "ToDoList"
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		assembly()
		presenter?.viewIsReady()
	}
	
	private func assembly() {
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = TaskManagerSectionsAdapter(taskManager: taskManager)
		presenter = ToDoPresenter(view: self, sectionManager: sections)
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		var contentConfig = cell.defaultContentConfiguration()
		
		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText)
			taskText.append(NSAttributedString(string: task.name))
			
			contentConfig.attributedText = taskText
			contentConfig.secondaryText = task.deadline
			contentConfig.secondaryTextProperties.color = task.isOverdue ? .systemPink.withAlphaComponent(0.2) : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfig.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}
		cell.tintColor = .systemRed
		contentConfig.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfig.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.selectionStyle = .none
		cell.contentConfiguration = contentConfig
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didTaskSelected(at: indexPath)
	}
}

extension ToDoTableViewController: IToDoViewController {
	func render(viewData: ToDoModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
