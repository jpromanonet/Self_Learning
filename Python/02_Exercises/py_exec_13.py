print ('Number of Rounds!') # Script title

final_Round = 0 # Control variable to equal in the loop

for round in range(101): # Start Loop 
    print('Number of rounds: ('+ str(round) + ')')
    final_Round = final_Round + round 

print(final_Round)

# The same problem but with range's function stuff

for round in range(0, 101, 2):
    print('Number of rounds: ('+ str(round) + ')')
    final_Round = final_Round + round 

print(final_Round)