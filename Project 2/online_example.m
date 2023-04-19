%Example from Bodgan M. Wilamowski
%NEURAL NETWORKS
%single neuron training

%single neuron LMS training with soft activation function
format compact; clear all;
ip=[1 2; 2 1], dp=[-1,1]', ww=[1 3 -3], c=0.1; k=1;
figure(1); clf; hold on; xlabel('X input'); ylabel('Y input');
plot(ip(1,1),ip(1,2),'ro'); plot(ip(2,1),ip(2,2),'bx');
[np,ni]=size(ip); ip(:,ni+1)=ones(np,1) %augmenting
a=axis ; a=[0 4 0 4]; axis(a); j=0;
for ite=1:100,
for p=1:np,
j=j+1; if j>1, plot(x,y,'g'); end;
net(p)=ip(p,:)*ww' ;
op(p)=tanh(0.5*k*net(p)); %hyperbolic function
er(p)=dp(p)-op(p); ww=ww+c*(dp(p)-net(p))*ip(p,:);
x(1)=-1; y(1)=-(ww(1)*x(1)+ww(3))./ww(2);
x(2)=4; y(2)=-(ww(1)*x(2)+ww(3))./ww(2);
plot(x,y,'r');
end
ter=sqrt(er*er'), tter(ite)=ter;
if ter <0.0001, break; end;
end;
hold off; ite
figure(2); clf;
semilogy(tter); xlabel('iterations'); ylabel('error');