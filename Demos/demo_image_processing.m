clear
close all
%read/display a gray-scale image
im1=imread('bacteria.bmp');
imshow(im1);
size(im1)
whos
max(max(im1))
min(min(im1))
pause

% examine pixel info using imtool()
imtool(im1)
pause

%convert to binary image by thresholding
imhist(im1)
pause
bw=im1<100;
imshow(bw)
pause

if(0)
%create a synthetic binary image
im2=zeros(200,200);
subplot(211), imshow(im2)
im2(80:120,100:140)=1;
subplot(212), imshow(im2)
pause

%add Gaussian random noise to an image
im3=0.5*ones(200,200);
subplot(111), imshow(im3)
pause
im4=im3+0.01*randn(size(im3));
subplot(211),imshow(im4)
subplot(212), imhist(im4)
pause

%color image
im5=imread('Water lilies.jpg');
size(im5)
imtool(im5)
pause
subplot(221), imshow(im5), title('RGB color image')
subplot(222), imshow(im5(:,:,1)), title('R-component of the color image')
subplot(223), imshow(im5(:,:,2)), title('G-component of the color image')
subplot(224), imshow(im5(:,:,3)), title('B-component of the color image')
pause

%color space conversion
hsvimg=rgb2hsv(im5);
subplot(221), imshow(im5), title('RGB color image')
subplot(222), imshow(hsvimg(:,:,1)), title('hue-component of the color image')
subplot(223), imshow(hsvimg(:,:,2)), title('saturation-component of the color image')
subplot(224), imshow(hsvimg(:,:,3)), title('value (intensity)-component of the color image')

end
