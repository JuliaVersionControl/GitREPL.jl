using GitREPL
using Test

function withtempdir(f::Function)
    mktempdir() do tmp_dir
        cd(tmp_dir) do
            f(tmp_dir)
        end
    end
    return nothing
end

@testset "GitREPL.jl" begin
    withtempdir() do tmp_dir
        @test !isdir("GitREPL.jl")
        @test !isfile(joinpath("GitREPL.jl", "Project.toml"))
        expr = GitREPL._gitrepl_parser("clone https://github.com/JuliaVersionControl/GitREPL.jl")
        @test expr isa Expr
        @test !isdir("GitREPL.jl")
        @test !isfile(joinpath("GitREPL.jl", "Project.toml"))
        @eval $(expr)
        @test isdir("GitREPL.jl")
        @test isfile(joinpath("GitREPL.jl", "Project.toml"))
    end
end
