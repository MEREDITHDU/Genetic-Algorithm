function [solution, sbest, per_eval] = real_GA(Xinitial, maxGen, pCrossover, pMutation, v)

Ng = maxGen;    %number of iterations 
No = length(Xinitial);         %to be generated by crossover (number of offspring)
population = Xinitial;
curParents = [];
curOffspring = [];
solution = [];
elite = population(1,:);
best_fitness = fitness(elite);
sbest = elite;
per_eval = [];


for i=1:Ng
    offSpring = [];
    for j=1:No
        curParents = selection_T(population);
        if(rand < pCrossover) %crossover occures
            curOffspring = crossover(curParents(1,:),curParents(2,:));
        else %crossover didnt occure
            curOffspring = curParents;
        end
        offSpring = cat(1,curOffspring, offSpring);
    end
    
    for j = 1:No
        offSpring(j,:) = mutation(offSpring(j,:), pMutation, v, elite);
        per_eval = cat(1, per_eval, best_fitness);
    end
    
    %select best parent as elite
    for k = 1:length(offSpring)
        if(fitness(offSpring(k,:)) > fitness(elite))
            elite = offSpring(k,:);
            best_fitness = fitness(offSpring(k,:));
        end
    end
    
    population = offSpring;
    
    if(fitness(elite) > fitness(sbest))
        sbest = elite;
    end
    
    solution = cat(1,solution, best_fitness);

end
end

