% Employs the best solution and displays segments of examined image.

function accept_solution(image, population, n_thresholds)

    segmentation = zeros(size(image));
    segmentation_value = 1/n_thresholds;
    genome_size = size(population, 2)/n_thresholds;

    % Retrieve the best solution
    [~, b_i] = sort(fitness(image, population, n_thresholds));
    best_genome = population(b_i(1),:);

    threshold = sort(threshold_bin2dec(best_genome, n_thresholds));

    value = 0;
    end_i = size(threshold, 2) + 1;
    for i = 1:end_i
        if (i == 1)
        % The first threshold
            left = 0;
            right = threshold(i);
        elseif (i == end_i)
        % The last threshold
            left = threshold(i-1);
            right = max(image(:));
        else
        % Regular threshold
            left = threshold(i-1);
            right = threshold(i);
        end 

        % <0; x) <x; y) <y; max(image))
        left_mask = image >= left;
        right_mask = image < right;
        mask = left_mask .* right_mask;

        segmentation=segmentation+(value*mask);

        % Display segments
        %if (i >= 2)
        %    figure
        %    mask_value = value*mask;
        %    imshow(mask_value);
        %    imwrite(mask_value, strcat(num2str(i), ".png"));
        %endif

        value=value+segmentation_value;
    end
    %s=roicolor(segmentation,180,230);
    imshow(segmentation);
    imshow(segmentation,'Colormap',jet(255));
    

end
