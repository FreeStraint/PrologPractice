/*
CMPUT325 Assignment4
Name:
CCID:
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

