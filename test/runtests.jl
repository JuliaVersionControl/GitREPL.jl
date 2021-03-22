using GitRepl
using Test

function withtempdir(f::Function)
    original_directory = pwd()
    mktempdir() do tmp_dir
        return f(tmp_dir)
    end
    cd(original_directory)
    return nothing
end

@testset "GitRepl.jl" begin
    withtempdir() do tmp_dir
        @test !isdir("GitRepl.jl")
        @test !isfile(joinpath("GitRepl.jl", "Project.toml"))
        expr = GitRepl._gitrepl_parser("clone https://github.com/JuliaVersionControl/GitRepl.jl")
        @test expr isa Expr
        @test !isdir("GitRepl.jl")
        @test !isfile(joinpath("GitRepl.jl", "Project.toml"))
        @eval $(expr)
        @test isdir("GitRepl.jl")
        @test isfile(joinpath("GitRepl.jl", "Project.toml"))
    end
end
