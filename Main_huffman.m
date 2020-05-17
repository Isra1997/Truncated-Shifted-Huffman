function [encoded_image,dictionary]=Main_huffman(img_path,Huffman_Type)
    % reading the image    
    img = imread(img_path);
    
    % creating array of all the unique color intesities in an image to be used as symbols    
    symbols=unique(img);

    % empty array to store the probabilities of the uniquie symbols 
    p = zeros(length(symbols),1);

    % calculating the frequency of each symbols
    for i = 1:length(symbols)
        for m = 1:length(img(:,1)) 
            for n = 1:length(img(1,:))
                if symbols(i) == img(m,n)
                        p(i) = p(i) + 1;
                end
            end
        end

    end
    
    % calculating the total number of pixels in the array     
    count = numel(img);
    
    % divide the frequency array with the total number of pixels in the
    % array to calculate the probablitiy of each symbol
    p = p ./ count;
    
    % Calling the huffman function 
    if Huffman_Type == 'H'
        % calculating the huffman dictionary        
        dictionary = Huffman_code(p);

        [rows, columns, numberOfColorChannels] = size(img);
        
        oi = reshape(img,[rows, columns, numberOfColorChannels]) ;

        % encoding the image 
        encoded_image = source_coding(oi,symbols,dictionary);

        fprintf('\nFile size was reduced by %f KiB\n', (512*512*8-length(encoded_image))/(1024*8));
    end
    
    if Huffman_Type == 'S'
        dictionary = Shifted_Huffman_code(p)
    end




