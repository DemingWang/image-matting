close all
clc
clear

methodtype.LB = 1;
methodtype.IFM = 1;

[imName, imPath] = uigetfile({'*.jpg;*.png;*bmp','Picture'},'Select Original Img');

if isequal(imName,0) || isequal(imPath,0)
   disp('User pressed cancel');
   return;
else
   disp(['User selected ', fullfile(imPath, imName)])
end

[maskName, maskPath] = uigetfile({'*.jpg;*.png;*bmp','Picture'},'Select Trimap Img');
if isequal(maskName,0) || isequal(maskPath,0)
   disp('User pressed cancel');
   return;
else
   disp(['User selected ', fullfile(maskPath, maskName)])
end

[bkName, bkPath] = uigetfile({'*.jpg;*.png;*bmp','Picture'},'Select BackGround Img');
if isequal(bkName,0) || isequal(bkPath,0)
   disp('User pressed cancel');
   return;
else
   disp(['User selected ', fullfile(bkPath, bkName)])
end

%% parameters to change according to your requests

imNameWithPath = fullfile(imPath,imName);
maskNameWithPath = fullfile(maskPath,maskName);
bkNameWithPath = fullfile(bkPath,bkName);

%% configuration
addpath(genpath('./code'));

%% read image and mask
imdata=imread(imNameWithPath);
imbk = imread(bkNameWithPath);
imtrimap = imread(maskNameWithPath);
mask=getMask_onlineEvaluation(maskNameWithPath);

figure('Name','Original Img');
imshow(imdata);
figure('Name','Trimap Mask Img');
imshow(imtrimap);

%% compute alpha matte
tic;
[alpha]=learningBasedMatting(imdata,mask);
toc;
t = toc;
disp(['Computing Time: ',num2str(t),' seconds']);

%% show and save results
figure,subplot(2,1,1); imshow(imdata);
subplot(2,1,2),imshow(uint8(alpha*255));


newImg = changeBackground(imdata,alpha,imbk);



figure('Name','NewBackground Img_LearningBased');
imshow(newImg);
imwrite(newImg,'./newImgOutput/newImg8.png');

%% IFM method
if methodtype.IFM == 1
    % Get the parameter struct and edit for customization if desired
    params = getMattingParams('IFM');
    params.useKnownToUnknown = 0;

    a_ifm = informationFlowMatting(imdata, imtrimap, params);

    newImg2 = changeBackground(imdata,a_ifm,imbk);
    figure('Name','NewBackground Img_IFM');
    imshow(newImg2);
end