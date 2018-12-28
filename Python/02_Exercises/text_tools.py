# Defining global values

input_Text = None
len_Text = None
upper_Text = None
lower_Text = None
keep_Working = 'Y'
option = None
text_Block = None

# Defining functions

def textLen(text): # Function to count text lenght
    len_Text = len(text)
    print('Your text lenght is: ' + str(len_Text) + ' characters')

def upperText(text): # Converting text to upper characters
    upper_Text = text.upper()
    print('Output: ' + str(upper_Text))
    
def lowerText(text): # Converting text to lower characters
    lower_Text = text.lower()
    print('Output: ' + str(lower_Text))

# Script logic

while keep_Working == 'Y': # Menu Loop

  print('-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-')
  print('1_______ Count text characters')
  print('')
  print('2_______ Convert to upper case')
  print('')
  print('3_______ Search word into a text')
  print('')
  print('4_______ Convert to lower case')
  print('')
  print('-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-')

  print('What do you want to do?')
  option = input()

  if option == '1':

    print('Write something, please')
    input_Text = input() # Introducing some text

    textLen(input_Text) # Counting the text lenght
    
  elif option == '2':

    print('Write something, please')
    input_Text = input() # Introducing some text

    upperText(input_Text) # Converting the text case
    
  elif option == '3':
    
    print('Write the keyboard to search into a text')
    input_Text = input() # Introducing keyboard text to search
    
    print('')
    
    print('Paste the text to search into')
    text_Block = input()
    
    if input_Text in text_Block == True:
      print('Your keyword is into the text')
    else:
      print('Result not found')
      
  elif option == '4':

    print('Write something, please')
    input_Text = input() # Introducing some text
    
    lowerText(input_Text) # Converting the text case
