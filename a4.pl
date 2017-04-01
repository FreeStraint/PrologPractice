/*
CMPUT325 Assignment4
Name:
CCID:

Able to pass all test cases, collaborate with Mingjun Zhao
*/

:- use_module(library(clpfd)).

/**
Question 1 - Four squares

It's an interesting theorem from number theory that every natural number can be expressed as the sum of four or fewer squares
For example:
1 = 1*1
2 = 1*1 + 1*1
3 = 1*1 + 1*1 + 1*1
4 = 2*2
5 = 1*1 + 2*2
6 = 2*2 + 1*1 + 1*1
7 = 2*2 + 1*1 + 1*1 + 1*1
8 = 2*2 + 2*2
fourSquares(+N, [-S1, -S2, -S3, -S4])
*/

fourSquares(N, [S1, S2, S3, S4]):- [S1,S2,S3,S4] ins 0..N,
									S1 #=< S2, S2 #=< S3, S3 #=< S4,
									S1 * S1 + S2 * S2 + S3 * S3 + S4 * S4 #= N,
									label([S1,S2,S3,S4]).

/**
Question 2 - War and Peace

Two countries have signed a peace treaty and want to disarm over a period of months, 
but they still don't completely trust each other. 
Each month one of the countries can choose to dismantle one military division 
while the other can dismantle two. 
Each division has a certain strength, and both sides want to make sure that the total military strength 
remains equal at each point during the disarmament process. 

Country A: 1, 3, 3, 4, 6, 10, 12
Country B: 3, 4, 7, 9, 16

Month 1: A dismantles 1 and 3, B dismantles 4
Month 2: A dismantles 3 and 4, B dismantles 7
Month 3: A dismantles 12, B dismantles 3 and 9
Month 4: A dismantles 6 and 10, B dismantles 16

Begin:
first check whether the two division sum is equal

then start disarm
disarmSelect will first select two element from Adivisions and select one elemnt from Bdivisions
If found, continue on rest of the list
If not found, then select one element from Adivisions and select two elements from Bdivisions
If not found, return false

Add strength variable, the current pair strength must be greater than the next pair, thus when inserting, the current pair will be insert later
than the next pair, to make the solution sorted

*/									 

disarm(Adivisions, Bdivisions, Solution):- sum(Adivisions, X), sum(Bdivisions, X), disarmSelect(Adivisions, Bdivisions, Solution,0).

disarmSelect(Adivisions, Bdivisions, Solution, Strength):-
				Vars = [A,B,C],
				select(A, Adivisions, A1),
				select(B, A1, A2),
				select(C, Bdivisions, B1),
				A #=< B,
				A + B #= C, 
				Strength #=< C,
				disarmSelect(A2,B1,S1,C),
				append([[[A,B],C]], S1, Solution),
				label(Vars).

disarmSelect(Adivisions, Bdivisions, Solution, Strength):-
				Vars = [A,B,C],
				select(A, Adivisions, A1),
				select(B, Bdivisions, B1),
				select(C, B1, B2),
				B #=< C,
				B + C #= A, 
				Strength #=< A ,
				disarmSelect(A1, B2, S1, A),
				append([[A,[B,C]]], S1, Solution),
				label(Vars).

disarmSelect([],[],[],_).

sum([], 0).
sum([A|L], X):- sum(L, X1), X is A + X1.



