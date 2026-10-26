from bluedot import BlueDot
from signal import pause

def say_hello():
    print("hello 184")
def say_goodbye():
    print("bye bye 184")

bd = BlueDot()
bd.when_pressed = say_hello
bd.when_released = say_goodbye