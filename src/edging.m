function data=edging(data,n)
if ndims(data)==4
    data(1:n,:,:,:)=1;
    data(end-n+1:end,:,:,:)=1;
    data(:,1:n,:,:)=1;
    data(:,end-n+1:end,:,:)=1;
else
    data(1:n,:,:)=1;
    data(end-n+1:end,:,:)=1;
    data(:,1:n,:)=1;
    data(:,end-n+1:end,:)=1;
end