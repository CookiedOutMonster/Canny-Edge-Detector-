clear;clc;
%There is a fair chance I need to open this image because opening gets rid
%of protusions / things that connects objects together

%% Thresholding

I = imread("money.png");
I = rgb2gray(I);

 for i=1:size(I,1)
       for j = 1:size(I,2)
           if(I(i,j) >= 10)
               I(i,j) = 1; 
           else
               I(i,j) = 0;
           end
       end
  end
  I = double(I);
 
%% erosion to seperate coins 
SE = strel('square', 100);
I = imerode(I, SE);

%% Fast Labeling Algorithm 
[L, num] = bwlabel(I, 8);

%% regionprop 
L = double(L);
blobs = regionprops(L, "area");
coins = struct2cell(blobs);

%% calculating amount of $$ based on surface area of blbos
money = 0; 
for i=1:13

    if coins{i} <= 2354 & coins{i} >= 2340
        money = money + 0.25;
    end

    if coins{i} == 11088
        money = money + 1;
    end

    if coins{i} == 47248
        money = money + 2;
    end


end

fprintf("There is $%.1f money in this image\n", money);






