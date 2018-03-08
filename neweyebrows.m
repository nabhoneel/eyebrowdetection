%read image:
I = imread('images/cole.jpg');
I = imresize(I, [244,244]);

%Face detection:
 FDetect = vision.CascadeObjectDetector;
 FaceSegment = step(FDetect,I);
 imgFace = (I(FaceSegment(1,2):FaceSegment(1,2)+FaceSegment(1,4),FaceSegment(1,1):FaceSegment(1,1)+FaceSegment(1,3),:));
 mappingLeft = FaceSegment;
 mappingRight = mappingLeft;
 

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
 LeftEyebrow(4) = (LeftEyebrow(4)/2) - 3;
 LeftEyebrow(3) = LeftEyebrow(3);
 LeftEyebrow(4) = uint8(LeftEyebrow(4));
 LeftEyebrow(3) = uint8(LeftEyebrow(3));
 mappingLeft = mappingLeft + LeftEyebrow;
 
 LeftEyebrow(1) = LeftEye(1);
 LeftEyebrow(2) = LeftEye(2) - LeftEye(4) * 2;
 LeftEyebrow(3) = LeftEye(3);
 LeftEyebrow(4) = LeftEye(4) * 2;
 %imgLeftEyebrow = imgFace(LeftEye(1,2):);

%To detect Right Eyebrow
 RightEyebrow  = RightEye;
 RightEyebrow(4) = (RightEyebrow(4)/3) + 1;
 RightEyebrow(3) = RightEyebrow(3);
 RightEyebrow(4) = uint8(RightEyebrow(4));
 RightEyebrow(3) = uint8(RightEyebrow(3));
 mappingRight = mappingRight + RightEyebrow;
 
 imshow(imgFace); hold on;
 
 for i = 1:size(LeftEye,1)
    rectangle('Position',LeftEye(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','r');
 end
  
 for i = 1:size(RightEye,1)
    rectangle('Position',RightEye(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','r');
 end
 
 for i = 1:size(LeftEyebrow,1)
    rectangle('Position',LeftEyebrow(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','g');
 end

 for i = 1:size(RightEyebrow,1)
    rectangle('Position',RightEyebrow(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','g');
 end
 