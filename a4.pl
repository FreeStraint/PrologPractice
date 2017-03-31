/*
CMPUT325 Assignment4
Name:
CCID:
*/

:- use_module(ibrary(clpfd)).

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


define a predicate count(+N,+M,-X) which given two integers N and M returns all the integers between them in succession. 
For example, the query 
?- count(3,7,X) 
would return

X = 3;
X = 4;
X = 5;
X = 6;
X = 7;
*/

