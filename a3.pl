% CMPUT325 Assignment3

/**
#1 xreverse
xreverse([7,3,4],[4,3,7]) 	should return true,
xreverse([7,3,4],[4,3,5]) 	should return false,
xreverse([7,3,4], R) 		should return R = [4,3,7].
*/
xreverse([],[]).
xreverse([A|L], N):- xreverse(L,R), append(R,[A],N).

/**
#2 xunique
xunique([a,c,a,d], O) should return O = [a,c,d], 
xunique([a,c,a,d], [a,c,d]) should return true, 
xunique([a,c,a,d], [c,a,d]) should return false (because of wrong order), 
xunique([a,a,a,a,a,b,b,b,b,b,c,c,c,c,b,a], O) should return O = [a,b,c], 
xunique([], O) should return O = [].

Input: L1, L2
L1: a given list of atoms
L2: a copy of L1 and all duplicates are removed

xunique(L1,L2,[]), input L1 and L2 into the function, the [] will be use to store the unique list
if A is a member of X, then run on the rest of the list
else A is not a member of X, append to X and run on the rest of the list 
if L1 is already empty, just return X
*/
xunique(L1,L2):- xunique(L1,L2,[]).
xunique([A|L],L2,X):- member(A,X), xunique(L,L2,X).
xunique([A|L],L2,X):- append(X,[A], N), xunique(L,L2,N).
xunique([],X,X).


/**
#3 xdiff
xdiff([a,b,f,c,d],[e,b,a,c],L) should return L=[f,d], 
xdiff([p,u,e,r,k,l,o,a,g],[n,k,e,a,b,u,t],L) should return L = [p,r,l,o,g], 
xdiff([],[e,b,a,c],L) should return L = [].

Use subtract to get the set differences
*/

xdiff(L1, L2, L):- subtract(L1, L2, L).

/**
#4 removeLast
removeLast([a,c,a,d], L1, Last) should return L1 = [a,c,a], Last = d, 
removeLast([a,c,a,d], L1, d) should return L1 = [a,c,a], 
removeLast([a,c,a,d], L1, [d]) should return false (why?), 
removeLast([a], L1, Last) should return L1 = [], Last = a, 
removeLast([[a,b,c]], L1, Last) should return L1 = [], Last = [a,b,c].

on the last element, L will be [], and first element will be Last
if not the last element, remove the first element of L1 and L2
*/

removeLast([F|R], R, F):- R=[].
removeLast([F|R1], [F|R2], Last):- removeLast(R1, R2, Last).

/**
#5clique

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
*/

clique(L) :- findall(X,node(X),Nodes), xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- xappend(_, [X|Set1], Set), xsubset(Xs, Set1).

xappend([], L, L).
xappend([H|T], L, [H|R]) :- xappend(T, L, R).