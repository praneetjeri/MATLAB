clc
clear all

x=input('enter the sequence');
M=input('enter the radix');

N1=length(x);
H=M^(ceil(log(N1)/log(M)))-N1;
x=[x,zeros(1,H)];
N=length(x);
n=round(log(N)/log(M));
L=N/M;
%%
v=1;
for j=1:L
    for i=1:M
        y(j,i)=x(v);
        v=v+1;
    end
end

for k=1:n-2
   L=L/M;
   O=0;
   for a=0:M^(k-1)-1
     for u=1:M
      x=y(a*M*L+1:(a+1)*M*L,u,k);
      
      v=1; 
     for j=1:L
       for i=1:M
        y(O*L+j,i,k+1)=x(v);
        v=v+1;
       end
     end
    O=O+1;
     end
    end
end

if N==M
    U(:,1)=x.';
else
for a=0:N/M^2-1
    K=y(a*M+1:(a+1)*M,:,n-1);
    U(a*M^2+1:(a+1)*M^2,:)=K(:);
end
end

for a=0:M^(n-2)-1
     for u=1:M
      y(a*L+1:(a+1)*L,u,n-1)=w(M)*y(a*L+1:(a+1)*L,u,n-1);
     end
   g = y(a*L+1:(a+1)*L,:,n-1);
   U(a*L*M+1:(a+1)*L*M,2)=g(:);
end

q=2;
%%
for k=n-2:-1:1
    
    q=q+1;
    for a=0:M^(k)-1
        
  Y=y(a*L+1:(a+1)*L,:,k+1);
  
  for i=1:L
       for j=1:M
    Y(i,j)=twid(i,j,L*M)*Y(i,j);
       end
  end
y(a*L+1:(a+1)*L,:,k+1)=Y;
    end
    
    for i=1:N/M
        y(i,:,k+1)=y(i,:,k+1)*w(M);
    end
    
    
    for a=0:M^k-1
    g=y(a*L+1:(a+1)*L,:,k+1);
    U(a*M*L+1:(a+1)*L*M,q)=g(:);
    end
            
 for a=0:M^k-1
    z=y(a*L+1:(a+1)*L,:,k+1);
    Z(:,a+1)=z(:);
 end
    
    v=1;
    for a=1:M^(k-1)
        for h=1:M
            
    y((a-1)*M*L+1:(a)*M*L,h,k)=Z(:,v);
       v=v+1;
        end
    end
    
L=L*M;

clear Z z;
end

Y=y(:,:,1);

  for i=1:N/M
      for j=1:M
   Y(i,j)= twid(i,j,N)*Y(i,j);
      end
  end
  y(:,:,1)=Y;
  
 
  for i=1:N/M
      y(i,:,1)=y(i,:,1)*w(M);
  end
X=y(:,:,1);
DFT=X(:).';
U(:,n+1)=X(:);
sprintf('The %6.0d point DIT FFT ,at the input and output of different stages, of the sequence using radix %2.0d is',N,M),disp(U)

