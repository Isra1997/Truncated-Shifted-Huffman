function [encoded_image,code_dict]= HuffamnCodes(image)
    img = imread(image);
    
    frequency= imhist(img);
    % % % % % testing with a smaller datset % % % % %
    % frequency = [0.4,0.3,0.1,0.1,0.06,0.04];
    % letters = ['a2','a6','a1','a4','a3','a5'];
    % % % % % testing with a smaller datset % % % % %
    
    nodes = {};
    
    % creating an array to store pixel intensties and their frequencies
    for i=1:length(frequency)
        if (frequency(i) ~= 0)   
               nodes {i,1} = {frequency(i)};
               nodes {i,2} = {num2str(i),''};
        end    
    end
    
    
    node_table = cell2table(nodes,'VariableNames',{'weight' 'children'});
    
    [m,n] = size(node_table);
    
%     while m>1
        [m,n] = size(node_table);
        node_table = sortrows(node_table, 'weight', 'descend');
        
        
        right = node_table {1,:};
        left = node_table {2,:};
        
        new_node_weight = right{1}+left{1};
        
        node_table(1:2,:)=[];
        
        for i=2:length(right)
            if (mod(i,2)==1)
                right{i} = strcat('1',right{i});
            end
        end
        
        for i=2:length(left)
            if (mod(i,2)==1)
                left{i} = strcat('0',left{i});
            end
        end
       
       new_node_child = [right{:,2:end} left{:,2:end}];
       
%        cell_newnode = {new_node_weight,new_node_child(:,2:3)};
%        
%        node_table = [node_table;cell_newnode];
        
        display(right)
        display(left)
        display(new_node_weight)
        display(new_node_child(:,2:3))
%     end
    display(size(node_table))
    
   



    
    

    
    
    
    
