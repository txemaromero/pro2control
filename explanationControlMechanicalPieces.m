%Quality control of mechanical pieces by artificial vision
%---------------------------------------------------------
%
%This system simulates an industrial chain using a process of stamping starting from
%metal sheetings. There are three types of pieces to analyze by using this vision system,
%IA04, 0863-012, and 5828-001 (see figures). The part reference IA04 is a snap ring more
%commonly called "circlips" in the industrial world. These rings are components of mechanical
%assembly generally used on the axes in order to carry out axial stops. The part which
%interests us can be placed in a gutter inside a tube or outside an axis. The part reference
%0863-012 is "circlips" outside. The part has a circular external form. The interior aspect
%is more complex with four salient parts in the inner contour. Furthermore, it contains two
%holes making it possible to handle it with a grip envisaged for this purpose. Finally, the
%part reference 5828-001 is similar to 0863-012. The principal difference is that instead of
%having four salient parts, it has three salient parts in the inner contour. At the exit of
%the chain, the parts must satisfy dimensional tolerances (e.g., B) and qualities criteria
%and be not distorted. In the other hand, this system is inspired in the objectives of Pro2-
%Control project: On-line control of Drawing and Blanking Processes and of Quality of the
%Product by Fusion of Sensors and Artificial Vision Techniques.
%
%NOTE: Copy all files in Matlab current directory and type "controlMechanicalPieces" on
%Matlab command window.
% 
%The piece images included are taken from University of Mondragon. See the cited reference
%for more information.
% 
%MENU:
%
%1. [Step 1] Reference image pieces (0 defaults) ...
%1.1. IA04
%1.2. 0863-012
%1.3. 5828-001
%1.3. Delete database
%1.4. Return to Main menu
%
%2. [Step 2] Capture tolerances ...
%2.1. From webcam
%2.2. From video ...
%2.2.1. IA04
%2.2.2. 0863-012
%2.2.3. 5828-001
%2.2.3. Return to Capture source menu
%2.3. From image ...
%2.3.1. IA04
%2.3.2. 0863-012
%2.3.2. 5828-001
%2.3.3. Return to Capture source menu
%2.4. Return to Main menu
%
%3. Learn about application ...
%
%4. About Pro2Control ...
%
%5. Exit
%
%*****************************************************************
%University of Mondragon
%Faculty of Engineering - Department of Electronics
%Loramendi, 4. Apartado 23
%20500 Mondragon
%Basque Country
%*****************************************************************
%