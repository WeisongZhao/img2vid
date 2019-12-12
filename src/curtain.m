function img=curtain(data1,data2,rate)

if ~iscelldata2)
    of=size(data1,3);
    frame=floor(size(data1,2)/rate);
    if size(data1,3)<frame
        data1=padarray(data1,[0,0,frame-of],'circular','post');
        data2=padarray(data2,[0,0,frame-of],'circular','post');
    end
    for i=1:frame
        data2(:,i*rate:end,i)=data1(:,i*rate:end,i);
        data2(:,i*rate:i*rate+1,i)=1;
    end
    img=data2;
else
    
    flage=1;
    of=size(data1,3);
    leave=0;
    
    for multistack=1:size(data2,2)
        if multistack==1
            frame=floor(size(data1,2)/rate);
            img=data2{1};
            
            if size(data1,3)<frame
                data1=padarray(data1,[0,0,frame-of],'circular','post');
                img=padarray(img,[0,0,frame-of],'circular','post');
            end
            
            for i=1:frame
                img(:,i*rate:end,flage)=data1(:,i*rate:end,i);
                img(:,i*rate:i*rate+1,flage)=1;
                flage=flage+1;
            end
            
        else
            
            if flage>of
                leave=mod(flage,of);
            end
            data2mid=data2{multistack};
            
            if of<frame
                data2mid=padarray(data2mid,[0,0,frame-of+leave+1],'circular','post');
                    data2mid2=data2{multistack-1};
                data2mid2=padarray(data2mid2,[0,0,frame-of+leave+1],'circular','post');
                img(:,:,flage:flage+frame)=data2mid(:,:,leave+1:leave+1+frame);
            else
                    data2mid2=data2{multistack-1};
                img(:,:,flage:flage+frame)=data2mid(:,:,leave+1:leave+1+frame);
            end
            
            for i=1:frame
                img(:,i*rate:end,flage)=data2mid2(:,i*rate:end,i+leave);
                img(:,i*rate:i*rate+1,flage)=1;
                flage=flage+1;
            end
            
        end
    end
end
end