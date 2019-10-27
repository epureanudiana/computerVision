function [f, d] = extract_features(image, descriptor_type, SIFT_type)

    image = reshape(image, [96, 96, 3]);
    
    if strcmp(descriptor_type, 'keypoints')
        if strcmp(SIFT_type, 'grayscale')
%             if you wanna visualize images + keypoints + descriptors            

              image = single(rgb2gray(image));
              [f, d] = vl_sift(image);
%             figure()
%             imshow(image)
%             perm = randperm(size(f,2)) ;
%             sel = perm(1:10) ;
%             h1 = vl_plotframe(f(:,sel)) ;
%             h2 = vl_plotframe(f(:,sel)) ;
%             set(h1,'color','k','linewidth',3) ;
%             set(h2,'color','y','linewidth',2) ;
%             h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%             set(h3,'color','g') ;
            
            
        elseif strcmp(SIFT_type, 'rgb')
            %TODO
        elseif strcmp(SIFT_type, 'opponent')
            %TODO
        else
            error("Not supported SIFT_type.");
        end        
    end 
    
     if strcmp(descriptor_type, 'dense')
        if strcmp(SIFT_type, 'grayscale')
            %TODO
        elseif strcmp(SIFT_type, 'rgb')
            %TODO
        elseif strcmp(SIFT_type, 'opponent')
            %TODO
        else
            error("Not supported SIFT_type.");
        end        
    end 
end