print('Another silly Log-in program')

while True:
    print('Who are you?') # Asking username
    userName = input()

    if userName != 'Jack': # Auth
        continue
    print('Welcome Jack, what is the password?') # Asking password
    passWord = input()
    if passWord == 'swordfish':
        break
print('Access Granted!')