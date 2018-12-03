print('Fourth Program!')

print('What is your name?') #ask for the name
my_Name = input()

if my_Name == 'Juan':
    print('Password?') #ask for the password
    my_Password = input()

    if my_Password == 'Rom':    #Login auth logic
        print('Access Granted ' + my_Name)
    else:
        print('Incorrect Password')
else:
    print('Username Doesnt Exist')