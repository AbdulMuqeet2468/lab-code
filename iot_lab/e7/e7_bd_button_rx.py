from bluedot import BlueDot
bd = BlueDot()

while True:
    bd.wait_for_press()
    print("you pressed the bluedot!")