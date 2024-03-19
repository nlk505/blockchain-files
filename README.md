#voting system

##Introduction

This project is basically a simple voting system which allows voters to pick a preferred candidate from a list of candidates assigned by the “chair”. Chair is basically the person who preside the election process. In this project it is the person who deploy the contract.

##Personals involved
There are three primary personals involved in this voting system, namely
1.	The chair: The person who controls the voting system environment
2.	The candidates: who compete for a particular position. The candidates are assigned to the system by the chair
3.	Voters: These are the people who decides the winner from the list of candidates

   
##Voting process

The voting process starts when the chair sets the status into “ongoing” from “notstarted”. Then chair adds the candidates which are stored in an array. Then it is followed by creation of a voter profile in which the voter had to give their address into a parameter called “voterID” and also need to give the address of their preferred candidate into a parameter called “candidateID”. This voter profiles are then stored in an array called “voterlist”. Then the voter has to use the “index” function by giving their address. This function helps to locate their profile in the array and also helps to deal with multiple profile creation by the same candidate. Then for registering vote each voter has to use the voting function and provide their address to the field. The result of the voting process can be obtained after the chair change the status into “completed”. Moreover, in order to register a vote using voting function the following conditions must be satisfied
I.	The voter should use the index function
II.	The status of the voting process should be “ongoing”.
III.	The voter address should map to 0 in the “vote counter” mapping (to avoid multiple voting).

##Functions involved and their functions

1.	createcandidate: to deploy candidates to the voting system.it can be used only by the chair
2.	addvoter: to add voter profile to an array called voterlist.
3.	setstatus: to start and stop the voting process. Can be used only by chair.
4.	index: to get the index or position of individual voter from the array “voterlist”. It also helps to deal with the duplicate profile creation by a user.
5.	voting: it is the main function of the program. In order to register vote the voter used use this function
6.	results: it is the function which is used to shoe the result of the whole process. It can be only used after the chair change the status into “completed”. 

##Mappings involved

1.	votesGained: it is a mapping from address to uint which helps to keep track of votes gained by a candidate.
2.	votecounter: it is a mapping from address to uint which helps to keep track of votes registered by a voter (only one is allowed)
Modifiers
Only one modifier is used and its name is “onlychair” which makes sure that certain function is only used by the chair.
