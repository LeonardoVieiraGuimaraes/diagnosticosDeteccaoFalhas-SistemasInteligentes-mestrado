function [ dna ] = generate_dna( chromosome_number )

    dna = zeros(1,chromosome_number);
    for i = 1:1:chromosome_number
        gene = rand;
        if gene > 0.5
            dna(1,i) = 1;
        else
            dna(1,i) = 0;
        end
    end

end

