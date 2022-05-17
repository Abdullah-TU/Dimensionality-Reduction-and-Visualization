%%
X=noisysculptfaces(:,1:256);
Y=noisysculptfaces(:,257:end);
%%
% QA a
Y_pred=zeros(size(Y));
sz=size(X);
for i=1:sz(1)
    Sq_errors=zeros(sz(1),1);
    Sq_errors(i)=999999;
    for j=1:sz(1)
        if i~=j
            Sq_errors(j)=sum((X(i,:)-X(j,:)).^2);
        end
    end
    [V , ind]=min(Sq_errors);
    Y_pred(i,:)=Y(ind,:);
end
Total_Error=sum(sum((Y-Y_pred).^2,1),2);

%% 
% QA1 b
sz=size(X);
best_features=[];
best_features_errors=[];
while true    
    errors=zeros(sz(2),1);
    for i=1:sz(2)
        if ~ismember(i,best_features)
            errors(i)=leave_one_out(X(:,[best_features i]),Y);
        else
            errors(i)=999999;
        end
    end
    [V ,Ind]=min(errors);
    sub_total_error=leave_one_out(X(:,[best_features Ind]),Y);
    if sub_total_error<Total_Error && length(best_features_errors)>1
        if sub_total_error>best_features_errors(1,end)
            break;
        end
    end
    best_features=[best_features Ind];
    best_features_errors=[best_features_errors sub_total_error];
end
%% 
% QA1 c
sz=size(X);
best_features=[];
best_features_errors=[];
while true    
    if length(best_features)==256
        break;
    end
    errors=zeros(sz(2),1);
    for i=1:sz(2)
        if ~ismember(i,best_features)
            errors(i)=leave_one_out(X(:,[best_features i]),Y);
        else
            errors(i)=999999;
        end
    end
    [V ,Ind]=min(errors);
    best_features=[best_features Ind];
    sub_total_error=leave_one_out(X(:,best_features),Y);    
    best_features_errors=[best_features_errors sub_total_error];
end
%%
% QA1 d
[Val index]=min(best_features_errors);
reduced=(1-Val/Total_Error)*100;
plot(best_features_errors)
xlabel('number of features')
ylabel('Error')