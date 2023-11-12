//
//  TaskListViewController.swift
//  To-DoApp
//
//  Created by 소현 on 11/12/23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editBarButton: UIBarButtonItem! // 보였다가 안보였다가 할 예정으로 weak가 되면 인스턴스 자체가 제거될 수 있음.
    var doneBarButton: UIBarButtonItem?
    
    var tasks: [Task] = [] {
        didSet {
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // selector는 function notation 방식으로 표기.
        self.doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        
        self.loadTasks()
        self.checkEditButtonAvailable()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // UserDefaults에 task 목록 저장.
    // 구조체인 Task를 그냥 저장하려고 하면 아래와 같은 exception 발생.
    // Attempt to set a non-property-list object ("To_DoApp.Task(title: \"Task1\", done: false)")
    // as an NSUserDefaults/CFPreferences value for key tasks
    
    private func saveTasks() {
        let taskDictionary = self.tasks.map { ["title": $0.title, "done": $0.done] }
        UserDefaults.standard.set(taskDictionary, forKey: "tasks")
    }
    
    private func loadTasks() {
        guard let taskDictionary = UserDefaults.standard.array(forKey: "tasks") as? [[String : Any]] else { return }
        self.tasks = taskDictionary.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
    // 데이터가 없을 때 수정이 불가능하도록 만들기.
    private func checkEditButtonAvailable() {
        self.editBarButton.isEnabled = !self.tasks.isEmpty
    }
    
    //MARK: Actions
    // 컴파일 타임에 메서드를 바인딩하는 Swift와는 다르게 Objective-C는 런타임에 메서드를 바인딩한다.
    // 따라서 Swift에서 Objective-C에 의존적인 메서드에 사용할 때는
    // 해당 메서드가 Objective-C와 유사한 방식으로 컴파일 되어야함을 컴파일러에게 알려주어야 하는데 이것이 @objc의 역할이다.
    @objc func tapDoneButton() {
        self.navigationItem.leftBarButtonItem = self.editBarButton
        self.tableView.setEditing(false, animated: true)
        self.checkEditButtonAvailable()
    }
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        // 비활성화 시키는 것이 더 좋음.
        // if self.tasks.isEmpty { return }
        
        self.navigationItem.leftBarButtonItem = self.doneBarButton
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in textField.placeholder = "할 일을 입력해주세요" }
        
        // The key question to ask yourself is if your alert object is "owned" by self.
        // In this case, it is not (because you declared let alert = ... in the function body).
        // So you do not need to create this as a weak or unowned reference.
        // If alert was a property of self, then it would be "owned" by self and
        // that is when you would want to create a weak reference to self in the closure "owned" by the alert.
        // https://itecnote.com/tecnote/ios-should-self-be-captured-as-strong-in-a-uialertactions-handler/
        // UIAlertConroller가 ViewController의 속성일 때 캡처되지만 여기서는 액션 함수 내에서 alert를 생성하기 때문에 순환참조 방지 필요 없음.
        
        let okayAction = UIAlertAction(title: "등록", style: .default) { /* [weak self] */ _ in
            guard let taskTitle = alert.textFields?.first?.text else { return }
            let task = Task(title: taskTitle, done: false)
            self.tasks.append(task)
            self.tableView.reloadData()
            self.checkEditButtonAvailable()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = tasks[indexPath.row]
        taskCell.textLabel?.text = task.title
        taskCell.accessoryType = task.done ? .checkmark : .none
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // The delegate for the editing style of a row at a particular location in a table view.
    // func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty {
            self.tapDoneButton()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tasks[indexPath.row].done.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 강의 내용
        // var tasks = self.tasks
        // let removedTask = tasks.remove(at: sourceIndexPath.row)
        // tasks.insert(removedTask, at: destinationIndexPath.row)
        // self.tasks = tasks
        
        let removedTask = self.tasks.remove(at: sourceIndexPath.row)
        self.tasks.insert(removedTask, at: destinationIndexPath.row)
        
        // 왜 복사해서 사용했을까?
        // 여기서는 reload 함수가 필요없음.
    }
    
    // 셀을 놓았을 때 특정 셀에는 이동이 안되게끔 하고싶은 경우, targetIndexPathForMoveFromRowAt 추가
    // func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
}

