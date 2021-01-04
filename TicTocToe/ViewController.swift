//
//  ViewController.swift
//  TicTocToe
//
//  Created by user173093 on 7/17/20.
//  Copyright © 2020 Alexander Germek. All rights reserved.
//

import UIKit

class MyButton: UIButton{
    override init(frame:CGRect){
        super.init(frame: frame)
        initial()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    
    func initial(){
        self.layer.cornerRadius = 20
        //self.layer.borderWidth = 5
       // self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //let Tic = UIImage(named: "toc")
        //self.setImage(Tic, for: UIControl.State.normal)
    }
}

class MyLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    func initial(){
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var moveLabel: UILabel!
    var moveTic = true //кто ходит - первым крестик
    var isEnd   = false // конец игры или нет
    
    @IBOutlet weak var btn1: MyButton!
    @IBOutlet weak var btn2: MyButton!
    @IBOutlet weak var btn3: MyButton!    
    @IBOutlet weak var btn4: MyButton!
    @IBOutlet weak var btn5: MyButton!
    @IBOutlet weak var btn6: MyButton!
    @IBOutlet weak var btn7: MyButton!
    @IBOutlet weak var btn8: MyButton!
    @IBOutlet weak var btn9: MyButton!
    
    let tic = UIImage(named: "tic")
    let toc = UIImage(named: "toc")
    
    //Функция первичной загрузки контроллера:
    override func viewDidLoad() {
        super.viewDidLoad()
        moveLabel.text = "Ходит Крестик..."
    }
    
    //Функция перехода в главное меню по кнопке exit:
    @IBAction func ExitButtonAction(_ sender: UIButton) {
        if let newViewController = storyboard?.instantiateViewController(withIdentifier: "First") as? FirstViewController {
            newViewController.modalTransitionStyle = .flipHorizontal // это значение можно менять для разных видов анимации появления
            newViewController.modalPresentationStyle = .overCurrentContext // это та самая волшебная строка, убрав или закомментировав ее, вы получите появление смахиваемого контроллера
         present(newViewController, animated: false, completion: nil)
        }
    }
    
    //ОСНОВНАЯ ФУНКЦИЯ ПО ИГРЕ Функция нажатия на ячейку поля - рисуем нолик или крестик:
    @IBAction func pushButton(_ sender: MyButton) {
        if isEnd || sender.currentImage != nil{
            return
        }
        sender.setImage(moveTic ? tic : toc, for: UIControl.State.normal)
        
        let (whoWin, arrOfBtns) = checkWin()
        
        if whoWin != ""{
            for item in arrOfBtns{
                item.setBackgroundImage(nil, for: UIControl.State.normal)
                item.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                
            }
            moveLabel.text = whoWin + " Победил!"
            isEnd = true
            goALert(myTitle: "Конец игры!")
                       
        }else{
            if checkDraw(){
                moveLabel.text = "Ничья!"
                isEnd = true
                goALert(myTitle: "Ничья!")
            }else{
            moveTic = !moveTic
            moveLabel.text = moveTic ? "Ходит Крестик..." : "Ходит Нолик..."
            }
        }
    }
    
    //Фунция выводит Алерт-сообщение после выигрыша или ничьей:
    func goALert(myTitle: String){
        let alertMessage = UIAlertController(
                           title: myTitle, message: "Начать новую игру?", preferredStyle: .alert)
                       
                       let yesAlert    = UIAlertAction(title: "Да", style: .default, handler: {ale in self.alertFunc(alert: ale) })
                       let cancelAlert = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
                       let endAlert    = UIAlertAction(title: "В главное меню", style: .cancel, handler: {ale in self.alertFunc(alert: ale) })
                       
                       alertMessage.addAction(yesAlert)
                       alertMessage.addAction(cancelAlert)
                       alertMessage.addAction(endAlert)
               self.present(alertMessage, animated: true, completion: nil)
    }
    
    //Функция обрабатывает результат после вывода Алерт-сообщения:
    func alertFunc(alert: UIAlertAction) -> (){
        switch alert.title {
        case "Да":
            for item in [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9]{
                item?.setImage(nil, for: .normal)
                item?.setBackgroundImage(UIImage(named: "cell"), for: .normal)
            }
            moveLabel.text = "Ходит Крестик..."
            isEnd = false
            moveTic = true

        case "В главное меню":
            ExitButtonAction(UIButton())
        default: exit(0)// сюда не попадаем никогда
        }
    }
    
    
    //Функция проверяет выигрыш или нет после очередного хода:
    func checkWin() -> (String, [MyButton]){
        var whoWin = ""
            var arrOfBtns: [MyButton] = []
            if btn1.currentImage == tic && btn2.currentImage == tic && btn3.currentImage == tic {
                arrOfBtns.append(btn1); arrOfBtns.append(btn2); arrOfBtns.append(btn3)
                whoWin = "Крестик"
            } else if btn4.currentImage == tic && btn5.currentImage == tic && btn6.currentImage == tic{
                arrOfBtns.append(btn4); arrOfBtns.append(btn5); arrOfBtns.append(btn6)
                whoWin = "Крестик"
            }else if btn7.currentImage == tic && btn8.currentImage == tic && btn9.currentImage == tic {
                       arrOfBtns.append(btn7); arrOfBtns.append(btn8); arrOfBtns.append(btn9)
                       whoWin = "Крестик"
                   }
                   else if btn1.currentImage == tic && btn5.currentImage == tic && btn9.currentImage == tic{
                        arrOfBtns.append(btn1); arrOfBtns.append(btn5); arrOfBtns.append(btn9)
                       whoWin = "Крестик"
                   }
                   else if btn3.currentImage == tic && btn5.currentImage == tic && btn7.currentImage == tic{
                      arrOfBtns.append(btn3); arrOfBtns.append(btn5); arrOfBtns.append(btn7)
                        whoWin = "Крестик"
                   }
            else if btn1.currentImage == tic && btn4.currentImage == tic && btn7.currentImage == tic{
                arrOfBtns.append(btn1); arrOfBtns.append(btn4); arrOfBtns.append(btn7)
                whoWin = "Крестик"
            } else if btn2.currentImage == tic && btn5.currentImage == tic && btn8.currentImage == tic{
                arrOfBtns.append(btn2); arrOfBtns.append(btn5); arrOfBtns.append(btn8)
                whoWin = "Крестик"
            }else if btn3.currentImage == tic && btn6.currentImage == tic && btn9.currentImage == tic{
                      arrOfBtns.append(btn3); arrOfBtns.append(btn6); arrOfBtns.append(btn9)
                       whoWin = "Крестик"
                   }//ZERO:
            else if btn1.currentImage == toc && btn2.currentImage == toc && btn3.currentImage == toc {
                arrOfBtns.append(btn1); arrOfBtns.append(btn2); arrOfBtns.append(btn3)
                whoWin = "Нолик"
            } else if  btn4.currentImage == toc && btn5.currentImage == toc && btn6.currentImage == toc{
                arrOfBtns.append(btn4); arrOfBtns.append(btn5); arrOfBtns.append(btn6)
                whoWin = "Нолик"
            } else if  btn7.currentImage == toc && btn8.currentImage == toc && btn9.currentImage == toc{
                arrOfBtns.append(btn7); arrOfBtns.append(btn8); arrOfBtns.append(btn9)
                whoWin = "Нолик"
                   }
                   else if btn1.currentImage == toc && btn5.currentImage == toc && btn9.currentImage == toc{
                            whoWin = "Нолик"
                         arrOfBtns.append(btn1); arrOfBtns.append(btn5); arrOfBtns.append(btn9)
                   }
                   else if btn3.currentImage == toc && btn5.currentImage == toc && btn7.currentImage == toc{
                           arrOfBtns.append(btn3); arrOfBtns.append(btn5); arrOfBtns.append(btn7)
                            whoWin = "Нолик"
                   }
            else if btn1.currentImage == toc && btn4.currentImage == toc && btn7.currentImage == toc {
                arrOfBtns.append(btn1); arrOfBtns.append(btn4); arrOfBtns.append(btn7)
                whoWin = "Нолик"
            } else if  btn2.currentImage == toc && btn5.currentImage == toc && btn8.currentImage == toc {
                 arrOfBtns.append(btn2); arrOfBtns.append(btn5); arrOfBtns.append(btn8)
                 whoWin = "Нолик"
        }else if    btn3.currentImage == toc && btn6.currentImage == toc && btn9.currentImage == toc{
                            arrOfBtns.append(btn3); arrOfBtns.append(btn6); arrOfBtns.append(btn9)
                                whoWin = "Нолик"
                   }
        return (whoWin,arrOfBtns)
    }
    
    
    //Функция проверяет ничью - все клетки заполнены:
    func checkDraw() -> Bool{
        var count = 0
        for item in [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9]{
            if item?.currentImage != nil{
                count += 1
            }
        }
        return count == 9 ? true : false
    }

    }




