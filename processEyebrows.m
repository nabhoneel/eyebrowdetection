%process eyebrows for contour detection
function BW = processEyebrows(imgFace, Eyebrow);
 imgEyebrow = (imgFace(Eyebrow(1,2):Eyebrow(1,2)+Eyebrow(1,4),Eyebrow(1,1):Eyebrow(1,1)+Eyebrow(1,3),:));
 IM1 = imcomplement(imgEyebrow);
 se = strel('disk', 10);
 afterOpening = imopen(IM1, se);
 IM = IM1 - afterOpening;
 K = imadjust(IM, [0.1 0.20], []);
 level = graythresh(K);
 BW = im2bw(K, level);
 BW = medfilt2(BW);
end