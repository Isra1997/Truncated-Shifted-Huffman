function [h,L,H]=Huffman_code(p)

    % array containing a zero and one
    zero_one=['0'; '1'];

    % making sure that calculated probabilities add's to one
    if abs(sum(p)-1)>1e-6
        fprintf('\n The probabilities in p does not add up to 1!');
    end

    M=length(p);

    N=M-1; 

    % creating a coloum vector of the probability
    p=p(:);
    
    
    h={zero_one(1),zero_one(2)};
    
    
    if M>2
        % setting a coloum to the calculated probabilities     
        pp(:,1)=p;
        
        % looping on all the probabilities
        for n=1:N
            
            % sorting the coloum n of probabilities          
            [pp(1:M-n+1,n) ,o(1:M-n+1,n)] = sort(pp(1:M-n+1,n),1,'descend');
            
            if n==1
              ord0=o; 
            end 
            
            % checking that we are not in the last iteration     
            if M-n>1
              % keep the coloum of the probabilities minus two as is and 
              % adding the least two probabilities and assigning the sum 
              % to the last row
              pp(1:M-n,n+1) = [pp(1:M-1-n,n);sum(pp(M-n:M-n+1,n))];
            end
            
        end
        
        for n=N:-1:2
            tmp=N-n+2;
            oi=o(1:tmp,n);
            
            for i=1:tmp
                h1{oi(i)}= h{i}; 
            end
            
            h=h1; 
            h{tmp+1}=h{tmp};
            h{tmp}=[h{tmp} zero_one(1)];
            h{tmp+1}=[h{tmp+1} zero_one(2)];
        end
        
        for i=1:length(ord0)
            h1{ord0(i)}=h{i}; 
        end
        
        h=h1;
    end
    
    L=0;
    
    for n=1:M
        L=L+p(n)*length(h{n}); 
    end 
    
    H=-sum(p.*log2(p)); 
    
    end