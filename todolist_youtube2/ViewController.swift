//
//  ViewController.swift
//  todolist_youtube2
//
//  Created by Brian Voong on 2/11/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "To-Do List"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.registerClass(TaskCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.registerClass(TaskHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
    }
    
    var tasks = ["Buy Groceries", "Fill up gas", "Pay bills"]

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let taskCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! TaskCell
        taskCell.nameLabel.text = tasks[indexPath.item]
        return taskCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 50)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerId", forIndexPath: indexPath) as! TaskHeader
        header.viewController = self
        return header
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }
    
    func addNewTask(taskName: String) {
        tasks.append(taskName)
        collectionView?.reloadData()
    }
}

class TaskHeader: BaseCell {
    
    var viewController: ViewController?
    
    let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Task Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .RoundedRect
        return textField
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Add Task", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupViews() {
        
        addSubview(taskNameTextField)
        addSubview(addTaskButton)
        
        addTaskButton.addTarget(self, action: "addTask", forControlEvents: .TouchUpInside)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0]-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskNameTextField, "v1": addTaskButton]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-24-[v0]-24-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskNameTextField]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": addTaskButton]))
    }
    
    func addTask() {
        viewController?.addNewTask(taskNameTextField.text!)
        taskNameTextField.text = ""
    }
    
}

class TaskCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    override func setupViews() {
        
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}