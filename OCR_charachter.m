clc
load TrainedModel.mat;
load emnist-letters.mat;
N = 10000;
data = [dataset.train.images(1:N,:) dataset.train.labels(1:N,:)];
data = double(data);
clc
close all
N = 10;
out = stringmaker(dataset,N);
imshow(out)
letters = segmenter(out);
letters = prepare_for_dataset(letters);
detected = trainedModel.predictFcn(letters.finalData);
show_detected(detected')
%% Functions

function out = stringmaker(dataset,N)
out = [];
for i = 1:N
    
    index = floor(length(dataset.train.images)*rand());
    sample  = dataset.train.images(index,:);
    img = reshape(sample,[28,28]);
    out = [out img]; 
    
end

end

function letters = segmenter(input)
i = 1;
input = double(input);
count = 1;
while( i < length(input))
    img = [];
   if(mean(input(:,i))~=0)
       j = i;
       while(mean(input(:,j))~=0)
           img=[img input(:,j)];
           j = j+1;
       end       
       letters.(sprintf("pic%i",count)) = img;
       count = count + 1;
       i = j;
   end
i = i +1;
end

end

function letters = prepare_for_dataset(letters)
finalData = [];
for i = 1 : numel(fieldnames(letters))
    pic = letters.(sprintf("pic%i",i));
   N_of_zeros = 28 - length(pic(1,:));
   left_zeros = floor(N_of_zeros/2);
   pic = [zeros(28,left_zeros) pic zeros(28,N_of_zeros-left_zeros)];
   
   letters.(sprintf("pic%i",i)) = uint8(reshape(pic,[1,28*28]));
   finalData = [finalData;uint8(reshape(pic,[1,28*28]))];
end
letters.finalData = finalData;
end

function show_detected(in)
show = "";
for i = in
    
    switch(i)
        
        case(1)
           show = show+"A ";
        case(2)
            show = show+"B ";
        case(3)
            show = show+"C ";
        case(4)
            show = show+"D ";
        case(5)
            show = show+"E ";
        case(6)
            show = show+"F ";
        case(7)
            show = show+"G ";
        case(8)
            show = show+"H ";
        case(9)
            show = show+"I ";
        case(10)
            show = show+"J ";
        case(11)
            show = show+"K ";
        case(12)
            show = show+"L ";
        case(13)
            show = show+"M ";
        case(14)
            show = show+"N ";
        case(15)
            show = show+"O ";
        case(16)
            show = show+"P ";
        case(17)
            show = show+"Q ";
        case(18)
            show = show+"R ";
        case(19)
            show = show+"S ";
        case(20)
            show = show+"T ";
        case(21)
            show = show+"U ";
        case(22)
            show = show+"V ";
        case(23)
            show = show+"W ";
        case(24)
            show = show+"X ";
        case(25)
            show = show+"Y ";
        case(26)
            show = show+"Z ";

    end
    
end
disp(show);
end