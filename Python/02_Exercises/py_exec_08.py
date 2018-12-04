print('Another silly program')

print('Magic Word?') # Asking for the magic word

magic_word = input()

if magic_word == 'Stan': # Comparing the magic word
    print('Access Granted') 
else:
    wrong_Magic_Word_Counter = 1 # This variable starts the loop for wrong answers
    # Starting the loop
    while wrong_Magic_Word_Counter < 20:
        print('ah ah ah')
        if wrong_Magic_Word_Counter == 18:
            break # Breakpoint at 18 times of repeat.
        wrong_Magic_Word_Counter = wrong_Magic_Word_Counter + 1
    print('The T-Rex ate you! HA!')