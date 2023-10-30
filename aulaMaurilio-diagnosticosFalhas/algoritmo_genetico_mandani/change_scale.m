function [ new_number ] = change_scale( number, old_upper_edge, new_upper_edge)

    % this function change the scale of a number

    new_number = (number * new_upper_edge) / old_upper_edge;


end

