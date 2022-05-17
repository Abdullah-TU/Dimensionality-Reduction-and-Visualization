function [error] = leave_one_out(x,Y)
    Y_pred=zeros(size(Y));
    sz=size(x);
    for i=1:sz(1)
        Sq_errors=zeros(sz(1),1);
        Sq_errors(i)=999999;
        for j=1:sz(1)
            if i~=j
                Sq_errors(j)=sum((x(i,:)-x(j,:)).^2);
            end
        end
        [V ind]=min(Sq_errors);
        Y_pred(i,:)=Y(ind,:);
    end
    error=sum(sum((Y-Y_pred).^2,1),2);
end