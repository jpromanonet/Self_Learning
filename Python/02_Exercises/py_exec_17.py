import random # Import the random library

def old_Trustie(answer_Number): # Create the function old_Trustie and stablish the parameters and returns
    if answer_Number == 1:
        return 'Its certain'
    elif answer_Number == 2:
        return 'It is decidedly no'
    elif answer_Number == 3:
        return 'Yes'
    elif answer_Number == 4:
        return 'Reply hazy, try again'
    elif answer_Number == 5:
        return 'Ask again later'
    elif answer_Number == 6:
        return 'Concentrate and ask again'
    elif answer_Number == 7:
        return 'My reply is NO'
    elif answer_Number == 8:
        return 'Outlook not so good'
    elif answer_Number == 9:
        return 'Very doubtful'

# Create a variable that contains the random function counting from 1 to 9
randomizer = random.randint(1, 9) 

# Create another variable that take the random number between 1 to 9 created by the variable randomizer and
# uses as a parameter to the funcion previously defined as old_Trustie, so it will return the print assigned for
# the number between 1 to 9
fortune = old_Trustie(randomizer)  

print(fortune)