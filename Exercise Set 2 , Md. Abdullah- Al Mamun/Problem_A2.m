%%
X=noisysculptfaces(:,1:256);
Y=noisysculptfaces(:,257:end);
%%
% Question 1
corrs=corr(X,Y);
corrs_mean=mean(abs(corrs),2);
features_num=sum(corrs_mean>mean(corrs_mean));
%%
% Question 2
sz=size(X);
rank_score=zeros(sz(2),1);
for i=1:sz(2)
    rank_score(i)=leave_one_out(X(:,i),Y);
end
[rank_score_sorted,indices]=sort(rank_score);
%%
same_features=0;
for i=1:length(indices(1:54))
    if ismember(indices(i),best_features(1:54))
        same_features=same_features+1;
    end
end
same_features_per=same_features/length(indices(1:54))*100