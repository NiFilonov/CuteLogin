//
//  ViewController.swift
//  CuteLogin
//
//  Created by Dragonborn on 13.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var formContainerView: UIView!
    // Констрейнт, который позиционирует formContainerView по центру экрана (отвечает за позицию по Y)
    @IBOutlet weak var centerVerticalFormContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        setupFormContainer()
        
        // Подписываемся на уведомления о появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Подписываемся на уведомления о скрытии клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Создаем объект, который будет обрабатывать нажатия на корневой view
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        // присваиваем его в обработчик нажатия корневого view
        self.view.addGestureRecognizer(tap)
    }
    // Функция, которая вызывается при срабатывании обработчика нажатий tap
    @objc func tapAction() {
        // Команда, которая закрывает клавиатуру
        view.endEditing(true)
    }
    
    // Функция, которая вызывается при открытии клавиатуры
    @objc func keyboardWillAppear(_ notification: Notification?) {
        // Пытаемся получить frame клавиатуры в NSValue
        if let keyboardFrame: NSValue = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            // Достаем CGRect клавиатуры
            let keyboardRectangle = keyboardFrame.cgRectValue
            // Из объекта CGRect получаем высоту клавиатуры
            let keyboardHeight = keyboardRectangle.height
            raiseFormView(to: keyboardHeight)
        }
    }
    
    // Функция, которая поднимает форму вверх
    func raiseFormView(to height: CGFloat) {
        // Высчитываем самую нижнюю точку formContainerView
        let formMaxY = formContainerView.frame.maxY
        // Считаем сколько остается свободного места на экране, после появления клавиатуры
        let currentViewHeight = self.view.frame.height - height
        // Считаем на сколько надо поднять formContainerView
        let moveDistance = (formMaxY - currentViewHeight) + 30
        // Добавляем анимацию
        UIView.animate(withDuration: 0.3) {
            // Поднимаем formContainerView вверх на moveDistance
            // -moveDistance - минус, потому что ось Y начинается в верху экрана
            self.centerVerticalFormContraint.constant = -moveDistance
            // Нужно вызвать, чтобы анимация заработала (только для анимирования contraint'ов)
            self.view.layoutIfNeeded()
        }
    }
    
    // Функция, которая срабатывает при закрытии клавиатуры
    @objc func keyboardWillDisappear(_ notification: NSNotification?) {
        // Добавляем анимацию
        UIView.animate(withDuration: 0.3) {
            // Присваиваем констрейнту значение 0 (оно стояло по умолчанию) - это переместит
            // formContainerView обратно, в центр экрана
            self.centerVerticalFormContraint.constant = 0
            // Нужно вызвать, чтобы анимация заработала (только для анимирования contraint'ов)
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.width / 2
    }
    
    func setupFormContainer() {
        formContainerView.layer.cornerRadius = 16.0
    }
    
}

