from bluedot import BlueDot
from signal import pause
def dpad(pos):
    if pos.top:
        print("UP 184")
    elif pos.bottom:
        print("BOTTOM 184")
    elif pos.left:
        print("LEFT 184")
    elif pos.right:
        print("RIGHT 184")
    elif pos.middle:
        print("fire 184")

bd = BlueDot()
bd.when_pressed = dpad
pause