function result=scalebar(img,a,b,c,d)
if ndims(img)==4
    result=img;
    result(a:b,c:d,:,:)=1;
else
    result=img;
    result(a:b,c:d,:)=1;
end