
function coded_seq=source_coding(src,symbols,codewords)
    
    no_of_symbols=length(symbols); 
    coded_seq=[];
    
    % checking that the length of the dictionary is equal to the the number
    % of symbols
    if length(codewords)<no_of_symbols
        error('The number of codewords must equal that of symbols');
    end
    
    % loop on every pixel in the image    
    for n=1:length(src)

        % loops on every symbol      
        for i=1:no_of_symbols
            if src(n)==symbols(i)
                tmp = codewords{i};

                break; 
            end     
        end
        
        coded_seq=[coded_seq tmp];
    
     end
end

        