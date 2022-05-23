%reading file
[originalvector,originalfrequency]=audioread("the_entertainer.wav");
info=audioinfo("the_entertainer.wav");
originalbits=info.BitsPerSample;

nelements=size(originalvector,1)*size(originalvector,2);
blocksize=100;
nblocks=floor(nelements/blocksize);
featuredata=zeros(nblocks,blocksize);
for blockindex=1:nblocks
  featuredata(blockindex,:)=originalvector( ((blockindex-1)*blocksize+1):((blockindex-1)*blocksize+blocksize))';
end

% -------------------your code begins here----------------

[W, SCORES]=pca(featuredata,'NumComponents',15);
reconstructed_featuredata=SCORES*W';

% -------------------your code ends here----------------


reconstructedvector=zeros(nblocks*blocksize,1);
for blockindex=1:nblocks
  reconstructedvector(((blockindex-1)*blocksize+1):((blockindex-1)*blocksize+blocksize))=(reconstructed_featuredata(blockindex,:))';
end

audiowrite("pca_musicreconstruction.wav", reconstructedvector, originalfrequency, 'BitsPerSample',originalbits);


%Plotting
fig=figure('Position', get(0, 'Screensize'));

subplot(2,1,1)
plot(originalvector,'b');
title('Original wave');
hold on;

subplot(2,1,2)
plot(reconstructedvector,'r');
title('Reconstructed wave');
saveas(fig,'Reconstructed_sound.png');
hold off;

%Plotting two signal differences
fig=figure('Position', get(0, 'Screensize'));
stem(originalvector(1:length(reconstructedvector))-reconstructedvector);
title('Two signal differences: original signal vs constructed');
saveas(fig,'signal differences.png');