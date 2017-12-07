function compute_cot
    load('output_data_1Band')
    load('output_data_1BigBand')

    stiffness = [250,100];
    speed = [.89;1.07];% speed in m/s
    mass = 0.6997;
    
    % 1
    i = 1
    idx = 13000:19000;
    cot = cost_of_transport(output_data_1Band(idx,:),mass,speed(i))
    
    % 2
    i = 2
    idx = 4000:13000;
    cot = cost_of_transport(output_data_1BigBand(idx,:),mass,speed(i))
    
    
end

function c = cost_of_transport(output_data, mass, speed)
    time = output_data(:,1);
    current1 = output_data(:,4);
    voltage1 = 12*output_data(:,6);
    
    current2 = output_data(:,9);
    voltage2 = 12*output_data(:,11);
    
    power = current1.*voltage1 - current2.*voltage2;
    energy = trapz(time,power);
    distance = time(end)-time(1);
    figure; plot(time, power)
    figure; plot(time, current1); hold on; plot(time, voltage1); plot(time, voltage1.*current1)
    figure; plot(time, current2); hold on; plot(time, voltage2); plot(time, voltage2.*current2)
    c = energy/(mass*9.81*distance);
end