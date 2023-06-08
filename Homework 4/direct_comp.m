function probability = direct_comp(sequence,initial_state,trans,emit)
%direct_computation HMM direct computation implementation
%   sequence is vector of numbers containing sequence of visible states
%   initial_state is first hidden state (at time t=0)
%   trans is the transition matrix
%   emit is the emission matrix
    
% find rmax to determine max possible combinations of hidden states for
% observed sequence
hidden_states = size(trans,1);
T = length(sequence);
rmax = hidden_states^T;
w_r = zeros(T,1);
w_states = 1:hidden_states;
w_states = zeros(rmax,T)

    %loop through all possible hidden state combos
    for r=1:rmax
        %create new hidden state sequence based on counter
        


    end

end