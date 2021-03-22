@testset "Unit tests" begin
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
