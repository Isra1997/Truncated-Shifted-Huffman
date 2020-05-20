function [encoded_image,dictionary]=Main_huffman(img_path,Huffman_Type,k)
    % reading the image    
    img = imread(img_path);
    
    % creating array of all the unique color intesities in an image to be used as symbols    
    symbols=unique(img);

    % empty array to store the probabilities of the uniquie symbols 
    p = zeros(length(symbols),1);
    
    [x,y,b]=size(img);
    % calculating the frequency of each symbols
    for i = 1:length(symbols)
       for j=1:b
            for m = 1:x
                for n = 1:y
                    if symbols(i) == img(m,n,j)
                            p(i) = p(i) + 1;
                    end
                end
            end
       end
    end
    
    % calculating the total number of pixels in the array     
    count = numel(img);
    
    % divide the frequency array with the total number of pixels in the
    % array to calculate the probablitiy of each symbol
    p = p ./ count;
   
    test = [0.3;0.2;0.15;0.1;0.08;0.06;0.05;0.04;0.02];
    % Calling the huffman function 
    if Huffman_Type == 'H'
        % calculating the huffman dictionary        
        dictionary = Huffman_code(p);

        [rows, columns, numberOfColorChannels] = size(img);
        
        oi = reshape(img,[rows, columns, numberOfColorChannels]) ;

        % encoding the image
        encoded_image = source_coding(oi,symbols,dictionary);
        
        % joining the symbols and dictionary in one dictionary
        Dict = {};
        for i=1:length(symbols)
            Dict{i} = strcat(num2str(symbols(i)),':',dictionary{i});
        end
        
        img_p = strcat('Result_',img_path(1),'_Huffman.txt');
        fileID = fopen(img_p,'w');
        fprintf(fileID,'\n Dictionary \n');
        fprintf(fileID,'\n %s \n', Dict{:});
        fprintf(fileID,'\n encoded_image :%s\n',encoded_image);
        fprintf(fileID,'\nFile size was reduced by %f KiB\n', (rows*columns*numberOfColorChannels*8-length(encoded_image))/(1024*8));
        fclose(fileID);
    end
    % Calling the truncated huffman function 
    if Huffman_Type == 'T'
        dictionary = Truncated_Huffman_code(p,k);
        
        [rows, columns, numberOfColorChannels] = size(img);
        
        oi = reshape(img,[rows, columns, numberOfColorChannels]) ;

        % encoding the image 
        encoded_image = source_coding(oi,symbols,dictionary);
        
        % joining the symbols and dictionary in one dictionary
        Dict = {};
        for i=1:length(symbols)
            Dict{i} = strcat(num2str(symbols(i)),':',dictionary{i});
        end
        img_p = strcat('Result_',img_path(1),'_Truncated.txt');
        fileID = fopen(img_p,'w');
        fprintf(fileID,'\n Dictionary \n');
        fprintf(fileID,'\n %s \n', Dict{:});
        fprintf(fileID,'\n encoded_image :%s\n',encoded_image);
        fprintf(fileID,'\nFile size was reduced by %f KiB\n', (rows*columns*numberOfColorChannels*8-length(encoded_image))/(1024*8));
        fclose(fileID);
    end
    
    % Calling the shifted huffman function 
    if Huffman_Type == 'S'
        dictionary = Shifted_Huffman_code(p,k);
        
        [rows, columns, numberOfColorChannels] = size(img);
        
        oi = reshape(img,[rows, columns, numberOfColorChannels]) ;

        % encoding the image 
        encoded_image = source_coding(oi,symbols,dictionary);

        fprintf('\nFile size was reduced by %f KiB\n', (rows*columns*numberOfColorChannels*8-length(encoded_image))/(1024*8));
        
        % joining the symbols and dictionary in one dictionary
        Dict = {};
        for i=1:length(symbols)
            Dict{i} = strcat(num2str(symbols(i)),':',dictionary{i});
        end
        
        img_p = strcat('Result_',img_path(1),'_Shifted.txt');
        fileID = fopen(img_p,'w');
        fprintf(fileID,'\n Dictionary \n');
        fprintf(fileID,'\n %s \n', Dict{:});
        fprintf(fileID,'\n encoded_image :%s\n',encoded_image);
        fprintf(fileID,'\nFile size was reduced by %f KiB\n', (rows*columns*numberOfColorChannels*8-length(encoded_image))/(1024*8));
        fclose(fileID);
    end
    
%     Note: to test the code with the exmples in the lecture please replace
%     the p variable in every method with the array test and comment the
%     four lines below the method call



