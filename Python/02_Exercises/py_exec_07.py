print('How old are you?') #ask the age
my_Age = input() # input age

if int(my_Age) < 18: # age comparision
    print('You are not on age')
elif int(my_Age) >= 18:
    print('You are on age')
    if int(my_Age) >= 100:
        print('You are a vampire or maybe inmortal')
        if int(my_Age) >= 500:
            print('You are inmortal')

while int(my_Age) < 18: # annoying part
    print('HAHA You cant buy beer!!!')
    my_Age = int(my_Age) + 1

else:
    print('You are not human then!')

# I left reading the book in chapter 2 | 'Break Stataments'