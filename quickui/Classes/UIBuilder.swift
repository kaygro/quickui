//
//  UIBuilder.swift
//  Zieh
//
//  Created by Kay Großblotekamp on 31.12.19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import UIKit


var currentViewInt: UIView = UIView(frame: .zero)
public func currentView()-> UIView{
	return currentViewInt
}

public func setCurrentView(to view: UIView){
	currentViewInt = view
}

public func withCurrentView(_ view : UIView, hugContent: Bool, _ block: () throws ->()) rethrows{
	view.translatesAutoresizingMaskIntoConstraints = false
	let oldview = currentViewInt
	currentViewInt.add(view, hugging: hugContent)
	currentViewInt = view
	defer{
		currentViewInt = oldview
	}
	try block()
}

@discardableResult 
public func Text(_ text: String,hugContent: Bool = true, _ config: (UILabel)->() = {_ in})-> UILabel{
	let label = UILabel(frame: .zero)
	label.text = text
	label.lineBreakMode = .byWordWrapping
	label.numberOfLines = 0
	withCurrentView(label, hugContent: hugContent){
		config(label)
	}
	return label
}

@discardableResult 
public func Horizontal(hugContent: Bool = true,  _ config: (UIStackView)->() = {_ in})-> UIStackView{
	let view = UIStackView(frame: .zero)
	withCurrentView(view, hugContent: hugContent){
		view.alignment = UIStackView.Alignment.center
		view.axis = .horizontal
		view.distribution = .fillProportionally
		config(view)
	}
	return view
}

@discardableResult 
public func Horizontal(hugContent: Bool = true, _ config: ()->())->UIStackView{
	return Horizontal(hugContent: hugContent){_ in		
		config()
	}
}

@discardableResult 
public func Vertical(hugContent: Bool = true, _ config: ()->())->UIStackView{
	return Vertical(hugContent: hugContent){_ in
		config()
	}
}


@discardableResult 
public func Vertical(hugContent: Bool = true, _ config: (UIStackView)->() = {_ in})-> UIStackView{
	let view = Horizontal(hugContent: hugContent){
		$0.axis = .vertical
		config($0)
	}
	return view
}

@discardableResult 
public func View(hugContent: Bool = true, _ config: (UIView)->() = {_ in})-> UIView{
	let view = UIView(frame: .zero)
	withCurrentView(view, hugContent: hugContent){
		config(view)
	}
	return view	
}

@discardableResult
public func Spacer(size: CGSize = CGSize(width: 8.0, height: 8.0))->UIView{
	return View{
		$0.backgroundColor = .clear
		$0.heightAnchor.constraint(equalToConstant: size.height).isActive = true
		$0.widthAnchor.constraint(equalToConstant: size.width).isActive = true
	}
}

open class SimpleButton: UIView{
	var action: ()->() = {}
	init(){
		super.init(frame: .zero)
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		gesture.numberOfTapsRequired = 1
		gesture.numberOfTouchesRequired = 1
		self.addGestureRecognizer(gesture)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc public func onTap(_ g: UITapGestureRecognizer){
		self.action()
	}
}

@discardableResult 
public func Button(action: @escaping ()->() = {},hugContent: Bool = true,  _ config: (SimpleButton)->() = {_ in})-> SimpleButton{
	let button = SimpleButton()
	withCurrentView(button, hugContent: hugContent){
		button.action = action
		config(button)
	}
	return button
}

@discardableResult 
public func Button(action: @escaping ()->() = {},hugContent: Bool = true,  _ config: ()->() = {})-> SimpleButton{
	return Button(action: action,hugContent:  hugContent){_ in config()}
}


@discardableResult
public func Image(named: String,hugContent: Bool = true,  _ config: (UIImageView)->())->UIImageView{
	let view = UIImageView(image: UIImage(named: named))
	withCurrentView(view, hugContent: hugContent){
		view.contentMode = .scaleAspectFit
		config(view)
	}
	return view
}
@discardableResult
public func Image(named: String)->UIImageView{
	return Image(named: named){_ in}
}

//return might go, makes definition more straight forward
@discardableResult
public func ScrollView(hugContent: Bool = true, _ config: (UIScrollView)->())-> UIView{
	let view = UIScrollView(frame: .zero)
	withCurrentView(view, hugContent: hugContent) { 
		View({_ in})
		//maybe do some research
	}
	return view
}
@discardableResult
public func ScrollView(_ config: ()->())-> UIView{
	return ScrollView{_ in}
}



extension UIView{
	@objc func add(_ view: UIView, hugging: Bool){
		self.addSubview(view)
		if hugging{
			setHuggingConstraints(on: view)
		}else{
			setExpandingConstraints(on: view)
		}
	}}

func setHuggingConstraints(on view: UIView){
	view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
	view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor).isActive = true
	
	view.leftAnchor.constraint(greaterThanOrEqualTo: view.superview!.leftAnchor).isActive = true
	view.rightAnchor.constraint(lessThanOrEqualTo: view.superview!.rightAnchor).isActive = true
	view.bottomAnchor.constraint(lessThanOrEqualTo: view.superview!.bottomAnchor).isActive = true
	view.topAnchor.constraint(greaterThanOrEqualTo: view.superview!.topAnchor).isActive = true
}

func setExpandingConstraints(on view: UIView){
	view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
	view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor).isActive = true
	
	view.leftAnchor.constraint(equalTo: view.superview!.leftAnchor).isActive = true
	view.rightAnchor.constraint(equalTo: view.superview!.rightAnchor).isActive = true
	view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor).isActive = true
	view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
}


 

extension UIStackView{
	@objc override func add(_ view: UIView, hugging: Bool){
		self.addArrangedSubview(view)
	}
}


