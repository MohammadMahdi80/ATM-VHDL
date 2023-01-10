import os, os.path
import sys
from PySide6.QtCore import *
from PySide6.QtGui import *
from PySide6.QtWidgets import *
import os
from PySide6 import *
from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtWebEngineWidgets import QWebEngineView
from sympy import E
import timer
from functools import partial
import time


def resource_path(relative_path):
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)



class Widget(QWidget):
    def __init__(self, parent=None):
        global width, height
        super(Widget, self).__init__(parent)
        width = self.screen().geometry().width()
        height = self.screen().geometry().height()    

        for i in range(8):
            label1 = QLabel(f'LED{i}',self)
            label1.setStyleSheet(f'background : #000000;color: #ff14f8')
            label1.resize(30,15)
            label1.move(30,200 + 30*i)
            label1.show()    
        
        self.setStyleSheet("background-color: #0d0d0d;")
        self.setFixedWidth(800)
        self.setFixedHeight(600)
        self.counter = 0
        self.lab_list = []
        self.btn_list = []
        self.led_list = []
        self.clk = 0
        with open('./write_file_ex.txt','r') as f :
            self.lines = f.readlines()

        self.lbl_clk = QLabel(self)
        self.lbl_clk.setText("CLK: "+str(self.clk))
        self.lbl_clk.setStyleSheet(f'background :#0d0d0d;font-size: 20px;color: #2fff08')
        self.lbl_clk.resize(150,50)
        self.lbl_clk.move(10, 10)
        self.lbl_clk.show()
        
        button1 = QPushButton('Next', self)
        button1.move(680, 550)
        button1.resize(70,30)
        button1.setStyleSheet("""QPushButton {background-color: #1200c7;font-size:20px}
                                QPushButton:pressed {
                                background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,
                                              stop: 0 #dadbde, stop: 1 #f6f7fa);
                                }""")
        button1.clicked.connect(self.next)
        button1.show()

    
    def drawRectangles(self, s):
        
        if self.counter < len(self.lines) :
            line = self.lines[self.counter]
            self.counter += s
            clk = int(line[:2])
            btns = int(line[2])
            btnu = int(line[3])
            btnd = int(line[4])
            btnl = int(line[5])
            btnr = int(line[6])
            seg1 = line[7:14]
            seg2 = line[14:21]
            seg3 = line[21:28]
            seg4 = line[28:35]
            leds = line[35:43]
            color = [seg1, seg2, seg3, seg4]
            color_dict = {1:'red',0:'black'}
            sel_color = {0:'000fe3',1:'42ff19'}
            led_color = {0:'000000',1:'feff14'}
            x = 250
            y = 25
            
            try:
                for i in range(4):
                    self.lab_list[i].close()
                    self.btn_list[i].close()
                    self.led_list[i].close()
            except:
                pass
            
            self.clk = self.clk + clk
            self.lbl_clk.setText("CLK: "+ str(self.clk))
            for i in range(4):
                clr = color[i]
                label1 = QLabel(self)
                label1.setStyleSheet(f'background :{color_dict[int(clr[5])]};')
                label1.resize(5,43)
                label1.move(x + i*70, y)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.resize(5,43)
                label1.setStyleSheet(f'background :{color_dict[int(clr[4])]};')
                label1.move(x + i*70, y + 48)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.setStyleSheet(f'background :{color_dict[int(clr[1])]};')
                label1.resize(5,43)
                label1.move(x + 50 + i*70,y)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.resize(5,43)
                label1.setStyleSheet(f'background :{color_dict[int(clr[2])]};')
                label1.move(x + 50 + i*70, y + 48)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.resize( 45, 5)
                label1.setStyleSheet(f'background :{color_dict[int(clr[0])]};')
                label1.move(x + 5 + i*70, y-3)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.resize( 45, 5)
                label1.setStyleSheet(f'background :{color_dict[int(clr[6])]};')
                label1.move(x + 5 + i*70, y+45)
                label1.show()
                self.lab_list.append(label1)

                label1 = QLabel(self)
                label1.resize( 45, 5)
                label1.setStyleSheet(f'background :{color_dict[int(clr[3])]};')
                label1.move(x + 5 + i*70, y+90)
                label1.show()
                self.lab_list.append(label1)

            for i in range(8):
                label1 = QLabel(self)
                label1.setStyleSheet(f'background : #{led_color[int(leds[i])]};')
                label1.resize(30,15)
                label1.move(70,410 - 30*i)
                label1.show()  
                self.led_list.append(label1)  


            button1 = QPushButton('U', self)
            button1.move(380, 400)
            button1.resize(20,50)
            button1.setStyleSheet(f"background-color: #{sel_color[btnu]};font-size:20px")
            button1.show()
            self.btn_list.append(button1)

            button1 = QPushButton('D', self)
            button1.move(380, 530)
            button1.resize(20,50)
            button1.setStyleSheet(f"background-color: #{sel_color[btnd]};font-size:20px")
            button1.show()
            self.btn_list.append(button1)

            button1 = QPushButton('L', self)
            button1.move(310, 465)
            button1.resize(20,50)
            button1.setStyleSheet(f"background-color: #{sel_color[btnl]};font-size:20px")
            button1.show()
            self.btn_list.append(button1)

            button1 = QPushButton('R', self)
            button1.move(450, 465)
            button1.resize(20,50)
            button1.setStyleSheet(f"background-color: #{sel_color[btnr]};font-size:20px")
            button1.show()
            self.btn_list.append(button1)

            button1 = QPushButton('S', self)
            button1.move(380, 465)
            button1.resize(20,50)
            button1.setStyleSheet(f"background-color: #{sel_color[btns]};font-size:20px")
            button1.show()
            self.btn_list.append(button1)

    def next(self):
        self.drawRectangles(1)

    def back(self):
        if self.counter != 0:
            self.drawRectangles(-1)



if __name__ == "__main__":
    app = QApplication()
    w = Widget()
    w.setWindowState(Qt.WindowMaximized)
    # w.resize(1000,700)
    width = w.screen().geometry().width()
    height = w.screen().geometry().height()


    w.show()
    with open('style.qss', 'w') as f:
        f.write("""
        QListWidget {
            color: #FFFFFF;
            background-color: #33373B;
            }

            QListWidget::item {
            height: 50px;
            }

            QListWidget::item:selected {
            background-color: #2ABf9E;
            }

            /*QLabel {*/
            /*    background-color: #FFFFFF;*/
            /*    qproperty-alignment: AlignCenter*/
            /*}*/

            QTreeWidget {
            color: #FFFFFF;
            background-color: #33373B;
            font-size: 18px;
            }

            QTreeWidget::item:selected {
            background-color: #2ABf9E;
            }

            QLabel{
            color: #33373B;
            background-color: None;
            }

            QLineEdit {
            border: 2px solid gray;
            border-radius: 10px;
            padding: 0 8px;
            background: greenyellow;
            selection-background-color: darkgray;
            font-size: 18px;
            }

            QLineEdit[echoMode="2"] {
            lineedit-password-character: 9679;
            }

            QLineEdit:read-only {
            background: lightblue;
            }

            QPushButton {
            border: 2px solid #8f8f91;
            border-radius: 10px;
            background-color: #2ABf9E;
            min-width: 50px;
            }

            QPushButton:pressed {
            background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1,
                                              stop: 0 #dadbde, stop: 1 #f6f7fa);
            }

            QPushButton:flat {
            border: none; /* no border for a flat push button */
            }

            QPushButton:default {
            border-color: navy; /* make the default button prominent */
            }

            QScrollBar:vertical {
            border: blue;
            background: orangered;
            border-radius: 10px;
            }

            QScrollBar:horizontal {
            border: blue;
            background: blue;
            border-radius: 10px;
            }
        """)

    with open("style.qss", "r") as f:
        _style = f.read()
        app.setStyleSheet(_style)
    
    sys.exit(app.exec())
    
    