function result=appendt(A,B)
if ndims(A)==4
    [x,y,~,t]=size(A);
    result=zeros(x,y,3,t+size(B,4));
    result(:,:,:,1:t)=A;
    result(:,:,:,t+1:end)=B;
else
    [x,y,t]=size(A);
    result=zeros(x,y,t+size(B,3));
    result(:,:,1:t)=A;
    result(:,:,t+1:end)=B;
end