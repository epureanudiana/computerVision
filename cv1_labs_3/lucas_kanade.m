function[] = lucas_kanade(im1, im2)


[im_rows, im_cols, channels] = size(im1);
size_row = 0;
size_col = 0;
nr_rows_block = 0;
nr_cols_block = 0;

%if the image sizes are not divisible by 15, crop to proper size
while (size_row <= im_rows - 15)
    size_row = size_row + 15;
    nr_rows_block = nr_rows_block + 1;
end
while (size_col <= im_cols - 15)
    size_col = size_col + 15;
    nr_cols_block = nr_cols_block + 1;
end

newim1 = im1(1:nr_rows_block*15, 1:nr_cols_block*15, :);
newim2 = im2(1:nr_rows_block*15, 1:nr_cols_block*15, :);


im1 = newim1;
im2 = newim2;
vector_row = 15*ones(1,nr_rows_block);
vector_col = 15*ones(1,nr_cols_block);

if(channels > 1)
    division1 = mat2cell(im1, vector_row, vector_col, channels);
    division2 = mat2cell(im2, vector_row, vector_col, channels);
else
    division1 = mat2cell(im1, vector_row, vector_col);
    division2 = mat2cell(im2, vector_row, vector_col);
end

% Now display all the blocks.
plotIndex = 1;
numPlotsR = size(division1, 1);
numPlotsC = size(division1, 2);
for i = 1 : numPlotsR
    for j = 1 : numPlotsC
        % Specify the location for display of the image.
        subplot(numPlotsR, numPlotsC, plotIndex);
        block1 = division1{i,j};
        block2 = division2{i,j};
        imshow(block2); % Could call imshow(ca{r,c}) if you wanted to.
        [rowsB columnsB channelsB] = size(block2);
        drawnow;
        % Increment the subplot to the next location.
        plotIndex = plotIndex + 1;
    end
end
end