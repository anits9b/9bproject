
% Default variables
n_population =  30;
n_iterations =  70;
n_bins       = 256;
n_thresholds =   5;

% Ratios of all GA operations
p_selection = 0.1;
p_crossover = 0.8;
p_mutation  = 0.1;
assert(sum([p_selection, p_crossover, p_mutation]) == 1, 'Total sum of proportions have to be 1!');

% Read image
image = imread('brainimg2.jpg');

% Convert image to gray levels
if (size(image, 3) == 3)
    image_gray = rgb2gray(image);
else
    image_gray = image;
end

% Resize image
image_gray = imresize(image_gray, [512 512]);

%removing noise
image_gray=medfilt2(image_gray);

% Initialization
population = initialization(n_population, n_bins, n_thresholds);

for i = 1:n_iterations
    new_population = [];

    % Evaluation of fitness
    ranking = fitness(image, population, n_thresholds);

    %% Reproduction
    % Selection
    % TODO create more strategies (like roulette wheel)
    new_population = first_best(ranking, population, p_selection, new_population);

    % Crossover
    new_population = crossover(population, p_crossover, new_population);

    % Mutation
    new_population = mutation(population, p_mutation, new_population);

    population = new_population;
end

%skull stripping
image_gray = skullstrip(image_gray);

% Accepting the solution
accept_solution(image_gray, population, n_thresholds);
