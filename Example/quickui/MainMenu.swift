//
//  MainMenu.swift
//  QuickUI
//
//  Created by Kay Großblotekamp on 12.01.20.
//  Copyright © 2020 self. All rights reserved.
//

import Foundation
import UIKit
import quickui

//MARK: Strings

//MARK: Dependencies


protocol	MainMenuDelegate{
	func play()
	func tutorial()
	func credits()
	func quit()
}

func Menutext(_ text: String){
	Text(text){
		$0.textColor = .blue
	}
}


//func MenuButton(_ config)
class MainMenu: QuickUIController{
	var delegate: MainMenuDelegate?
	override func viewDidLoad() {
		super.viewDidLoad()
		Image(named: "placeholder"){
			$0.contentMode = .scaleAspectFill
		}
		Vertical(hugContent:true){
			$0.distribution = .equalSpacing
			Spacer()
			Button(action: {
				print("pressed button")
				self.delegate?.play()
			}){ 
				Menutext("Play")
			}
			Spacer()
			Button(action: {self.delegate?.tutorial()}){
				Menutext("Tutorial")
			}
			Spacer()
			Button(action: {self.delegate?.credits()}){
				Menutext("Credits")
			}			
			Spacer()
			Button(action: {self.delegate?.quit()}){
				Menutext("Quit")
				Spacer()
			}
		}
	}
}


class MainMenuFactory{
	static func MakeMainMenu()->UIViewController{
		let ret = MainMenu()
		return ret
	}
}

extension UIApplication{
	static 	var appDelegate: AppDelegate{
		return UIApplication.shared.delegate as! AppDelegate
	}
}
