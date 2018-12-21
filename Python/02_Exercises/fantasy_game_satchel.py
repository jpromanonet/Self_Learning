# Importing libraries

import pprint

# Defining global scope values

new_Item = None
add_Item = None
keep_Adding = 'Y'
stuff = ['rope','torch','gold coin','dagger','arrow']

# Defining functions

def add_New_Item(item):
    stuff.append(item)

# Output and logic

print('Your current satchel has: ')
pprint.pprint(stuff)
print('')
print('Want to add stuff? Y/N')
add_Item = input()

if add_Item == 'Y':

    while keep_Adding == 'Y':

        if add_Item == 'Y':
            print('What do you want to add?')
            new_Item = input()
            add_New_Item(new_Item)
            print('')
            print('Your satchel has now: ')
            pprint.pprint(stuff)
            print('')
            print('Do you want to keep adding? Y/N')
            keep_Adding = input()
            if keep_Adding == 'Y':
                continue
            else:
                keep_Adding = 'N'
                break

    print('Bye traveler!')

else:
print('Bye traveler!')