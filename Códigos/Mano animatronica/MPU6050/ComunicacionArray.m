Arduino = serialport('COM18', 115200);
configureTerminator(Arduino, "LF");
receivedArray = [];
while true
    % Read the incoming data as a string
    dataStr = readline(Arduino);  % Reading the whole line as a string
    
    % Split the string into individual numbers
    dataStrArray = split(dataStr, ', ');  % Use the separator from Arduino
    
    % Convert the string array into numerical values
    receivedArray = str2double(dataStrArray);  
    
    % Display the received array
    disp(receivedArray);
end