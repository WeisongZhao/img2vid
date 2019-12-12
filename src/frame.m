function result=frame(img,a,b,c,d,n)
if ndims(img)==4
    result=img;
    result(a:b+n,c:c+n,:,:)=1;
    result(a:b+n,d:d+n,:,:)=1;
    result(b:b+n,c:d+n,:,:)=1;
    result(a:a+n,c:d+n,:,:)=1;
else
    result=img;
    result(a:b+n,c:c+n,:)=1;
    result(a:b+n,d:d+n,:)=1;
    result(b:b+n,c:d+n,:)=1;
    result(a:a+n,c:d+n,:)=1;
end

