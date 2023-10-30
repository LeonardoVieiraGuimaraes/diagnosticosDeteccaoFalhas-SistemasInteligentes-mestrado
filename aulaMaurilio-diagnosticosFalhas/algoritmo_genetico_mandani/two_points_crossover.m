function [ childrem ] = two_points_crossover( father, mother, first_point, second_point)
    childrem = mother;
    childrem(1,first_point:second_point) = father(1,first_point:second_point);
end

