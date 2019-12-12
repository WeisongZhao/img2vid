function largeimg=imlarge(img,n)
if ndims(img)==4
    largeimg=zeros(n*size(img,1),n*size(img,2),3,size(img,4));
    for i=1:n
        for j=1:n
            largeimg(i:n:end-n+i,j:n:end-n+j,:,:)=img;
        end
    end
else
    largeimg=zeros(n*size(img,1),n*size(img,2),size(img,3));
    
    for i=1:n
        for j=1:n
            largeimg(i:n:end-n+i,j:n:end-n+j,:)=img;
        end
    end
end