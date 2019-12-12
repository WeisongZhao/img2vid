function stack=colorm(data,colormap)
z=size(data,3);
c=size(colormap,2);
stack=zeros(size(data,1),size(data,2),3,size(data,3));
colormap=double(colormap);
colormap=colormap./max(colormap(:));
for i=1:z
    stack(:,:,1,i)=1/z*data(:,:,i)*colormap(1,ceil(i*c/z),1);
    stack(:,:,2,i)=1/z*data(:,:,i)*colormap(1,ceil(i*c/z),2);
    stack(:,:,3,i)=1/z*data(:,:,i)*colormap(1,ceil(i*c/z),3);
end