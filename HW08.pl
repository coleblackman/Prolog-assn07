% Proves if the coordinates share a row or column.
same_row_or_column(X, _, X, _).
same_row_or_column(_, Y, _, Y).

% Proves if there are checks, duplicates, or collisions.
check(C/H/_/_, [C/H/_/_|_]). 
check(_/_/X/Y, [_/_/X/Y|_]). 
check(C/_/X/Y, [C/_/X1/Y1|_]) :- same_row_or_column(X, Y, X1, Y1).
check(_/H/X/Y, [_/H/X1/Y1|_]) :- same_row_or_column(X, Y, X1, Y1).  
check(C/H/X/Y, [_|T]) :- check(C/H/X/Y, T). 

% Ensures the coordinates are integers between 1 and N.
coordinate(X, X).
coordinate(X, N) :- N1 is N-1, N1 =\= 0, coordinate(X, N1).

% Proves if the board is legal.
legal(_, []).
legal(S, [C/H/X/Y|T]) :-
    legal(S, T),
    coordinate(X,S),
    coordinate(Y,S),
    not(check(C/H/X/Y,T)).

% Initializes the board according to a given area.
board(_, 0, _, []).
board(S, C, 1, [C/1/_/_|T]) :- C1 is C-1, board(S,C1,S,T).
board(S, C, H, [C/H/_/_|T]) :- H1 is H-1, board(S,C,H1,T).

% Gives a sixty-four rook board in the format Color/Height/X/Y.
sixty_four_rooks(S, X) :-
    board(S, S, S, X),
	legal(S, X).

/* Results:
 * Board size 3, query "sixty_four_rooks(3, X)":
 * X = [3/3/2/3, 3/2/3/1, 3/1/1/2, 2/3/3/2, 2/2/1/3, 2/1/2/1, 1/3/1/1, 1/2/2/2, 1/1/3/3]
 * 
 * Board size 4, query "sixty_four_rooks(4, X)":
 * X = [4/4/4/2, 4/3/3/1, 4/2/2/4, 4/1/1/3, 3/4/3/4, 3/3/4/3, 3/2/1/2, 3/1/2/1, 2/4/2/3, 2/3/1/4, 2/2/4/1, 2/1/3/2, 1/4/1/1, 1/3/2/2, 1/2/3/3, 1/1/4/4]
 * 
 * Board size 5, query "sixty_four_rooks(5, X)":
 * X = [5/5/2/3, 5/4/3/4, 5/3/4/5, 5/2/5/1, 5/1/1/2, 4/5/3/5, 4/4/4/1, 4/3/5/2, 4/2/1/3, 4/1/2/4, 3/5/4/2, 3/4/5/3, 3/3/1/4, 3/2/2/5, 3/1/3/1, 2/5/5/4, 2/4/1/5, 2/3/2/1, 2/2/3/2, 2/1/4/3, 1/5/1/1, 1/4/2/2, 1/3/3/3, 1/2/4/4, 1/1/5/5]
 * 
 * Board size 6, query "sixty_four_rooks(6, X)":
 * time limit exceeded
 * 
 * Board size 7, query "sixty_four_rooks(7, X)":
 * time limit exceeded
 * 
 * Board size 8, query "sixty_four_rooks(8, X)":
 * time limit exceed
 * 
 * For board sizes of 6 or greater, the compiler times out as these queries
 * are too computationally expensive to complete. A solution to this could
 * be to optimize our code, possibly using the clpfd library; however, this
 * is out of the reach of the assignment. 
 * 
*/
