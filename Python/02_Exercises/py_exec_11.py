name = ''
while not name: # Start loop
    print('Enter your name:')
    name = input()
print('How many guests will you have?')
numOfGuests = int(input())
if numOfGuests: 
    print('Be sure to have enough room for all your guests.') # More questions
print('Done')