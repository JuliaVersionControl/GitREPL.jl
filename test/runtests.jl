using GitRepl
using Test

function withtempdir(f::Function)
    mktempdir() do tmp_dir
        cd(tmp_dir) do
            f(tmp_dir)
        end
    end
    return nothing
end

include("fakeptys.jl")

@testset "GitRepl.jl" begin
    include("unit.jl")
    include("integration.jl")
end
