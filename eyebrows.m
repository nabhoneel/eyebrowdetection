%Detect eyebrows, find distances and width

%read image:
I = imread('images/mug.jpg');
I = imresize(I, [244, 244]);

%Face detection:
 FDetect = vision.CascadeObjectDetector;
 FaceSegment = step(FDetect,I);
 imgFace = (I(FaceSegment(1,2):FaceSegment(1,2)+FaceSegment(1,4),FaceSegment(1,1):FaceSegment(1,1)+FaceSegment(1,3),:));
 mappingLeft = FaceSegment;
 mappingRight = mappingLeft;
 
%%
 %imshow(imgFace); figure;

 %To detect Left Eye
 EyeDetect = vision.CascadeObjectDetector('LeftEye');
 Eye=step(EyeDetect,imgFace);
 LeftEye  = Eye(1,:);
  
 %To detect Right Eye
 EyeDetect = vision.CascadeObjectDetector('RightEye');
 Eye=step(EyeDetect,imgFace);
 RightEye = Eye(2,:);

%To detect Left Eyebrow
 LeftEyebrow   = LeftEye;
 LeftEyebrow(4) = (LeftEyebrow(4)/2) - 4;
 LeftEyebrow(3) = LeftEyebrow(3);
 LeftEyebrow(4) = uint8(LeftEyebrow(4));
 LeftEyebrow(3) = uint8(LeftEyebrow(3));
 mappingLeft = mappingLeft + LeftEyebrow;

%To detect Right Eyebrow
 RightEyebrow  = RightEye;
 RightEyebrow(4) = (RightEyebrow(4)/3) + 1;
 RightEyebrow(3) = RightEyebrow(3);
 RightEyebrow(4) = uint8(RightEyebrow(4));
 RightEyebrow(3) = uint8(RightEyebrow(3));
 mappingRight = mappingRight + RightEyebrow;
 
 
 imshow(imgFace); hold on;
 
 figure;
 
%%

%To show the left eyebrow as a figure:
 
 BW = processEyebrows(imgFace, LeftEyebrow); 
 
 [startlx stoplx startly stoply contourL] = findContours(BW, mappingLeft);
 
 widthL = findWidth(contourL);
 
 subplot(2, 2, 1);
 imshow(I); hold on
 plot(contourL(:,2),contourL(:,1),'g','LineWidth',1);
 plot(startlx, startly, 'o');
 plot(stoplx, stoply, 'o');
 
 distance = num2str(pdist([startlx, startly; stoplx, stoply], 'euclidean'));
 t = strcat('Distance= ', distance, '    Width=', num2str(widthL));
 title(t);
 
%%
 
 %To show the right eyebrow as a figure:
 
 BW = processEyebrows(imgFace, RightEyebrow);
 
 [startrx stoprx startry stopry contourR] = findContours(BW, mappingRight);
 
 widthR = findWidth(contourR);
 
 subplot(2,2,2);
 imshow(I); hold on;
 plot(contourR(:,2),contourR(:,1),'g','LineWidth',1);
 plot(startrx, startry, 'o');
 plot(stoprx, stopry, 'o');
 
 distance = num2str(pdist([startrx, startry; stoprx, stopry], 'euclidean'));
 t = strcat('Distance= ', distance, '    Width=', num2str(widthR));
 title(t);
 
 %%

 subplot(2,2,3);
 imshow(I);
 hold on;
 midPointRX = (stoprx + startrx)/2;
 midPointRY = (stopry + startry)/2;
 midPointLX = (stoplx + startlx)/2;
 midPointLY = (stoply + startly)/2;
 
 distance = num2str(pdist([midPointLX, midPointLY; midPointRX, midPointRY], 'euclidean'));
 t = strcat('Distance between centres=', distance);
 title(t);
 
 plot(midPointRX, midPointRY - 4, 'o');
 plot(midPointLX, midPointRY - 4, 'o');
 
 %%
 
 subplot(2,2,4);
 imshow(I);
 hold on;
 
 distance = num2str(pdist([startlx, startly; stoprx, stopry], 'euclidean'));
 t = strcat('Distance between eyebrows (ends)=', distance);
 title(t);
 
 plot(startlx, startly, 'o');
 plot(stoprx, stopry, 'o');