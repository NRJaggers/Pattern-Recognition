%You can write MATLAB code in three places, in command window directly, in
%a script file such as this one, or in a function (more flexible, 
%it can take arguments, return values).

% The following is a collection of some simple MATLAB code
clear
%define variables (scalar, vector, matrix)
a=10
v1=[1 2 3]
v2=[1;2;3]
v3=1:-0.1:0
v4=1:10
A=[1 2 3; 4 5 6; 7 8 9]
pause

%address element in vector/matrix (the index starts from 1 in MATLAB!)
v1(2)
A(4)
A(2,3)
pause

%special matrix
A2=zeros(2,3)
A3=ones(3)
A4=eye(5)
A5=rand(2,3)
z=randn(100,1); histogram(z)
pause

%matrix operation
A+A3
A*A3
matrix_with_element_greater_than_3 = A>3
max_of_A=max(max(A))
[i,j]=find(A==max(max(A)))
largest_element=A(i,j)
eigenvector=eig(A)

%flow control using if...else, switch...case, whie, for,.... 
%use help in case of doubt
