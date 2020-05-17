function [Dictinary]=Shifted_Huffman_code(p)

    block_size = 2;
    length_p = length(p);
    
    % calculating the block size that creates even height blocks
    while (block_size < length_p)
        if (mod(length_p,block_size)==0)
            break;
        else
             block_size = block_size+1;
        end
    end
    display(block_size)
    
    
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
    

    % preforming the shifted hufman    
    for i=block_size:length_p:block_size
        num_of_block = length_p/i;
        added_ones = num2str(ones(num_of_block,1));
        for j=1:block_size
            cell_num = i+j;
            Dictinary{cell_num} = strcat(added_ones,Block_dictionary{j});
        end
        
    end
    
        celldisp(Dictinary)
    
end

