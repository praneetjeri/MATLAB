%Radix-2 Decimation in Time FFT.
clc         %Clear the Command Window.
clear       %Clear all variables and functions from memory.

while true
    %Variable N = Number of equidistant samples of DTFT X(w).
    N = input('Enter the number of samples, N = ');
    
    %N must be greator than or equal to 2.
    if N < 2
        disp('N must be greator than or equal to 2.');
        disp(' ');
        continue;
    end
    
    %log N (with base 2) must be an integer.
    if 2^(floor(log2(N))) == N
        break;
    end
    disp('log N (with base 2) must be an integer.');
    disp(' ');
end

%% Input Sequence x(n).
x = zeros(N,1);
disp(' ');
disp('Enter the input sequence x(n).');
for n = 1:N
    x(n) = input(['x(' num2str(n) ') = ']);   
end

%Save the input sequence x(n).
px = x;

%% Bit-reverse the sequence x(n).
x = Digit_Reverse(x,2);

%% Radix 2 FFT using decimation in time implementation.
%Variable 'a' counts the number of stages. 
for a = 1 : log2(N)
    %Variable 'b' counts the number of distinct butterfly collections per stage.
    for b = 1 : N/(2^a)
        tw = 0;
        %Variable 'c' counts the number of butterflies in each distinct collection.
        for c = (b - 1)*(2^a) + 1 : (b - 1)*(2^a) + 2^(a-1)
            t = x(c);
            
            %Radix-2 DIT Butterfly Implementation.
            x(c) = x(c) + (exp(-2i*(tw)*pi/N)) * x(c + 2^(a-1));
            x(c + 2^(a-1)) = t - (exp(-1i*2*(tw)*pi/N)) * x(c + 2^(a-1)); 
            
            tw = tw + N/(2^a);
        end
    end
end

disp(' ');
disp('Radix-2 FFT DIT, X(w) = ');
disp(x);

X = x;
x = px;