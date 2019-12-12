## img2vid
### A light weight matlab library for making exsiting images to videos 
It contains all codes to generate the videos in the publication:
**Weisong Zhao et al. Mathematically surpassing microscopic hardware limits
% to enable ultrafast, 60 nm resolution in live cells (2020) .........**

### Pipeline
- Load your exsiting images (captured with your camera or PMT) into memory:
`imreadRGBTiff` `imreadTiff`
- Process the images as your design:
`curtain` `colorm` `scalebar` `edging` `frame` `imlarge``appendt` `appendxy` `Merge` `tifresize` 
- Save your results: `imwriteRGBstack` `imwritestack` 
- Print the label to the processed images.
- Make the videos! `draw_gif` `draw_avi`

### Instruction

- curtain.m: to creat the curtain-like special effect (comparison between multi-image). 

```python
/example1
data1=before;
data2{1}=after1;
data2{2}=after3;
img=curtain(data1,data2,rate)

/example2
data1=before;
data2=after;
img=curtain(data1,data2,rate)

/example3
for i=1:3
	data1=before(:,:,i);
	data2=after(:,:,i);
	img(:,:,i,:)=curtain(data1,data2,rate)
end
```
- colorm.m: to creat the color-coded special effect (t or z axial projection). The common colormap **jet** and **16_colors** is provided in this repo.

```python
large=zeros(975+130,1042*2+200,3);
jet=double(imread('16_colors.tif'));
Mito=3*SHMito;
Mito=edging(Mito,3);
Mito=scalebar(Mito,950,953,750,855);
Tubulin=scalebar(Tubulin,950,953,750,855);
Mito2=2*SIMMito;
Mito2=edging(Mito2,3);
Mito=colorm(Mito,jet);
Mito2=colorm(Mito2,jet);
flage=0;
for i=141:-1:1
    large=zeros(975+130,1042*2+200,3);
    flage=flage+1;
    mid=sum(Mito(:,:,:,i:140),4);
    mid=mid./max(mid(:));
    mid=edging(mid,3);
    mid=scalebar(mid,900,903,850,955);
    large(81:80+975,71:70+1042,:)=mid;
    mid=sum(Mito2(:,:,:,i:140),4);
    mid=10*mid./max(mid(:));
    mid=edging(mid,3);
    mid=scalebar(mid,900,903,850,955);
    large(81:80+975,141+1042:140+1042*2,:)=mid;
    large(651:650+size(ceil(i*256/120):256,2),131:162,1)=jet(:,256:-1:ceil(i*256/120),1)'/255;
    large(651:650+size(ceil(i*256/120):256,2),131:162,2)=jet(:,256:-1:ceil(i*256/120),2)'/255;
    large(651:650+size(ceil(i*256/120):256,2),131:162,3)=jet(:,256:-1:ceil(i*256/120),3)'/255;
    imwrite(large,['stage1\',int2str(flage),'.tif']);
end
```
- imlarge.m: Interestingly, if you have a small image (for example 50x50) and want to display it in large, the interpolation (if over 2 times) will make such image looks very blurry or oversmooth. This function will enlarge each pixel without interpolation to solve this problem.

```python
large=imlarge(imgsmall,20);
```
#### Example：left: interpolation, right: imlarge.
<p align='center'>
  <img src='imgs/imginter.png' width='350'/>
  <img src='imgs/imlarge.png' width='350'/>
</p>

- draw_avi.m: You can DIY your specific video rate with a maximal rate.

```python
function draw_avi(display,filename,mag,Quality)
if nargin < 3 || isempty(mag)
    mag=1;
end
if nargin < 4 || isempty(Quality)
    Quality=100;
end
vid = VideoWriter(filename,'MPEG-4');
% vid = VideoWriter(filename,'Uncompressed AVI');
vid.Quality = Quality;
vid.FrameRate=30;
open(vid)
for i = 1 : 141
    for loop2=1:2
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end
for i = 141 : 141
    for loop2=1:60
        imshow(display(:,:,:,i),'border','tight','initialmagnification','fit')
        set (gcf,'Position',[0,0,mag*size(display(:,:,i),2),mag*size(display(:,:,i),1)])
        axis normal
        drawnow;
        c = getframe;
        writeVideo(vid, c);
    end
end
close(vid)
```
#### A code snippet to print label in matlab
```python
for i=142:349
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])
    text1=text(920,40,['\it{Z axial position 0 ~ }',num2str(roundn((140)*(0.05),-2)),' (\mu\it{m})']);
    set(text1,'Color',[1,1, 0],'Fontsize',20,'Fontname','Arial')
    text1=text(500,45,['label1']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    text1=text(1580,45,['label 2']);
    set(text1,'Color',[1,1,0.99],'Fontsize',20,'Fontname','Arial')
    text1=text(1284,1005-(i-142)*4,['\it{y}']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')
    text1=text(1224,951-(i-142)*4,['\it{z}']);
    set(text1,'Color',[1,1,0.99],'Fontsize',18,'Fontname','Arial')  
    annotation(gcf,'arrow',[0.53 0.53],...
    [0.097+(0.0034)*(i-142) 0.17+(0.0034)*(i-142)],'Color',[1 1 1],'LineWidth',2);
    annotation(gcf,'arrow',[0.53 0.58],...
    [0.096+(0.0034)*(i-142), 0.096+(0.0034)*(i-142)],'Color',[1 1 1],'LineWidth',2);
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
for i=517:543
    figure(1)
    flage=flage+1;
    large=imread(['stage1\',int2str(i),'.tif']);
    imshow(large,'border','tight','initialmagnification','fit')
    set (gcf,'Position',[0,0,1*size(large,2),1*size(large,1)])    
    text1=text(230,505,['label1']);
    set(text1,'Color',[1,0,0],'Fontsize',25,'Fontname','Arial')     
    text1=text(280,545,['+']);
    set(text1,'Color',[1,1,1],'Fontsize',25,'Fontname','Arial')  
    text1=text(170,585,['label2']);
    set(text1,'Color',[0,1,0],'Fontsize',25,'Fontname','Arial')
    export_fig(gcf,['stage2\',int2str(flage),'total.png'])
end
```
#### An example
<p align='center'>
  <img src='imgs/stage2.gif' width='1000'/>
</p>
#### `frame` aims to draw a rectangle ROI in the large field of view.
#### `appendt`and `appendxy` aim to append frames along different axes.
#### `Merge`and `tifresize` aim to append frames with different xy size along t axial 
#### `saclebar` aim to draw a scale bar.
#### `edging` aim to draw white boxes on the edge of images.

### Addional dependency:
#### [export_fig](https://github.com/altmany/export_fig)
#### [Zoom in ROI](https://gist.github.com/ekatrukha/61a1138063591b524e043891e5201f3d)
You can find documents through the links!