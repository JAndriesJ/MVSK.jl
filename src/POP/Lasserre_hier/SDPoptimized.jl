module SDPoptimized
using MosekTools, JuMP
 
export optimize_SDP,
       batch_optimize_SDP

# Pkg.build("MosekTools")  # [[[In the powershell]]] # Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted 
function optimize_SDP(model)
    JuMP.set_optimizer(model, Mosek.Optimizer)
    optimize!(model)

    return  primal_status(model) == dual_status(model) == "Feasible" ? objective_value(model) : nothing 
end
 
end


# output results
# println("Primal: ", primal_status(model))
# println("Dual: ", dual_status(model))
# println("Objective: ", objective_value(model))


# using Dates
# function batch_optimize_SDP(N_list,t_list,k)
    #     save_dir = "C:\\Users\\jandr\\MahCodes\\MVSK\\assets\\$(string(Dates.today()))-bounds_data.md"
    #     abc = open(save_dir, "w")
    #     write(abc, "## φ^($(k)) \n \n" )
    #     write(abc,"|level|#stocks|primal_status|dual_status|obj_val|comp_time(s)|\n")
    #     write(abc,"|---|---|---|---|\n")
    #     close(abc)
    
    #     for t in t_list
    #         for N in N_list 
    #             # try 
    #             SDPmod = SDPmodel.get_SDP_model(N,t,k)
    #             optSDPmod = SDPoptimized.optimize_SDP(SDPmod)
    #             P_stat = string(primal_status(optSDPmod)) 
    #             D_stat = string(dual_status(optSDPmod))
    #             obj_val = JuMP.objective_value(optSDPmod)
    #             comp_time = JuMP.solve_time(optSDPmod)
    #             abc = open(save_dir, "a")
    #                 write(abc,"|$(t)|$(N)|$(P_stat)|$(D_stat)|$(obj_val)|$(comp_time)|\n")
    #             close(abc)
    #             # catch 
    #             # abc = open(save_dir, "a")
    #             #     write(abc,"|$(t)|$(N)|Mem_err.|-|-|-|\n")
    #             # close(abc)
    #             # break
    #             # end
    #         end
    #     end
    # end
    