//
//  QuickUIController.swift
//  Zieh
//
//  Created by Kay Großblotekamp on 12.01.20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

open class QuickUIController: UIViewController{
	open override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		setCurrentView(to: self.view)
	}
	open override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(true)
		if self.isMovingFromParent{
			self.viewDidPop()
		}
	}
	
	open func viewDidPop(){
		setCurrentView(to: UIView())
	}
}
