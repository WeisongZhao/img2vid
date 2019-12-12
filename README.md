## img2vid
### A light weight matlab library for making exsiting images to videos 
It contains all codes to generate the videos in the publication:
**Weisong Zhao et al. Mathematically surpassing microscopic hardware limits
% to enable ultrafast, 60 nm resolution in live cells (2020) .........**

### Pipeline
- Load your exsiting images (captured with your camera or PMT) into memory:
`imreadRGBTiff` `imreadTiff`
- Process the images as your design:
`curtain` `colorm` `scalebar`  `frame` `imlarge``appendt` `appendxy` `Merge` `tifresize` 
- Save your results: `imwriteRGBstack` `imwritestack` 
- Print the label to the processed images.
- Make the videos! `draw_gif` `draw_avi`

### Instruction

- curtain.m: to creat the curtain-like special effect (comparison between multi-image). 

```python
data1=before;
data2{1}=after1;
data2{2}=after3;
img=curtain(data1,data2,rate)

data1=before;
data2=after;
img=curtain(data1,data2,rate)

for i=1:3
	data1=before(:,:,i);
	data2=after(:,:,i);
	img(:,:,i,:)=curtain(data1,data2,rate)
end
```

### Addional dependency:
#### [export_fig](https://github.com/altmany/export_fig)
#### [Zoom in ROI](https://gist.github.com/ekatrukha/61a1138063591b524e043891e5201f3d)
You can find documents through the links!