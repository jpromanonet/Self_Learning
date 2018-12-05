import sys

print('What do you want to do? stay or exit?')

while True:
    print('Type exit to exit or stay to stay(?).')
    response = input()
    if response == 'exit':
        sys.exit()
    else:
        print('You are in the eternal doom!! MUAHAHAHA')
    print('You typed ' + response + '.')
    sys.exit()