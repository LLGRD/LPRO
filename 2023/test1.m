
%====================
% [] = test1()
%--------------------
% Laman 16/01/2023
%====================

function [] = test1()

t1 = double(imread('noisy1.png'));
[h,w,~] = size(t1);
t2 = t1((h/2+1):end,:,:);
t1 = t1(1:(h/2),:,:);
c1 = zeros(256,3);  % hist cum t1
c2 = zeros(256,3);  % hist cum t2

for k = 1:256
	c1(k,1) = sum(sum(double(t1(:,:,1)<k)));
	c1(k,2) = sum(sum(double(t1(:,:,2)<k)));
	c1(k,3) = sum(sum(double(t1(:,:,3)<k)));
	c2(k,1) = sum(sum(double(t2(:,:,1)<k)));
	c2(k,2) = sum(sum(double(t2(:,:,2)<k)));
	c2(k,3) = sum(sum(double(t2(:,:,3)<k)));
endfor

c1(:,1) = round(255*c1(:,1)/c1(end,1));
c1(:,2) = round(255*c1(:,2)/c1(end,2));
c1(:,3) = round(255*c1(:,3)/c1(end,3));
c2(:,1) = round(255*c2(:,1)/c2(end,1));
c2(:,2) = round(255*c2(:,2)/c2(end,2));
c2(:,3) = round(255*c2(:,3)/c2(end,3));

c3 = zeros(256,3);  % reciproque de c1

for k = 1:256
	c3((c1(k,1)+1):end,1) = k-1;
	c3((c1(k,2)+1):end,2) = k-1;
	c3((c1(k,3)+1):end,3) = k-1;
endfor

figure(1); plot(0:255,c1(:,1),'r',0:255,c1(:,2),'g',0:255,c1(:,3),'b');
figure(2); plot(0:255,c2(:,1),'r',0:255,c2(:,2),'g',0:255,c2(:,3),'b');
figure(3); plot(0:255,c3(:,1),'r',0:255,c3(:,2),'g',0:255,c3(:,3),'b');

t = c2(:,1);
u = c3(:,1);
t2(:,:,1) = u(t(t2(:,:,1)+1)+1);
t = c2(:,2);
u = c3(:,2);
t2(:,:,2) = u(t(t2(:,:,2)+1)+1);
t = c2(:,3);
u = c3(:,3);
t2(:,:,3) = u(t(t2(:,:,3)+1)+1);

imwrite(uint8([t1;t2]),'test1.png');

endfunction
