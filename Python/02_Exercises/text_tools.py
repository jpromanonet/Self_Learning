# Defining global values

input_Text = None
len_Text = None
upper_Text = None
keep_Working = 'Y'
option = None

# Defining functions

def textLen(text): # Function to count text lenght
    len_Text = len(text)
    print('Your text lenght is: ' + str(len_Text) + ' characters')

def upperText(text): # Converting text to upper characters
    upper_Text = text.upper()
    print('Your text in upper characters is: ' + str(upper_Text))

# Script logic

while keep_Working == 'Y': # Menu Loop

    print('What do you want to do?')
    option = input()

    

    print('Write something, please')
    input_Text = input() # Introducing some text

    textLen(input_Text) # Counting the text lenght