/**
CMPUT325 Assignment3
*/

/*
#1 xreverse (1 mark)

Define the predicate xreverse(+L, ?R) to reverse a list, where L is a given list and R is either a variable or another given list.

Examples: 
xreverse([7,3,4],[4,3,7]) should return true,
xreverse([7,3,4],[4,3,5]) should return false,
xreverse([7,3,4], R) should return R = [4,3,7].
*/

xreverse([F|L], R):- xreverse(L,T), append(T,[F],R).
xreverse([],[]).

/*
#2 xunique (2 marks)

Define the predicate xunique(+L, ?O) where L is a given list of atoms and O is a copy of L where all the duplicates have been removed. O can be either a variable or a given list. The elements of O should be in the order in which they first appear in L.

Examples: 
xunique([a,c,a,d], O) should return O = [a,c,d], 
xunique([a,c,a,d], [a,c,d]) should return true, 
xunique([a,c,a,d], [c,a,d]) should return false (because of wrong order), 
xunique([a,a,a,a,a,b,b,b,b,b,c,c,c,c,b,a], O) should return O = [a,b,c], 
xunique([], O) should return O = [].
*/

xunique(L, O):- xunique1(L, O, []).
xunique1([F|L1], O, N):- member(F,N), xunique1(L1, O, N).
xunique1([F|L1], O, N):- not(member(F,N)), append([F],N,T), xunique1(L1,O,T).
xunique1([],X,X).

/*
#3 xdiff (1 mark)

Define the predicate xdiff(+L1, +L2, -L) where L1 and L2 are given lists of atoms, and L contains the elements that are contained in L1 but not L2 (set difference of L1 and L2). 

Examples: 

xdiff([a,b,f,c,d],[e,b,a,c],L) should return L=[f,d], 
xdiff([p,u,e,r,k,l,o,a,g],[n,k,e,a,b,u,t],L) should return L = [p,r,l,o,g], 
xdiff([],[e,b,a,c],L) should return L = [].
*/

xdiff(L1, L2, L):- subtract(L1, L2, L).

/*
#4 removeLast (1 mark)

Define the predicate removeLast(+L, ?L1, ?Last) where L is a given non-empty list, L1 is the result of removing the last element from L, and Last is that last element. L1 and Last can be either variables or given values.

Examples: 
removeLast([a,c,a,d], L1, Last) should return L1 = [a,c,a], Last = d, 
removeLast([a,c,a,d], L1, d) should return L1 = [a,c,a], 
removeLast([a,c,a,d], L1, [d]) should return false (why?), 
removeLast([a], L1, Last) should return L1 = [], Last = a, 
removeLast([[a,b,c]], L1, Last) should return L1 = [], Last = [a,b,c].
*/

removeLast([F|L], [F|L1], Last):- removeLast(L, L1, Last).
removeLast([F|[]], [], F).

/*
#5 clique (5 marks)
The clique problem is a graph-theoretic problem of finding a subset of nodes where each node is connected to every other node in the subset. 
In this problem, a graph will be represented by a collection of predicates, node(A) and edge(A,B), where A and B are constants. 
Edges are undirected but only written once, so edge(A,B) also implies edge(B,A).
*/
node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).

/*
#5.1 allConnected (2 marks)
Use the predicates clique, xsubset and xappend above. 
Your job is to define the predicate allConnected(L) to test if each node in L is connected to each other node in L. A node A is connected to another node B if either edge(A,B) or edge(B,A) is true.

This is a simple (and very slow) "generate and test" approach to solving the clique problem. 
Upon backtracking, the subset predicate in your program will generate all the subsets, and each subset will be tested by your allConnected predicate.

allConnected(L) is true for an empty list, L= []. The recursive case is: 
allConnected([A|L]) if A is connected to every node in L and allConnected(L). Thus, you need to define a predicate, say connect(A,L), to test if A is connected to every node in L.
*/

allConnected([A|L]):- connect(A,L), allConnected(L) .
allConnected([]).

connect(A, [L1|L]):- edge(A,L1), connect(A, L).
connect(A, [L1|L]):- edge(L1,A), connect(A, L).
connect(_, []).

/*
#5.2 maxclique (3 marks)

Write a predicate maxclique(+N, -Cliques) to compute all the maximal cliques of size N that are contained in a given graph. 
N is the given input, Cliques is the output you compute: a list of cliques. 
A clique is maximal if there is no larger clique that contains it. 
In the example above, cliques [a,b,c] and [a,d] are maximal, but [a,b] is not, since it is contained in [a,b,c].

Examples (using the graph above): 
maxclique(2,Cliques) returns Cliques = [[a,d],[a,e]] 
maxclique(3,Cliques) returns Cliques = [[a,b,c]] 
maxclique(1,Cliques) returns Cliques = [] 
maxclique(0,Cliques) returns Cliques = []
*/

maxclique(N, Cliques):- number(N),
						findall(X, findCliqueLargerThan(N, X), T),
						findall(M, findMaxClique(M, T), T1),
						findall(G, checkLength(G, N, T1), Cliques).

%find all list that has a size greater than size N
findCliqueLargerThan(N, L):- clique(L), length(L, C), C>=N.

/*
find all list of M such that M is not a subet of any element of T
find check whether M contain in T
remove the subset
findMaxClique([1,2,3],[[1,2,3]]). => true
findMaxClique([1,2],[[1,2],[1,2,3]]). => false
*/
findMaxClique(M,T):- contain(M, T), removeSubset(M,T).

/*
find L inside [F|L1] st L is not a subset of F
removeSubset([1,2],[[1,2],[1,2,3]]). => false
removeSubset([1,2,3],[[1,2],[1,2,3]]). => true
*/
removeSubset(L, [F|L1]):- notsubset(L, F), removeSubset(L, L1).
removeSubset(L, [L|L1]):- removeSubset(L, L1).
removeSubset(_,[]).

/*
check whether [A|L] is a subset of X
If A is a member of X, continue checking with L
If A is not a member of X, stop
notsubset([1,2],[1,2,3]) => false
notsubset([1,2],[1,3,4]) => true
*/
notsubset([A|L], X):- member(A, X), notsubset(L, X).
notsubset([A|_], X):- not(member(A, X)).

/*
check whether element X contain in [A|L]
contain([1],[[1],[2]]) => true
contain([1,2],[[1,2],[3,4]]) => true
contain([1,2], [[1,2,3]]) => false
*/
contain(X,[A|L]):- not(X == A), contain(X, L).
contain(X,[X|_]).

/*
Find the L in T1 where length = N. 
checkLength([1,2],2,[[1,2],[3,4]]) => true
checkLength([3,4],2,[[1,2],[3,4]]) => true
checkLength([1,2],3,[[1,2],[3,4]]) => false
*/
checkLength(L, N, T1):- contain(L,T1), length(L, N).






