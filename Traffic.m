a=VideoReader('traffic.mp4');
 get(a);
 darkCarValue=50;
 darkCar=rgb2gray(read(a,71));
noDarkCar=imextendedmax(darkCar,darkCarValue);
sedisk=strel('disk',2);
noSmallStructures=imopen(noDarkCar,sedisk);
nframes=get(a,'NumberOfFrames');
i=read(a,1);
taggedCars = zeros([size(i,1) size(i,2) 3 nframes],class(i));
 for k=1:nframes
singleFrame=read(a,k);
i=rgb2gray(singleFrame);
noDarkCars=imextendedmax(i,darkCarValue);
noSmallStructures=imopen(noDarkCars,sedisk);
noSmallStructures=bwareaopen(noSmallStructures,150);
taggedCars(:,:,:,k)=singleFrame;
stats=regionprops(noSmallStructures,{'Centroid','Area'});
if ~isempty([stats.Area])
areaArray=[stats.Area];
[junk,idx]=max(areaArray);
c=stats(idx).Centroid;
c=floor(fliplr(c));
width=2;
row=c(1)-width:c(1)+width;
col=c(2)-width:c(2)+width;
taggedCars(row,col,1,k)=255;
taggedCars(row,col,2,k)=0;
taggedCars(row,col,3,k)=0;
end
end
frameRate=get(a,'FrameRate');
implay(taggedCars,frameRate);
displayEndOfDemoMessage(mfilename)