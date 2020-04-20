% test draw cylinder 
function [X,Y,Z] = capsule_generate(R, cap1, cap2)
    %% compute the how many axis are different 
    diff1 = cap1 - cap2;
    cnt = 0;
    for i = 1:3
        if abs(diff1(i)) > 0.0001
            cnt = cnt + 1;
        end
    end
    
%     %% along x, y or z axis capsule (simple)
%     if cnt == 1
%         points = 20;
%         for i = 1:3
%             if cap1(i) ~= cap2(2)
%                 break;
%             end
%         end
%         switch i
%             case 1
%                 direction = 'x';
%             case 2
%                 direction = 'y';
%             case 3 
%                 direction = 'z';
%         end
% 
% 
% 
% 
%         [X,Y,Z] = sphere(points);
%         X = R*X;
%         Y = R*Y;
%         Z = R*Z;
%         xm = X(11,:);
%         ym = Y(11,:);
%         zm = Z(11,:);
% 
% 
%         % lower 
%         X1 = X(1:11,:);
%         Y1 = Y(1:11,:);
%         Z1 = Z(1:11,:);
% 
%         % higher
%         X2 = X(11:21,:);
%         Y2 = Y(11:21,:);
%         Z2 = Z(11:21,:);
% 
%         switch direction
%             case 'x'
%                 disp('capsule along x axis');
%                 CHG = X1;
%                 X1 = Z1;
%                 Z1 = CHG; 
% 
%                 CHG = X2;
%                 X2 = Z2;
%                 Z2 = CHG; 
% 
%                 CHG = xm;
%                 xm = zm;
%                 zm = CHG; 
%             case 'y'
%                 disp('capsule along y axis');
%                 CHG = Y1;
%                 Y1 = Z1;
%                 Z1 = CHG; 
% 
%                 CHG = Y2;
%                 Y2 = Z2;
%                 Z2 = CHG; 
% 
%                 CHG = ym;
%                 ym = zm;
%                 zm = CHG; 
%             case 'z'
%                 disp('capsule along z axis');
%         end
%         X1 = X1 + cap1(1);
%         xm = xm + cap1(1);
%         Y1 = Y1 + cap1(2);
%         ym = ym + cap1(2);
%         Z1 = Z1 + cap1(3);
%         zm = zm + cap1(3);
% 
%         X2 = X2 + cap2(1);
%         Y2 = Y2 + cap2(2);
%         Z2 = Z2 + cap2(3);
% 
% 
% 
%         % media
%         XM = [];
%         YM = [];
%         ZM = [];
%         diff = cap2 - cap1;
%         for ratio = 0:0.1:1
%             incre = ratio*diff;
%             XM = [XM; xm+incre(1)];
%             YM = [YM; ym+incre(2)];
%             ZM = [ZM; zm+incre(3)];
%         end
% 
%         % concatenate capsule 
%         X = [X1;XM;X2];
%         Y = [Y1;YM;Y2];
%         Z = [Z1;ZM;Z2];
%     end
%     
%     %% there is two axises are different (hard), need rotate solution 
%     if cnt == 2
%         diff1 = cap1 - cap2;
%         record = [0,0,0];
%         for i = 1:3
%             if abs(diff1(i)) > 0.0001
%                 record(i) = 1;
%             end
%         end
%         len = norm(diff1);
%         points = 20;
%         [X,Y,Z] = sphere(points);
%         X = R*X;
%         Y = R*Y;
%         Z = R*Z;
%         xm = X(11,:);
%         ym = Y(11,:);
%         zm = Z(11,:);
% 
% 
%         % lower 
%         X1 = X(1:11,:);
%         Y1 = Y(1:11,:);
%         Z1 = Z(1:11,:);
% 
%         % higher
%         X2 = X(11:21,:);
%         Y2 = Y(11:21,:);
%         Z2 = Z(11:21,:);
%         
%         % y,z are different, record = [0,1,1]
%         yz = [0,1,1];
%         if record == yz
%             % construct along capsule along z axis first (do nothing)
%             cap1new = [0,0,-len/2];
%             cap2new = [0,0,len/2];
%             X1 = X1 + cap1new(1);
%             xm = xm + cap1new(1);
%             Y1 = Y1 + cap1new(2);
%             ym = ym + cap1new(2);
%             Z1 = Z1 + cap1new(3);
%             zm = zm + cap1new(3);
% 
%             X2 = X2 + cap2new(1);
%             Y2 = Y2 + cap2new(2);
%             Z2 = Z2 + cap2new(3);
% 
%             % media
%             diffnew = cap2new - cap1new;
%             XM = [];
%             YM = [];
%             ZM = [];
%             for ratio = 0:0.1:1
%                 incre = ratio*diffnew;
%                 XM = [XM; xm+incre(1)];
%                 YM = [YM; ym+incre(2)];
%                 ZM = [ZM; zm+incre(3)];
%             end
% 
%             % concatenate capsule 
%             X = [X1;XM;X2];
%             Y = [Y1;YM;Y2];
%             Z = [Z1;ZM;Z2];
%             
%             
%             % rotate about x axis
%             midpoint = (cap1 + cap2) / 2;
%             assert(cap2(3) > cap1(3)); % make sure the second is in the upper position 
%             vec = cap2 - cap1;
%             t = atan(abs(vec(3))/abs(vec(2)));
%             theta = pi/2 - t;
%             if cap2(2) < cap1(2)
%                 % counter clockwise rotate 
%                 R = [1, 0, 0;
%                      0, cos(theta), -sin(theta);
%                      0, sin(theta), cos(theta)];
%             else
%                 R = [1, 0, 0;
%                      0, cos(-theta), -sin(-theta);
%                      0, sin(-theta), cos(-theta)];
%             end
%             % construct twist matrix in SE(3)
%             M = [R, midpoint;
%                 zeros(1,3), 1];
%             % transform the point 
%             for n1 = 1:size(X,1)
%                 for n2 = 1:size(X,2)
%                     newvec=[X(n1,n2),Y(n1,n2),Z(n1,n2)]*M(1:3,1:3)'+M(1:3,4)';
%                     X(n1,n2)=newvec(1);
%                     Y(n1,n2)=newvec(2);
%                     Z(n1,n2)=newvec(3);
%                 end
%             end
%         end
%     end
    
    
    %% there is three axises are different (very hard), need rotate solution 
%     if cnt == 3
        diff1 = cap1 - cap2;
        len = norm(diff1);
        points = 20;
        [X,Y,Z] = sphere(points);
        X = R*X;
        Y = R*Y;
        Z = R*Z;
        xm = X(11,:);
        ym = Y(11,:);
        zm = Z(11,:);


        % lower 
        X1 = X(1:11,:);
        Y1 = Y(1:11,:);
        Z1 = Z(1:11,:);

        % higher
        X2 = X(11:21,:);
        Y2 = Y(11:21,:);
        Z2 = Z(11:21,:);
        
        % y,z are different, record = [0,1,1]
        yz = [0,1,1];

        % construct along capsule along z axis first (do nothing)
        cap1new = [0,0,-len/2];
        cap2new = [0,0,len/2];
        X1 = X1 + cap1new(1);
        xm = xm + cap1new(1);
        Y1 = Y1 + cap1new(2);
        ym = ym + cap1new(2);
        Z1 = Z1 + cap1new(3);
        zm = zm + cap1new(3);

        X2 = X2 + cap2new(1);
        Y2 = Y2 + cap2new(2);
        Z2 = Z2 + cap2new(3);

        % media
        diffnew = cap2new - cap1new;
        XM = [];
        YM = [];
        ZM = [];
        for ratio = 0:0.1:1
            incre = ratio*diffnew;
            XM = [XM; xm+incre(1)];
            YM = [YM; ym+incre(2)];
            ZM = [ZM; zm+incre(3)];
        end

        % concatenate capsule 
        X = [X1;XM;X2];
        Y = [Y1;YM;Y2];
        Z = [Z1;ZM;Z2];

        
        % compute the transformation matrix 
        % we only care about the z axis is correct 
        % find the higher point 
        if cap1(3) >= cap2(3)
            high = cap1;
        else
            high = cap2;
        end
        % capsule center 
        cap1 = cap1;
        cap2 = cap2;
        centre = (cap1 + cap2)/2;
        % z vec 
        zvec = high - centre;
        zvec = zvec/norm(zvec);
        % randomly select a xvec, since it's not important 
        % find the axes that is not zero 
        for k = 1:3
            if zvec(k) < -0.0001 || zvec(k) > 0.0001
                break
            end
        end
        switch k
            case 1
                xvec = [(-zvec(2)-zvec(3))/zvec(1);1;1];
            case 2
                xvec = [1;(-zvec(1)-zvec(3))/zvec(2);1];
            case 3
                xvec = [1;1;(-zvec(1)-zvec(2))/zvec(3)];
        end
        xvec = xvec / norm(xvec);
        yvec = hatw(zvec)*xvec;
        yvec = yvec / norm(yvec);
        % now get the transformation matrix
        R = [xvec, yvec, zvec];
        T = centre;
        M = [R, T;
             zeros(1,3) 1];

        % transform the point 
        for n1 = 1:size(X,1)
            for n2 = 1:size(X,2)
                newvec=[X(n1,n2),Y(n1,n2),Z(n1,n2)]*M(1:3,1:3)'+M(1:3,4)';
                X(n1,n2)=newvec(1);
                Y(n1,n2)=newvec(2);
                Z(n1,n2)=newvec(3);
            end
        end

%     end

end