function result=appendxy(A,B,axial)
if ndims(A)==4
    [~,~,~,t]=size(A);
    for i=1:t
        for j=1:3
            if axial==1
                result(:,:,j,i)=[squeeze(A(:,:,j,i)),squeeze(B(:,:,j,i))];
            else
                result(:,:,j,i)=[squeeze(A(:,:,j,i));squeeze(B(:,:,j,i))];
            end
        end
    end
else
    [~,~,t]=size(A);
    for i=1:t
            if axial==1
                result(:,:,i)=[squeeze(A(:,:,i)),squeeze(B(:,:,i))];
            else
                result(:,:,i)=[squeeze(A(:,:,i));squeeze(B(:,:,i))];
            end
    end
end