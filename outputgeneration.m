%read image:
I = imread('images/face.jpg');
I = imresize(I, [244, 244]);

%Face detection:
 FDetect = vision.CascadeObjectDetector;
 FaceSegment = step(FDetect,I);
 imgFace = (I(FaceSegment(1,2):FaceSegment(1,2)+FaceSegment(1,4),FaceSegment(1,1):FaceSegment(1,1)+FaceSegment(1,3),:));

%To detect Left Eye
 EyeDetect = vision.CascadeObjectDetector('LeftEye');
 Eye=step(EyeDetect,imgFace);
 LeftEye  = Eye(1,:);

%To detect Left Eyebrow
 Eyebrow   = LeftEye;
 Eyebrow(4) = (Eyebrow(4)/2) - 4;
 Eyebrow(3) = Eyebrow(3);
 Eyebrow(4) = uint8(Eyebrow(4));
 Eyebrow(3) = uint8(Eyebrow(3));

 figure;
 imgEyebrow = (imgFace(Eyebrow(1,2):Eyebrow(1,2)+Eyebrow(1,4),Eyebrow(1,1):Eyebrow(1,1)+Eyebrow(1,3),:));
 subplot(2, 3, 1);
 imshow(imgEyebrow);
 IM1 = imcomplement(imgEyebrow);
 subplot(2, 3, 2);
 imshow(IM1);
 se = strel('disk', 10);
 afterOpening = imopen(IM1, se);
 subplot(2, 3, 3);
 imshow(afterOpening);
 IM = IM1 - afterOpening;
 subplot(2, 3, 4);
 imshow(IM);
 K = imadjust(IM, [0.1 0.20], []);
 subplot(2, 3, 5);
 imshow(K);
 level = graythresh(K);
 BW = im2bw(K, level);
 subplot(2, 3, 6);
 imshow(BW);
 BW = medfilt2(BW);