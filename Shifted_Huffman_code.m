function [Dictinary]=Shifted_Huffman_code(p,k)

    block_size = k;
    length_p = length(p);
    
    % creating an array to place the referance block in     
    Referance_block = zeros(block_size+1,1);
    
    % sorting the probabilities   
    p=sort(p,1,'descend');
    
    % placing the refrance block
    Referance_block(1:block_size,1) = p(1:block_size,1);
    
    % Summing the rest of the probabilities and placing the in the last row
    Referance_block(block_size+1,1) = sum(p(block_size+1:length(p),1));
    
    % calculating the huffman codes of the referance block and the last row   
    Block_dictionary = Huffman_code(Referance_block);
    
    % placing the codes of the referance block in the begining of the dictionary 
    Dictinary = {Block_dictionary{1:length(Block_dictionary)-1}};

    c=0;
    num_of_block=1;
    
    % preforming the shifted hufman    
    for i=block_size+1:length_p
        if(c>=block_size)
            c = 1;
            num_of_block = floor(i/block_size);
        else
            c = c+1;
        end
        added_ones = num2str(ones(1,num_of_block));
        added_ones= added_ones(find(~isspace(added_ones)));
        Dictinary{i} = strcat(added_ones,Block_dictionary{c});
    end
    
    
end

