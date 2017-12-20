function [ newImg ] = changeBackground( Img,alpha,newBackImg )
beta = 1-alpha;
[row,col,channel] = size(Img);
newBackImg = imresize(newBackImg,[row,col]);
Img = double(Img);
newBackImg = double(newBackImg);

for it_channel = 1:channel
   newImg(:,:,it_channel) = Img(:,:,it_channel).* alpha + newBackImg(:,:,it_channel).*beta;%
end

newImg = uint8(newImg);


end

