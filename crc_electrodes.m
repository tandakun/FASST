function crc_electrodes
% Function to create and save the file CRC_electrodes.mat used by FASST. 
% This should allow an easier reviewing editing of the channel 
% characteristics for other users.
%
% The CRC_electrodes.mat file containes 6 variables, summarizing any
% channel configurations for a BrainProducts MR compatible EEG recording
% system. (This could certainly be extended to other systems)
%
% If you want to add more channels, the easiest is to simply add their
% specific information at the end of the arrays.
%
% After adjusting the electrode informations to your specific setup, you
% should execute this function in order to generate a new
% CRC_electrodes.mat file !!!
%
% Variables:
% - Rxy         scaling factor for flat map display
% - names       cell array of channel names
% - pos         array with 2D coordinates for each channel listed
% - Cpos        same as pos
% - crc_types   channel types, specific to FASST !
%   They are particularly useful for the display functions:             
%       -1  ->  usual MEEG channel, i.e. use standard EEG scaling.
%       -2  ->  different scaling, e.g. for physiological signal like ECG.
%        n  ->  this channel should be referenced with channel 'n', and 
%               channel 'n' crc_types should be pointing towards this one.
%               i.e. this is a "bipolar channel" but each channel was 
%               acquired individually with the system's reference.
%               Example: channel #31 and #32 should be used as one bipolar
%                   channel. Then crc_types(31) = 32 and crc_types(32) = 31
% - Nchannels   number of channels listed
%__________________________________________________________________________
% Copyright (C) 2009 Cyclotron Research Centre

% Written by Y. Leclercq & C. Phillips, 2009.
% Cyclotron Research Centre, University of Liege, Belgium
% $Id$


%% Scaling on screen
Rxy = 1.5;

%% channel names, 10 per line for ease editing
names = {...
  'FP1', 'FP2', 'F3',  'F4',  'C3',  'C4',  'P3',  'P4',  'O1',  'O2',  ...
  'F7',  'F8',  'T7',  'T8',  'P7',  'P8',  'FZ',  'CZ',  'PZ',  'OZ',  ...
  'FC1', 'FC2', 'CP1', 'CP2', 'FC5', 'FC6', 'CP5', 'CP6', 'M1',  'M2',  ...
  'N_A', 'NOSE','F1',  'F2',  'C1',  'C2',  'P1',  'P2',  'AF3', 'AF4', ...
  'FC3', 'FC4', 'CP3', 'CP4', 'PO3', 'PO4', 'F5',  'F6',  'C5',  'C6',  ...
  'P5',  'P6',  'AF7', 'AF8', 'FT7', 'FT8', 'TP7', 'TP8', 'PO7', 'PO8', ...
  'FPZ', 'AFZ', 'CPZ', 'POZ', 'VEOG','HEOG','EMG', 'ECG1','ECG2','ECG3',...
  'LEGLEFT','LEGRIGHT','EOG','ECG','TP9','TP10','NOSE2','EOGG','EOGD','EOGH',...
  'EOGB','EMG1','EMG2','REF2','EOGHG','EOGBD','1FZ','1CZ','1PZ', '1OZ', ...
  '1EOGG','1EOGD','1EOGH','1EOGB','1EMG1','1EMG2','1ECG1','1ECG2','2FZ','2CZ',...
  '2PZ','2OZ','2EOGG','2EOGD','2EOGH','2EOGB','LEG1','LEG2','FR','ECG12',...
  'EOGDH','EOGGB', 'FT9', 'FT10', 'FCz', 'A1', 'A2', ...
  ... % adding the EGI 256 channel names
  'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'e9', 'e10', ...
  'e11', 'e12', 'e13', 'e14', 'e15', 'e16', 'e17', 'e18', 'e19', 'e20', ...
  'e21', 'e22', 'e23', 'e24', 'e25', 'e26', 'e27', 'e28', 'e29', 'e30', ...
  'e31', 'e32', 'e33', 'e34', 'e35', 'e36', 'e37', 'e38', 'e39', 'e40', ...
  'e41', 'e42', 'e43', 'e44', 'e45', 'e46', 'e47', 'e48', 'e49', 'e50', ...
  'e51', 'e52', 'e53', 'e54', 'e55', 'e56', 'e57', 'e58', 'e59', 'e60', ...
  'e61', 'e62', 'e63', 'e64', 'e65', 'e66', 'e67', 'e68', 'e69', 'e70', ...
  'e71', 'e72', 'e73', 'e74', 'e75', 'e76', 'e77', 'e78', 'e79', 'e80', ...
  'e81', 'e82', 'e83', 'e84', 'e85', 'e86', 'e87', 'e88', 'e89', 'e90', ...
  'e91', 'e92', 'e93', 'e94', 'e95', 'e96', 'e97', 'e98', 'e99', 'e100', ...
  'e101', 'e102', 'e103', 'e104', 'e105', 'e106', 'e107', 'e108', 'e109', 'e110', ...
  'e111', 'e112', 'e113', 'e114', 'e115', 'e116', 'e117', 'e118', 'e119', 'e120', ...
  'e121', 'e122', 'e123', 'e124', 'e125', 'e126', 'e127', 'e128', 'e129', 'e130', ...
  'e131', 'e132', 'e133', 'e134', 'e135', 'e136', 'e137', 'e138', 'e139', 'e140', ...
  'e141', 'e142', 'e143', 'e144', 'e145', 'e146', 'e147', 'e148', 'e149', 'e150', ...
  'e151', 'e152', 'e153', 'e154', 'e155', 'e156', 'e157', 'e158', 'e159', 'e160', ...
  'e161', 'e162', 'e163', 'e164', 'e165', 'e166', 'e167', 'e168', 'e169', 'e170', ...
  'e171', 'e172', 'e173', 'e174', 'e175', 'e176', 'e177', 'e178', 'e179', 'e180', ...
  'e181', 'e182', 'e183', 'e184', 'e185', 'e186', 'e187', 'e188', 'e189', 'e190', ...
  'e191', 'e192', 'e193', 'e194', 'e195', 'e196', 'e197', 'e198', 'e199', 'e200', ...
  'e201', 'e202', 'e203', 'e204', 'e205', 'e206', 'e207', 'e208', 'e209', 'e210', ...
  'e211', 'e212', 'e213', 'e214', 'e215', 'e216', 'e217', 'e218', 'e219', 'e220', ...
  'e221', 'e222', 'e223', 'e224', 'e225', 'e226', 'e227', 'e228', 'e229', 'e230', ...
  'e231', 'e232', 'e233', 'e234', 'e235', 'e236', 'e237', 'e238', 'e239', 'e240', ...
  'e241', 'e242', 'e243', 'e244', 'e245', 'e246', 'e247', 'e248', 'e249', 'e250', ...
  'e251', 'e252', 'e253', 'e254', 'e255', 'e256', 'e257',...
  };

%% channel position in 2D, 
% for an easy 2D display of the approximate location of the electrode on a
% flattened scalp surface (used in channel selection mainly).
pos = [... 
... % x coord 
0.3960, 0.6040, 0.3672, 0.6328, 0.3318, 0.6682, 0.3672, 0.6328, 0.3960, 0.6040, ...
0.2278, 0.7722, 0.1635, 0.8365, 0.2278, 0.7722, 0.5000, 0.5000, 0.5000, 0.5000, ...
0.4211, 0.5789, 0.4211, 0.5789, 0.2610, 0.7390, 0.2610, 0.7390, 0.1000, 0.9000, ...
0.0500, 0.5000, 0.4346, 0.5654, 0.4159, 0.5841, 0.4346, 0.5654, 0.4035, 0.5965, ...
0.3414, 0.6586, 0.3414, 0.6586, 0.4035, 0.5965, 0.2982, 0.7018, 0.2476, 0.7524, ...
0.2982, 0.7018, 0.3022, 0.6978, 0.1800, 0.8200, 0.1800, 0.8200, 0.3022, 0.6978, ...
0.5000, 0.5000, 0.5000, 0.5000, 0.2000, 0.8000, 0.0500, 0.9000, 0.9000, 0.9000, ...
0.0500, 0.0500, 0.2000, 0.8000, 0.1000, 0.9000, 0.0500, 0.2000, 0.2000, 0.2000, ...
0.2000, 0.0500, 0.0500, 0.0500, 0.2000, 0.2000, 0.5000, 0.5000, 0.5000, 0.5000, ...
0.2000, 0.2000, 0.2000, 0.2000, 0.0500, 0.0500, 0.9000, 0.9000, 0.5000, 0.5000, ...
0.5000, 0.5000, 0.2000, 0.2000, 0.2000, 0.2000, 0.0500, 0.0500, 0.0500, 0.0500, ...
0.0500, 0.0500, 0.1000, 0.9000, 0.5000, 0.1000, 0.9000, ... 
... % EGI-256 channels setup
0.7559, 0.7012, 0.6524, 0.6117, 0.5765, 0.5456, 0.5231, 0.5000, 0.4780, 0.6932, ...
0.6414, 0.5929, 0.5562, 0.5250, 0.5000, 0.4769, 0.4549, 0.6172, 0.5731, 0.5324, ...
0.5000, 0.4750, 0.4544, 0.4327, 0.5377, 0.5000, 0.4676, 0.4438, 0.4235, 0.4049, ...
0.5000, 0.4623, 0.4269, 0.4071, 0.3883, 0.3842, 0.3828, 0.3586, 0.3476, 0.3470, ...
0.3605, 0.3834, 0.4041, 0.4298, 0.4623, 0.3068, 0.2988, 0.2987, 0.3115, 0.3368, ...
0.3642, 0.3902, 0.4274, 0.2441, 0.2487, 0.2632, 0.2900, 0.3212, 0.3536, 0.3896, ...
0.1908, 0.2121, 0.2444, 0.2795, 0.3172, 0.3502, 0.1421, 0.1685, 0.1983, 0.2398, ...
0.2818, 0.3172, 0.1029, 0.2075, 0.2580, 0.3021, 0.3419, 0.3807, 0.4189, 0.4577, ...
0.5000, 0.0785, 0.2049, 0.2390, 0.2923, 0.3362, 0.3789, 0.4180, 0.4562, 0.5000, ...
0.0773, 0.1198, 0.1722, 0.2027, 0.2412, 0.2892, 0.3382, 0.3777, 0.4182, 0.4567, ...
0.5000, 0.1323, 0.1752, 0.2265, 0.2510, 0.2960, 0.3459, 0.3903, 0.4261, 0.4629, ...
0.2101, 0.2482, 0.2946, 0.3071, 0.3704, 0.4141, 0.4523, 0.4750, 0.5000, 0.2772, ...
0.3181, 0.3629, 0.4040, 0.4355, 0.4727, 0.5000, 0.5250, 0.5371, 0.5433, 0.5438, ...
0.5423, 0.5377, 0.3529, 0.3910, 0.4292, 0.4696, 0.5000, 0.5273, 0.5477, 0.5739, ...
0.5818, 0.5820, 0.5811, 0.5726, 0.4215, 0.4588, 0.5000, 0.5304, 0.5645, 0.5859, ...
0.6097, 0.6223, 0.6211, 0.6193, 0.6104, 0.5412, 0.5708, 0.5960, 0.6296, 0.6541, ...
0.6618, 0.6638, 0.6581, 0.6498, 0.5785, 0.6090, 0.6371, 0.6929, 0.7040, 0.7108, ...
0.7077, 0.6979, 0.6828, 0.6471, 0.6819, 0.7054, 0.7490, 0.7588, 0.7610, 0.7420, ...
0.7182, 0.6828, 0.6464, 0.6098, 0.5702, 0.5220, 0.7228, 0.7518, 0.7735, 0.7973, ...
0.7951, 0.7925, 0.7602, 0.7205, 0.6788, 0.6358, 0.5959, 0.5451, 0.7899, 0.8248, ...
0.8278, 0.8017, 0.7556, 0.7100, 0.6632, 0.6166, 0.5673, 0.8677, 0.8802, 0.8315, ...
0.7879, 0.7368, 0.6885, 0.6395, 0.5951, 0.9227, 0.9215, 0.8971, 0.8579, 0.8092, ...
0.7513, 0.7013, 0.6530, 0.6158, 0.8377, 0.8080, 0.8783, 0.9170, 0.9452, 0.7858, ...
0.8496, 0.8894, 0.9340, 0.7458, 0.8116, 0.8538, 0.9013, 0.6936, 0.7818, 0.8268, ...
0.3064, 0.2182, 0.1732, 0.2542, 0.1884, 0.1462, 0.0987, 0.2142, 0.1504, 0.1106, ...
0.0660, 0.1920, 0.1623, 0.1217, 0.0830, 0.0548, 0.5000 ...
; ... % y coord
0.8804, 0.8804, 0.7353, 0.7353, 0.5000, 0.5000, 0.2647, 0.2647, 0.1196, 0.1196, ...
0.7351, 0.7351, 0.5000, 0.5000, 0.2649, 0.2649, 0.7000, 0.5000, 0.3000, 0.1000, ...
0.6158, 0.6158, 0.3842, 0.3842, 0.6288, 0.6288, 0.3712, 0.3712, 0.3000, 0.3000, ...
0.9000, 0.9500, 0.7215, 0.7215, 0.5000, 0.5000, 0.2785, 0.2785, 0.8238, 0.8238, ...
0.6257, 0.6257, 0.3743, 0.3743, 0.1762, 0.1762, 0.7404, 0.7404, 0.5000, 0.5000, ...
0.2596, 0.2596, 0.8236, 0.8236, 0.6236, 0.6236, 0.3764, 0.3764, 0.1764, 0.1764, ...
0.9000, 0.8000, 0.4000, 0.2000, 0.9100, 0.9100, 0.2000, 0.2000, 0.1200, 0.0400, ...
0.1200, 0.0400, 0.9100, 0.9100, 0.3455, 0.3455, 0.9000, 0.9100, 0.9100, 0.9100, ...
0.9100, 0.2000, 0.2000, 0.9000, 0.9100, 0.9100, 0.7000, 0.5000, 0.3000, 0.1000, ...
0.9100, 0.9100, 0.9100, 0.9100, 0.2000, 0.2000, 0.2000, 0.1200, 0.7000, 0.5000, ...
0.3000, 0.1000, 0.9100, 0.9100, 0.9100, 0.9100, 0.1200, 0.0400, 0.0400, 0.0400, ...
0.0400, 0.0400, 0.6545, 0.6545, 0.6000, 0.5000, 0.5000, ...
... % EGI-256 channels setup
0.6979, 0.6987, 0.6927, 0.6805, 0.6581, 0.6307, 0.6011, 0.5695, 0.5289, 0.7402, ...
0.7331, 0.7163, 0.6937, 0.6647, 0.6341, 0.6011, 0.5573, 0.7712, 0.7552, 0.7290, ...
0.6980, 0.6647, 0.6307, 0.5887, 0.7877, 0.7633, 0.7290, 0.6937, 0.6581, 0.6183, ...
0.8142, 0.7877, 0.7552, 0.7163, 0.6805, 0.6455, 0.7712, 0.7331, 0.6927, 0.6516, ...
0.6146, 0.5830, 0.5532, 0.5213, 0.4885, 0.7402, 0.6987, 0.6544, 0.6124, 0.5752, ...
0.5431, 0.5124, 0.4777, 0.6979, 0.6502, 0.6019, 0.5634, 0.5326, 0.5013, 0.4670, ...
0.6252, 0.5764, 0.5388, 0.5110, 0.4864, 0.4572, 0.5810, 0.5451, 0.5027, 0.4755, ...
0.4593, 0.4441, 0.5386, 0.4306, 0.4152, 0.4073, 0.4127, 0.4189, 0.4303, 0.4440, ...
0.4640, 0.4709, 0.3601, 0.3716, 0.3632, 0.3697, 0.3804, 0.3936, 0.4068, 0.4300, ...
0.3845, 0.3393, 0.3058, 0.3118, 0.3143, 0.3189, 0.3230, 0.3384, 0.3545, 0.3732, ...
0.3575, 0.2793, 0.2595, 0.2484, 0.2629, 0.2699, 0.2771, 0.2925, 0.3141, 0.3362, ...
0.2014, 0.1984, 0.2039, 0.2269, 0.2301, 0.2494, 0.2733, 0.2998, 0.3240, 0.1582, ...
0.1620, 0.1748, 0.2002, 0.2158, 0.2388, 0.2680, 0.2998, 0.3362, 0.3732, 0.4068, ...
0.4440, 0.4885, 0.1351, 0.1406, 0.1670, 0.1814, 0.2036, 0.2388, 0.2733, 0.3141, ...
0.3545, 0.3936, 0.4303, 0.4777, 0.1164, 0.1301, 0.1514, 0.1814, 0.2158, 0.2494, ...
0.2925, 0.3384, 0.3804, 0.4189, 0.4670, 0.1301, 0.1670, 0.2002, 0.2301, 0.2771, ...
0.3230, 0.3697, 0.4127, 0.4572, 0.1164, 0.1406, 0.1748, 0.2269, 0.2699, 0.3189, ...
0.3632, 0.4073, 0.4441, 0.1351, 0.1620, 0.2039, 0.2629, 0.3143, 0.3716, 0.4152, ...
0.4593, 0.4864, 0.5013, 0.5124, 0.5213, 0.5289, 0.1582, 0.1984, 0.2484, 0.3118, ...
0.3601, 0.4306, 0.4755, 0.5110, 0.5326, 0.5431, 0.5532, 0.5573, 0.2014, 0.2595, ...
0.3058, 0.5027, 0.5388, 0.5634, 0.5752, 0.5830, 0.5887, 0.2793, 0.3393, 0.5451, ...
0.5764, 0.6019, 0.6124, 0.6146, 0.6183, 0.3845, 0.4709, 0.5386, 0.5810, 0.6252, ...
0.6502, 0.6544, 0.6516, 0.6455, 0.6438, 0.7042, 0.6265, 0.5767, 0.4908, 0.7540, ...
0.7008, 0.6702, 0.6020, 0.8017, 0.7640, 0.7423, 0.7035, 0.8395, 0.8112, 0.7904, ...
0.8395, 0.8112, 0.7904, 0.8017, 0.7640, 0.7423, 0.7035, 0.7540, 0.7008, 0.6702, ...
0.6020, 0.7042, 0.6438, 0.6265, 0.5767, 0.4908, 0.5000 ...
]' ;
Cpos = pos;

%% channel types
crc_types = [ ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -2     -2     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -2     -2     -2     -2     -2     -2 ...
     72     71     -2     -2     -1     -1     -2     79     78     81 ...
     80     83     82     -2     86     85     -1     -1     -1     -1 ...
     92     91     94     93     96     95     -2     -2     -1     -1 ...
     -1     -1    104    103    106    105    108    107     -2     -2 ...
    112    111     -1     -1     -1     -1     -1 ...
... % EGI-256 channels setup, all EEG.
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1     -1     -1     -1 ...
     -1     -1     -1     -1     -1     -1     -1 ...
   ];

% Explanation on how this channel "crc_types" is used
% -1  -> usual M/EEG channel, i.e. use standard EEG scaling.
% -2  -> different scaling, e.g. for physiological signal like ECG.
%  n  -> this channel should be referenced with channel n, i.e. this is a
%       "bipolar channel" but each channel was acquired individually with 
%       the system's reference. So using n(i) = j for n(j) = i for channels
%       i and j allows easy online re-referencing in a bipolar montage. :-)

%% Number of channels, check stuff
Nnames = length(names);
Npos   = size(pos,1);
Ntypes = length(crc_types);

if Nnames~=Npos || Nnames~=Ntypes
    fprintf('Found %d names, %d positions, and %d types.\n',[Nnames Npos Ntypes]);
    error('You got the channel characteristics wrong!')
else
    Nchannels = Nnames;
end

%% Saving things in toolbox directory !
Pelec = [spm_str_manip(which('crc_main'),'h'),filesep,'CRC_electrodes.mat'];
save(Pelec,'Rxy','Nchannels','names','pos','crc_types','Cpos');

return

%% Extra bits code ?