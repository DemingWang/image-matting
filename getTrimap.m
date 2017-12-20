close all;
img = imread('Original.jpg');
img = rgb2gray(img);
img = imresize(img,0.25);
% img=double(img);
% %guass �˲�
% H=fspecial('gaussian',[5 5]);
% img=imfilter(img,H,'replicate');
% figure('Name','Gauss Filter');
% imshow(uint8(img));
% % img = uint8(img);
% 
% %%sobel��Ե���
% H=fspecial('sobel');
% img_w=imfilter(img,H,'replicate');      %����Ե
% H=H';
% img_h=imfilter(img,H,'replicate');      %������Ե
% img=sqrt(img_w.^2+img_h.^2);        %ע�����ﲻ�Ǽ򵥵���ƽ��������ƽ�����ڿ������������ó�һ��ʱ�䶼�����
% figure;
% imshow(uint8(img))


%log �˲�
hsize = [15 15];
sigma = 0.32;
H = fspecial('log',hsize,sigma);
img_filter_log = imfilter(img,H);
figure('Name','logFilter');
imshow((img_filter_log));

% ��ֵ�˲�
hsize = [15 15];
sigma = 0.35;
H = fspecial('average',5);
img_averagefilter = imfilter(img_filter_log,H);
% figure('Name','averagefilter');
% imshow((img_averagefilter));


imbw = im2bw(img_averagefilter,0.15);
% figure('Name','binary img');
% imshow(imbw);
H = fspecial('average',5);
imbw_filter = imfilter(imbw,H);
% figure('Name','imbw_averageFilter');
% imshow(imbw_filter);




   
se1=strel('disk',7);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ�� ����
im_dilate=imdilate(imbw_filter,se1);
% figure('Name','imdilate');
% imshow(im_dilate);

img_fill = imfill(im_dilate,'holes');
% figure('Name','Fill the holes');
% imshow(img_fill);
im_erode = img_fill;
imbw_filter = img_fill;

se1=strel('disk',7);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ�� ����
im_dilate=imdilate(imbw_filter,se1);
% figure('Name','imdilate');
% imshow(im_dilate);

img_fill = imfill(im_dilate,'holes');
figure('Name','Fill the holes');
imshow(img_fill);


se1=strel('disk',18);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ��
im_erode=imerode(im_erode,se1);
% figure('Name','imgerode');
% imshow(im_erode);
[row,col] = size(img);
for i = 1:row
    for j = 1:col
        if im_erode(i,j) == 1
            im_trimap(i,j) = 255;
        elseif img_fill(i,j) == 1
            im_trimap(i,j) = 128;
        else
            im_trimap(i,j) = 0;
        end
        
    end
end
im_trimap = uint8(im_trimap);
figure('Name','Trimap');
imshow(im_trimap);
% im_trimap = imresize(im_trimap,0.25);
imwrite(im_trimap,'./trimapOutput/autotrimap.png');

