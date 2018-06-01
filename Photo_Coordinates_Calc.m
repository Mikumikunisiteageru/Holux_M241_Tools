
% 20180601

GPS_Data = 'D:\GPSLogger\M241\Decoder\GPS.tsv';
Photo_ID = 'D:\GPSLogger\M241\Decoder\Photo_ID.tsv';
Photo_Folder_Name = '20180529';
Photo_Folder = strcat('D:\Photo\', Photo_Folder_Name(1:4), '\', Photo_Folder_Name(1:6), '\', Photo_Folder_Name);
% Photo_Folder = 'D:\Photo\2018\201805\20180529';
Output = 'D:\GPSLogger\M241\Decoder\Photo_Coordinates.tsv';
Time_Zone = +8; % China

Photo_Path = @ (Photo_Name) strcat (Photo_Folder, '\IMG_', Photo_Name, '.JPG');

f_GPS_Data = fopen (GPS_Data);
d_GPS_Data = textscan (f_GPS_Data, '%d%f%s%f%f%f%f%d', 'delimiter', '\t');
fclose (f_GPS_Data);

Local_Time = d_GPS_Data{2} / 86400 + 719529 + Time_Zone / 24;
Local_Time = Local_Time + rand(size(Local_Time)) * 1e-7;
Latitude = d_GPS_Data{4};
Longitude = d_GPS_Data{5};
Altitude = d_GPS_Data{6};
Velocity = d_GPS_Data{7};

clear d_Photo_ID

f_Photo_ID = fopen (Photo_ID);
d_Photo_ID = textscan (f_Photo_ID, '%s');
fclose(f_Photo_ID);

Local_Time_Photo = datenum (arrayfun (@ (i) getfield (imfinfo (Photo_Path (d_Photo_ID{1}{i})), 'FileModDate'), (1:length(d_Photo_ID{1}))', 'UniformOutput', false));

Latitude_Photo = interp1 (Local_Time, Latitude, Local_Time_Photo);
Longitude_Photo = interp1 (Local_Time, Longitude, Local_Time_Photo);
Altitude_Photo = interp1 (Local_Time, Altitude, Local_Time_Photo);
Velocity_Photo = interp1 (Local_Time, Velocity, Local_Time_Photo);

f_Output = fopen (Output, 'w');
fprintf (f_Output, '%.3f\t%.6f\t%.6f\t%0.1f\r\n', [Velocity_Photo'; Longitude_Photo'; Latitude_Photo'; Altitude_Photo']);
fclose (f_Output);

subplot (4, 1, 1);
plot (Local_Time, Latitude, '.', Local_Time_Photo, Latitude_Photo, '+');
set (gca, 'Position', [0.05, 0.76, 0.94, 0.23]); 
ylim ([min(Latitude), max(Latitude)]);
subplot (4, 1, 2);
plot (Local_Time, Longitude, '.', Local_Time_Photo, Longitude_Photo, '+');
set (gca, 'Position', [0.05, 0.51, 0.94, 0.23]); 
ylim ([min(Longitude), max(Longitude)]);
subplot (4, 1, 3);
plot (Local_Time, Altitude, '.', Local_Time_Photo, Altitude_Photo, '+');
set (gca, 'Position', [0.05, 0.26, 0.94, 0.23]); 
ylim ([min(Altitude), max(Altitude)]);
subplot (4, 1, 4);
plot (Local_Time, Velocity, '.', Local_Time_Photo, Velocity_Photo, '+');
set (gca, 'Position', [0.05, 0.01, 0.94, 0.23]); 
ylim ([0, 6]);

















