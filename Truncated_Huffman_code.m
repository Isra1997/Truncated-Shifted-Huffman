function [Dictinary]=Truncated_Huffman_code(p,k)

    % creating an array to place the referance block in     
    Referance_block = zeros(k+1,1);
    
    % sorting the probabilities   
    p=sort(p,1,'descend');
    
    % placing the refrance block
    Referance_block(1:k,1) = p(1:k,1);
    
    % Summing the rest of the probabilities and placing the in the last row
    Referance_block(k+1,1) = sum(p(k+1:length(p),1));
    
    % calculating the huffman codes of the referance block and the last row   
    Block_dictionary = Huffman_code(Referance_block);
    
    % placing the codes of the referance block in the begining of the dictionary 
    Dictinary = {Block_dictionary{1:length(Block_dictionary)-1}};
    
    % counter to access the the probability arry startfing from k to
    % length(p)
    c=k+1;
   
    for i=1:length(p)-k
        % creating a binary string of the number we stoped at       
        added_binay_code = num2str(de2bi(i-1,'left-msb'));
        % removing spaces and storing creating a string out of the binary code 
        added_binay_code = added_binay_code(find(~isspace(added_binay_code)));
        % concatenating the calculate huffman code for Ax and the binary string      
        Dictinary{c} = strcat(Block_dictionary{k+1},added_binay_code);
        % incrementing the counter used to access the probability array        
        c = c+1;
    end
end