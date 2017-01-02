function [number]=num_finger_30_12(image,rmean,bmean,rbcov)
 [a2,width]= FINGERS_30_12(image,rmean,bmean,rbcov);
 [number_of_fingers1] = erode_filter(a2,width,4);
 [number_of_fingers2] = erode_filter(a2,width,3);
%%jk
number=0;
if number_of_fingers1==number_of_fingers2;
    number=number_of_fingers1;
elseif number_of_fingers1>number_of_fingers2 && number_of_fingers1<6;
    number=number_of_fingers1;
elseif number_of_fingers2>number_of_fingers1 && number_of_fingers2<6
    number=number_of_fingers2;
elseif number ==10;
end