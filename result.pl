:- consult(data).

%1. List all orders of a customer

list_orders(CustomerName, Orders) :-
    customer(CustomerId, CustomerName),
    list_orders_helper(CustomerId, Orders).

list_orders_helper(_, []).

list_orders_helper(CustomerId, [Order|Rest]) :-
    order(CustomerId, _, Order),
    list_orders_helper(CustomerId, Rest).

%2. Get number of orders of a customer
count_orders_for_customer(CustomerName, Count) :-
    customer(CustomerId, CustomerName),
    count_orders_helper(CustomerId, 1,Count).

count_orders_helper(_, Count, Count).
count_orders_helper(CustomerId, AccCount, Count) :-
    order(CustomerId, _, _),
    NewAccCount is AccCount + 1,
    order(NextCustomerId, _, _),
    NextCustomerId \= CustomerId, % Check if the next order belongs to a different customer
    !, % Cut to stop further backtracking
    Count = NewAccCount. % Stop counting, unify Count with the current count
count_orders_helper(CustomerId, AccCount, Count) :-
    order(CustomerId, _, _),
    NewAccCount is AccCount + 1,
    count_orders_helper(CustomerId, NewAccCount, Count).


% 3.List all items in a specific customer order given cust id and order
% id

getItemsInOrder(CustomerName, OrderId, Items) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderId, Items).
